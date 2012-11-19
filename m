From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH 3/3] MMC: omap_hsmmc: add DT property for ti-swakeup-not-implemented.
Date: Mon, 19 Nov 2012 22:42:59 +0100
Message-ID: <1353361379-21002-4-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:37896 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752321Ab2KSVoB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 16:44:01 -0500
In-Reply-To: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: david.vrabel@csr.com, daniel@zonque.org, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/boot/dts/am335x-sue-s800.dtsi |    1 +
 drivers/mmc/host/omap_hsmmc.c          |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sue-s800.dtsi b/arch/arm/boot/dts/am335x-sue-s800.dtsi
index 06304cc..7a446fe 100644
--- a/arch/arm/boot/dts/am335x-sue-s800.dtsi
+++ b/arch/arm/boot/dts/am335x-sue-s800.dtsi
@@ -158,6 +158,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc1_pins>;
 			ti,non-removable;
+			ti,swakeup-not-implemented;
 			bus-width = <4>;
 			vmmc-supply = <&ldo2_reg>;
 			vmmc_aux-supply = <&vmmc>;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 90f4b32..290d5da 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1783,6 +1783,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,dual-volt", NULL))
 		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
 
+	if (of_find_property(np, "ti,swakeup-not-implemented", NULL))
+		pdata->controller_flags |= OMAP_HSMMC_SWAKEUP_NOT_IMPLEMENTED;
+
 	/* This driver only supports 1 slot */
 	pdata->nr_slots = 1;
 	pdata->slots[0].switch_pin = of_get_named_gpio(np, "cd-gpios", 0);
-- 
1.7.10.4

