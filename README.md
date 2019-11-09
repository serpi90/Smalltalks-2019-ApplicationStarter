# Example for ba-st/ApplicationStarter

## Docker setup

clone this repository

```bash
git clone https://github.com/serpi90/Smalltalks-2019-ApplicationStarter.git
cd Smalltalks-2019-ApplicationStarter
```

Start with `docker-compose` & multiple instances

```bash
docker-compose up --scale app=2
```

Should be accessible on port 80 on localhost <http://localhost/factorial/3>
