//
//  LanguageResourcesTests.swift
//  CodeEditLanguages
//


import XCTest
import CodeEditLanguages

final class LanguageResourcesTests: XCTestCase {
	/// This package is resource-only: ensure bundled query folders are usable by consumers.
	func test_treeSitterResourceFoldersContainHighlights() throws {
		let root = try XCTUnwrap(resourceUrl)
		let entries = try FileManager.default.contentsOfDirectory(
			at: root,
			includingPropertiesForKeys: [URLResourceKey.isDirectoryKey],
			options: [.skipsHiddenFiles]
		)

		let languageDirectories = try entries.filter { url in
			guard url.lastPathComponent.hasPrefix("tree-sitter-") else {
				return false
			}
			let values = try url.resourceValues(forKeys: [URLResourceKey.isDirectoryKey])
			return values.isDirectory == true
		}

		XCTAssertFalse(languageDirectories.isEmpty, "No tree-sitter resource directories were found.")

		for dir in languageDirectories {
			let highlightURL = dir.appendingPathComponent("highlights.scm")
			XCTAssertTrue(
				FileManager.default.fileExists(atPath: highlightURL.path),
				"Missing highlights.scm in \(dir.lastPathComponent)"
			)
		}
	}

	func test_queryFilesUseScmExtension() throws {
		let root = try XCTUnwrap(resourceUrl)
		let entries = try FileManager.default.contentsOfDirectory(
			at: root,
			includingPropertiesForKeys: [URLResourceKey.isDirectoryKey],
			options: [.skipsHiddenFiles]
		)

		for dir in entries where dir.lastPathComponent.hasPrefix("tree-sitter-") {
			let values = try dir.resourceValues(forKeys: [URLResourceKey.isDirectoryKey])
			guard values.isDirectory == true else { continue }

			let files = try FileManager.default.contentsOfDirectory(
				at: dir,
				includingPropertiesForKeys: [URLResourceKey.isRegularFileKey],
				options: [.skipsHiddenFiles]
			)
			for file in files {
				let fileValues = try file.resourceValues(forKeys: [URLResourceKey.isRegularFileKey])
				guard fileValues.isRegularFile == true else { continue }
				XCTAssertEqual(
					file.pathExtension,
					"scm",
					"Unexpected non-.scm file in \(dir.lastPathComponent): \(file.lastPathComponent)"
				)
			}
		}
	}
}
