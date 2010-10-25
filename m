From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH 1/1]mmc: implemented eMMC4.4 hardware reset feature
Date: Mon, 25 Oct 2010 22:18:20 +0800
Message-ID: <20101025141820.GA28000@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51288 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164Ab0JYOTb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Oct 2010 10:19:31 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Hi,
	This patch implemented eMMC4.4 hardware reset feature in core layer
	and sdhci host layer, but need each sdhci host controller to
	implement the real reset part specially.
	I also have a concern about the enabling hardware reset part. As
	eMMC 4.4 standar says, to enable hardware reset need to set the bit
	0 of byte 162 in ext_csd register. However this register is onetime
	programmable, once setted, cannot be changed any more. And the
	standar also says this feature is disabled by default. If driver
	does not set it, the feature can not be enabled. So my question is
	that is it suitable for driver to set this bit?

>From e14942d9c8fd6f0a77ca41b0f06381ec0a2abade Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Mon, 25 Oct 2010 21:51:39 +0800
Subject: [PATCH] mmc: implemented eMMC 4.4 hardware reset feature

This feature is implemented in core layer and sdhci host layer.
Each SDHCI host controller driver needs to implement the really
reset eMMC card part specially.

In this patch, driver can detect whether eMMC card complies
with 4.4 standar. If so, driver enable hardware reset feature
for eMMC card.

When driver detect there occureed data timeout errors, driver
will reset and then reinit eMMC card

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c  |   26 +++++++++++++++++++++++++
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/mmc.c   |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c |   23 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |    1 +
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    5 ++++
 include/linux/mmc/mmc.h  |    1 +
 8 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f86d70..75615ce 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -209,6 +209,8 @@ static void mmc_wait_done(struct mmc_request *mrq)
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct mmc_card *card = host->card;
+
 	DECLARE_COMPLETION_ONSTACK(complete);
 
 	mrq->done_data = &complete;
@@ -217,6 +219,30 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 	mmc_start_request(host, mrq);
 
 	wait_for_completion(&complete);
+	/* as MMC4.4 standard says, when some data timeout conditions
+	 * occur, HC need to do a hardware reset for eMMC4.4 card.
+	 * If the card is eMMC4.4 card && data error is timeout,
+	 * do the following things:
+	 * 1. let host controller do a specific hardware reset for eMMC
+	 *    card (trigger RST_n signal).
+	 * 2. after reset done, reinit eMMC4.4 card.
+	 * */
+	if (mrq->data && card &&
+		mrq->data->error == -ETIMEDOUT &&
+		card->ext_csd.rst == 1) {
+		int err = 1;
+		if (host->ops->hardware_reset &&
+				host->bus_ops->reinit) {
+			err = host->ops->hardware_reset(host);
+			if (err)
+				pr_warn("MMC card reset failed, no reinit\n");
+			else
+				err = host->bus_ops->reinit(host);
+		}
+
+		if (err)
+			pr_warn("cannot reset and reinit eMMC4.4 card\n");
+	}
 }
 
 EXPORT_SYMBOL(mmc_wait_for_req);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 77240cd..232a3d9 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -24,6 +24,7 @@ struct mmc_bus_ops {
 	int (*resume)(struct mmc_host *);
 	int (*power_save)(struct mmc_host *);
 	int (*power_restore)(struct mmc_host *);
+	int (*reinit)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 995261f..e015e55 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -237,6 +237,8 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		}
 	}
 
+	card->ext_csd.rst = ext_csd[EXT_CSD_RST];
+
 	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
 	if (card->ext_csd.rev > 5) {
 		printk(KERN_ERR "%s: unrecognised EXT_CSD revision %d\n",
@@ -484,6 +486,32 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * eMMC4.4 version card has HW reset capbility.
+	 * Enable this feature here:
+	 * RST_N_FUNCTION register is W/R, one time programmable
+	 * or readable.
+	 * So need to enable this register only once after power on
+	 * */
+	if (card->csd.mmca_vsn >= CSD_SPEC_VER_4 &&
+			card->ext_csd.rev >= 4 &&
+			card->ext_csd.rst != 1) {
+		/* FIXME should driver set this register? */
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_RST, 1);
+
+		if (err && err != -EBADMSG)
+			goto free_card;
+
+		if (err) {
+			printk(KERN_WARNING "%s: switch to rst enable "
+				   "failed %d\n",
+				   mmc_hostname(card->host), err);
+			err = 0;
+		} else
+			card->ext_csd.rst = 1;
+	}
+
+	/*
 	 * Activate high speed (if supported)
 	 */
 	if ((card->ext_csd.hs_max_dtr != 0) &&
@@ -699,6 +727,23 @@ static int mmc_awake(struct mmc_host *host)
 	return err;
 }
 
+static int mmc_reinit_card(struct mmc_host *host)
+{
+	int err;
+
+	BUG_ON(!host);
+	BUG_ON(!host->card);
+
+	host->ios.clock = host->f_min;
+	mmc_set_clock(host, host->ios.clock);
+
+	err = mmc_init_card(host, host->ocr, host->card);
+	if (err)
+		printk(KERN_ERR "%s: err %d\n", __func__, err);
+
+	return err;
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.awake = mmc_awake,
 	.sleep = mmc_sleep,
@@ -707,6 +752,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
+	.reinit = mmc_reinit_card,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -717,6 +763,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.power_restore = mmc_power_restore,
+	.reinit = mmc_reinit_card,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
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
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8ce0827..3d17867 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -54,6 +54,7 @@ struct mmc_ext_csd {
 	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
 	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
 	unsigned int		trim_timeout;		/* In milliseconds */
+	unsigned int		rst;
 };
 
 struct sd_scr {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 6d87f68..6e9eba8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -117,6 +117,11 @@ struct mmc_host_ops {
 
 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
+
+	/* HW reset callback, used for eMMC 4.4 new feature.
+	 * when occurs data timeout, HC will need to reset eMMC4.4 card
+	 * */
+	int (*hardware_reset)(struct mmc_host *host);
 };
 
 struct mmc_card;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 956fbd8..9edc643 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -251,6 +251,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_RST					162	/* R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
-- 
1.6.6.1

