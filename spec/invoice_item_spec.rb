require 'spec_helper'

describe SalesEngine::InvoiceItem do
  describe "#item" do
    let(:invoice_item) { Fabricate(:invoice_item, :id => 1) }
    let(:item) { mock(SalesEngine::Item) }
    let(:other_item) { mock(SalesEngine::Item) }

    before(:each) do
      item.stub(:id).and_return(1)
      other_item.stub(:id).and_return(2)
      SalesEngine::Database.stub(:items).and_return([item, other_item])
    end
    
    it "returns the item with matching item_id" do
      invoice_item.item.should == item
    end
  end

  describe "#invoice" do
    let(:invoice_item) { Fabricate(:invoice_item, :id => 1) }
    let(:invoice) { mock(SalesEngine::Invoice) }
    let(:other_invoice) { mock(SalesEngine::Invoice) }

    before(:each) do
      invoice.stub(:id).and_return(1)
      other_invoice.stub(:id).and_return(2)
      SalesEngine::Database.stub(:invoices).and_return([invoice, other_invoice])
    end
    
    it "returns the invoice with matching invoice_id" do
      invoice_item.invoice.should == invoice
    end
  end
end