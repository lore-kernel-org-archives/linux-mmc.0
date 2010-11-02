From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v2 1/2]mmc: implemented eMMC4.4 hardware reset feature in
	mmc core layer
Date: Tue, 2 Nov 2010 20:36:03 +0800
Message-ID: <20101102123603.GB1313@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63815 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab0KBMhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Nov 2010 08:37:19 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

>From 74d68fecf5fa527e729a566bc0214d2c1d237dab Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Tue, 2 Nov 2010 20:06:58 +0800
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
 scripts/recordmcount     |  Bin 0 -> 15723 bytes
 7 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 scripts/recordmcount

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
diff --git a/scripts/recordmcount b/scripts/recordmcount
new file mode 100755
index 0000000000000000000000000000000000000000..001266a1e6b9ca831ccb1de52c9bdfbaafec06f6
GIT binary patch
literal 15723
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
ab_Sxpo;F`J7z^L!UA78W%J?o*srG-;8`cQ`

literal 0
HcmV?d00001

-- 
1.6.6.1

