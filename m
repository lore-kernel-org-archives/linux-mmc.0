From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC PATCH 4/4] mmc: core: Implement mmc_partial_init during resume
Date: Mon, 20 Feb 2017 13:33:12 +0530
Message-ID: <1487577792-12510-5-git-send-email-riteshh@codeaurora.org>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, linux-kernel@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>, Talel Shenhar <tatias@codeaurora.org>, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds mmc_partial_init functionality
combining with CMD5 awake feature to reduce resume
latency for emmc.

This is not enabled for HS400 mode, since tuning
in HS400 is required to be done in HS200 timing.

Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/core/core.c  |  13 +++++
 drivers/mmc/core/core.h  |   1 +
 drivers/mmc/core/mmc.c   | 134 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h |   3 ++
 include/linux/mmc/host.h |   1 +
 5 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 926e0fd..4bbe3eb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1197,6 +1197,19 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 	mmc_set_ios(host);
 }
 
+void mmc_set_init_state(struct mmc_host *host)
+{
+	host->ios.bus_mode = host->cached_ios.bus_mode;
+	host->ios.bus_width = host->cached_ios.bus_width;
+	host->ios.timing = host->cached_ios.timing;
+	if (host->card &&
+	    host->card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES &&
+	    host->cached_ios.timing == MMC_TIMING_MMC_HS400)
+		host->ios.enhanced_strobe = true;
+
+	mmc_set_ios(host);
+}
+
 /*
  * Set initial state after a power cycle or a hw_reset.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 55f543f..9476a89 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -58,6 +58,7 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
 void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
 void mmc_set_initial_state(struct mmc_host *host);
+void mmc_set_init_state(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 83bcc86..f7c244c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1827,6 +1827,28 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return (card && card->ext_csd.rev >= 3);
 }
 
+static int mmc_can_sleepawake_mode(struct mmc_host *host)
+{
+	/*
+	 * Disabled for HS400 mode since it requires tuning
+	 * to be done in HS200 timing and then switching
+	 * to HS400 mode.
+	 */
+	switch (host->cached_ios.timing) {
+	case MMC_TIMING_MMC_HS400:
+		if (!(host->card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES))
+			return 0;
+	default:
+		return 1;
+	}
+}
+
+static int mmc_can_sleepawake(struct mmc_host *host)
+{
+	return (host && host->caps2 & MMC_CAP2_SLEEP_AWAKE &&
+		mmc_can_sleep(host->card) && mmc_can_sleepawake_mode(host));
+}
+
 static int mmc_sleepawake(struct mmc_host *host, bool sleep)
 {
 	struct mmc_command cmd = {};
@@ -1964,6 +1986,100 @@ static void mmc_detect(struct mmc_host *host)
 	}
 }
 
