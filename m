From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [RFC][PATCH 1/1]mmc: To implement eMMC4.4 standard HW reset feature
Date: Tue, 31 Aug 2010 17:17:34 +0800
Message-ID: <20100831091734.GA25467@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31648 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab0HaJUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2010 05:20:40 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chuanxiao.dong@intel.com, yunpeng.gao@intel.com

Hi all,
   This is a RFC patch to implement eMMC4.4 standared HW reset feature.
   This patch is generated against the latest linus kernel git tree. I
   am not sure whether it is an appropriate source code tree for me to
   use, if anybody knows which tree is the appropritate one to generate
   linux-mmc patches, please let me know. Thanks very much :)

   In this patch, only the framework is done. Actual reset and
   reinitialize operations will be done after this.

   My understanding about HW reset feature:
   1) To implement this, RST_n_FUNCTION field in extended CSD must be
   set to 1 to enable this feature.
   2) when eMMC card occurs data timeout error, HC need to trigger a
   RST_n signal to reset eMMC card.
   3) After HW reset, HC need to reinitialize eMMC card.
   2) and 3) maybe need sleep or some delay.

   Expect any feedback. Thank you all.


>From 6b7aaa0bfdb779678905246b1651d15cd93fd4d4 Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Tue, 31 Aug 2010 16:45:02 +0800
Subject: [PATCH] linux-mmc: rfc patch: implement eMMC4.4 standard HW reset feature

This is a RFC patch which only has a framework. Detailed HW reset
work and reinit work will be done later.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c      |   27 +++++++++++++++++++++++
 drivers/mmc/core/core.h      |    1 +
 drivers/mmc/core/mmc.c       |   48 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.c |   15 +++++++++++++
 drivers/mmc/host/sdhci.c     |   23 ++++++++++++++++++++
 drivers/mmc/host/sdhci.h     |    1 +
 include/linux/mmc/card.h     |    1 +
 include/linux/mmc/host.h     |    5 ++++
 include/linux/mmc/mmc.h      |    1 +
 9 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5db49b1..dcf74d9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -208,6 +208,8 @@ static void mmc_wait_done(struct mmc_request *mrq)
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct mmc_card *card = host->card;
+
 	DECLARE_COMPLETION_ONSTACK(complete);
 
 	mrq->done_data = &complete;
@@ -216,6 +218,31 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 	mmc_start_request(host, mrq);
 
 	wait_for_completion(&complete);
+
+	/* as MMC4.4 standard says, when some data timeout conditions
+	 * occur, HC need to do a hardware reset for eMMC4.4 card.
+	 * If the card is eMMC4.4 card && data error is timeout,
+	 * do the following things:
+	 * 1. let host controller do a specific hardware reset for eMMC
+	 *    card (trigger RST_n signal).
+	 * 2. after reset done, reinit eMMC4.4 card.
+	 * */
+	if(mrq->data && card &&
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
index 9d9eef5..d37e5e8 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -24,6 +24,7 @@ struct mmc_bus_ops {
 	int (*resume)(struct mmc_host *);
 	void (*power_save)(struct mmc_host *);
 	void (*power_restore)(struct mmc_host *);
+	int (*reinit)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6909a54..28623ab 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -225,6 +225,9 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		goto out;
 	}
 
+	/* Get eMMC card HW reset capbility */
+	card->ext_csd.rst = ext_csd[EXT_CSD_RST];
+
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	if (card->csd.structure == 3) {
 		int ext_csd_struct = ext_csd[EXT_CSD_STRUCTURE];
@@ -469,6 +472,30 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * eMMC4.4 version card has HW reset capbility.
+	 * Enable this feature here:
+	 * RST_N_FUNCTION register is W/R, one time programmable
+	 * or readable.
+	 * So need to enable this register only once after power on
+	 * */
+	if (card->csd.mmca_vsn == CSD_SPEC_VER_4 &&
+			card->ext_csd.rev == 5 &&
+			card->ext_csd.rst != 1) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_RST, 1);
+
+		if (err && err != -EBADMSG)
+			goto free_card;
+
+		if (err) {
+			printk(KERN_WARNING "%s: switch to rst enable "
+				   "failed %d\n", mmc_hostname(card->host), err);
+			err = 0;
+		} else
+			card->ext_csd.rst = 1;
+	}
+
+	/*
 	 * Activate high speed (if supported)
 	 */
 	if ((card->ext_csd.hs_max_dtr != 0) &&
@@ -661,6 +688,25 @@ static int mmc_awake(struct mmc_host *host)
 	return err;
 }
 
+static int mmc_reinit_card(struct mmc_host *host)
+{
+	int err;
+
+	BUG_ON(!host);
+	BUG_ON(!host->card);
+
+	/* FIXME
+	 * not sure how to reinit card when occurs
+	 * data timeout error,
+	 * just use mmc_init_card
+	 * */
+	mmc_claim_host(host);
+	err = mmc_init_card(host, host->ocr, host->card);
+	mmc_release_host(host);
+
+	return err;
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.awake = mmc_awake,
 	.sleep = mmc_sleep,
@@ -669,6 +715,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
+	.reinit = mmc_reinit_card,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -679,6 +726,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.power_restore = mmc_power_restore,
+	.reinit = mmc_reinit_card,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e8aa99d..45afb93 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -534,8 +534,23 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
+/*
+ * HW reset eMMC4.4 card callback
+ * In this function, driver need to trigger RST_n signal
+ * as eMMC4.4 standar says.
+ * RETURN VALUE:
+ * 0: reset emmc successfully
+ * 1: reset emmc failed
+ */
+static int sdhci_pci_reset_emmc(struct sdhci_host *host)
+{
+	/* TODO trigger a RST_n signal*/
+	return 0;
+}
+
 static struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
+	.reset_emmc = sdhci_pci_reset_emmc,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..1b15651 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1245,11 +1245,34 @@ out:
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
index d316bc7..c9011b6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -323,6 +323,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	int		(*reset_emmc)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6b75250..bf52b4b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -53,6 +53,7 @@ struct mmc_ext_csd {
 	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
 	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
 	unsigned int		trim_timeout;		/* In milliseconds */
+	unsigned char		rst;			/* identify HW reset cap */
 };
 
 struct sd_scr {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1575b52..6eefa34 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -111,6 +111,11 @@ struct mmc_host_ops {
 
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
index dd11ae5..94c1a85 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -251,6 +251,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_RST		162	/* R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
-- 
1.6.6.1

