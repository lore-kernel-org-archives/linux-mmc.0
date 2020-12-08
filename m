Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C8AC4167B
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D37F23A80
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgLHGUb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 01:20:31 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:40706 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgLHGUb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 01:20:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 003E72000B4E;
        Tue,  8 Dec 2020 14:18:58 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v4tPbF-CXAos; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id A07332003044;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 70D4FC01FB6;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 21F0F2006D0; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jack <jack.lo@gtsys.com.hk>
Subject: [PATCH 4/6] mmc: core: remove mmc_select_hs400es()
Date:   Tue,  8 Dec 2020 14:18:37 +0800
Message-Id: <20201208061839.21163-5-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enhanced strobe function had been merged in mmc_select_hs400();
mmc_select_hs400es() is obsolate and removed.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/mmc/core/mmc.c | 94 ------------------------------------------
 1 file changed, 94 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 84c09d9e0317..f11562b58e89 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1239,100 +1239,6 @@ static void mmc_select_driver_type(struct mmc_card *card)
 		mmc_set_driver_type(card->host, drv_type);
 }
 
-static int mmc_select_hs400es(struct mmc_card *card)
-{
-	struct mmc_host *host = card->host;
-	int err = -EINVAL;
-	u8 val;
-
-	if (!(host->caps & MMC_CAP_8_BIT_DATA)) {
-		err = -ENOTSUPP;
-		goto out_err;
-	}
-
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V)
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
-
-	if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
-
-	/* If fails try again during next card power cycle */
-	if (err)
-		goto out_err;
-
-	err = mmc_select_bus_width(card);
-	if (err != MMC_BUS_WIDTH_8) {
-		pr_err("%s: switch to 8bit bus width failed, err:%d\n",
-			mmc_hostname(host), err);
-		err = err < 0 ? err : -ENOTSUPP;
-		goto out_err;
-	}
-
-	/* Switch card to HS mode */
-	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
-			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
-	if (err) {
-		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
-			mmc_hostname(host), err);
-		goto out_err;
-	}
-
-	mmc_set_timing(host, MMC_TIMING_MMC_HS);
-	err = mmc_switch_status(card, true);
-	if (err)
-		goto out_err;
-
-	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
-
-	/* Switch card to DDR with strobe bit */
-	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			 EXT_CSD_BUS_WIDTH,
-			 val,
-			 card->ext_csd.generic_cmd6_time);
-	if (err) {
-		pr_err("%s: switch to bus width for hs400es failed, err:%d\n",
-			mmc_hostname(host), err);
-		goto out_err;
-	}
-
-	mmc_select_driver_type(card);
-
-	/* Switch card to HS400 */
-	val = EXT_CSD_TIMING_HS400 |
-	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
-	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			   EXT_CSD_HS_TIMING, val,
-			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true);
-	if (err) {
-		pr_err("%s: switch to hs400es failed, err:%d\n",
-			mmc_hostname(host), err);
-		goto out_err;
-	}
-
-	/* Set host controller to HS400 timing and frequency */
-	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
-
-	/* Controller enable enhanced strobe function */
-	host->ios.enhanced_strobe = true;
-	if (host->ops->hs400_enhanced_strobe)
-		host->ops->hs400_enhanced_strobe(host, &host->ios);
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
 static int mmc_select_hs400(struct mmc_card *card, bool enhancedstrobe)
 {
 	struct mmc_host *host = card->host;
-- 
2.20.1

