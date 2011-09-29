From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
Date: Thu, 29 Sep 2011 20:14:59 +0530
Message-ID: <1317307500-5514-2-git-send-email-balajitk@ti.com>
References: <1317307500-5514-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1317307500-5514-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

MMC1 data line IO's are powered down in before set regulator function.
IO's should not be powered ON when regulator is OFF.
Keep the IO's in power pown mode after regulator OFF.
Delete incorrect comments which are not applicable for OMAP4.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Reported-by: Viswanath Puttagunta <vishp@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 097a42d..9cc2eb7 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -129,15 +129,11 @@ static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
 	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
 	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
 	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
-	 *
-	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
-	 * is most naturally TWL VSIM; those pins also use PBIAS.
-	 *
-	 * FIXME handle VMMC1A as needed ...
 	 */
 	reg = omap4_ctrl_pad_readl(control_pbias_offset);
 	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-		OMAP4_MMC1_PWRDNZ_MASK);
+		OMAP4_MMC1_PWRDNZ_MASK |
+		OMAP4_MMC1_PBIASLITE_VMODE_MASK);
 	omap4_ctrl_pad_writel(reg, control_pbias_offset);
 }
 
@@ -172,12 +168,6 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK);
 			omap4_ctrl_pad_writel(reg, control_pbias_offset);
 		}
-	} else {
-		reg = omap4_ctrl_pad_readl(control_pbias_offset);
-		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-			OMAP4_MMC1_PWRDNZ_MASK |
-			OMAP4_MMC1_PBIASLITE_VMODE_MASK);
-		omap4_ctrl_pad_writel(reg, control_pbias_offset);
 	}
 }
 
-- 
1.7.0.4

