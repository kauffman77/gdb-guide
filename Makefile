CLASS=tutorials
# Files to upload, use a shell command to list them but only upload
# the most recent determined by the count arg to head
FILES=gdb.html *.png

# Files above but with directory name stripped
BASEFILES=$(notdir $(FILES))

WEB_MOUNT=${HOME}/www/$(CLASS)
PUBLIC_MIRROR=${HOME}/github-pages

gdb.html : gdb.org
	emacs $< --batch \
	  --eval '(load-file "~/.emacs")' \
	  --eval "(package-initialize)" \
	  --eval "(setq org-export-allow-bind-keywords t)" \
	  -f org-html-export-to-html \
	  --kill

push: 
	make mirror

# make web

# mount :
# 	@echo ========================================
# 	@echo MOUNTING
# 	mntweb
# 	@echo

# web : mount
# 	@echo ========================================
# 	@echo WEB: Pushing
# 	@for f in ${FILES}; do printf '  %s\n' $$f; done
# 	@echo to $(WEB_MOUNT)
# 	mkdir -p $(WEB_MOUNT) && chmod a+rX $(WEB_MOUNT)
# 	cp -r $(FILES) $(WEB_MOUNT)
# 	cd $(WEB_MOUNT) && chmod -R g+rw,a+r $(BASEFILES)
# 	@echo

mirror :
	@echo ========================================
	@echo MIRROR: Copying to mirror directory and pushing
	mkdir -p "$(PUBLIC_MIRROR)/$(CLASS)"
	cp -a $(FILES) $(PUBLIC_MIRROR)/$(CLASS)
	cd $(PUBLIC_MIRROR) && ./do_mirror

