;;; code-maater.el --- An Emacs interface to =code-maat=
;;
;; Filename: code-maater.el
;; Description:An Emacs interface to =code-maat=
;; Author: Francis Murillo
;; Maintainer:Francis Murillo
;; Created: Sun Aug 28 08:31:20 2016 (+0800)
;; Version: 0.10
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 0
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


(require 'vc)
(require 's)
(require 'dash)
(require 'f)
(require 'deferred)
(require 'tabulated-list)

(defgroup code-maater nil
  "Analyze your project using code-maat."
  :prefix "code-maater/"
  :group 'tools
  :tag "Github" "https://github.com/FrancisMurillo/code-maater.el")


(define-derived-mode code-maater-mode tabulated-list-mode "Code Maater"
  "A special mode for using =code-maat= output"
  (setq mode-name "Code Maater"))



(defcustom code-maater/code-maat-jar nil
  "Where the standalone code-maat jar is located."
  :group 'code-maater
  :type '(file :must-match t))

(defcustom code-maater/code-maat-runner 'java
  "Whether to run code-maat with 'java or 'lein or provide a list of command arguments if this isn't enough."
  :group 'code-maater
  :type 'symbol)

(defcustom code-maater/project-root-function #'vc-root-dir
  "How to determine the current project root directory."
  :group 'code-maater
  :type 'function)

(defcustom code-maater/deduce-project-vcs-function code-maater/deduce-project-vcs
  "How to determine the current project."
  :group 'code-maater
  :type 'function)


(defvar code-maater/current-project nil
  "The current project directory being analyzed.")

(defvar code-maater/current-project-log nil
  "The current project log file being examined.")


(defun code-maater/deduce-project-vcs ()
  "A simple wrapper for vc-deduce-backend which maps to the known code-maat supported types."
  (pcase (vc-deduce-backend)
    ;; TODO: Not the best deducer and probably missing some other mapping
    (`Git 'git)
    (`SVN 'svn)
    (`Hg 'hg)
    ;; TODO: p4 and tfs are missing
    (_ nil)))

(defun code-maater ()
  "Analyze current project with code-maat.")


(provide 'code-maater)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; code-maater.el ends here
