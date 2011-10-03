From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 1/2] arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
Date: Mon, 3 Oct 2011 17:52:50 +0530
Message-ID: <1317644571-25175-2-git-send-email-balajitk@ti.com>
References: <1317644571-25175-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35221 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755615Ab1JCMWL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Oct 2011 08:22:11 -0400
In-Reply-To: <1317644571-25175-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com, Balaji T K <balajitk@ti.com>

MMC1 data line IO's are powered down in before set regulator function.
IO's should not be powered ON when regulator is OFF.
Keep the IO's in power pown mode after regulator OFF otherwise VMODE_ERROR
interrupt is generated due to mismatch in input (regulator)
voltage and MMC IO drive voltage.
Delete incorrect comments which are not applicable for OMAP4.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Reported-by: Viswanath Puttagunta <vishp@ti.com>
---
v2:
update description

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

