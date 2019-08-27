# statusfy

Сборка: docker build -t stfv .
Запуск: docker run -p 3000:3000 -p 3001:3001 --network bridge-my -v /usr/src/content:/usr/src/app/content -d stfv

Добавлена русификация, вынесены модули для добавления новых типов инцидентов плюс конфиг и запуск происходит вместе с browsersync.
