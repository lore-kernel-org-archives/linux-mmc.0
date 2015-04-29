From: <micky_ching@realsil.com.cn>
Subject: [PATCH 06/12] mmc: core: init SD4.0 mode before legacy mode
Date: Wed, 29 Apr 2015 09:23:38 +0800
Message-ID: <60e169321fc81d1ee129d2a0d0c9ece363f1c6a7.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

We alloc card before init card, if init UHSII mode failed, then
try to init legacy mode.

Since we card is allocated before do init operations, so mmc/sdio
card init should do some modify. To reduce many diff hunks, the old
labels are reserved(we can remove them in the future).

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/core/core.c |  60 +++++++++++++++++++++-------
 drivers/mmc/core/mmc.c  |  63 +++++++++++++----------------
 drivers/mmc/core/sd.c   |  95 +++++++++++++++++++++++---------------------
 drivers/mmc/core/sdio.c | 103 +++++++++++++++++++++---------------------------
 4 files changed, 169 insertions(+), 152 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4c5433b..d9e904f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2435,16 +2435,8 @@ int mmc_hw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_hw_reset);
 
-static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
+static int mmc_reset_card(struct mmc_host *host)
 {
-	host->f_init = freq;
-
-#ifdef CONFIG_MMC_DEBUG
-	pr_info("%s: %s: trying to init card at %u Hz\n",
-		mmc_hostname(host), __func__, host->f_init);
-#endif
-	mmc_power_up(host, host->ocr_avail);
-
 	/*
 	 * Some eMMCs (with VCCQ always on) may not be reset after power up, so
 	 * do a hardware reset if possible.
@@ -2473,6 +2465,20 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	return -EIO;
 }
 
+static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
+{
+	host->f_init = freq;
+
+#ifdef CONFIG_MMC_DEBUG
+	pr_info("%s: %s: trying to init card at %u Hz\n",
+		mmc_hostname(host), __func__, host->f_init);
+#endif
+
+	mmc_power_up(host, host->ocr_avail);
+
+	return mmc_reset_card(host);
+}
+
 int _mmc_detect_card_removed(struct mmc_host *host)
 {
 	int ret;
@@ -2544,7 +2550,8 @@ void mmc_rescan(struct work_struct *work)
 {
 	struct mmc_host *host =
 		container_of(work, struct mmc_host, detect.work);
-	int i;
+	struct mmc_card *card;
+	int i, err;
 
 	if (host->trigger_card_event && host->ops->card_event) {
 		host->ops->card_event(host);
@@ -2599,14 +2606,37 @@ void mmc_rescan(struct work_struct *work)
 	}
 
 	mmc_claim_host(host);
-	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
-		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
-			break;
-		if (freqs[i] <= host->f_min)
-			break;
+
+	card = mmc_alloc_card(host, NULL);
+	if (IS_ERR(card)) {
+		mmc_release_host(host);
+		goto out;
 	}
+	host->card = card;
+
+	mmc_sd_init_uhsii_card(card);
+
+	if (mmc_card_uhsii(card)) {
+		err = mmc_reset_card(host);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(freqs); i++) {
+			err = mmc_rescan_try_freq(host,
+					max(freqs[i], host->f_min));
+			if (!err)
+				break;
+			if (freqs[i] <= host->f_min)
+				break;
+		}
+	}
+
 	mmc_release_host(host);
 
+	/* Attach fail, free host->card */
+	if (err) {
+		mmc_remove_card(host->card);
+		host->card = NULL;
+	}
+
  out:
 	if (host->caps & MMC_CAP_NEEDS_POLL)
 		mmc_schedule_delayed_work(&host->detect, HZ);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f36c76f..ddb8831 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1187,14 +1187,10 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 
 /*
  * Handle the detection and initialisation of a card.
- *
- * In the case of a resume, "oldcard" will contain the card
- * we're trying to reinitialise.
  */
-static int mmc_init_card(struct mmc_host *host, u32 ocr,
-	struct mmc_card *oldcard)
+static int mmc_do_init_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card, bool reinit)
 {
-	struct mmc_card *card;
 	int err;
 	u32 cid[4];
 	u32 rocr;
@@ -1239,23 +1235,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto err;
 
-	if (oldcard) {
-		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
+	if (reinit) {
+		if (memcmp(cid, card->raw_cid, sizeof(cid)) != 0) {
 			err = -ENOENT;
 			goto err;
 		}
-
-		card = oldcard;
 	} else {
-		/*
-		 * Allocate card structure.
-		 */
-		card = mmc_alloc_card(host, &mmc_type);
-		if (IS_ERR(card)) {
-			err = PTR_ERR(card);
-			goto err;
-		}
-
+		card->dev.type = &mmc_type;
 		card->ocr = ocr;
 		card->type = MMC_TYPE_MMC;
 		card->rca = 1;
@@ -1279,7 +1265,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
 	}
 
-	if (!oldcard) {
+	if (!reinit) {
 		/*
 		 * Fetch CSD from card.
 		 */
@@ -1311,7 +1297,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	if (!oldcard) {
+	if (!reinit) {
 		/* Read extended CSD. */
 		err = mmc_read_ext_csd(card);
 		if (err)
@@ -1487,18 +1473,25 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
-	if (!oldcard)
-		host->card = card;
-
 	return 0;
 
 free_card:
-	if (!oldcard)
-		mmc_remove_card(card);
 err:
 	return err;
 }
 
+static inline int mmc_init_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card)
+{
+	return mmc_do_init_card(host, ocr, card, false);
+}
+
+static inline int mmc_reinit_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card)
+{
+	return mmc_do_init_card(host, ocr, card, true);
+}
+
 static int mmc_can_sleep(struct mmc_card *card)
 {
 	return (card && card->ext_csd.rev >= 3);
@@ -1700,7 +1693,7 @@ static int _mmc_resume(struct mmc_host *host)
 		goto out;
 
 	mmc_power_up(host, host->card->ocr);
-	err = mmc_init_card(host, host->card->ocr, host->card);
+	err = mmc_reinit_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
 
 out:
@@ -1787,7 +1780,7 @@ static int mmc_power_restore(struct mmc_host *host)
 	int ret;
 
 	mmc_claim_host(host);
-	ret = mmc_init_card(host, host->card->ocr, host->card);
+	ret = mmc_reinit_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
 	return ret;
@@ -1851,12 +1844,15 @@ static const struct mmc_bus_ops mmc_ops = {
  */
 int mmc_attach_mmc(struct mmc_host *host)
 {
+	struct mmc_card *card;
 	int err;
 	u32 ocr, rocr;
 
-	BUG_ON(!host);
+	BUG_ON(!host || !host->card);
 	WARN_ON(!host->claimed);
 
+	card = host->card;
+
 	/* Set correct bus mode for MMC before attempting attach */
 	if (!mmc_host_is_spi(host))
 		mmc_set_bus_mode(host, MMC_BUSMODE_OPENDRAIN);
@@ -1891,7 +1887,7 @@ int mmc_attach_mmc(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_init_card(host, rocr, NULL);
+	err = mmc_init_card(host, rocr, card);
 	if (err)
 		goto err;
 
@@ -1899,15 +1895,10 @@ int mmc_attach_mmc(struct mmc_host *host)
 	err = mmc_add_card(host->card);
 	mmc_claim_host(host);
 	if (err)
-		goto remove_card;
+		goto err;
 
 	return 0;
 
-remove_card:
-	mmc_release_host(host);
-	mmc_remove_card(host->card);
-	mmc_claim_host(host);
-	host->card = NULL;
 err:
 	mmc_detach_bus(host);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 8dd35d9..5c00e23 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -863,12 +863,12 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 		/* Erase init depends on CSD and SSR */
 		mmc_init_erase(card);
 
-		/*
-		 * Fetch switch information from card.
-		 */
-		err = mmc_read_switch(card);
-		if (err)
-			return err;
+		if (!mmc_card_uhsii(card)) {
+			/* Fetch switch information from card. */
+			err = mmc_read_switch(card);
+			if (err)
+				return err;
+		}
 	}
 
 	/*
@@ -922,14 +922,10 @@ unsigned mmc_sd_get_max_clock(struct mmc_card *card)
 
 /*
  * Handle the detection and initialisation of a card.
- *
- * In the case of a resume, "oldcard" will contain the card
- * we're trying to reinitialise.
  */
-static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
-	struct mmc_card *oldcard)
+static int mmc_sd_do_init_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card, bool reinit)
 {
-	struct mmc_card *card;
 	int err;
 	u32 cid[4];
 	u32 rocr = 0;
@@ -941,19 +937,11 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		return err;
 
-	if (oldcard) {
-		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
+	if (reinit) {
+		if (memcmp(cid, card->raw_cid, sizeof(cid)) != 0)
 			return -ENOENT;
-
-		card = oldcard;
 	} else {
-		/*
-		 * Allocate card structure.
-		 */
-		card = mmc_alloc_card(host, &sd_type);
-		if (IS_ERR(card))
-			return PTR_ERR(card);
-
+		card->dev.type = &sd_type;
 		card->ocr = ocr;
 		card->type = MMC_TYPE_SD;
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
@@ -974,7 +962,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	if (!oldcard) {
+	if (!reinit) {
 		err = mmc_sd_get_csd(host, card);
 		if (err)
 			goto free_card;
@@ -998,10 +986,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	err = mmc_sd_setup_card(host, card, oldcard != NULL);
+	err = mmc_sd_setup_card(host, card, reinit);
 	if (err)
 		goto free_card;
 
+	if (mmc_card_uhsii(card))
+		return 0;
+
 	/* Initialization sequence for UHS-I cards */
 	if (rocr & SD_ROCR_S18A) {
 		err = mmc_sd_init_uhs_card(card);
@@ -1035,16 +1026,23 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
-	host->card = card;
 	return 0;
-
 free_card:
-	if (!oldcard)
-		mmc_remove_card(card);
-
 	return err;
 }
 
+static inline int mmc_sd_reinit_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card)
+{
+	return mmc_sd_do_init_card(host, ocr, card, true);
+}
+
+static inline int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card)
+{
+	return mmc_sd_do_init_card(host, ocr, card, false);
+}
+
 /*
  * Host is being removed. Free up the current card.
  */
@@ -1151,11 +1149,16 @@ static int _mmc_sd_resume(struct mmc_host *host)
 	if (!mmc_card_suspended(host->card))
 		goto out;
 
-	mmc_power_up(host, host->card->ocr);
-	err = mmc_sd_init_card(host, host->card->ocr, host->card);
-	mmc_card_clr_suspended(host->card);
+	if (mmc_card_uhsii(host->card))
+		mmc_sd_init_uhsii_card(host->card);
+
+	if (!mmc_card_uhsii(host->card))
+		mmc_power_up(host, host->card->ocr);
+
+	err = mmc_sd_reinit_card(host, host->card->ocr, host->card);
 
 out:
+	mmc_card_clr_suspended(host->card);
 	mmc_release_host(host);
 	return err;
 }
@@ -1218,7 +1221,7 @@ static int mmc_sd_power_restore(struct mmc_host *host)
 	int ret;
 
 	mmc_claim_host(host);
-	ret = mmc_sd_init_card(host, host->card->ocr, host->card);
+	ret = mmc_sd_reinit_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
 
 	return ret;
@@ -1405,13 +1408,22 @@ int mmc_attach_sd(struct mmc_host *host)
 {
 	int err;
 	u32 ocr, rocr;
+	struct mmc_card *card;
 
-	BUG_ON(!host);
+	BUG_ON(!host || !host->card);
 	WARN_ON(!host->claimed);
 
+	card = host->card;
+
+	/*
+	 * some sd4.0 card may fail to response ACMD41 with arg=0.
+	 */
 	err = mmc_send_app_op_cond(host, 0, &ocr);
-	if (err)
-		return err;
+	if (err) {
+		ocr = MMC_VDD_32_33 | MMC_VDD_33_34;
+		pr_debug("%s: using default ocr = 0x%08x\n",
+			mmc_hostname(host), ocr);
+	}
 
 	mmc_attach_bus(host, &mmc_sd_ops);
 	if (host->ocr_avail_sd)
@@ -1441,7 +1453,7 @@ int mmc_attach_sd(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_sd_init_card(host, rocr, NULL);
+	err = mmc_sd_init_card(host, rocr, card);
 	if (err)
 		goto err;
 
@@ -1449,15 +1461,10 @@ int mmc_attach_sd(struct mmc_host *host)
 	err = mmc_add_card(host->card);
 	mmc_claim_host(host);
 	if (err)
-		goto remove_card;
+		goto err;
 
 	return 0;
 
-remove_card:
-	mmc_release_host(host);
-	mmc_remove_card(host->card);
-	host->card = NULL;
-	mmc_claim_host(host);
 err:
 	mmc_detach_bus(host);
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5bc6c7d..d74f42b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -575,18 +575,17 @@ out:
 
 /*
  * Handle the detection and initialisation of a card.
- *
- * In the case of a resume, "oldcard" will contain the card
- * we're trying to reinitialise.
  */
-static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
-			      struct mmc_card *oldcard, int powered_resume)
+static int mmc_sdio_do_init_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card, int powered_resume, bool reinit)
 {
-	struct mmc_card *card;
 	int err;
+	unsigned short old_vendor = 0;
+	unsigned short old_device = 0;
 	int retries = 10;
 	u32 rocr = 0;
 	u32 ocr_card = ocr;
+	u32 raw_cid[4];
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -619,31 +618,20 @@ try_again:
 			goto err;
 	}
 
-	/*
-	 * Allocate card structure.
-	 */
-	card = mmc_alloc_card(host, NULL);
-	if (IS_ERR(card)) {
-		err = PTR_ERR(card);
-		goto err;
-	}
-
 	if ((rocr & R4_MEMORY_PRESENT) &&
-	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
+		mmc_sd_get_cid(host, ocr & rocr, raw_cid, NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
-
-		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
-		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
-			mmc_remove_card(card);
-			return -ENOENT;
+		if (reinit) {
+			int cmp_cid = memcmp(raw_cid, card->raw_cid,
+					sizeof(raw_cid));
+			if (cmp_cid != 0 || card->type != MMC_TYPE_SD_COMBO)
+				return -ENOENT;
 		}
 	} else {
-		card->type = MMC_TYPE_SDIO;
-
-		if (oldcard && oldcard->type != MMC_TYPE_SDIO) {
-			mmc_remove_card(card);
+		if (reinit && card->type != MMC_TYPE_SDIO)
 			return -ENOENT;
-		}
+
+		card->type = MMC_TYPE_SDIO;
 	}
 
 	/*
@@ -666,7 +654,6 @@ try_again:
 			sdio_reset(host);
 			mmc_go_idle(host);
 			mmc_send_if_cond(host, host->ocr_avail);
-			mmc_remove_card(card);
 			retries--;
 			goto try_again;
 		} else if (err) {
@@ -684,20 +671,12 @@ try_again:
 		err = mmc_send_relative_addr(host, &card->rca);
 		if (err)
 			goto remove;
-
-		/*
-		 * Update oldcard with the new RCA received from the SDIO
-		 * device -- we're doing this so that it's updated in the
-		 * "card" struct when oldcard overwrites that later.
-		 */
-		if (oldcard)
-			oldcard->rca = card->rca;
 	}
 
 	/*
 	 * Read CSD, before selecting the card
 	 */
-	if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
+	if (!reinit && card->type == MMC_TYPE_SD_COMBO) {
 		err = mmc_sd_get_csd(host, card);
 		if (err)
 			return err;
@@ -737,6 +716,11 @@ try_again:
 	if (err)
 		goto remove;
 
+	if (reinit) {
+		old_vendor = card->cis.vendor;
+		old_device = card->cis.device;
+	}
+
 	/*
 	 * Read the common CIS tuples.
 	 */
@@ -744,20 +728,17 @@ try_again:
 	if (err)
 		goto remove;
 
-	if (oldcard) {
-		int same = (card->cis.vendor == oldcard->cis.vendor &&
-			    card->cis.device == oldcard->cis.device);
-		mmc_remove_card(card);
+	if (reinit) {
+		int same = (card->cis.vendor == old_vendor &&
+			    card->cis.device == old_device);
 		if (!same)
 			return -ENOENT;
-
-		card = oldcard;
 	}
 	card->ocr = ocr_card;
 	mmc_fixup_device(card, NULL);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
-		err = mmc_sd_setup_card(host, card, oldcard != NULL);
+		err = mmc_sd_setup_card(host, card, reinit);
 		/* handle as SDIO-only card if memory init failed */
 		if (err) {
 			mmc_go_idle(host);
@@ -776,6 +757,9 @@ try_again:
 	if (err)
 		goto remove;
 
+	if (mmc_card_uhsii(card))
+		return err;
+
 	/* Initialization sequence for UHS-I cards */
 	/* Only if card supports 1.8v and UHS signaling */
 	if ((ocr & R4_18V_PRESENT) && card->sw_caps.sd3_bus_mode) {
@@ -805,18 +789,23 @@ try_again:
 			goto remove;
 	}
 finish:
-	if (!oldcard)
-		host->card = card;
-	return 0;
-
 remove:
-	if (!oldcard)
-		mmc_remove_card(card);
-
 err:
 	return err;
 }
 
+static inline int mmc_sdio_reinit_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card, int powered_resume)
+{
+	return mmc_sdio_do_init_card(host, ocr, card, powered_resume, true);
+}
+
+static inline int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
+		struct mmc_card *card, int powered_resume)
+{
+	return mmc_sdio_do_init_card(host, ocr, card, powered_resume, false);
+}
+
 /*
  * Host is being removed. Free up the current card.
  */
@@ -973,7 +962,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		mmc_send_if_cond(host, host->card->ocr);
 		err = mmc_send_io_op_cond(host, 0, NULL);
 		if (!err)
-			err = mmc_sdio_init_card(host, host->card->ocr,
+			err = mmc_sdio_reinit_card(host, host->card->ocr,
 						 host->card,
 						 mmc_card_keep_power(host));
 	} else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
@@ -1031,8 +1020,8 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 	if (ret)
 		goto out;
 
-	ret = mmc_sdio_init_card(host, host->card->ocr, host->card,
-				mmc_card_keep_power(host));
+	ret = mmc_sdio_reinit_card(host, host->card->ocr, host->card,
+			mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
 
@@ -1078,9 +1067,11 @@ int mmc_attach_sdio(struct mmc_host *host)
 	u32 ocr, rocr;
 	struct mmc_card *card;
 
-	BUG_ON(!host);
+	BUG_ON(!host || !host->card);
 	WARN_ON(!host->claimed);
 
+	card = host->card;
+
 	err = mmc_send_io_op_cond(host, 0, &ocr);
 	if (err)
 		return err;
@@ -1103,12 +1094,10 @@ int mmc_attach_sdio(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_sdio_init_card(host, rocr, NULL, 0);
+	err = mmc_sdio_init_card(host, rocr, card, 0);
 	if (err)
 		goto err;
 
-	card = host->card;
-
 	/*
 	 * Enable runtime PM only if supported by host+card+board
 	 */
-- 
1.9.1
