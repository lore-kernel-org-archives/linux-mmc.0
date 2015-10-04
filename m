From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 1/3] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Sun,  4 Oct 2015 12:04:11 +0000
Message-ID: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34545 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbJDLzq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Oct 2015 07:55:46 -0400
Received: by padhy16 with SMTP id hy16so8548396pad.1
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2015 04:55:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: workgroup.linux@csr.com, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Weijun Yang <york.yang@csr.com>

As SD Specifications Part1 Physical Layer Specification Version
3.01 says, CMD19 tuning is available for unlocked cards in transfer
state of 1.8V signaling mode. The small difference between v3.00
and 3.01 spec means that CMD19 tuning is also available for DDR50
mode.

Signed-off-by: Weijun Yang <york.yang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/core/sd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4e7366a..eaf8cb3 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -628,9 +628,24 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
 	 */
 	if (!mmc_host_is_spi(card->host) &&
-	    (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
-	     card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
+		(card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
+		 card->sd_bus_speed == UHS_DDR50_BUS_SPEED ||
+		 card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
 		err = mmc_execute_tuning(card);
+
+		/*
+		 * As SD Specifications Part1 Physical Layer Specification Version
+		 * 3.01 says, CMD19 tuning is available for unlocked cards in transfer
+		 * state of 1.8V signaling mode. The small difference between v3.00
+		 * and 3.01 spec means that CMD19 tuning is also available for DDR50
+		 * mode.
+		 */
+		if (err && (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
+			pr_warn("%s: ddr50 tuning failed\n", mmc_hostname(card->host));
+			err = 0;
+		}
+	}
+
 out:
 	kfree(status);
 
-- 
1.9.1

