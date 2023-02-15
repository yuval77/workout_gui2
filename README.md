# workout_gui

workout with gui

## setup

You need to open two projects, one for the server folder and one for everything else.
Also you need to download ngrok for running the server.

In the server project you need to:
Run main.py
Open ngrok cmd and type ngrok http 4000
Then copy the link after the word forwwarding
paste it in the workout_gui/lib/start_page- line 158 instead of the existing url.
Add "/upload" in the end of the pasted url.
Then, run the app! (I recommend in an emulator)



