From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: Update driver to support without regulators
Date: Tue, 14 Jul 2015 14:29:46 -0500
Message-ID: <1436902186-6542-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45576 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbbGNTaK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Jul 2015 15:30:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, rogerq@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>

From: Roger Quadros <rogerq@ti.com>

Update driver to support without regulators.

Without this patch boards that do not enable regulator config options will
fail to boot with a kernel panic.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  2 ++
 drivers/mmc/host/omap_hsmmc.c                           | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 76bf087..2408e87 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -22,6 +22,8 @@ ti,dual-volt: boolean, supports dual voltage cards
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
+voltage-ranges: Specify the voltage range supported if regulator framework
+isn't enabled.
 dmas: List of DMA specifiers with the controller specific format
 as described in the generic DMA client binding. A tx and rx
 specifier is required.
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b2b411d..16c870f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1551,10 +1551,13 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
-			mmc_pdata(host)->set_power(host->dev, 0, 0);
+			if (host->use_reg)
+				mmc_pdata(host)->set_power(host->dev, 0, 0);
 			break;
 		case MMC_POWER_UP:
-			mmc_pdata(host)->set_power(host->dev, 1, ios->vdd);
+			if (host->use_reg)
+				mmc_pdata(host)->set_power(host->dev, 1,
+							   ios->vdd);
 			break;
 		case MMC_POWER_ON:
 			do_send_init_stream = 1;
@@ -2082,10 +2085,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		if (ret)
 			goto err_irq;
 		host->use_reg = 1;
+		mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
+	} else {
+		ret = mmc_of_parse_voltage(pdev->dev.of_node, &mmc->ocr_avail);
+		if (ret)
+			goto err_irq;
 	}
 
-	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
-
 	omap_hsmmc_disable_irq(host);
 
 	/*
-- 
1.9.1

