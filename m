From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH v3] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Sun, 15 Nov 2015 21:53:51 +0800
Message-ID: <56488E6F.3090109@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23247 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbbKONxz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 15 Nov 2015 08:53:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, neilb@suse.de, jh80.chung@samsung.com, afenkart@gmail.com, joe@perches.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition timing dependency between devices. This
patch enables SDIO card and function devices to suspend/resume
asynchronously. This will take advantage of multicore and improve
system suspend/resume speed. After enabling the SDIO devices and all
their child devices to suspend/resume asynchronously on ASUS T100TA,
the system suspend-to-idle time is reduced from 1645ms to 1119ms, and
the system resume time is reduced from 940ms to 918ms.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
Changes in v3:
- Add test result in commit message

 drivers/mmc/core/sdio.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 16d838e..530ce88 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1113,6 +1113,8 @@ int mmc_attach_sdio(struct mmc_host *host)
 		pm_runtime_enable(&card->dev);
 	}
 
+	device_enable_async_suspend(&card->dev);
+
 	/*
 	 * The number of functions on the card is encoded inside
 	 * the ocr.
@@ -1133,6 +1135,8 @@ int mmc_attach_sdio(struct mmc_host *host)
 		 */
 		if (host->caps & MMC_CAP_POWER_OFF_CARD)
 			pm_runtime_enable(&card->sdio_func[i]->dev);
+
+		device_enable_async_suspend(&card->sdio_func[i]->dev);
 	}
 
 	/*
-- 1.7.1

