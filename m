From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] MMC/SDIO: enable SDIO device to suspend/resume asynchronously
Date: Thu, 30 Jul 2015 15:40:31 +0800
Message-ID: <55B9D4EF.2010704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64997 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbbG3Hkg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jul 2015 03:40:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, neilb@suse.de, Jaehoon Chung <jh80.chung@samsung.com>, afenkart@gmail.com, joe@perches.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Enable SDIO card and function device to suspend/resume asynchronously.
This can improve system suspend/resume speed.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
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

