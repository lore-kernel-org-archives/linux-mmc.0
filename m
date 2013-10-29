From: David Cohen <david.a.cohen@linux.intel.com>
Subject: [RFC/PATCH 1/2] mmc: sdhci: add quirk for broken HS200 support
Date: Tue, 29 Oct 2013 10:58:26 -0700
Message-ID: <1383069507-27574-2-git-send-email-david.a.cohen@linux.intel.com>
References: <1383069507-27574-1-git-send-email-david.a.cohen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383069507-27574-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, adrian.hunter@intel.com, gregkh@linuxfoundation.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chuanxiao.dong@intel.com, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

This patch defines a quirk for platforms unable to enable HS200 support.

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
Reviewed-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci.c  | 3 ++-
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a7fb4f..ef91ad4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3002,7 +3002,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		/* SD3.0: SDR104 is supported so (for eMMC) the caps2
 		 * field can be promoted to support HS200.
 		 */
-		mmc->caps2 |= MMC_CAP2_HS200;
+		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
+			mmc->caps2 |= MMC_CAP2_HS200;
 	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
 		mmc->caps |= MMC_CAP_UHS_SDR50;
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 3e781b8..362927c4 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
 /* Controller has a non-standard host control register */
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
+/* Controller does not support HS200 */
+#define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.4.rc3
