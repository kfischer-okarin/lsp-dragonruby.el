;;; lsp-dragonruby.el --- lsp-mode dragonruby integration -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Kevin Fischer

;; Author: Kevin Fischer <kevin@kf-labo.dev>
;; Keywords: languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;  Client for DragonRuby Language Server

;;; Code:

(require 'lsp-mode)

(defun lsp-dragonruby--is-dragonruby-project (buffer-filename major-mode)
  (and (locate-dominating-file buffer-filename "app/main.rb")
       (or (eq major-mode 'ruby-mode)
           (eq major-mode 'enh-ruby-mode))))

(setq lsp-dragonruby--relay-path
      (expand-file-name "dragonruby-lsp-relay" (file-name-directory load-file-name)))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection `("node" ,lsp-dragonruby--relay-path))
                  :add-on? t
                  :activation-fn #'lsp-dragonruby--is-dragonruby-project
                  :priority 10
                  :server-id 'dragonruby-ls))

(provide 'lsp-dragonruby)
;;; lsp-dragonruby.el ends here
