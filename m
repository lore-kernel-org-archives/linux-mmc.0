From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH [mmc-utils] 2/2] start a README
Date: Thu, 12 Dec 2013 19:17:16 -0500
Message-ID: <1386893836-16833-2-git-send-email-vapier@gentoo.org>
References: <1386893836-16833-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:38630 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab3LMARS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Dec 2013 19:17:18 -0500
In-Reply-To: <1386893836-16833-1-git-send-email-vapier@gentoo.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 README | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 0000000..e7d5210
--- /dev/null
+++ b/README
@@ -0,0 +1,12 @@
+Userspace tools for MMC/SD devices
+
+Useful for doing things like updating firmware or poking registers in the
+MMC/SD card itself.
+
+Upstream git repo:
+	https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
+	git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
+
+Mailing list:
+	linux-mmc@vger.kernel.org
+	http://vger.kernel.org/vger-lists.html#linux-mmc
-- 
1.8.4.3