+static int mmc_cache_card_ext_csd(struct mmc_host *host)
+{
+	int err;
+	u8 *ext_csd;
+	struct mmc_card *card = host->card;
+
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err || !ext_csd) {
+		pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/* only cache read/write fields that the sw changes */
+	card->ext_csd.raw_ext_csd_cache_ctrl = ext_csd[EXT_CSD_CACHE_CTRL];
+	card->ext_csd.raw_ext_csd_bus_width = ext_csd[EXT_CSD_BUS_WIDTH];
+	card->ext_csd.raw_ext_csd_hs_timing = ext_csd[EXT_CSD_HS_TIMING];
+	kfree(ext_csd);
+	return 0;
+}
+
+static int mmc_test_awake_ext_csd(struct mmc_host *host)
+{
+	int err;
+	u8 *ext_csd;
+	struct mmc_card *card = host->card;
+
+	return 0;
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err) {
+		pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/* only compare read/write fields that the sw changes */
+	pr_debug("%s: %s: type(cached:current) cache_ctrl(%d:%d) bus_width (%d:%d) timing(%d:%d)\n",
+		 mmc_hostname(host), __func__,
+		 card->ext_csd.raw_ext_csd_cache_ctrl,
+		 ext_csd[EXT_CSD_CACHE_CTRL],
+		 card->ext_csd.raw_ext_csd_bus_width,
+		 ext_csd[EXT_CSD_BUS_WIDTH],
+		 card->ext_csd.raw_ext_csd_hs_timing,
+		 ext_csd[EXT_CSD_HS_TIMING]);
+
+	err = !((card->ext_csd.raw_ext_csd_cache_ctrl ==
+			ext_csd[EXT_CSD_CACHE_CTRL]) &&
+		(card->ext_csd.raw_ext_csd_bus_width ==
+			ext_csd[EXT_CSD_BUS_WIDTH]) &&
+		(card->ext_csd.raw_ext_csd_hs_timing ==
+			ext_csd[EXT_CSD_HS_TIMING]));
+
+	kfree(ext_csd);
+	return err;
+}
+
+static int mmc_partial_init(struct mmc_host *host)
+{
+	int err = 0;
+	struct mmc_card *card = host->card;
+
+	mmc_set_init_state(host);
+	mmc_set_clock(host, host->cached_ios.clock);
+	if (mmc_card_hs400(card)) {
+		if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
+			if (host->ops->hs400_enhanced_strobe)
+				host->ops->hs400_enhanced_strobe(host,
+								 &host->ios);
+		}
+	} else if (mmc_card_hs200(card)) {
+		err = mmc_hs200_tuning(card);
+		if (err)
+			pr_warn("%s: %s: tuning execution failed (%d)\n",
+				mmc_hostname(host), __func__, err);
+	}
+
+	/*
+	 * The ext_csd is read to make sure the card did not went through
+	 * Power-failure during sleep period.
+	 * A subset of the W/E_P, W/C_P register will be tested. In case
+	 * these registers values are different from the values that were
+	 * cached during suspend, we will conclude that a Power-failure occurred
+	 * and will do full initialization sequence.
+	 */
+	err = mmc_test_awake_ext_csd(host);
+	if (err) {
+		pr_err("%s: %s: fail on ext_csd read (%d)\n",
+		       mmc_hostname(host), __func__, err);
+		goto out;
+	}
+out:
+	return err;
+}
+
 static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 {
 	int err = 0;
@@ -1988,7 +2104,11 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_can_poweroff_notify(host->card) &&
 		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
+	else if (mmc_can_sleepawake(host)) {
+		memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
+		mmc_cache_card_ext_csd(host);
+		err = mmc_sleep(host);
+	} else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
@@ -2032,7 +2152,17 @@ static int _mmc_resume(struct mmc_host *host)
 		goto out;
 
 	mmc_power_up(host, host->card->ocr);
-	err = mmc_init_card(host, host->card->ocr, host->card);
+	if (mmc_can_sleepawake(host)) {
+		err = mmc_awake(host);
+		if (!err)
+			err = mmc_partial_init(host);
+		if (err)
+			pr_err("%s: awake failed (%d), fallback to full init\n",
+			       mmc_hostname(host), err);
+	}
+	if (err || !mmc_can_sleepawake(host))
+		err = mmc_init_card(host, host->card->ocr, host->card);
+
 	mmc_card_clr_suspended(host->card);
 
 out:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 77e61e0..9aa2c97 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -93,11 +93,14 @@ struct mmc_ext_csd {
 	unsigned int		cmdq_depth;	/* Command Queue depth */
 #define MMC_FIRMWARE_LEN 8
 	u8			fwrev[MMC_FIRMWARE_LEN];  /* FW version */
+	u8			raw_ext_csd_cache_ctrl;	/* 33 */
 	u8			raw_exception_status;	/* 54 */
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_rpmb_size_mult;	/* 168 */
 	u8			raw_erased_mem_count;	/* 181 */
+	u8			raw_ext_csd_bus_width;	/* 183 */
 	u8			strobe_support;		/* 184 */
+	u8			raw_ext_csd_hs_timing;	/* 185 */
 	u8			raw_ext_csd_structure;	/* 194 */
 	u8			raw_card_type;		/* 196 */
 	u8			raw_driver_strength;	/* 197 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index df7882b..c89407c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -320,6 +320,7 @@ struct mmc_host {
 	spinlock_t		lock;		/* lock for claim and bus ops */
 
 	struct mmc_ios		ios;		/* current io bus settings */
+	struct mmc_ios		cached_ios;
 
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
