Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C36C2BB40
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D62A23A6A
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLHGTt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 01:19:49 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:40576 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLHGTp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 01:19:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id BD3A520001FE;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fhajEbyVtyYI; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 98A2020009E8;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 66598C01FA8;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 17D7A2001EA; Tue,  8 Dec 2020 14:18:56 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jack <jack.lo@gtsys.com.hk>
Subject: [PATCH 1/6] mmc: core: prepare hs400 update, code order
Date:   Tue,  8 Dec 2020 14:18:34 +0800
Message-Id: <20201208061839.21163-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch didn't change functionality just move
mmc_select_hs400() and mmc_hs200_to_hs400() between
mmc_select_hs400es() and mmc_select_hs200.
fix checkpatch --script warings.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/mmc/core/mmc.c | 184 ++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 92 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ff3063ce2acd..5477786aded8 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1142,98 +1142,6 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	return err;
 }
 
-static int mmc_select_hs400(struct mmc_card *card)
-{
-	struct mmc_host *host = card->host;
-	unsigned int max_dtr;
-	int err = 0;
-	u8 val;
-
-	/*
-	 * HS400 mode requires 8-bit bus width
-	 */
-	if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
-	      host->ios.bus_width == MMC_BUS_WIDTH_8))
-		return 0;
-
-	/* Switch card to HS mode */
-	val = EXT_CSD_TIMING_HS;
-	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			   EXT_CSD_HS_TIMING, val,
-			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
-	if (err) {
-		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
-			mmc_hostname(host), err);
-		return err;
-	}
-
-	/* Prepare host to downgrade to HS timing */
-	if (host->ops->hs400_downgrade)
-		host->ops->hs400_downgrade(host);
-
-	/* Set host controller to HS timing */
-	mmc_set_timing(host, MMC_TIMING_MMC_HS);
-
-	/* Reduce frequency to HS frequency */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
-	err = mmc_switch_status(card, true);
-	if (err)
-		goto out_err;
-
-	if (host->ops->hs400_prepare_ddr)
-		host->ops->hs400_prepare_ddr(host);
-
-	/* Switch card to DDR */
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			 EXT_CSD_BUS_WIDTH,
-			 EXT_CSD_DDR_BUS_WIDTH_8,
-			 card->ext_csd.generic_cmd6_time);
-	if (err) {
-		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
-			mmc_hostname(host), err);
-		return err;
-	}
-
-	/* Switch card to HS400 */
-	val = EXT_CSD_TIMING_HS400 |
-	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
-	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			   EXT_CSD_HS_TIMING, val,
-			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
-	if (err) {
-		pr_err("%s: switch to hs400 failed, err:%d\n",
-			 mmc_hostname(host), err);
-		return err;
-	}
-
-	/* Set host controller to HS400 timing and frequency */
-	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
-	mmc_set_bus_speed(card);
-
-	if (host->ops->hs400_complete)
-		host->ops->hs400_complete(host);
-
-	err = mmc_switch_status(card, true);
-	if (err)
-		goto out_err;
-
-	return 0;
-
-out_err:
-	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
-	       __func__, err);
-	return err;
-}
-
-int mmc_hs200_to_hs400(struct mmc_card *card)
-{
-	return mmc_select_hs400(card);
-}
-
 int mmc_hs400_to_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
@@ -1425,6 +1333,98 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	return err;
 }
 
+static int mmc_select_hs400(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	unsigned int max_dtr;
+	int err = 0;
+	u8 val;
+
+	/*
+	 * HS400 mode requires 8-bit bus width
+	 */
+	if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
+	      host->ios.bus_width == MMC_BUS_WIDTH_8))
+		return 0;
+
+	/* Switch card to HS mode */
+	val = EXT_CSD_TIMING_HS;
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			   EXT_CSD_HS_TIMING, val,
+			   card->ext_csd.generic_cmd6_time, 0,
+			   false, true);
+	if (err) {
+		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
+		       mmc_hostname(host), err);
+		return err;
+	}
+
+	/* Prepare host to downgrade to HS timing */
+	if (host->ops->hs400_downgrade)
+		host->ops->hs400_downgrade(host);
+
+	/* Set host controller to HS timing */
+	mmc_set_timing(host, MMC_TIMING_MMC_HS);
+
+	/* Reduce frequency to HS frequency */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
+	err = mmc_switch_status(card, true);
+	if (err)
+		goto out_err;
+
+	if (host->ops->hs400_prepare_ddr)
+		host->ops->hs400_prepare_ddr(host);
+
+	/* Switch card to DDR */
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BUS_WIDTH,
+			 EXT_CSD_DDR_BUS_WIDTH_8,
+			 card->ext_csd.generic_cmd6_time);
+	if (err) {
+		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
+		       mmc_hostname(host), err);
+		return err;
+	}
+
+	/* Switch card to HS400 */
+	val = EXT_CSD_TIMING_HS400 |
+	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			   EXT_CSD_HS_TIMING, val,
+			   card->ext_csd.generic_cmd6_time, 0,
+			   false, true);
+	if (err) {
+		pr_err("%s: switch to hs400 failed, err:%d\n",
+		       mmc_hostname(host), err);
+		return err;
+	}
+
+	/* Set host controller to HS400 timing and frequency */
+	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
+	mmc_set_bus_speed(card);
+
+	if (host->ops->hs400_complete)
+		host->ops->hs400_complete(host);
+
+	err = mmc_switch_status(card, true);
+	if (err)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
+	       __func__, err);
+	return err;
+}
+
+int mmc_hs200_to_hs400(struct mmc_card *card)
+{
+	return mmc_select_hs400(card);
+}
+
 /*
  * For device supporting HS200 mode, the following sequence
  * should be done before executing the tuning process.
-- 
2.20.1

