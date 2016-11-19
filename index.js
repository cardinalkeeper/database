
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
	


function readdir(dirname) {
	return new Promise((resolve, reject) => {
		fs.readdir(dirname, (err, files) => {
			if (err) reject(err); else resolve(files);
		});
	});
}

function onError(err) {
	console.error("Фатальная ошибка:");
	console.error(err);
	process.exit(1);
}

const config = require("./config");


const db = pgp(config.db);

const dirUpMigration = path.join(__dirname, "migrations");
//const dirUpMigration = path.join(__dirname, "temp/migrations");

program
	.command("last")
	.description("Накатить последнюю версию миграции")
	.action(function() {
		
		readdir(dirUpMigration).then(files => {
			
			files = files.sort((a, b) => (a < b) ? -1 : (a > b) ? 1 : 0);
			
			const lastfile = _.last(files);
			
			
			const lastMigrationVersion = path.basename(lastfile, path.extname(lastfile));
			
			return db.oneOrNone("select count(*) as count from migration_history where version = $1", lastMigrationVersion, m => !!(m && m.count)).then(has => {
				
				console.log(has);
				process.exit(0);
			});

			
			
			
		}).catch(onError);
	});


program
	.command("install")
	.description("Создать всю схему базы данных")
	.action(function() {
		console.log("Инсталяция базы данных.");

		// TODO Сделать проверку инсталирована база или нет
		
		readdir(dirUpMigration).then(files => {
			files = files.sort((a, b) => (a < b) ? -1 : (a > b) ? 1 : 0);
			
			const queries = [];
			files.forEach(filename => {
				filename = path.join(dirUpMigration, filename);
				queries.push(db.none(new pgp.QueryFile(filename)));
			});
			
			return Promise.all(queries).then(result => {
				console.log("Обработано файлов:", result.length);
				console.log("Инсталяция завершена.");
				process.exit(0);
			});
		}).catch(onError);
	});












program.parse(process.argv);
if (!program.args.length) program.help();