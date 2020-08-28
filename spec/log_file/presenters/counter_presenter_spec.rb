RSpec.describe LogFile::Presenters::CounterPresenter do
  let(:presenter) { described_class.new(counter) }
  let(:counter) { LogFile::Counter.new }

  describe '#most_visited_pages' do
    context 'when counter has 0 webpage visits' do
      it 'returns an empty array' do
        expect(presenter.most_visited_pages).to eq([])
      end
    end

    context 'when counter has 1 webpage visit' do
      let(:web_page) { '/home' }
      let(:ip) { '123.123.123.123' }
      let(:expected_array) { [[web_page, 1]] }

      before { counter.add_web_page_visit(web_page, ip) }

      it 'returns correct array' do
        expect(presenter.most_visited_pages).to eq(expected_array)
      end
    end

    context 'when counter has multiple webpage visits' do
      let(:web_page) { '/home' }
      let(:web_page2) { '/about' }
      let(:web_page3) { '/login/2' }
      let(:ip) { '111.111.111.111' }
      let(:ip2) { '222.222.222.222' }
      let(:ip3) { '333.333.333.333' }
      let(:ip4) { '444.444.444.444' }

      let(:expected_array) { [[web_page, 3], [web_page2, 2], [web_page3, 1]] }

      before do
        counter.add_web_page_visit(web_page, ip3)
        counter.add_web_page_visit(web_page3, ip2)
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page2, ip4)
        counter.add_web_page_visit(web_page, ip3)
        counter.add_web_page_visit(web_page2, ip)
      end

      it 'returns correct array and sorted by visits descending' do
        expect(presenter.most_visited_pages).to eq(expected_array)
      end
    end
  end

  describe '#most_uniq_visited_pages' do
    context 'when counter has 0 webpage visits' do
      it 'returns an empty array' do
        expect(presenter.most_uniq_visited_pages).to eq([])
      end
    end

    context 'when counter has 1 webpage visit' do
      let(:web_page) { '/home' }
      let(:ip) { '123.123.123.123' }
      let(:expected_array) { [[web_page, 1]] }

      before { counter.add_web_page_visit(web_page, ip) }

      it 'returns correct array' do
        expect(presenter.most_uniq_visited_pages).to eq(expected_array)
      end
    end

    context 'when counter has multiple webpage visits' do
      let(:web_page) { '/home' }
      let(:web_page2) { '/about' }
      let(:web_page3) { '/login/2' }
      let(:ip) { '111.111.111.111' }
      let(:ip2) { '222.222.222.222' }
      let(:ip3) { '333.333.333.333' }
      let(:ip4) { '444.444.444.444' }

      let(:expected_array) { [[web_page2, 3], [web_page, 2], [web_page3, 1]] }

      before do
        counter.add_web_page_visit(web_page, ip3)
        counter.add_web_page_visit(web_page3, ip2)
        counter.add_web_page_visit(web_page, ip)
        counter.add_web_page_visit(web_page2, ip4)
        counter.add_web_page_visit(web_page, ip3)
        counter.add_web_page_visit(web_page2, ip)
        counter.add_web_page_visit(web_page2, ip3)
      end

      it 'returns correct array and sorted by uniq visits descending' do
        expect(presenter.most_uniq_visited_pages).to eq(expected_array)
      end
    end
  end
end
