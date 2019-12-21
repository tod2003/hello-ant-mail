
1. 安装django

pip3 install django
pip3 install django-admin
pip3 install -U django-socketio
pip3 install socketio

2. 检查django安装结果
python3 -c "import django; print(django.__path__)"

3. 设置django环境变量

4. 安装django脚手架，假如项目名为store
django-admin startproject store

5. 创建app
django-admin.py startapp hello

6. 启动django项目
python3 manage.py runserver

