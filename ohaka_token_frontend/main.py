from flask import Flask, render_template, request, json, jsonify

app = Flask(__name__)

@app.route('/')
def helloView():
    return render_template('ohaka.html', title='OhakaToken')

if __name__ == '__main__':
    app.run()