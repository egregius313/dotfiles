(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-cons-mode-line-p nil t)
 '(auto-save-default nil)
 '(avy-keys-alist
   '((avy-goto-line 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122)))
 '(backup-by-copying t)
 '(backup-directory-alist '(("." . "~/.saves/")))
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(browse-url-browser-function 'browse-url-generic)
 '(browse-url-generic-program "firefox")
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(custom-safe-themes
   '("80365dd15f97396bdc38490390c23337063c8965c4556b8f50937e63b5e9a65c" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "84da7b37214b4ac095a55518502dfa82633bee74f64daf6e1785322e77516f96" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "c30633c6acc15ab088ef409e6947ae987d3579c682c120027835fc45da1e000d" "e39ff005e524c331b08d613109bff0b55fc21c64914c4a243faa70f330015389" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
	 ("2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" default)
	 "2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" default))
 '(dashboard-banner-logo-title "" t)
 '(dashboard-items '((recents . 5) (projects . 5) (bookmarks . 5)) t)
 '(dashboard-startup-banner "/home/egregius313/.emacs.d/img/gods_lament.png" t)
 '(delete-old-versions t)
 '(dired-details-hidden-string "" t)
 '(dired-dwim-target t)
 '(dired-wormhole-code-length nil)
 '(display-line-numbers-type 'relative)
 '(display-time-24hr-format t)
 '(display-time-format "%H:%M - %B %d %Y")
 '(display-time-mode t)
 '(doom-modeline-buffer-file-name-style 'buffer-name t)
 '(doom-modeline-major-mode-color-icon t t)
 '(egregius313/feeds-directory "/home/egregius313/Projects/feeds/" t)
 '(enable-recursive-minibuffers t)
 '(exwm-randr-workspace-monitor-plist '(0 "HDMI1" 1 "eDP1" 2 "HDMI1"))
 '(exwm-randr-workspace-output-plist '(0 "DP-1"))
 '(exwm-workspace-number 1)
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
	 ("#679A01" . 20)
	 ("#4BBEAE" . 30)
	 ("#1DB4D0" . 50)
	 ("#9A8F21" . 60)
	 ("#A75B00" . 70)
	 ("#F309DF" . 85)
	 ("#3C3D37" . 100)))
 '(ivy-use-virtual-buffers t)
 '(jdee-db-active-breakpoint-face-colors (cons "#f2f2f2" "#4271ae"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f2f2f2" "#718c00"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f2f2f2" "#a5a4a5"))
 '(kept-new-versions 6)
 '(kept-old-versions 2)
 '(key-chord-two-keys-delay 0.2 t)
 '(line-number-mode t)
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(nyan-animate-nyancat t)
 '(nyan-wavy-trail nil)
 '(objed-cursor-color "#c82829")
 '(org-ellipsis " ")
 '(org-use-speed-commands t)
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(powerline-default-separator nil)
 '(restart-emacs-restore-frames t t)
 '(rmh-elfeed-org-files
   '("/home/egregius313/Projects/feeds/README.org" "/home/egregius313/Projects/feeds/cooking.org" "/home/egregius313/Projects/feeds/feeds.org" "/home/egregius313/Projects/feeds/jobs.org" "/home/egregius313/Projects/feeds/linguistics.org" "/home/egregius313/Projects/feeds/videos.org"))
 '(scroll-bar-mode nil)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(super-save-auto-save-when-idle t)
 '(symon-delay 10)
 '(symon-sparkline-type 'plain)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
	 (40 . "#CF4F1F")
	 (60 . "#C26C0F")
	 (80 . "#E6DB74")
	 (100 . "#AB8C00")
	 (120 . "#A18F00")
	 (140 . "#989200")
	 (160 . "#8E9500")
	 (180 . "#A6E22E")
	 (200 . "#729A1E")
	 (220 . "#609C3C")
	 (240 . "#4E9D5B")
	 (260 . "#3C9F79")
	 (280 . "#A1EFE4")
	 (300 . "#299BA6")
	 (320 . "#2896B5")
	 (340 . "#2790C3")
	 (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(version-control t)
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
