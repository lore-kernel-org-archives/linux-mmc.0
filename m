From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: rtsx_pci: Enable MMC_CAP_ERASE to allow erase/discard/trim requests
Date: Wed, 27 Jul 2016 14:25:38 +0200
Message-ID: <1469622338-11158-3-git-send-email-ulf.hansson@linaro.org>
References: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35872 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbcG0MZ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 08:25:57 -0400
Received: by mail-lf0-f49.google.com with SMTP id g62so26046891lfe.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 05:25:56 -0700 (PDT)
In-Reply-To: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Mauro Santos <registo.mailling@gmail.com>, Baolin Wang <baolin.wang@linaro.org>

Cc: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 6158b96..40f957e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1360,7 +1360,7 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
-		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
+		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_ERASE;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
-- 
1.9.1

