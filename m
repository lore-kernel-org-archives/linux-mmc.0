From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH v2] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Mon, 21 Sep 2015 12:30:41 +0800
Message-ID: <55FF87F1.1000209@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26461 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbbIUEar (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Sep 2015 00:30:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, neilb@suse.de, Jaehoon Chung <jh80.chung@samsung.com>, afenkart@gmail.com, joe@perches.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition timing dependency between devices. This
patch enables SDIO card and function devices to suspend/resume
asynchronously. This will take advantage of multicore and improve
system suspend/resume speed.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
Changes in v2:
- Amend commit message.

 drivers/mmc/core/sdio.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b91abed..6719b77 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1106,6 +1106,8 @@ int mmc_attach_sdio(struct mmc_host *host)
 		pm_runtime_enable(&card->dev);
 	}
 
+	device_enable_async_suspend(&card->dev);
+
 	/*
 	 * The number of functions on the card is encoded inside
 	 * the ocr.
@@ -1126,6 +1128,8 @@ int mmc_attach_sdio(struct mmc_host *host)
 		 */
 		if (host->caps & MMC_CAP_POWER_OFF_CARD)
 			pm_runtime_enable(&card->sdio_func[i]->dev);
+
+		device_enable_async_suspend(&card->sdio_func[i]->dev);
 	}
 
 	/*
-- 1.7.1

