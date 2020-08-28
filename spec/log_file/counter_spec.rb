RSpec.describe LogFile::Counter do
  let(:counter) { described_class.new }
  let(:web_page) { '/first_page' }
  let(:ip) { '123.123.123.123' }

  describe '#initialize' do
    it 'visits_per_web_page returns an empty hash' do
      expect(counter.visits_per_web_page).to eq({})
    end
  end

  describe '#add_web_page_visit' do
    context 'when add first web page visit' do
      before { counter.add_web_page_visit(web_page, ip) }

      it 'adds one visit' do
        expect(counter.visits_per_web_page.count).to eq(1)
      end

      it 'saves the Ip in ip_list list for the web_page' do
        expected_set = Set.new.add(ip)
        expect(counter.visits_per_web_page[web_page][:ip_list]).to eq(expected_set)
      end

      it 'increases total_visits for the web_page to 1' do
        expect(counter.visits_per_web_page[web_page][:total_visits]).to eq(1)
      end
    end

    context 'when add same web page visit twice' do
      before do
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page, ip)
      end

      it 'adds one visit' do
        expect(counter.visits_per_web_page.count).to eq(1)
      end

      it 'saves the Ip in ip_list list for the web_page only once' do
        expected_set = Set.new.add(ip)
        expect(counter.visits_per_web_page[web_page][:ip_list]).to eq(expected_set)
      end

      it 'increases total_visits for the web_page to 2' do
        expect(counter.visits_per_web_page[web_page][:total_visits]).to eq(2)
      end
    end

    context 'when add same web page visit twice from different ips' do
      let(:ip2) { '124.124.124.124' }

      before do
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page, ip2)
      end

      it 'adds one visit' do
        expect(counter.visits_per_web_page.count).to eq(1)
      end

      it 'saves both ips in ip_list list for the web_page' do
        expected_set = Set.new.add(ip).add(ip2)
        expect(counter.visits_per_web_page[web_page][:ip_list]).to eq(expected_set)
      end

      it 'increases total_visits for the web_page to 2' do
        expect(counter.visits_per_web_page[web_page][:total_visits]).to eq(2)
      end
    end

    context 'when add 2 different web page visits from same ip' do
      let(:web_page2) { '/second_page' }

      before do
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page2, ip)
      end

      it 'adds two visits' do
        expect(counter.visits_per_web_page.count).to eq(2)
      end

      it 'saves the ip in ip_list list for web_page1' do
        expected_set = Set.new.add(ip)
        expect(counter.visits_per_web_page[web_page][:ip_list]).to eq(expected_set)
      end

      it 'saves the ip in ip_list list for web_page2' do
        expected_set = Set.new.add(ip)
        expect(counter.visits_per_web_page[web_page2][:ip_list]).to eq(expected_set)
      end

      it 'increases total_visits for the web_page1 to 1' do
        expect(counter.visits_per_web_page[web_page][:total_visits]).to eq(1)
      end

      it 'increases total_visits for the web_page2 to 1' do
        expect(counter.visits_per_web_page[web_page2][:total_visits]).to eq(1)
      end
    end

    context 'when add 2 different web page visits from different ips' do
      let(:web_page2) { '/second_page' }
      let(:ip2) { '124.124.124.124' }

      before do
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page2, ip2)
      end

      it 'adds two visits' do
        expect(counter.visits_per_web_page.count).to eq(2)
      end

      it 'saves the ip in ip_list list for web_page1' do
        expected_set = Set.new.add(ip)
        expect(counter.visits_per_web_page[web_page][:ip_list]).to eq(expected_set)
      end

      it 'saves the ip in ip_list list for web_page2' do
        expected_set = Set.new.add(ip2)
        expect(counter.visits_per_web_page[web_page2][:ip_list]).to eq(expected_set)
      end

      it 'increases total_visits for the web_page1 to 1' do
        expect(counter.visits_per_web_page[web_page][:total_visits]).to eq(1)
      end

      it 'increases total_visits for the web_page2 to 1' do
        expect(counter.visits_per_web_page[web_page2][:total_visits]).to eq(1)
      end
    end

    context 'when add multiple web page visits' do
      let(:web_page2) { '/second_page' }
      let(:ip2) { '124.124.124.124' }

      before do
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page, ip2)
        counter.add_web_page_visit(web_page2, ip2)
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page2, ip2)
      end

      it 'adds two web page visits' do
        expect(counter.visits_per_web_page.count).to eq(2)
      end

      it 'correctly saves the ip_list list for the web_page1' do
        expected_set = Set.new.add(ip).add(ip2)
        expect(counter.visits_per_web_page[web_page][:ip_list]).to eq(expected_set)
      end

      it 'correctly saves the ip_list list for the web_page2' do
        expected_set = Set.new.add(ip2)
        expect(counter.visits_per_web_page[web_page2][:ip_list]).to eq(expected_set)
      end

      it 'correctly increases total_visits for the web_page1' do
        expect(counter.visits_per_web_page[web_page][:total_visits]).to eq(3)
      end

      it 'correctly increases total_visits for the web_page2' do
        expect(counter.visits_per_web_page[web_page2][:total_visits]).to eq(2)
      end
    end
  end
end
