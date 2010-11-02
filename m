From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v2 2/2]mmc: implemented hardware reset callback in sdhci
	host layer
Date: Tue, 2 Nov 2010 20:36:18 +0800
Message-ID: <20101102123618.GC1313@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30463 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab0KBMhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Nov 2010 08:37:34 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

>From 9fe8402c59d9346dabc1898ddd82ace98583c01e Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Tue, 2 Nov 2010 20:11:09 +0800
Subject: [PATCH 2/2] mmc: implemented hardware reset callback for sdhci layer

the hardware reset callback in sdhci layer cannot really do
a reset for eMMC card. Different sdhci host controller need use
reset_emmc callback to implement the real reset part.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci.c |   23 +++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..ac789d9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1266,11 +1266,34 @@ out:
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+/*
+ *  HW reset callback for eMMC4.4 card
+ *  In this function, HC will do the real HW reset
+ *  for eMMC4.4 card
+ *
+ *  RETURN VALUE:
+ *  0: reset emmc successfully
+ *  1: reset emmc failed
+ * */
+static int sdhci_hardware_reset(struct mmc_host *mmc)
+{
+	int err = 1;
+	struct sdhci_host *host;
+
+	host = mmc_priv(mmc);
+
+	if (host->ops && host->ops->reset_emmc)
+		err = host->ops->reset_emmc(host);
+
+	return err;
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
+	.hardware_reset = sdhci_hardware_reset,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b7b8a3b..c4cb360 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -215,6 +215,7 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	int		(*reset_emmc)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.6.1

