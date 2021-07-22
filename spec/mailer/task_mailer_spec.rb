require 'rails_helper'

describe TaskMailer, type: :mailer do

  let(:task) { FactoryBot.create(:task, name: 'メイラーのスペック', description: '送信したメールの内容') }

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
    part.body.raw_source
  end

  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
    part.body.raw_source
  end

  describe '#creation_email' do
    let(:mail) { TaskMailer.creation_email(task) }

    it '想定通りのメールが生成されていること' do
      expect(mail.subject).to eq('タスク作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['taskleaf@example.com'])

      expect(text_body).to match('以下のタスクを作成しました')
      expect(text_body).to match('メイラーのスペック')
      expect(text_body).to match('送信したメールの内容')

      expect(html_body).to match('以下のタスクを作成しました')
      expect(html_body).to match('メイラーのスペック')
      expect(html_body).to match('送信したメールの内容')
    end
  end
end
