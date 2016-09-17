From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing led
Date: Sat, 17 Sep 2016 12:14:38 +0200
Message-ID: <1474107278-3271-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36748 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757077AbcIQKOs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Sep 2016 06:14:48 -0400
Received: by mail-lf0-f43.google.com with SMTP id g62so77045740lfe.3
        for <linux-mmc@vger.kernel.org>; Sat, 17 Sep 2016 03:14:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Micky Ching <micky_ching@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

Each access of the parent device (usb device) needs to be done in runtime
resumed state. Currently this isn't case while changing the leds, so let's
add pm_runtime_get_sync() and pm_runtime_put() around these calls.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

While discussing an issue[1] related to runtime PM, I found out that this
minor change at least improves the behavior that has been observed.

[1]
http://www.spinics.net/lists/linux-usb/msg144634.html

---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 6c71fc9..a59c7fa 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
 		container_of(work, struct rtsx_usb_sdmmc, led_work);
 	struct rtsx_ucr *ucr = host->ucr;
 
+	pm_runtime_get_sync(sdmmc_dev(host));
 	mutex_lock(&ucr->dev_mutex);
 
 	if (host->led.brightness == LED_OFF)
@@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
 		rtsx_usb_turn_on_led(ucr);
 
 	mutex_unlock(&ucr->dev_mutex);
+	pm_runtime_put(sdmmc_dev(host));
 }
 #endif
 
-- 
1.9.1

