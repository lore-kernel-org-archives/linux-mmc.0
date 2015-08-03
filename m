From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 16/16] mmc: host: omap_hsmmc: use "mmc_of_parse_voltage" to get ocr_avail
Date: Mon, 3 Aug 2015 17:56:41 +0530
Message-ID: <1438604801-11823-17-git-send-email-kishon@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

For platforms that doesn't have explicit regulator control in MMC,
populate voltage-ranges in MMC device tree node and use
mmc_of_parse_voltage to get ocr_avail

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 ++
 drivers/mmc/host/omap_hsmmc.c                      |    9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

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
index 15973f1..d884d8f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2184,7 +2184,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 			goto err_irq;
 	}
 
-	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
+	if (!mmc_pdata(host)->ocr_mask) {
+		ret = mmc_of_parse_voltage(pdev->dev.of_node, &mmc->ocr_avail);
+		if (ret)
+			goto err_parse_voltage;
+	} else {
+		mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
+	}
 
 	omap_hsmmc_disable_irq(host);
 
@@ -2224,6 +2230,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
+err_parse_voltage:
 	omap_hsmmc_reg_put(host);
 err_irq:
 	device_init_wakeup(&pdev->dev, false);
-- 
1.7.9.5
