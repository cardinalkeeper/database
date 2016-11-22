
const fs = require("fs");
const path = require("path");

/**
 * Общие функции.
 */

function readdir(dirname) {
	return new Promise((resolve, reject) => {
		fs.readdir(dirname, (err, files) => {
			if (err) reject(err); else resolve(files);
		});
	});
}

function readdirOnlyFiles(dirname) {
	return readdir(dirname).then(files => {
		return files.filter(filename => {
			filename = path.join(dirname, filename);
			return fs.statSync(filename).isFile();
		});
	});
}

function onError(err) {
	console.error("Фатальная ошибка:");
	console.error(err);
	process.exit(1);
}

function checkInstalledDatabase(db) {
	return db.oneOrNone("select count(*) as count from migration_history", m => !!(m && m.count)).then(has => {
		return true;
	}).catch(none => {
		return false;
	});
}

function printDatabaseConnection(config) {
	console.log(`Соединяемся с базой: ${config.db.host}:${config.db.port}/${config.db.database}`);
}

module.exports = {
	readdir, readdirOnlyFiles, onError, checkInstalledDatabase
};