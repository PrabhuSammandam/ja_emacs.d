(defun compile-pkg (&optional command startdir)
  "Compile a package, moving up to the parent directory
  containing configure.ac, if it exists. Start in startdir if defined,
  else start in the current directory."
  (interactive)

  (let ((dirname)
	(dir-buffer nil))
    (setq startdir (expand-file-name (if startdir startdir ".")))
    (setq command  (if command command compile-command))

    (setq dirname (upward-find-file "make_evo" startdir))
    (setq dirname (if dirname dirname (upward-find-file "make_evo" startdir)))
    (setq dirname (if dirname dirname (expand-file-name ".")))
    ; We've now worked out where to start. Now we need to worry about
    ; calling compile in the right directory
    (save-excursion
      (setq dir-buffer (find-file-noselect dirname))
      (set-buffer dir-buffer)
      (compile dirname)
      (kill-buffer dir-buffer))))

(defun upward-find-file (filename &optional startdir)
  "Move up directories until we find a certain filename. If we
  manage to find it, return the containing directory. Else if we
  get to the toplevel directory and still can't find it, return
  nil. Start at startdir or . if startdir not given"

  (let ((dirname (expand-file-name
		  (if startdir startdir ".")))
	(found nil) ; found is set as a flag to leave loop if we find it
	(top nil))  ; top is set when we get
		    ; to / so that we only check it once

    ; While we've neither been at the top last time nor have we found
    ; the file.
    (while (not (or found top))
      ; If we're at / set top flag.
      (if (string= (expand-file-name dirname) "/")
	  (setq top t))
      
      ; Check for the file
      (if (file-exists-p (expand-file-name filename dirname))
	  (setq found t)
	; If not, move up a directory
	(setq dirname (expand-file-name ".." dirname))))
					; return statement
    (message dirname)
    (if found dirname nil)))

(defun mor_build()
  "Compile the mor build repository"
  (interactive)
  (setq mor_compile_command "./make_evo release dspuc4 NFS_MOUNT=ON SOFTWARE_VERSION=CI_2020_03_0083 NDS_SW_VER=CI_2020_03_0083 PROCESS_LINK=ON MAKE=/usr/bin/make")
  (compile-pkg mor_compile_command))

(defun compile-next-makefile ()
  (interactive)
  (let* ((default-directory (or (upward-find-file "build_system") "."))
	 (compile-command (concat "cd " default-directory "/build_system" " && "  "./make_evo release dspuc4 NFS_MOUNT=ON SOFTWARE_VERSION=CI_2020_03_0083 NDS_SW_VER=CI_2020_03_0083 PROCESS_LINK=ON MAKE=/usr/bin/make")))
    (compile compile-command))) 
