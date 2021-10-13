import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    var xmlParser = XMLParser()

    var currentElement = ""
    var items = [[String : String]]()
    var item = [String : String]()
    var vaccinetpcd = ""
    var vaccinefirstCnt = ""
    var vaccinesecondCnt = ""
    var vaccinethirdCnt = ""

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestVaccineSidoInfo()
    }

    func requestVaccineSidoInfo() {
        let url = "https://nip.kdca.go.kr/irgd/cov19stats.do?list=all"
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        xmlParser.delegate = self
        xmlParser.parse()
    }
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            item = [String : String]()
            vaccinetpcd = ""
            vaccinefirstCnt = ""
            vaccinesecondCnt = ""
            vaccinethirdCnt = ""
            //print("didStartElement")
        }
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            item["tpcd"] = vaccinetpcd
            item["firstCnt"] = vaccinefirstCnt
            item["secondCnt"] = vaccinesecondCnt
            item["thridCnt"] = vaccinethirdCnt
            items.append(item)

            //print("didEndElement")
        }

    }

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "tpcd" {
            vaccinetpcd = string
            if vaccinetpcd != "" {
            print("시도명: \(vaccinetpcd)")
            }
        } else if (currentElement == "firstCnt") {
            vaccinefirstCnt = string
            print("1차 백신 총 접종자 수: \(vaccinefirstCnt)")

        } else if (currentElement == "secondCnt") {
            vaccinesecondCnt = string
            print("2차 백신 총 접종자 수: \(vaccinesecondCnt)")

        } else if (currentElement == "thirdCnt") {
            vaccinethirdCnt = string
            print("3차 백신 총 접종자 수: \(vaccinethirdCnt)")

        }
    }
}
