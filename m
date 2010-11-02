From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v2 1/2]mmc: implemented eMMC4.4 hardware reset feature in
	core layer
Date: Tue, 2 Nov 2010 20:44:40 +0800
Message-ID: <20101102124440.GB2741@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64306 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab0KBMp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Nov 2010 08:45:57 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

>From 80260a0e193a5d0f428afaebb69bcf1790d6e217 Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Tue, 2 Nov 2010 20:39:58 +0800
Subject: [PATCH 1/2] mmc: implemented eMMC4.4 hardware reset feature in mmc core layer

When core layer detect a data timeout error, core driver need to
first reset eMMC card and then do a reinit for card. After that,
posts the original timeout error to mmc block layer.

1. enable hardware reset feature: to enable hardware reset
feature, mmc driver need to set RST_n_function bit in ext_csd
register. But this bit is onetime programmable, not sure whether
it is suitable for driver to set this bit.

2. The reset part was resvered for host controller to implement.

3. The reinit card part was implemented.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c  |   27 +++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/mmc.c   |   45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    5 +++++
 include/linux/mmc/mmc.h  |    1 +
 6 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f86d70..0c8882e 100644
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
@@ -217,6 +219,31 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
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
index 995261f..123b203 100644
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
@@ -484,6 +486,25 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
+		/* Be careful, EXT_CSD_RST register is one
+		 * time programmable
+		 * */
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_RST, 1);
+		if (!err)
+			card->ext_csd.rst = 1;
+	}
+
+	/*
 	 * Activate high speed (if supported)
 	 */
 	if ((card->ext_csd.hs_max_dtr != 0) &&
@@ -699,6 +720,28 @@ static int mmc_awake(struct mmc_host *host)
 	return err;
 }
 
+static int mmc_reinit_card(struct mmc_host *host)
+{
+	int err;
+
+	BUG_ON(!host);
+	BUG_ON(!host->card);
+
+	if (host->f_min > 400000) {
+		pr_warning("%s: Minimum clock frequency too high for "
+				"identification mode\n", mmc_hostname(host));
+		host->ios.clock = host->f_min;
+	} else
+		host->ios.clock = 400000;
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
@@ -707,6 +750,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
+	.reinit = mmc_reinit_card,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -717,6 +761,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.power_restore = mmc_power_restore,
+	.reinit = mmc_reinit_card,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8ce0827..ebee676 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -54,6 +54,7 @@ struct mmc_ext_csd {
 	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
 	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
 	unsigned int		trim_timeout;		/* In milliseconds */
+	unsigned int		rst; /* hardware reset enable bit */
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
index 956fbd8..b7ab0da 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -251,6 +251,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_RST		162	/* onetime programmable R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
-- 
1.6.6.1

