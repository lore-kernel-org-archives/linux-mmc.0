From: "Yuan, JuntaoX" <juntaox.yuan@intel.com>
Subject: [PATCH] Add SDR12 & SDR25 support for sdio cards.
Date: Tue, 22 Jul 2014 10:52:51 +0000
Message-ID: <588D8A7789B2934A9950BF189ED6F50AEC21B7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "chris@printf.net" <chris@printf.net>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "Yuan, JuntaoX" <juntaox.yuan@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
List-Id: linux-mmc@vger.kernel.org

>From c8a190816725dd6586bc9de997bf8e50416da428 Mon Sep 17 00:00:00 2001
From: Yuan Juntao <juntaox.yuan@intel.com>
Date: Tue, 22 Jul 2014 18:16:34 +0800
Subject: [PATCH] Add SDR12 & SDR25 support for sdio cards.

According to SDIO simplified specification v3.0, a card should also
support SDR25 & SDR12 if one of the DDR50, SDR50, and SDR104 modes
is supported.

Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
---
 drivers/mmc/core/sdio.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4d721c6..6a8ce6f 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -160,15 +160,23 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
 			if (mmc_host_uhs(card->host)) {
 				if (data & SDIO_UHS_DDR50)
 					card->sw_caps.sd3_bus_mode
-						|= SD_MODE_UHS_DDR50;
+						|= SD_MODE_UHS_DDR50 |
+						   SD_MODE_UHS_SDR50 |
+						   SD_MODE_UHS_SDR25 |
+						   SD_MODE_UHS_SDR12;
 
 				if (data & SDIO_UHS_SDR50)
 					card->sw_caps.sd3_bus_mode
-						|= SD_MODE_UHS_SDR50;
+						|= SD_MODE_UHS_SDR50 |
+						   SD_MODE_UHS_SDR25 |
+						   SD_MODE_UHS_SDR12;
 
 				if (data & SDIO_UHS_SDR104)
 					card->sw_caps.sd3_bus_mode
-						|= SD_MODE_UHS_SDR104;
+						|= SD_MODE_UHS_SDR104 |
+						   SD_MODE_UHS_SDR50 |
+						   SD_MODE_UHS_SDR25 |
+						   SD_MODE_UHS_SDR12;
 			}
 
 			ret = mmc_io_rw_direct(card, 0, 0,
-- 
1.7.9.5
