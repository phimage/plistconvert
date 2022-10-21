import XcodeProjKit
import ArgumentParser
import Foundation

extension PropertyList.Format {
    init?(string: String) {
        switch string.lowercased()  {
            case "openstep":
                self = .openStep
            case "xml", "xml1":
                self = .xml
            case "json":
                self = .json
            case "binary":
                self = .binary
            default:
                return nil
        }
    }
}

struct Cmd: ParsableCommand {

    @Option(name: .shortAndLong, help: "Specify an alternate path name for the result of the convert operation")
    var output: String?

    @Option(name: .long, help: "Specify an alternate extension for converted file")
    var `extension`: String?

    @Option(name: .long, help: "Convert the named file to the indicated format")
    var convert: String

    @Argument(help: "File to convert")
    var path: String

    var format: PropertyList.Format {
        return PropertyList.Format(string: convert) ?? .xml
    }

    var outputURL: URL {
        if let output = self.output {
            return URL(fileURLWithPath: output)
        }
        if let ext = self.`extension` {
            return URL(fileURLWithPath: self.path).deletingPathExtension().appendingPathExtension(ext)
        }
        return URL(fileURLWithPath: self.path)
    }

    mutating func run() throws {
        let url = URL(fileURLWithPath: self.path)
        let xcodeProj = try XcodeProj(url: url)

        try xcodeProj.write(to: outputURL, format: self.format)
    }
}

Cmd.main()