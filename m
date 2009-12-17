From: akpm@linux-foundation.org
Subject: [patch 13/20] sdhci: protect header file against multi inclusion
Date: Thu, 17 Dec 2009 15:27:19 -0800
Message-ID: <200912172327.nBHNRJ3m024886@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53756 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752184AbZLQX1V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2009 18:27:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, albert_herranz@yahoo.es, linux-mmc@vger.kernel.org

From: Albert Herranz <albert_herranz@yahoo.es>

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.h |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN drivers/mmc/host/sdhci.h~sdhci-protect-header-file-against-multi-inclusion drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-protect-header-file-against-multi-inclusion
+++ a/drivers/mmc/host/sdhci.h
@@ -8,6 +8,8 @@
  * the Free Software Foundation; either version 2 of the License, or (at
  * your option) any later version.
  */
+#ifndef __SDHCI_H
+#define __SDHCI_H
 
 #include <linux/scatterlist.h>
 #include <linux/compiler.h>
@@ -408,3 +410,5 @@ extern void sdhci_remove_host(struct sdh
 extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
 extern int sdhci_resume_host(struct sdhci_host *host);
 #endif
+
+#endif /* __SDHCI_H */
_
