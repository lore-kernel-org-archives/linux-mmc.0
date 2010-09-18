From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v2 4/4] omap4 hsmmc: Update ocr mask for MMC2 for regulator
     to use
Date: Sat, 18 Sep 2010 22:04:24 +0530 (IST)
Message-ID: <33993.10.24.255.17.1284827664.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693Ab0IRQe0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Sep 2010 12:34:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On OMAP4, MMC2 controller has eMMC which draws power from VAUX regulator
on TWL. Though the eMMC supports dual voltage[1.8v/3v] as per ocr register,
its VCC is fixed at 3V for operation. With this once the mmc core selects
the minimum voltage supported based on the ocr value read from OCR register,
eMMC will not get detected. Thus the platform data for MMC2 is updated with ocr
mask and same will be communicated to core which will set the regulator to
always operate at 3V when turned ON.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    1 +
 drivers/mmc/host/omap_hsmmc.c       |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ac8541c..9fd1044 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -202,6 +202,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable   = true,
+		.ocr_mask	= MMC_VDD_29_30,
 	},
 	{}	/* Terminator */
 };
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bfca9ca..00d16d1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -364,6 +364,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	struct regulator *reg;
 	int ret = 0;
+	int ocr_value = 0;

 	switch (host->id) {
 	case OMAP_MMC1_DEVID:
@@ -396,6 +397,17 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 		}
 	} else {
 		host->vcc = reg;
+		ocr_value = mmc_regulator_get_ocrmask(reg);
+		if (!mmc_slot(host).ocr_mask) {
+			mmc_slot(host).ocr_mask = ocr_value;
+		} else {
+			if (!(mmc_slot(host).ocr_mask & ocr_value)) {
+				pr_err("MMC%d ocrmask %x is not supported\n",
+					host->id, mmc_slot(host).ocr_mask);
+				mmc_slot(host).ocr_mask = 0;
+				return -EINVAL;
+			}
+		}
 		mmc_slot(host).ocr_mask = mmc_regulator_get_ocrmask(reg);

 		/* Allow an aux regulator */
-- 
1.7.0.4


