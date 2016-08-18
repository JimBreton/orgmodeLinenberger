(require 'org-install)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key mode-specific-map [?a] 'org-agenda)

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)
     (define-key org-mode-map "\C-cx" 'org-todo-state-map)
     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "t"
       #'(lambda nil (interactive) (org-todo "TODO")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "W/F")))
     ))


(custom-set-variables
 '(org-agenda-files (quote ("~/org/tasks.org")))
;;; notes-file is for org-capture
 '(org-default-notes-file (quote ("~/org/inbox.org")))
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-todo-keywords '((type "STARTED" "W/F" "TODO" "|" "DONE" "CANCELLED")))
 '(org-priorities (list ?A ?B ?C))
 '(org-highest-priority ?A)
 '(org-lowest-priority ?C)
 '(org-default-priority ?B)
 '(org-agenda-todo-ignore-scheduled 'all)
 '(org-agenda-tags-todo-honor-ignore-options t)
 '(org-agenda-custom-commands
   (quote (("d" todo "DONE" nil)
           ("c" todo "DONE|CANCELLED" nil)
	   ("w" todo "W/F" nil)
	   ("W" agenda "" ((org-agenda-ndays 21)))
	   ("A" agenda ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
	     (org-agenda-ndays 1)
	     (org-agenda-overriding-header "Today's Priority #A tasks: ")))
	   ("u" alltodo ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote scheduled) (quote deadline)
					  (quote regexp) "\n]+>")))
	     (org-agenda-overriding-header "Unscheduled TODO entries: ")))
;;; "l" is the agenda related to linenberger setup
;;; it has four sections 
          ("l" "Linenberger" (
;;; for SOC we select tag = :SOC: which is found by looking for a regular expression
;;;; we have org-agenda-ndays 1 which means it will look only for current day and before
;;; ordering is scheduled up and then todo state up  
	     (agenda "" 
	      ((org-agenda-overriding-header "SOC") 
               (org-agenda-skip-function
	       (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*:SOC:")))
              (org-agenda-ndays 1)
              (org-agenda-sorting-strategy (quote (scheduled-up)))))
;;; for Critical Now we select priority = [#A] which is found by looking for a regular expression
;;;; we have org-agenda-ndays 1 which means it will look only for current day and before
;;; ordering is scheduled down and then todo state up  
             (agenda "" 
              ((org-agenda-overriding-header "Critical Now") 
               (org-agenda-skip-function
	       (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
               (org-agenda-ndays 1)
               (org-agenda-sorting-strategy (quote (scheduled-down)))))
;;; for Critical Now we select priority = [#B] which is found by looking for a regular expression
;;;; we have org-agenda-ndays 1 which means it will look only for current day and before
;;; ordering is scheduled down and then todo state up  
;;; Target now contains items which are scheduled for today
            (agenda "" 
             ((org-agenda-overriding-header "Opportunity Now") 
              (org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#B\\]")))
              (org-agenda-ndays 1)
              (org-agenda-sorting-strategy (quote (scheduled-down))))))
   nil nil) ))))

;;; use capture (instead of remember which is replaced by capture)
(require 'org-capture) 

(define-key global-map "\C-cc" 'org-capture)

;;; create a capture template which sets priority B and Scheduled for today

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
             "* TODO [#B] %?\n   SCHEDULED: <%<%Y-%m-%d %a>>\n  [%<%Y-%m-%d %a>]\n  %a")))

;;; where capture notes should go
;;; for org-capture templates it is given there explicitly 

(setq org-default-notes-file "~/org/inbox.org")








;; let the global todo list only show events which are not scheduled

;; (setq org-agenda-todo-ignore-scheduled 'all)
;; (setq org-agenda-tags-todo-honor-ignore-options t)

(defun org-agenda-show-only-unscheduled ()
   (interactive)
   (setq org-agenda-todo-ignore-scheduled 'all)
   (setq org-agenda-tags-todo-honor-ignore-options t)
)


;;;; https://github.com/jwiegley/newartisans/blob/master/posts/2007-08-20-using-org-mode-as-a-day-planner.md





;;(setq org-agenda-todo-ignore-scheduled 'all)
;; (setq org-agenda-todo-ignore-scheduled nil)




;;; use capture (instead of remember which is replaced by capture)
(require 'org-capture) 

(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/git/inbox.org" "Tasks")
             "* TODO [#B] %?\n   SCHEDULED: <%<%Y-%m-%d %a>>\n  [%<%Y-%m-%d %a>]\n  %a")))

(setq org-default-notes-file "~/git/inbox.org")
