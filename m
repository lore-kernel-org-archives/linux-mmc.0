From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC Patch] SDHCI: add quirk for data timeout value when card busy.
Date: Tue, 30 Nov 2010 15:13:48 +0900
Message-ID: <4CF4961C.5020606@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62573 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab0K3GSx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 01:18:53 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LCO00GZ6PB0RJ20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 15:13:48 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LCO00KT6PB0Q8@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Nov 2010 15:13:48 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, matt@console-pimps.org

This patch is added quirks for data timeout value.

Some card have problem when suspend/resume.
CMD6(switch command) to switch the bus to high speed mode 
and to set the bus width.

After resuming, the card was initialized...in that time, some
card need set a correct timeout value.
so we add SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL.

Let me know any comment, plz.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
 Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
 drivers/mmc/host/sdhci.c  |    6 +++++-
 include/linux/mmc/sdhci.h |    3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..3b93d97 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -655,8 +655,12 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 
 	WARN_ON(host->data);
 
-	if (data == NULL)
+	if (data == NULL) {
+		if ((host->quirks & SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL) &&
+				(host->cmd->flags & MMC_RSP_BUSY))
+			sdhci_writel(host, 0xE, SDHCI_TIMEOUT_CONTROL);
 		return;
+	}
 
 	/* Sanity checks */
 	BUG_ON(data->blksz * data->blocks > 524288);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..315ff49 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -83,7 +83,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
-
+/* Controller need set data timeout value when card is busy */
+#define SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL		(1<<30)
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
-- 
1.6.0.4

Thanks
Jaehoon Chung

