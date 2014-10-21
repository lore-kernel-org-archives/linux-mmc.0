From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/15] mmc: core: Add helper function for EXT_CSD support
Date: Tue, 21 Oct 2014 19:19:04 +0200
Message-ID: <1413911953-19012-7-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:48714 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933122AbaJURTc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:32 -0400
Received: by mail-lb0-f180.google.com with SMTP id n15so1407816lbi.11
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:31 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

The helper function mmc_can_ext_csd() will return a positive value if
the card supports the EXT_CSD register. Start using it at relavant
places in the mmc core.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c     | 8 ++++----
 drivers/mmc/core/mmc_ops.c | 5 +++++
 drivers/mmc/core/mmc_ops.h | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1ed3d82..24dc30f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -190,7 +190,7 @@ static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 
 	*new_ext_csd = NULL;
 
-	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
+	if (!mmc_can_ext_csd(card))
 		return 0;
 
 	/*
@@ -827,7 +827,7 @@ static int mmc_select_powerclass(struct mmc_card *card)
 	int err, ddr;
 
 	/* Power class selection is supported for versions >= 4.0 */
-	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
+	if (!mmc_can_ext_csd(card))
 		return 0;
 
 	bus_width = host->ios.bus_width;
@@ -888,7 +888,7 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	unsigned idx, bus_width = 0;
 	int err = 0;
 
-	if ((card->csd.mmca_vsn < CSD_SPEC_VER_4) &&
+	if (!mmc_can_ext_csd(card) &&
 	    !(host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)))
 		return 0;
 
@@ -1129,7 +1129,7 @@ static int mmc_select_timing(struct mmc_card *card)
 {
 	int err = 0;
 
-	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
+	if (!mmc_can_ext_csd(card))
 		goto bus_speed;
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 7911e05..1db60be4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -675,3 +675,8 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 
 	return 0;
 }
+
+int mmc_can_ext_csd(struct mmc_card *card)
+{
+	return (card && card->csd.mmca_vsn > CSD_SPEC_VER_3);
+}
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index f752ec6..6f4b00e 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -26,6 +26,7 @@ int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
+int mmc_can_ext_csd(struct mmc_card *card);
 
 #endif
 
-- 
1.9.1

