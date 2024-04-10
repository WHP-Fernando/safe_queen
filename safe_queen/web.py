from flask import Flask, jsonify
import requests
from bs4 import BeautifulSoup

app = Flask(__name__)

@app.route('/scrape', methods=['GET'])
def scrape_data():
    url = 'https://www.rainn.org/resources'
    response = requests.get(url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        resource_titles = [element.text.strip() for element in soup.select('.views-row h3.views-field-title')]
        return jsonify({'resource_titles': resource_titles})
    else:
        return jsonify({'error': 'Failed to load data'})

if __name__ == '__main__':
    app.run(debug=True)
