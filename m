From: Bryan Buckley <bryan.buckley@ti.com>
Subject: [PATCH] OMAP4: MMC: fix power and audio issue, decouple USBC1 from MMC1
Date: Thu, 21 Jul 2011 14:29:03 -0500
Message-ID: <1311276543-9374-1-git-send-email-bryan.buckley@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Moiz Sonasath <m-sonasath@ti.com>, Viswanath Puttagunta <vishp@ti.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Bryan Buckley <bryan.buckley@ti.com>
List-Id: linux-mmc@vger.kernel.org

Remove OMAP4_USBC1_ICUSB_PWRDNZ_MASK during enable/disable PWRDNZ mode for
MMC1_PBIAS and associated extended-drain MMC1 I/O cell. This is in accordance
with the control module programming guide. This fixes a bug where if trying to
use gpio_98 or gpio_99 and MMC1 at the same time the GPIO signal will be
affected by a changing SDMMC1_VDDS.

Software must keep MMC1_PBIAS cell and MMC1_IO cell PWRDNZ signals low whenever
SDMMC1_VDDS ramps up/down or changes for cell protection purposes.

MMC1 is based on SDMMC1_VDDS whereas USBC1 is based on SIM_VDDS therefore
they can operate independently.

Signed-off-by: Bryan Buckley <bryan.buckley@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 3842405..a6135df 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -144,8 +144,7 @@ static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
 	 */
 	reg = omap4_ctrl_pad_readl(control_pbias_offset);
 	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-		OMAP4_MMC1_PWRDNZ_MASK |
-		OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+		OMAP4_MMC1_PWRDNZ_MASK);
 	omap4_ctrl_pad_writel(reg, control_pbias_offset);
 }
 
@@ -165,8 +164,7 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 		else
 			reg |= OMAP4_MMC1_PBIASLITE_VMODE_MASK;
 		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-			OMAP4_MMC1_PWRDNZ_MASK |
-			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+			OMAP4_MMC1_PWRDNZ_MASK);
 		omap4_ctrl_pad_writel(reg, control_pbias_offset);
 		/* 4 microsec delay for comparator to generate an error*/
 		udelay(4);
@@ -174,16 +172,14 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
 			pr_err("Pbias Voltage is not same as LDO\n");
 			/* Caution : On VMODE_ERROR Power Down MMC IO */
-			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK |
-				OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK);
 			omap4_ctrl_pad_writel(reg, control_pbias_offset);
 		}
 	} else {
 		reg = omap4_ctrl_pad_readl(control_pbias_offset);
 		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
 			OMAP4_MMC1_PWRDNZ_MASK |
-			OMAP4_MMC1_PBIASLITE_VMODE_MASK |
-			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+			OMAP4_MMC1_PBIASLITE_VMODE_MASK);
 		omap4_ctrl_pad_writel(reg, control_pbias_offset);
 	}
 }
-- 
1.7.0.4

