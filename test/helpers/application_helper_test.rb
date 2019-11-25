# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "パスにロケールクエリを付加したリンクを出力する" do
    assert_dom_equal %{<a href="/books?locale=ja">日本語</a>}, create_language_links("ja", "/books")
  end

  test "enを渡されたら直近のリクエストパスに\"?locale=en\"を付加したリンクを出力する" do
    assert_dom_equal %{<a href="/books?locale=en">English</a>}, create_language_links("en", "/books")
  end

  test "jnを渡されたらエラーメッセージを出力する" do
    assert_dom_equal t("applicationhelper.create_language_links.unsupported_language"), create_language_links("jn", "/books")
  end

  test "book_id: 10を渡されたらhidden_fieldにbook_idを設定する" do
    assert_dom_equal %{<input type="hidden" name="book_id" id="book_id" value="10">}, set_comment_destination(book_id: 10, report_id: nil)
  end

  test "report_id: 99を渡されたらhidden_fieldにreport_idを設定する" do
    assert_dom_equal %{<input type="hidden" name="report_id" id="report_id" value="99">}, set_comment_destination(book_id: nil, report_id: 99)
  end
end
