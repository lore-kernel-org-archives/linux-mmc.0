From: Sachin Nikam <Snikam@nvidia.com>
Subject: RE: [PATCH v2 4/4] mmc add support for eMMC Dual Data Rate
Date: Fri, 13 May 2011 11:35:07 +0530
Message-ID: <723849F6A4B5A3408299DF1FFE37CA776C09CFC1FB@BGMAIL02.nvidia.com>
References: <1305265638-1572-1-git-send-email-arindam.nath@amd.com>
 <1305265638-1572-5-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:19799 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1EMGFO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2011 02:05:14 -0400
In-Reply-To: <1305265638-1572-5-git-send-email-arindam.nath@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Arindam Nath' <arindam.nath@amd.com>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "prakity@marvell.com" <prakity@marvell.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>

Hello Folks,

Sorry for interruption.
I wanted to know when and which version of kernel mmc driver will have SD 4.0(UHS-II) support?

Regards,
Sachin Nikam.
NVIDIA.

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Arindam Nath
Sent: Friday, May 13, 2011 11:17 AM
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org; prakity@marvell.com; zhangfei.gao@gmail.com; Arindam Nath
Subject: [PATCH v2 4/4] mmc add support for eMMC Dual Data Rate

From: Philip Rakity <prakity@marvell.com>

eMMC voltage change not required for 1.8V.  3.3V and 1.8V vcc
are capable of doing DDR. vccq of 1.8v is not required.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/core.c  |   14 ++------------
 drivers/mmc/core/core.h  |    2 --
 drivers/mmc/core/mmc.c   |   35 ++++++++++++++++++++++++++++++-----
 include/linux/mmc/host.h |    1 +
 4 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 580fe82..43ca596 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -718,22 +718,12 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
 }
 
 /*
- * Change data bus width and DDR mode of a host.
- */
-void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
-			   unsigned int ddr)
-{
-	host->ios.bus_width = width;
-	host->ios.ddr = ddr;
-	mmc_set_ios(host);
-}
-
-/*
  * Change data bus width of a host.
  */
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 {
-	mmc_set_bus_width_ddr(host, width, MMC_SDR_MODE);
+	host->ios.bus_width = width;
+	mmc_set_ios(host);
 }
 
 /**
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 53d23c2..d9411ed 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -38,8 +38,6 @@ void mmc_ungate_clock(struct mmc_host *host);
 void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
-void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
-			   unsigned int ddr);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
 int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
 			   bool cmd11);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a2c795e..0433fe6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -20,6 +20,7 @@
 #include "core.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "sd_ops.h"
 
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
@@ -633,10 +634,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (mmc_card_highspeed(card)) {
 		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
-			&& (host->caps & (MMC_CAP_1_8V_DDR)))
+			&& ((host->caps & (MMC_CAP_1_8V_DDR |
+			     MMC_CAP_UHS_DDR50))
+				== (MMC_CAP_1_8V_DDR | MMC_CAP_UHS_DDR50)))
 				ddr = MMC_1_8V_DDR_MODE;
 		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
-			&& (host->caps & (MMC_CAP_1_2V_DDR)))
+			&& ((host->caps & (MMC_CAP_1_2V_DDR |
+			     MMC_CAP_UHS_DDR50))
+				== (MMC_CAP_1_2V_DDR | MMC_CAP_UHS_DDR50)))
 				ddr = MMC_1_2V_DDR_MODE;
 	}
 
@@ -670,8 +675,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 					 ext_csd_bits[idx][0],
 					 0);
 			if (!err) {
-				mmc_set_bus_width_ddr(card->host,
-						      bus_width, MMC_SDR_MODE);
+				mmc_set_bus_width(card->host, bus_width);
 				/*
 				 * If controller can't handle bus width test,
 				 * use the highest bus width to maintain
@@ -697,8 +701,29 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				1 << bus_width, ddr);
 			goto free_card;
 		} else if (ddr) {
+			/*
+			 * eMMC cards can support 3.3V to 1.2V i/o (vccq)
+			 * signaling.
+			 *
+			 * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V vccq.
+			 *
+			 * 1.8V vccq at 3.3V core voltage (vcc) is not required
+			 * in the JEDEC spec for DDR.
+			 *
+			 * Do not force change in vccq since we are obviously
+			 * working and no change to vccq is needed.
+			 *
+			 * WARNING: eMMC rules are NOT the same as SD DDR
+			 */
+			if (ddr == EXT_CSD_CARD_TYPE_DDR_1_2V) {
+				err = mmc_set_signal_voltage(host,
+					MMC_SIGNAL_VOLTAGE_120, 0);
+				if (err)
+					goto err;
+			}
 			mmc_card_set_ddr_mode(card);
-			mmc_set_bus_width_ddr(card->host, bus_width, ddr);
+			mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
+			mmc_set_bus_width(card->host, bus_width);
 		}
 	}
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 6716bd1..de32e6a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -66,6 +66,7 @@ struct mmc_ios {
 
 #define MMC_SIGNAL_VOLTAGE_330	0
 #define MMC_SIGNAL_VOLTAGE_180	1
+#define MMC_SIGNAL_VOLTAGE_120	2
 
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
