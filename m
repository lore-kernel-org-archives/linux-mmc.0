From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v3 3/4] omap4 hsmmc: Register offset handling
Date: Wed, 22 Sep 2010 22:13:55 +0530 (IST)
Message-ID: <14881.10.24.255.18.1285173835.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51950 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab0IVQoA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Sep 2010 12:44:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, b-cousson@ti.com

In OMAP4, as per new PM programming model, the legacy registers
which were there in OMAP3 are all shifted by 0x100 while new one's
are added from offset 0 to 0x10.
For OMAP4, the register offset appending of 0x100 done in devices.c
currently, is moved to driver file.This change fits in for current
implementation as well as once the driver undergoes hwmod adaptation.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/devices.c         |    8 +++-----
 arch/arm/mach-omap2/hsmmc.c           |    4 ++++
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    2 ++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..bb7ec13 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -745,13 +745,13 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		case 3:
 			if (!cpu_is_omap44xx())
 				return;
-			base = OMAP4_MMC4_BASE + OMAP4_MMC_REG_OFFSET;
+			base = OMAP4_MMC4_BASE;
 			irq = OMAP44XX_IRQ_MMC4;
 			break;
 		case 4:
 			if (!cpu_is_omap44xx())
 				return;
-			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
+			base = OMAP4_MMC5_BASE;
 			irq = OMAP44XX_IRQ_MMC5;
 			break;
 		default:
@@ -762,10 +762,8 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			size = OMAP2420_MMC_SIZE;
 			name = "mmci-omap";
 		} else if (cpu_is_omap44xx()) {
-			if (i < 3) {
-				base += OMAP4_MMC_REG_OFFSET;
+			if (i < 3)
 				irq += OMAP44XX_IRQ_GIC_START;
-			}
 			size = OMAP4_HSMMC_SIZE;
 			name = "mmci-omap-hs";
 		} else {
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index c8f647b..49d76a7 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -261,6 +261,10 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->slots[0].wires = c->wires;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
+		if (cpu_is_omap44xx())
+			mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
+		else
+			mmc->reg_offset = 0;

 		mmc->get_context_loss_count = hsmmc_get_context_loss;

diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 9b89ec6..4e6ef07 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -71,6 +71,9 @@ struct omap_mmc_platform_data {

 	u64 dma_mask;

+	/* Register offset deviation */
+	u16 reg_offset;
+
 	struct omap_mmc_slot_data {

 		/* 4 wire signaling is optional, and is used for SD/SDIO/HSMMC;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a51894d..8cb007c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2009,6 +2009,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;

+	res->start += pdata->reg_offset;
+	res->end += pdata->reg_offset;
 	res = request_mem_region(res->start, res->end - res->start + 1,
 							pdev->name);
 	if (res == NULL)
-- 
1.7.0.4


