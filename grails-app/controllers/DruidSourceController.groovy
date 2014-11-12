import org.springframework.dao.DataIntegrityViolationException

class DruidSourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [druidSourceInstanceList: DruidSource.list(params), druidSourceInstanceTotal: DruidSource.count()]
    }

    def create() {
        [druidSourceInstance: new DruidSource(params)]
    }

    def save() {
        def druidSourceInstance = new DruidSource(params)
        if (!druidSourceInstance.save(flush: true)) {
            render(view: "create", model: [druidSourceInstance: druidSourceInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), druidSourceInstance.id])
        redirect(action: "show", id: druidSourceInstance.id)
    }

    def show(Long id) {
        def druidSourceInstance = DruidSource.get(id)
        if (!druidSourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            redirect(action: "list")
            return
        }

        [druidSourceInstance: druidSourceInstance]
    }

    def edit(Long id) {
        def druidSourceInstance = DruidSource.get(id)
        if (!druidSourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            redirect(action: "list")
            return
        }

        [druidSourceInstance: druidSourceInstance]
    }

    def update(Long id, Long version) {
        def druidSourceInstance = DruidSource.get(id)
        if (!druidSourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (druidSourceInstance.version > version) {
                druidSourceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'druidSource.label', default: 'DruidSource')] as Object[],
                          "Another user has updated this DruidSource while you were editing")
                render(view: "edit", model: [druidSourceInstance: druidSourceInstance])
                return
            }
        }

        druidSourceInstance.properties = params

        if (!druidSourceInstance.save(flush: true)) {
            render(view: "edit", model: [druidSourceInstance: druidSourceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), druidSourceInstance.id])
        redirect(action: "show", id: druidSourceInstance.id)
    }

    def delete(Long id) {
        def druidSourceInstance = DruidSource.get(id)
        if (!druidSourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            redirect(action: "list")
            return
        }

        try {
            druidSourceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            redirect(action: "show", id: id)
        }
    }
}
