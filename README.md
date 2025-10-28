# Django-WebApp       <img alt="GitHub" src="https://img.shields.io/github/license/smahesh29/Django-WebApp">

A modern Django web application deployed on AWS EKS with complete CI/CD pipeline, container security scanning, and Kubernetes orchestration.

<h2>Assignment Problem Statement:</h2>

<h4>Part 1:</h4>
<ol>
    <li>Create a web-app where a user can login.</li>
    <li>User can upload files.</li>
    <li>User can view his/her uploaded files.</li>
</ol>

<h4>Part 2:</h4>
<ol>
     <li>User can search and view profile of other users.</li>
     <li>They can share their uploaded files with any of those users.</li>
     <li>Users can see the shared files by other users also in uploaded files.</li>
</ol>

<h4>Additional Features:</h4>
<ol>
    <li>In users profile user can set his/her profile picture.</li>
    <li>Users can download other users uploaded files.</li>
    <li>The user can upload any type of files such as images, videos, text files and also different types of programs like python code, java code, etc.</li>
</ol>
    
<h2>Technologies Used:</h2>
<ul>
    <li>Python</li>
    <li>Django</li>
    <li>Bootstrap</li>
    <li>JavaScript</li>
</ul>

<h2>DevOps Technologies:</h2>
<ul>
    <li>Docker - Containerization</li>
    <li>Kubernetes (EKS) - Container orchestration</li>
    <li>AWS ECR - Container registry</li>
    <li>GitHub Actions - CI/CD pipeline</li>
    <li>Terraform - Infrastructure as Code</li>
    <li>Trivy - Container security scanning</li>
    <li>NGINX Ingress Controller - Load balancing</li>
</ul>
    
<h2>Additional Python Modules Required:</h2>
<ul>
    <li>Django</li>
    <li>django-crispy-forms</li>
    <li>Pillow</li>
</ul>
  
<h2>Note :</h2>

<b>The Secret_Key required for the execution and debugging of project is not removed from the project code. So you can use the project as your college mini-project or by using the project code you can build your own project.</b>

<h2>Quick Start:</h2>

### Local Development

```bash
# Migrations
python django_web_app/manage.py makemigrations
python django_web_app/manage.py migrate

# Run server
python django_web_app/manage.py runserver
```

Visit: http://localhost:8000

### AWS Deployment (CI/CD)

The application automatically deploys to AWS EKS when you push to the `main` branch via GitHub Actions pipeline.

**Pipeline includes:**
- ✅ Automated testing and linting
- ✅ Docker image build with timestamp tagging
- ✅ Security scanning with Trivy
- ✅ Push to AWS ECR
- ✅ Kubernetes deployment update

See [docs/setup.md](docs/setup.md) and [docs/deployment.md](docs/deployment.md) for detailed instructions.

# Working:
[![Watch the video](https://img.youtube.com/vi/qIK-vfTig6c/0.jpg)](https://youtu.be/qIK-vfTig6c)

# Screenshots : 
<img src="Screenshots/New Tab - Google Chrome 03-12-2019 19_14_36.png" height="400" width="800">
<img src="Screenshots/New Tab - Google Chrome 03-12-2019 19_14_51.png" height="400" width="800">
<img src="Screenshots/New Tab - Google Chrome 03-12-2019 19_14_44.png" height="400" width="800">
<img src="Screenshots/New Tab - Google Chrome 03-12-2019 19_15_47.png" height="400" width="800">
<img src="Screenshots/New Tab - Google Chrome 03-12-2019 19_16_14.png" height="400" width="800">
<img src="Screenshots/Django WebApp - Google Chrome 04-12-2019 13_41_50.png" height="400" width="800">
<img src="Screenshots/Django WebApp - Google Chrome 03-12-2019 20_48_45.png" height="400" width="800">