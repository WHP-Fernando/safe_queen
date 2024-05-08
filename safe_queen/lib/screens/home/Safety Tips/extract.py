import requests
from bs4 import BeautifulSoup

def fetch_and_parse_html_content(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return BeautifulSoup(response.content, 'html.parser')
        elif response.status_code == 403:
            print('Access to the resource is forbidden (403)')
            return None
        else:
            print(f'Failed to load HTML content: {response.status_code}')
            return None
    except requests.exceptions.RequestException as e:
        print(f'Error occurred: {e}')
        return None

def extract_data(soup):
    paragraph_tags = soup.find_all('p')
    paragraphs = [p.text.strip() for p in paragraph_tags]
    return paragraphs

def main():
    url = 'https://brightside.me/articles/7-self-defense-techniques-for-women-recommended-by-a-professional-441310/','https://resourcehub.bakermckenzie.com/en/resources/fighting-domestic-violence/asia/sri-lanka/topics/1legal-provisions',
    'https://www.instructables.com/Basic-Street-Safety-for-Women/','https://paladinsecurity.com/safety-tips/for-women/'
    
    soup = fetch_and_parse_html_content(url)
    if soup:
        data = extract_data(soup)
        for paragraph in data:
            print(paragraph)

if __name__ == "__main__":
    main()
