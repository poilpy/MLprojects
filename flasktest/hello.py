from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Index Page'

@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that username
    return 'User %s' % username

@app.route('/post/<int:post_id>')
def show_post(post_id):
    # show the post with the given id, the id is an integer
    return 'Post %d' % post_id

@app.route('/projects/')
def projects():
    return 'The project page'

@app.route('/about')
def about():
    return 'The about page'


from flask import render_template

@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)