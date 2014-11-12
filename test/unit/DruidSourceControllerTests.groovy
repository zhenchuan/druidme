

import org.junit.*
import grails.test.mixin.*

@TestFor(DruidSourceController)
@Mock(DruidSource)
class DruidSourceControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/druidSource/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.druidSourceInstanceList.size() == 0
        assert model.druidSourceInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.druidSourceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.druidSourceInstance != null
        assert view == '/druidSource/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/druidSource/show/1'
        assert controller.flash.message != null
        assert DruidSource.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/druidSource/list'

        populateValidParams(params)
        def druidSource = new DruidSource(params)

        assert druidSource.save() != null

        params.id = druidSource.id

        def model = controller.show()

        assert model.druidSourceInstance == druidSource
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/druidSource/list'

        populateValidParams(params)
        def druidSource = new DruidSource(params)

        assert druidSource.save() != null

        params.id = druidSource.id

        def model = controller.edit()

        assert model.druidSourceInstance == druidSource
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/druidSource/list'

        response.reset()

        populateValidParams(params)
        def druidSource = new DruidSource(params)

        assert druidSource.save() != null

        // test invalid parameters in update
        params.id = druidSource.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/druidSource/edit"
        assert model.druidSourceInstance != null

        druidSource.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/druidSource/show/$druidSource.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        druidSource.clearErrors()

        populateValidParams(params)
        params.id = druidSource.id
        params.version = -1
        controller.update()

        assert view == "/druidSource/edit"
        assert model.druidSourceInstance != null
        assert model.druidSourceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/druidSource/list'

        response.reset()

        populateValidParams(params)
        def druidSource = new DruidSource(params)

        assert druidSource.save() != null
        assert DruidSource.count() == 1

        params.id = druidSource.id

        controller.delete()

        assert DruidSource.count() == 0
        assert DruidSource.get(druidSource.id) == null
        assert response.redirectedUrl == '/druidSource/list'
    }
}
