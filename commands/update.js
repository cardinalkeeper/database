
const _ = require("lodash");
const path = require("path");
const func = require("./func");

module.exports = function(reg) {
	
	const dirUpMigration = reg.dirUpMigration;
	const pgp = reg.pgp;
	const db = reg.db;
	
	return {
		command: "update",
		description: "Обновить схему базы данных до последней версии",
		action: function() {
		
			console.log("\nОбновление схемы базы данных:");
			
			func.checkInstalledDatabase(db).then(installed => {
				if (!installed) {
					console.log("Обновление невозможно. База данных не установлена.");
					return;
				} else {
					return Promise.all([
						func.readdirOnlyFiles(dirUpMigration),
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
			}).catch(func.onError);
			
		}
	};
	
};