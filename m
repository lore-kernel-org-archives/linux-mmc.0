From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/9] mmc: core: Update CMD13 polling policy when switch to HS DDR mode
Date: Wed, 16 Nov 2016 11:51:18 +0100
Message-ID: <1479293481-20186-7-git-send-email-ulf.hansson@linaro.org>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36855 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934463AbcKPKvn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 05:51:43 -0500
Received: by mail-wm0-f45.google.com with SMTP id g23so231070662wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 02:51:42 -0800 (PST)
In-Reply-To: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

According to the JEDEC specification, during bus timing change operations
for mmc, sending a CMD13 could trigger CRC errors.

As switching to HS DDR mode indeed causes a bus timing change, polling with
CMD13 to detect card busy, may thus potentially trigger CRC errors.
Currently these errors are treated as the switch to HS DDR mode failed.

To improve this behaviour, let's instead tell __mmc_switch() to retry when
it encounters CRC errors during polling.

Moreover, when switching to HS DDR mode, let's make sure the CMD13 polling
is done by having the mmc host and the mmc card, being configured to
operate at the same selected bus speed timing. Fix this by providing
MMC_TIMING_MMC_DDR52 as the timing parameter to __mmc_switch().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 15dd51c..3268fcd 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1040,10 +1040,12 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
 		EXT_CSD_DDR_BUS_WIDTH_8 : EXT_CSD_DDR_BUS_WIDTH_4;
 
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_BUS_WIDTH,
-			ext_csd_bits,
-			card->ext_csd.generic_cmd6_time);
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			   EXT_CSD_BUS_WIDTH,
+			   ext_csd_bits,
+			   card->ext_csd.generic_cmd6_time,
+			   MMC_TIMING_MMC_DDR52,
+			   true, true, true);
 	if (err) {
 		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
@@ -1086,9 +1088,6 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	if (err)
 		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
 
-	if (!err)
-		mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
-
 	return err;
 }
 
-- 
1.9.1

