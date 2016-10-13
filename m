From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/6] mmc: rtsx_usb_sdmmc: Avoid keeping the device runtime resumed when unused
Date: Thu, 13 Oct 2016 13:37:35 +0200
Message-ID: <1476358660-8338-2-git-send-email-ulf.hansson@linaro.org>
References: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33435 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbcJMLia (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 07:38:30 -0400
Received: by mail-lf0-f45.google.com with SMTP id x79so135043890lff.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2016 04:37:55 -0700 (PDT)
In-Reply-To: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>, stable@vger.kernel.org

The rtsx_usb_sdmmc driver may bail out in its ->set_ios() callback when no
SD card is inserted. This is wrong, as it could cause the device to remain
runtime resumed when it's unused. Fix this behaviour.

Tested-by: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: <stable@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 4106295..e0b8590 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1138,11 +1138,6 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	dev_dbg(sdmmc_dev(host), "%s\n", __func__);
 	mutex_lock(&ucr->dev_mutex);
 
-	if (rtsx_usb_card_exclusive_check(ucr, RTSX_USB_SD_CARD)) {
-		mutex_unlock(&ucr->dev_mutex);
-		return;
-	}
-
 	sd_set_power_mode(host, ios->power_mode);
 	sd_set_bus_width(host, ios->bus_width);
 	sd_set_timing(host, ios->timing, &host->ddr_mode);
-- 
1.9.1

