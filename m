From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP4: MMC: increase delay for pbias
Date: Wed, 1 Jun 2011 16:45:22 +0530
Message-ID: <1306926923-3398-2-git-send-email-balajitk@ti.com>
References: <1306926923-3398-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161136Ab1FALRS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2011 07:17:18 -0400
In-Reply-To: <1306926923-3398-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com, Balaji T K <balajitk@ti.com>

4 micro seconds is not enough for PBIAS if MMC regulator is
enabled from MMC regulator OFF.
Increase the delay for PBIAS to stabilize.
Wait for PBIAS and timeout if not.

Resolves MMC/SD failure on OMAP4
"Pbias Voltage is not same as LDO"

Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>
---
v2:
replace usleep by usleep_range

 arch/arm/mach-omap2/hsmmc.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b2f30be..24f25c7 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -145,6 +145,7 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 				 int power_on, int vdd)
 {
 	u32 reg;
+	unsigned long timeout;
 
 	if (power_on) {
 		reg = omap4_ctrl_pad_readl(control_pbias_offset);
@@ -157,9 +158,15 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 			OMAP4_MMC1_PWRDNZ_MASK |
 			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
 		omap4_ctrl_pad_writel(reg, control_pbias_offset);
-		/* 4 microsec delay for comparator to generate an error*/
-		udelay(4);
-		reg = omap4_ctrl_pad_readl(control_pbias_offset);
+
+		timeout = jiffies + msecs_to_jiffies(5);
+		do {
+			reg = omap4_ctrl_pad_readl(control_pbias_offset);
+			if (!(reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK))
+				break;
+			usleep_range(100, 200);
+		} while (!time_after(jiffies, timeout));
+
 		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
 			pr_err("Pbias Voltage is not same as LDO\n");
 			/* Caution : On VMODE_ERROR Power Down MMC IO */
-- 
1.7.0.4

