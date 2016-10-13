From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/6] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing the led
Date: Thu, 13 Oct 2016 13:37:36 +0200
Message-ID: <1476358660-8338-3-git-send-email-ulf.hansson@linaro.org>
References: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Accesses of the rtsx sdmmc's parent device, which is the rtsx usb device,
must be done when it's runtime resumed. Currently this isn't case when
changing the led, so let's fix this by adding a pm_runtime_get_sync() and
a pm_runtime_put() around those operations.

Reported-by: Ritesh Raj Sarraf <rrs@researchut.com>
Tested-by: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: <stable@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index e0b8590..6e9c0f8 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1309,6 +1309,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
 		container_of(work, struct rtsx_usb_sdmmc, led_work);
 	struct rtsx_ucr *ucr = host->ucr;
 
+	pm_runtime_get_sync(sdmmc_dev(host));
 	mutex_lock(&ucr->dev_mutex);
 
 	if (host->led.brightness == LED_OFF)
@@ -1317,6 +1318,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
 		rtsx_usb_turn_on_led(ucr);
 
 	mutex_unlock(&ucr->dev_mutex);
+	pm_runtime_put(sdmmc_dev(host));
 }
 #endif
 
-- 
1.9.1
