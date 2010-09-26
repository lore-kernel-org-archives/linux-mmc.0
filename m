From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: sepearate get_ro into code that calls platform and
 helper
Date: Sat, 25 Sep 2010 17:43:44 -0700
Message-ID: <A8DEF24B-343B-4ED8-B556-12E3550506A9@marvell.com>
References: <E6553F30-7D88-476A-A8AF-3F7793FA4DE0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50136 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754013Ab0IZAnr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 25 Sep 2010 20:43:47 -0400
In-Reply-To: <E6553F30-7D88-476A-A8AF-3F7793FA4DE0@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



>From 0037e6513afc3fc39dd39010f994278c84623b29 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sat, 25 Sep 2010 17:23:59 -0700
Subject: [PATCH] sdhci: sepearate get_ro into code that calls platform and helper

If a helper function is supplied allow it to make use of the helper.
This allows specific behavior to be added when needed and reuse the standard
code
Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |   14 +++++++++++++-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0774dad..6f2bc4b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1204,7 +1204,7 @@ out:
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_get_ro(struct mmc_host *mmc)
+int sdhci_get_ro_helper(struct mmc_host *mmc)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -1226,6 +1226,18 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	return !(present & SDHCI_WRITE_PROTECT);
 }
 
+int sdhci_get_ro(struct mmc_host *mmc)
+{
+	struct sdhci_host *host;
+
+	host = mmc_priv(mmc);
+
+	if (host->ops->get_ro)
+		return host->ops->get_ro(mmc);
+	else
+		return sdhci_get_ro_helper(mmc);
+}
+
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sdhci_host *host;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f68af47..bd1fa15 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -324,6 +324,7 @@ struct sdhci_ops {
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	void	(*platform_specific_reset)(struct sdhci_host *host, u8 mask);
+	int	(*get_ro)(struct mmc_host *mmc);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.0.4

