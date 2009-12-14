From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [RFC PATCH v2 1/4] sdhci: protect header file against multi inclusion
Date: Mon, 14 Dec 2009 23:24:16 +0100
Message-ID: <1260829459-23518-2-git-send-email-albert_herranz@yahoo.es>
References: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp104.mail.ukl.yahoo.com ([77.238.184.36]:27053 "HELO
	smtp104.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932758AbZLNWY3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 17:24:29 -0500
In-Reply-To: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, Albert Herranz <albert_herranz@yahoo.es>

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/mmc/host/sdhci.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ce5f1d7..842f46f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -8,6 +8,8 @@
  * the Free Software Foundation; either version 2 of the License, or (at
  * your option) any later version.
  */
+#ifndef __SDHCI_H
+#define __SDHCI_H
 
 #include <linux/scatterlist.h>
 #include <linux/compiler.h>
@@ -408,3 +410,5 @@ extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
 extern int sdhci_resume_host(struct sdhci_host *host);
 #endif
+
+#endif /* __SDHCI_H */
-- 
1.6.3.3

