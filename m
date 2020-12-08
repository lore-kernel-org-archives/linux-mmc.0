Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B8C193FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7879523A61
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgLHGUA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 01:20:00 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:40574 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLHGUA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 01:20:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id B225620035E4;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wppR-p9lkS4W; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 943AC200033F;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 6B179C01FB4;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 1BE472001EB; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jack <jack.lo@gtsys.com.hk>
Subject: [PATCH 2/6] mmc: core: make hs400 independent from hs200 init
Date:   Tue,  8 Dec 2020 14:18:35 +0800
Message-Id: <20201208061839.21163-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move mmc_select_hs400() out from hs200 init path and make hs400
independent.

The patch makes quite some changes and needs to be reviewed carefully.

In function mmc_select_timing() call for mmc_select_hs400().
HS400 requires a host bus with of 8bit, if not supported we
return with -ENOTSUPP, there is no retry.
If the host controller can't switch to 8bit (dts: bus-width = <4>)
it can't recover on next power-up init failed.
Have the controller set to HS mode, make the hs400 tuning prepare
if any and run mmc tuning before switching to HS400.

This patch resolve the problem if hs400-1_8v is set but extended
strobe is not.

&sdhci { // eMMC
        bus-width = <8>;
        mmc-hs400-1_8v;
        // mmc-hs400-enhanced-strobe;
        non-removable;
        status = "okay";
};

[    1.775721] mmc1: CQHCI version 5.10
[    1.802342] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
[    2.007581] mmc1: mmc_select_hs200 failed, error -110
[    2.007589] mmc1: error -110 whilst initialising MMC card
[    2.413559] mmc1: mmc_select_hs200 failed, error -110
[    2.413562] mmc1: error -110 whilst initialising MMC card
[    3.183343] mmc1: Command Queue Engine enabled
[    3.183355] mmc1: new HS400 MMC card at address 0001
[    3.197163] mmcblk1: mmc1:0001 DG4008 7.28 GiB
[    3.197256] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
[    3.197360] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
[    3.197360] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
[    3.197479] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev (242:0)

[    1.743386] mmc1: CQHCI version 5.10
[    1.769952] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
[    1.846223] mmc1: Command Queue Engine enabled
[    1.846230] mmc1: new HS400 MMC card at address 0001
[    1.846557] mmcblk1: mmc1:0001 DG4008 7.28 GiB
[    1.846650] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
[    1.846742] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
[    1.846825] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev (242:0)

Tested with rk3399 customized board.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/mmc/core/mmc.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5477786aded8..e7b4de3d4f47 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1337,15 +1337,46 @@ static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	unsigned int max_dtr;
-	int err = 0;
+	int err = -EINVAL;
 	u8 val;
 
 	/*
-	 * HS400 mode requires 8-bit bus width
+	 * HS400 mode requires host 8-bit bus width
 	 */
-	if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
-	      host->ios.bus_width == MMC_BUS_WIDTH_8))
-		return 0;
+	if (!(host->caps & MMC_CAP_8_BIT_DATA)) {
+		pr_err("%s: host not support hs400 8bit\n",
+		       mmc_hostname(host));
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Below is a change from previous logic.
+	 * mmc_avail_type vccq voltage set in dts, it can be 1_2v or 1_8v
+	 * but not both.
+	 */
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V) {
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
+	} else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V) {
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+	} else {
+		pr_err("%s: hs400 unsupported vccq voltage, err:%d\n",
+		       mmc_hostname(host), -EOPNOTSUPP);
+		return -EOPNOTSUPP;
+	}
+
+	/* Failed set 1_2v or 1_8v try again during next card power cycle */
+	if (err)
+		return err;
+
+	mmc_select_driver_type(card);
+
+	err = mmc_select_bus_width(card);
+	if (err != MMC_BUS_WIDTH_8) {
+		pr_err("%s: switch to 8bit bus width failed, err:%d\n",
+		       mmc_hostname(host), err);
+		err = err < 0 ? err : -EOPNOTSUPP;
+		goto out_err;
+	}
 
 	/* Switch card to HS mode */
 	val = EXT_CSD_TIMING_HS;
@@ -1388,6 +1419,18 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
+	/* HS400 prepare and execute tuning  */
+	host->doing_init_tune = 1;
+	if (host->ops->prepare_hs400_tuning)
+		host->ops->prepare_hs400_tuning(host, &host->ios);
+	err = mmc_execute_tuning(card);
+	host->doing_init_tune = 0;
+	if (err) {
+		pr_err("%s: hs400 tuning failed, err:%d\n",
+		       mmc_hostname(host), err);
+		return err;
+	}
+
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1496,7 +1539,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 }
 
 /*
- * Activate High Speed, HS200 or HS400ES mode if supported.
+ * Activate High Speed, HS200 ,HS400 or HS400ES mode if supported.
  */
 static int mmc_select_timing(struct mmc_card *card)
 {
@@ -1507,6 +1550,8 @@ static int mmc_select_timing(struct mmc_card *card)
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
 		err = mmc_select_hs400es(card);
+	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400)
+		err = mmc_select_hs400(card);
 	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
 		err = mmc_select_hs200(card);
 	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
@@ -1766,15 +1811,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		host->doing_init_tune = 1;
 
 		err = mmc_hs200_tuning(card);
-		if (!err)
-			err = mmc_select_hs400(card);
 
 		host->doing_init_tune = 0;
 
 		if (err)
 			goto free_card;
 
-	} else if (!mmc_card_hs400es(card)) {
+	} else if (!mmc_card_hs400es(card) && !mmc_card_hs400(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
 		if (err > 0 && mmc_card_hs(card)) {
-- 
2.20.1

