# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build
MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# For every <dir>/repos.txt, symlink each listed repo's sibling working tree
# (e.g. ../muxdoc) into <dir>/ so the build picks up un-pushed local changes.
# Skips any target that already exists (e.g. cloned by CI) so it is never
# clobbered.
link:
	@for list in */repos.txt; do \
		[ -e "$$list" ] || continue; \
		dest="$${list%/repos.txt}"; \
		while read -r repo branch _; do \
			case "$$repo" in ''|\#*) continue ;; esac; \
			name="$${repo##*/}"; \
			if [ -e "$$dest/$$name" ]; then \
				echo "$$dest/$$name already present, skipping link"; \
			elif [ -d "$(MAKEFILE_DIR)../$$name" ]; then \
				echo "Linking ../$$name -> $$dest/$$name"; \
				ln -s "$(MAKEFILE_DIR)../$$name" "$$dest/$$name"; \
			else \
				echo "WARNING: no sibling ../$$name and $$dest/$$name not present"; \
			fi; \
		done < "$$list"; \
	done

# Remove only the symlinks we created; leave real (cloned) directories alone.
unlink:
	@for list in */repos.txt; do \
		[ -e "$$list" ] || continue; \
		dest="$${list%/repos.txt}"; \
		while read -r repo branch _; do \
			case "$$repo" in ''|\#*) continue ;; esac; \
			name="$${repo##*/}"; \
			if [ -L "$$dest/$$name" ]; then \
				echo "Unlinking $$dest/$$name"; \
				rm "$$dest/$$name"; \
			fi; \
		done < "$$list"; \
	done

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	$(MAKE) link
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	$(MAKE) unlink


.PHONY: help link unlink Makefile
