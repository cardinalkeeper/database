
const _ = require("lodash");
const fs = require("fs");
const path = require("path");
const program = require("commander");
const programPackage = require("load-pkg").sync(__dirname);
const pgp = require("pg-promise")({});

console.log(programPackage.description);
console.log("Версия:", programPackage.version);

program.version(programPackage.version);
	//.usage("[options] <command>");
	//.option("-l, --last", "Накатить последнюю версию миграции")
	//.parse(process.argv);
	
/**
 * Общие функции.
 */

/*function readdir(dirname) {
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

function checkInstalledDatabase() {
	return db.oneOrNone("select count(*) as count from migration_history", m => !!(m && m.count)).then(has => {
		return true;
	}).catch(none => {
		return false;
	});
}*/

/**
 * Глобальные данные.
 */

const config = require("./config/config.json");

const reg = {
	config: config,
	pgp: pgp,
	db: pgp(config.db),
	dirUpMigration: path.join(__dirname, "migrations")
};

/*const db = pgp(config.db);

const dirUpMigration = path.join(__dirname, "migrations");*/

	
/**
 * Обработчики команд.
 */

["install", "update"].forEach(cmd => {
	const commandConf = require(`./commands/${cmd}`)(reg);
	program
		.command(commandConf.command)
		.description(commandConf.description)
		.action(commandConf.action);
});



/*
program
	.command("install")
	.description("Создать всю схему базы данных")
	.action(function() {
		console.log("\nИнсталяция схемы базы данных:");
		checkInstalledDatabase().then(installed => {
			if (installed) {
				console.log("Инсталяция невозможна. База данных уже установлена.");
				return;
			} else {
				return readdirOnlyFiles(dirUpMigration).then(files => {
					files = files.sort((a, b) => (a < b) ? -1 : (a > b) ? 1 : 0);
					
					const lastfile = _.last(files);
					const lastNewMigrationVersion = path.basename(lastfile, path.extname(lastfile));
					
					const queries = [];
					files.forEach(filename => {
						filename = path.join(dirUpMigration, filename);
						queries.push(db.none(new pgp.QueryFile(filename)));
					});
					
					return Promise.all(queries).then(result => {
						console.log("Обработано SQL-файлов миграции:", result.length);
						console.log("Версия последней миграции:", lastNewMigrationVersion);
						console.log("Инсталяция завершена.");
					});
				});
			}
		}).then(none => {
			process.exit(0);
		}).catch(onError);
		
	});

program
	.command("update")
	.description("Обновить схему базы данных до последней версии")
	.action(function() {
		console.log("\nОбновление схемы базы данных:");
		checkInstalledDatabase().then(installed => {
			if (!installed) {
				console.log("Обновление невозможно. База данных не установлена.");
				return;
			} else {
				return Promise.all([
					readdirOnlyFiles(dirUpMigration),
					db.one("select * from migration_history order by version desc", null, m => m.version)
				]).then(([files, lastMigrationVersion]) => {
					const lastfile = _.last(files);
					const lastNewMigrationVersion = path.basename(lastfile, path.extname(lastfile));
					if (lastMigrationVersion == lastNewMigrationVersion) {
						console.log("Обновлять нечего. В базе уже установлена последняя миграция");
						return;
					} else {
						files = files.sort((a, b) => (a < b) ? -1 : (a > b) ? 1 : 0);
						const queries = [], processedMigrations = [];
						files.forEach(filename => {
							const migrationVersion = path.basename(filename, path.extname(filename));
							filename = path.join(dirUpMigration, filename);
							if (migrationVersion > lastMigrationVersion) {
								queries.push(db.none(new pgp.QueryFile(filename)));
								processedMigrations.push(migrationVersion);
							}
						});
						return Promise.all(queries).then(result => {
							console.log("Обработано SQL-файлов миграции:", processedMigrations.length);
							console.log("Установлены миграции:", processedMigrations);
							console.log("Обновление завершено.");
						});
					}
				});
			}
		}).then(none => {
			process.exit(0);
		}).catch(onError);
	});
*/

/**
 * Обработка командной строки.
 */


program.parse(process.argv);
if (!program.args.length) program.help();