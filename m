From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH [mmc-utils] 1/2] fix make handling
Date: Thu, 12 Dec 2013 19:17:15 -0500
Message-ID: <1386893836-16833-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:38628 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab3LMARR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Dec 2013 19:17:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Mike Frysinger <vapier@chromium.org>

From: Mike Frysinger <vapier@chromium.org>

Fix the recurisve make targets by using $(MAKE).  Otherwise we get lots of
warnings and issues with parallel builds.

Fix the install target -- the man subdir was missing a dummy target.

Add proper .PHONY markings.

Signed-off-by: Mike Frysinger <vapier@chromium.org>
---
 Makefile     | 8 +++++---
 man/Makefile | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ae846e2..91cfc35 100644
--- a/Makefile
+++ b/Makefile
@@ -34,15 +34,17 @@ mmc: $(objects)
 	$(CC) $(CFLAGS) -o $@ $(objects) $(LDFLAGS) $(LIBS)
 
 manpages:
-	cd man && make
+	$(MAKE) -C man
 
 install-man:
-	cd man && make install
+	$(MAKE) -C man install
 
 clean:
 	rm -f $(progs) $(objects)
-	cd man && make clean
+	$(MAKE) -C man clean
 
 install: $(progs) install-man
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(progs) $(DESTDIR)$(bindir)
+
+.PHONY: all clean install manpages install-man
diff --git a/man/Makefile b/man/Makefile
index c8957f6..da79a50 100644
--- a/man/Makefile
+++ b/man/Makefile
@@ -1,2 +1,5 @@
 all: 
 clean: 
+install:
+
+.PHONY: all clean install
-- 
1.8.4.3

