require "csv"
require "nokogiri"
require "pry"
require 'rubygems'
require 'rest-client'

class Scrapper::ConcoursAgricoleScrapper
  BODY = {
    "ctl00_ctl00_TM_HiddenField" => "",
    "__EVENTTARGET" => "ctl00$ctl00$CPH$CPH$B_RECHERCHE",
    "__EVENTARGUMENT" => "",
    "__LASTFOCUS" => "",
    "__VIEWSTATE" => "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dWNpc3NlIGRlIFN0cmFzYm91cmcsIEtuYWNrKFNhdWNpc3NlcyDDoCBjdWlyZSBmdW3DqWVzLCBncm9zIGhhY2hhZ2UKU2F1Y2lzc29ucwpDaWRyZXMgQU9DHkNpZHJlcyBhcnRpc2FuYXV4IG91IGRlIG1hcnF1ZRZDaWRyZXMgZGUgQnJldGFnbmUgSUdQF0NpZHJlcyBkZSBOb3JtYW5kaWUgSUdQD0NpZHJlcyBmZXJtaWVycwdQb2lyw6lzGkNvbmZpdHVyZSBleHRyYSBldCBnZWzDqWVzLEN1aXNzZXMgZGUgcG91bGV0cyBwacOoY2UgZW50acOocmUgYXZlYyBwZWF1KUZpbGV0cyBkZSBwb3VsZXQgc2FucyBwZWF1IG5pIGFpZ3VpbGxldHRlF01hZ3JldHMgZGUgQ2FuYXJkIGZyYWlzEkF1dHJlcyBFYXV4IGRlIFZpZQxDYWx2YWRvcyBBT0MKQ29nbmFjIEFPQxRFYXV4IGRlIFZpZSBkZSBDaWRyZRVFYXV4IGRlIHZpZSBkZSBmcnVpdHMiUHJvZHVpdHMgYXJ0aXNhbmF1eCBvdSBpbmR1c3RyaWVscxFQcm9kdWl0cyBmZXJtaWVycwxBdXRyZXMgbWllbHMLLS1IeWRyb21lbHMQTWllbCBkZSBtb250YWduZQlNaWVscyBBT1AMTWllbHMgZGUgY3J1Dkh1aWxlcyBkZSBOb2l4GEh1aWxlcyBkJ29saXZlIGRlIEZyYW5jZRpIdWlsZXMgZCdPbGl2ZXMgQU9DIGV0IEFPUA8tLU9saXZlcyBub2lyZXMTLS1PbGl2ZXMgdmVydGVzIEFPUBdPbGl2ZXMgdmVydGVzIGRlIEZyYW5jZQ9Qw6R0ZXMgZCdvbGl2ZXMaVGFwZW5hZGVzIGV0IHNww6ljaWFsaXTDqXMgSHXDrnRyZXMgZGUgbGEgcsOpZ2lvbiBBcXVpdGFpbmUfSHXDrnRyZXMgZGUgbGEgcsOpZ2lvbiBCcmV0YWduZSBIdcOudHJlcyBkZSBsYSByw6lnaW9uIE5vcm1hbmRpZSdIdcOudHJlcyBkZSBsYSByw6lnaW9uIFBvaXRvdS1DaGFyZW50ZXMdSHXDrnRyZXMgZGVzIFBheXMgZGUgbGEgTG9pcmUiSHXDrnRyZXMgZHUgQmFzc2luIE3DqWRpdGVycmFuw6llbg9IdcOudHJlcyBwbGF0ZXNERm9pZSBHcmFzIGVudGllciBkZSBDYW5hcmQgZW4gY29uc2VydmUgKERMVU8gc3Vww6lyaWV1cmUgw6AgMjQgbW9pcykrRm9pZSBHcmFzIGVudGllciBkZSBDYW5hcmQgZW4gc2VtaS1jb25zZXJ2ZUBGb2llIEdyYXMgZW50aWVyIGQnT2llIGVuIGNvbnNlcnZlIChETFVPIHN1cMOpcmlldXJlIMOgIDI0IG1vaXMpJ0ZvaWUgR3JhcyBlbnRpZXIgZCdPaWUgZW4gc2VtaS1jb25zZXJ2ZTFNYWdyZXRzIGRlIENhbmFyZCBzw6ljaMOpcyBvdSwgc8OpY2jDqXMgZXQgZnVtw6lzFFJpbGxldHRlcyBwdXIgY2FuYXJkFFJpbGxldHRlcyBwdXJlIGQnb2llFlBpbWVudCBkJ0VzcGVsZXR0ZSBBT0MpLS0gUHJvZHVpdHMgTGFpdGllcnMgLSBDb25jb3VycyBFeHBvcnQgLS0IRnJvbWFnZXMrLS0gUHJvZHVpdHMgTGFpdGllcnMgLSBDb25jb3VycyBOYXRpb25hbCAtLQdCZXVycmVzB0Nyw6htZXMQRGVzc2VydHMgbGFjdMOpcwhGcm9tYWdlcyFGcm9tYWdlcyBmcmFpcyBldCBGcm9tYWdlcyBmb25kdXMFTGFpdHMaWWFvdXJ0cyAsIExhaXRzIGZlcm1lbnTDqXMXUG9tbWVhdSBkZSBCcmV0YWduZSBBT0MYUG9tbWVhdSBkZSBOb3JtYW5kaWUgQU9DFFBvbW1lYXUgZHUgTWFpbmUgQU9DDlB1bmNocyBhdSByaHVtHVJodW0gYW1icsOpIGRlIG1vaW5zIGRlIDMgYW5zNFJodW1zIGJsYW5jcyBhZ3JpY29sZXMgYXZlYyBpbmRpY2F0aW9uIGfDqW9ncmFwaGlxdWUoUmh1bXMgYmxhbmNzIGFncmljb2xlcyBkZSBNYXJ0aW5pcXVlIEFPQ1gtLVJodW1zIGJsYW5jcyBwcm9kdWl0cyDDoCBwYXJ0aXIgZGUgc3VjcmVyaWUgKGRpc3RpbGxhdGlvbiBkZSBtw6lsYXNzZSkgZGUgNDXCsCDDoCA1MMKwLFJodW1zIHZpZXV4IGF2ZWMgaW5kaWNhdGlvbnMgZ8Opb2dyYXBoaXF1ZXMgHVJodW1zIHZpZXV4IGRlIE1hcnRpbmlxdWUgQU9DBlNhZnJhbgdUcnVpdGVzB1ZhbmlsbGUYLS1BdXRyZXMgVmlucyBkZSBsaXF1ZXVyFEZsb2MgZGUgR2FzY29nbmUgQU9DEk1hY3ZpbiBkdSBKdXJhIEFPQxhQaW5lYXUgZGVzIENoYXJlbnRlcyBBT0NRVmlhbmRlIGQnYWduZWF1IGLDqW7DqWZpY2lhbnQgZCd1biBzaWduZSBvZmZpY2llbCBkZSBxdWFsaXTDqSAoTFIsIElHUCwgQU9DLCBBT1ApD1ZpYW5kZSBkZSBib2V1Zg5WaWFuZGUgZGUgcG9yY1BWaWFuZGUgZGUgdmVhdSBiw6luw6lmaWNpYW50IGQndW4gc2lnbmUgb2ZmaWNpZWwgZGUgcXVhbGl0w6kgKExSLCBJR1AsIEFPQywgQU9QKRVmAi0xBTQ0NTk1BTQ0NjA4BTQ0NjA5BTQ0NjE3BTQ0NjQ4BTQ0NTk2BTQ0NjYyBTQ0NjY3BTQ0NjY4BTQ0NjAxBTQ0NjAyBTQ0NjAzBTQ0NjA0BTQ0NjA1BTQ0NjA2BTQ0NjA3BTQ0NjExBTQ0NjQ1BTQ0NjQ2BTQ0NjU5BTQ0NjY5BTQ0Njc5BTQ0NjgzBTQ0Njg0BTQ0Njg1BTQ0NjEyBTQ0NjEzBTQ0NjE0BTQ0NjE1BTQ0NjE2BTQ0NjYzBTQ0NjE5BTQ0NjIxBTQ0NjI1BTQ0NjUwBTQ0NTk3BTQ0NjEwBTQ0NjE4BTQ0NjIzBTQ0NjI0BTQ0NjcwBTQ0NjcxBTQ0NTk4BTQ0NjQ0BTQ0NjUyBTQ0NjUzBTQ0NjU0BTQ0NjM0BTQ0NjM1BTQ0NjM2BTQ0NjU1BTQ0NjU2BTQ0NjU3BTQ0NjU4BTQ0Njg2BTQ0NjM3BTQ0NjM4BTQ0NjM5BTQ0NjQwBTQ0NjQxBTQ0NjQyBTQ0NjQzBTQ0NjI3BTQ0NjI4BTQ0NjI5BTQ0NjMwBTQ0NjUxBTQ0NjgwBTQ0NjgxBTQ0NjYwAi0zBTQ0NjMxAi0yBTQ0NjAwBTQ0NjIwBTQ0NjIyBTQ0NjMyBTQ0NjMzBTQ0NjQ3BTQ0NjkzBTQ0NjY0BTQ0NjY1BTQ0NjY2BTQ0NjcyBTQ0NjczBTQ0Njc0BTQ0Njc1BTQ0Njc2BTQ0Njc3BTQ0Njc4BTQ0NjgyBTQ0Njg3BTQ0Njg4BTQ0NTk5BTQ0NjI2BTQ0NjQ5BTQ0NjYxBTQ0Njg5BTQ0NjkwBTQ0NjkxBTQ0NjkyFCsDZmdnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2RkAhUPEA8WBh8BZx8CBQ50ZXh0Ym94SW5wdXRfMh8DAgJkEBUCFS0tLSBOb21lbmNsYXR1cmUgPy0tLQAVAgItMQItMRQrAwJnZ2RkAhcPFgIeBXN0eWxlBQ5kaXNwbGF5OmJsb2NrO2QCGQ8WAh8EBQ5kaXNwbGF5OmJsb2NrOxYEAgEPEA8WBh8BZx8CBQ50ZXh0Ym94SW5wdXRfMR8DAgJkEBUPEC0tLSBSw6lnaW9uID8tLS0VQXV2ZXJnbmUtUmjDtG5lLUFscGVzGEJvdXJnb2duZS1GcmFuY2hlLUNvbXTDqQhCcmV0YWduZRNDZW50cmUtVmFsIGRlIExvaXJlBUNvcnNlB0RPTS1UT00JR3JhbmQtRXN0D0hhdXRzLWRlLUZyYW5jZQ1JbGUtZGUtRnJhbmNlCU5vcm1hbmRpZRJOb3V2ZWxsZS1BcXVpdGFpbmUJT2NjaXRhbmllEFBheXMgZGUgbGEgTG9pcmUbUHJvdmVuY2UtQWxwZXMtQ8O0dGUgZCdBenVyFQ8CLTEBMQEyATMBNAE1AjE0ATYBNwE4ATkCMTACMTECMTICMTMUKwMPZ2dnZ2dnZ2dnZ2dnZ2dnZGQCAw8QDxYGHwFnHwIFDnRleHRib3hJbnB1dF8yHwMCAmQQFQ0VLS0tIETDqXBhcnRlbWVudCA/LS0tCEFpbiAoMDEpC0FsbGllciAoMDMpDUFyZMOoY2hlICgwNykLQ2FudGFsICgxNSkLRHLDtG1lICgyNikLSXPDqHJlICgzOCkKTG9pcmUgKDQyKRBIYXV0ZS1Mb2lyZSAoNDMpEFB1eS1kZS1Eb21lICg2MykLUmjDtG5lICg2OSkLU2F2b2llICg3MykRSGF1dGUtU2F2b2llICg3NCkVDQItMQIwMQIwMwIwNwIxNQIyNgIzOAI0MgI0MwI2MwI2OQI3MwI3NBQrAw1nZ2dnZ2dnZ2dnZ2dnZGQCHQ8PFgIeBFRleHQFGFJFQ0hFUkNIRSBBVkFOQyZFYWN1dGU7RRYCHwQFDWRpc3BsYXk6bm9uZTtkAh8PDxYCHwUFGFJFQ0hFUkNIRSBBVkFOQyZFYWN1dGU7RRYCHwQFDmRpc3BsYXk6YmxvY2s7ZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WAwUXY3RsMDAkY3RsMDAkQ1BIJENQSCRNXzEFF2N0bDAwJGN0bDAwJENQSCRDUEgkTV8yBRdjdGwwMCRjdGwwMCRDUEgkQ1BIJE1fM9DDnQaPRC4ii4jw9fgq3iP3UHwn",
    "__EVENTVALIDATION" => "/wEWvQECkdnpvgYCgYOpiQ4CwpT2lwMCwpTa8AsCwpSuXALClLK5CQLClIaCDgLClOrvBgLClP7IDwLClMKVBAKprfCMAwKprcTpCwKpreiADQKprfztBQKprcC2CgKprdSTAwLvusj6BgLs1a6XCgKIusGQDgKIusXxDAKIurHVBwLt0MK9CALt0L6RAwLt0KrqCwKIur30BgLt0IbPAgLt0NreDALt0OLaAgLt0PKgDQLt0O6FBALy6eCmDgLy6aSwCALt0N6/DQLy6dz7BgLy6cjcAQLt0LayBwLy6ZCVAwLy6YzuCwLy6fjDAgLy6dSkDQLy6fygAwLy6YDPCAKIuqnJAQLV4IGzCALWj+feBAKjwLiwAwLT6sopAtDqyikCxuq2jAcC0+r6ng0CrMC4sAMCxerSxAsCxurSxAsC0+rSxAsC2OrKKQLF6sopAtrqyikCx+rKKQLE6sopAsHqyikCxurKKQLY6raMBwLE6vqeDQLB6vqeDQLQ6ubhBALQ6tLECwLQ6r6vAwLa6urABQLH6urABQLE6urABQLF6raMBwLa6raMBwLH6raMBwLE6raMBwLB6raMBwLa6tLECwLQ6raMBwLY6qLXDgLE6qLXDgLb6ubhBAKtwLiwAwLb6raMBwLT6raMBwLa6qLXDgLH6qLXDgLb6r6vAwLY6r6vAwK+wLiwAwLH6vqeDQLF6ubhBALa6ubhBALH6ubhBALH6o66BgLE6o66BgLB6o66BgLE6ubhBALB6ubhBALG6ubhBALT6ubhBALB6urABQLG6o66BgLT6o66BgLQ6o66BgLb6vqeDQLY6vqeDQLF6vqeDQLa6vqeDQLG6qLXDgLT6qLXDgLQ6qLXDgLb6o66BgLY6ubhBALb6urABQLY6urABQLb6tLECwLWj9/eBALY6o66BgLWj+PeBALb6sopAtvqotcOAsXqotcOAsXqjroGAtrqjroGAsbq+p4NAtrq1qsNAsfq0sQLAsTq0sQLAsHq0sQLAsXqvq8DAtrqvq8DAsfqvq8DAsTqvq8DAsHqvq8DAsbqvq8DAtPqvq8DAsXq6sAFAsbq6sAFAtPq6sAFAr/AuLADAsHqotcOAtDq+p4NAtjq0sQLAtDq6sAFAtvq1qsNAtjq1qsNAsXq1qsNApir2Z0GApvEv/AKApvEv/AKAovF29UIAteF5LAHArycxpsNAqGzqIYDAujW+P4KAuu5npMGAue50pAGAua50pAGAuW50pAGAuS50pAGAuO50pAGAue5opMGAuK50pAGAuG50pAGAvC50pAGAv+50pAGAue5kpMGAue5npMGAue5mpMGAue5ppMGAqf74KsCAqSUhsYOAreUhsYOAreUvsYOAreUrsYOAqiUtsYOAqmUssYOAqqU6sUOAquUgsYOAquUvsYOAq2UvsYOAq2U5sUOAq6UvsYOAq6UusYOAsLs8IgEAvvR6qcOAr6R2tAHAsSHo4YCAsyk86AFAqTu2aMNtbZFvcZBp7JsyFHegiY36ha+i/Q=",
    "ctl00$ctl00$CPH$CPH$DDL_CLASSES" => "-1",
    "ctl00$ctl00$CPH$CPH$DDL_CATEGORIES" => "-1",
    "ctl00$ctl00$CPH$CPH$DDL_NOMENCLATURES" => "-1",
    "ctl00$ctl00$CPH$CPH$T_MARQUE" => "",
    "ctl00$ctl00$CPH$CPH$M_1" => "on",
    "ctl00$ctl00$CPH$CPH$M_2" => "on",
    "ctl00$ctl00$CPH$CPH$M_3" => "on",
    "ctl00$ctl00$CPH$CPH$DDL_REGIONS" => "1",
    "ctl00$ctl00$CPH$CPH$DDL_DEPARTEMENTS" => "-1",
    "ctl00$ctl00$CPH$CPH$T_ACCES_CANDIDAT" => "",
    "ctl00$ctl00$CPH$CPH$T_PRODUCTEUR" => "",
    "ctl00$ctl00$CPH$CPH$T_AFFINEUR" => ""
  }

  HOST = "http://www.concours-agricole.com/produits_palmares_rech.aspx"

  def initialize(attributes)
    @year = attributes[:year]
  end

  def scrap
    response = RestClient.post(HOST, data)
    page = Nokogiri::HTML(response)

    page.search("tr .tr_detail_produit").map do |elem|
      extract_interest_zones_for(elem)


      {
        medaille: medaille_for(elem),
        company_email: email_for(elem),
        phone: phone_for(elem),
        zipcode: zipcode_for(elem),
        city: city_for(elem),
        address: @right_data_result[1],
        name: @right_data_result[0],
        category: @left_data_result[0],
        description: @left_data_result.join(" ")
      }

    end
  end

  private

  def extract_interest_zones_for(elem)
    elem.search(".detail_produit_gauche br").each { |n| n.replace("\n") }
    elem.search(".detail_produit_droite br").each { |n| n.replace("\n") }
    @right_data_result = elem.search(".detail_produit_droite").text.split("\n")
    @left_data_result = elem.search(".detail_produit_gauche").text.split("\n")
  end

  def medaille_for(elem)
    elem.search(".detail_produit_gauche>img").attr("src").text.match(/\d{1}/).to_s
  end

  def email_for(elem)
    data = @right_data_result.find do |elem|
      elem.match(/Email/)
    end
    data.split(':').last if data != nil
  end

  def phone_for(elem)
    data = @right_data_result.find do |elem|
      elem.match(/^Tél :/)
    end

    data.split(":").last if data != nil
  end

  def zipcode_for(elem)
    data = @right_data_result.find do |elem|
      elem.match(/((^\d{2}|2[AB])\d{3})/)
    end

    data.split(" ").first
  end

  def city_for(elem)
    data = @right_data_result.find do |elem|
      elem.match(/((^\d{2}|2[AB])\d{3})/)
    end

    data.split(/((^\d{2}|2[AB])\d{3})/).last.strip
  end

  def data
    BODY.merge({ "ctl00$ctl00$CPH$CPH$DDL_ANNEES" => @year.to_s })
  end
end





