//
//  GalleryPresenterTests.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 14.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import XCTest

@testable import Gallery

class GalleryPresenterTests: XCTestCase {
    
    var viewSpy: GalleryViewSpy!
    var useCaseFactory: TestUseCaseFactory!
    var routerFactory: TestRouterFactory!
    
    override func setUp() {
        super.setUp()
        viewSpy = GalleryViewSpy()
        useCaseFactory = TestUseCaseFactory()
        routerFactory = TestRouterFactory()
    }

    func test_gallery_presenter_list_images_success() throws {
        let images = FixtureHelper().createImages()
        let listImagesUseCase = ListImagesUseCaseStub()
        listImagesUseCase.resultToBeReturned = .success(images)
        useCaseFactory.listImagesUseCase = listImagesUseCase
        
        let presenter = GalleryPresenter(view: viewSpy, useCaseFactory: useCaseFactory, routerFactory: routerFactory)
        presenter.loadImages()
        
        XCTAssertEqual(GalleryViewState.listing(images), viewSpy.currentState)
    }
    
    func test_gallery_presenter_list_images_failure() throws {
        let listImagesUseCase = ListImagesUseCaseStub()
        listImagesUseCase.resultToBeReturned = .failure(TestError.test)
        useCaseFactory.listImagesUseCase = listImagesUseCase
        
        let presenter = GalleryPresenter(view: viewSpy, useCaseFactory: useCaseFactory, routerFactory: routerFactory)
        presenter.loadImages()
        
        XCTAssertEqual(GalleryViewState.failure(TestError.test), viewSpy.currentState)
    }
    
    func test_gallery_presenter_present_editor() throws {
        let editorViewRouter = EditorViewRouterSpy()
        routerFactory.editorViewRouter = editorViewRouter
        let presenter = GalleryPresenter(view: viewSpy, useCaseFactory: useCaseFactory, routerFactory: routerFactory)
        
        let localImage = FixtureHelper().createLocalImage()
        presenter.presentEditor(for: localImage)
        
        XCTAssertEqual(editorViewRouter.imageToEdit, localImage)
    }

}
