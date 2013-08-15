From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: [PATCH 5/5] mmc: sdhci: add quirk to ignore timeout err for R1B
Date: Thu, 15 Aug 2013 17:32:20 +0300
Message-ID: <1376577140-2652-6-git-send-email-gdjakov@mm-sol.com>
References: <1376577140-2652-1-git-send-email-gdjakov@mm-sol.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376577140-2652-1-git-send-email-gdjakov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Georgi Djakov <gdjakov@mm-sol.com>, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds a quirk to ignore data timeout error for R1B commands
as there will be no data associated and the busy timeout value for these
commands could be larger than the maximum timeout value that controller
can handle.

CC: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 drivers/mmc/host/sdhci.c  |    3 +++
 include/linux/mmc/sdhci.h |    4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e21bb6f..f120b14 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2353,6 +2353,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			}
 		}
 
+		if (host->quirks2 & SDHCI_QUIRK2_IGNORE_DATATOUT_FOR_R1BCMD)
+			return;
+
 		pr_err("%s: Got data interrupt 0x%08x even "
 			"though no data operation was in progress.\n",
 			mmc_hostname(host->mmc), (unsigned)intmask);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index f42f6dd..ad65fb8 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -108,6 +108,10 @@ struct sdhci_host {
  * the mmc queue. Otherwise, it takes a long time for secure discard kind of
  * operations to complete. */
 #define SDHCI_QUIRK2_USE_MAX_DISCARD_SIZE		(1<<9)
+/* Ignore data timeout error for R1B commands as there will be no data
+ * associated and the busy timeout value for these commands could be larger
+ * than the maximum timeout value that controller can handle. */
+#define SDHCI_QUIRK2_IGNORE_DATATOUT_FOR_R1BCMD	(1<<10)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.9.5
