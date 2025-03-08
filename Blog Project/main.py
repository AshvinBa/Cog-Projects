from flask import Flask , render_template , request , session , url_for , redirect
from flask_sqlalchemy import SQLAlchemy 
from werkzeug.utils import secure_filename
from datetime import datetime
import json  # import json for configure json file
import os
import math

with open('config.json','r') as c:    # open config.json file and read that file as considering as "C".
    params = json.load(c)["params"]   # loading json data into params variable from params variable in "config.json".  

local_server = True   # it is run on the local server.
app = Flask(__name__)
app.secret_key = "super secret key"
app.config['UPLOAD_FOLDER'] = params['upload_location']
# app.config.update(
#     MAIL_SERVER = 'smtp.gmail.com',
#     MAIL_PORT = '456',
#     MAIL_USE_SSL = True,
#     MAIL_USERNAME = params['gmail-user'],
#     MAIL_PASSWORD = params['gmail-password']
# )
# mail = Mail(app)


if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri'] 
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False , nullable = False )
    phone_num = db.Column(db.String(80), nullable = False)
    msg = db.Column(db.String(80), nullable = False)
    date = db.Column(db.String(80), nullable = True)
    email = db.Column(db.String(120), nullable = False)
    
class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable = False )
    slug = db.Column(db.String(80), nullable = False)
    content = db.Column(db.String(80), nullable = False)
    date = db.Column(db.String(80), nullable = True)
    tagline = db.Column(db.String(80), nullable = False)
    users = db.Column(db.String(80), nullable = False)
    
    
# 1 Home Page.
@app.route("/")
def home():
    # Fetch all posts from the database
    posts = Posts.query.filter_by().all()

    # Calculate the total number of pages
    last = math.ceil(len(posts) / int(params['no_od_posts']))
    
    # Get the current page number from query parameters
    page = request.args.get('page')

    # If the page is not numeric or not provided, default to the first page
    if not (page and page.isnumeric()):
        page = 1
    else:
        page = int(page)
    
    # Slice the posts to display only the posts for the current page
    posts = posts[(page-1) * int(params['no_od_posts']): page * int(params['no_od_posts'])]
    
    # Determine navigation links for pagination
    if page == 1:
        prev = "#"
        next = f"/?page={page+1}"
    elif page == last:
        prev = f"/?page={page-1}"
        next = "#"
    else:
        prev = f"/?page={page-1}"
        next = f"/?page={page+1}"

    # Render the template with the sliced posts and pagination links
    return render_template("index.html", params=params, posts=posts, prev=prev, next=next)
    


# 2 About Page.
@app.route("/about")
def about():
    return render_template("about.html" , params = params)


# 3 Post Page.
@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html", params=params, post = post )


# 3 Post Page.
@app.route("/post")
def post():
    post = Posts.query.all()
    return render_template("post.html" , params = params , post = post)
                                                    
# 4 Contact Page.
@app.route("/contact" , methods = ['GET', 'POST']) 
def contact():
    
    if(request.method == 'POST'):
        '''Add Entry to the database.'''
        # Fetching of the Entry into the databese from HTML files
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        
        entry = Contacts(name = name , phone_num = phone , email = email , date = datetime.now() , msg = message)
        # To add entry into the database
        db.session.add(entry)
        db.session.commit()

        # To send the message
        # mail.send_message('New Message From ' + name, 
        #                   sender = email , 
        #                   recipients = [params['gmail-user']],
        #                   body = message + "\n" + phone,
        #                 )
    
    # To return or display the web page
    return render_template("contact.html" , params = params)

# 5 Dashboard Login Page 

@app.route("/login", methods=['GET', 'POST'])
def login():
    if 'user' in session and session['user'] == params['admin_user']:   # User is already logged in, redirect to dashboard
        post = Posts.query.all()                                        # This is fine in this block
        return render_template("dashboard.html" , params = params , post = post)
    
    if request.method == 'POST':                                        # Retrieve username and password from form
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        
        # Check if the credentials match
        if username == params['admin_user'] and userpass == params['admin_pass']:
            session['user'] = username  # Set user in session
            post = Posts.query.all()
            return render_template("dashboard.html" , params = params , post = post)
           
    
    # Render the login page
    return render_template("login.html", params=params)




@app.route("/uploader" , methods=['GET','POST'])
def uploader():
    if('user' in session and session['user'] == params['admin_user']):
        if(request.method == 'POST'):   #if post request is applied
            f= request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
    return "Uploaded Succesfully"



# 6) edit
@app.route("/edit/<int:sno>", methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            # Fetch form data
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            date = datetime.now()
            user = request.form.get('user')

            if sno == 0:  # Add a new post
                post = Posts(title=box_title, slug=slug, tagline=tline, content=content, date=date, users=user)
                db.session.add(post)
                db.session.commit()
            else:  # Update an existing post
                post = Posts.query.filter_by(sno=sno).first()
                if post:  # Ensure the post exists
                    post.title = box_title
                    post.slug = slug
                    post.tagline = tline
                    post.content = content
                    post.date = date
                    post.users = user
                    db.session.commit()
                else:
                    return "Post not found", 404

        # Fetch the post for pre-filling the form if editing
        post = Posts.query.filter_by(sno=sno).first() if sno != 0 else None
        return render_template("edit.html", params=params, sno=sno, post=post)
    return redirect("/login")


# 8 logout
@app.route("/logout")
def logout():
    session.pop('user',None)
    return redirect(url_for('home'))


@app.route("/delete/<int:sno>", methods=['GET', 'POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        # Query the post
        post = Posts.query.filter_by(sno=sno).first()
        # Check if the post exists
        if post:
            db.session.delete(post)  # Delete the post
            db.session.commit()  # Commit changes
        else:
            return "Post not found", 404  # Return a 404 error if the post doesn't exist
    return redirect("/login")


def post():
    post = Posts.query.all()
    return render_template("post.html" , params = params , post = post)

# To run the flask
app.run(debug=True)