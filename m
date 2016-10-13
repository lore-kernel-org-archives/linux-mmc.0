From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/6] mmc: core: Don't power off the card when starting the host
Date: Thu, 13 Oct 2016 13:37:40 +0200
Message-ID: <1476358660-8338-7-git-send-email-ulf.hansson@linaro.org>
References: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

The MMC_CAP2_NO_PRESCAN_POWERUP was invented to avoid running the power up
sequence, mmc_power_up(), during ->probe() of the mmc host driver, but
instead defer this to the mmc detect work. This is especially useful for
those hosts that suffers from a long initialization time, as this time
would otherwise add up to the total boot time.

However, due to the introduction of runtime PM of mmc host devices in the
mmc core, this behaviour changed a bit. More precisely, it caused the mmc
core to runtime resume the host device during ->probe() of the host driver.
In cases like the rtsx_usb_sdmmc, runtime resuming the device may be costly
and thus affecting the total boot time.

To improve this behaviour when using MMC_CAP2_NO_PRESCAN_POWERUP, let's
postpone also calling mmc_power_off() when starting the host. This change
allows the mmc core to avoid runtime resuming the device, as it don't need
to claim the host for that execution path.

Cc: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2553d90..2ad7291 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2824,12 +2824,11 @@ void mmc_start_host(struct mmc_host *host)
 	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
 
-	mmc_claim_host(host);
-	if (host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)
-		mmc_power_off(host);
-	else
+	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
+		mmc_claim_host(host);
 		mmc_power_up(host, host->ocr_avail);
-	mmc_release_host(host);
+		mmc_release_host(host);
+	}
 
 	mmc_gpiod_request_cd_irq(host);
 	_mmc_detect_change(host, 0, false);
-- 
1.9.1
