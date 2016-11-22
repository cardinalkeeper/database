
const _ = require("lodash");
const path = require("path");
const func = require("./func");

module.exports = function(reg) {
	
	const dirUpMigration = reg.dirUpMigration;
	const pgp = reg.pgp;
	const db = reg.db;
	
	return {
		command: "install",
		description: "Создать всю схему базы данных",
		action: function() {
			
			func.printDatabaseConnection(reg.config);
		
			console.log("\nИнсталяция схемы базы данных:");
			
			func.checkInstalledDatabase(db).then(installed => {
				if (installed) {
					console.log("Инсталяция невозможна. База данных уже установлена.");
					return;
				} else {
					return func.readdirOnlyFiles(dirUpMigration).then(files => {
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
			}).catch(func.onError);
			
		}
	};
	
};