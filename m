From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 01/14] ARM: multi_v7_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
Date: Thu, 14 Dec 2017 19:10:41 +0530
Message-ID: <20171214134054.7749-2-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:34431 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdLNNlw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Dec 2017 08:41:52 -0500
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com

Enable CONFIG_MMC_SDHCI_OMAP so that TI's dra7/k2g based SoC's
can use sdhci-omap for eMMC/SD/SDIO controller..

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 61509c4b769f..c8761731aaee 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -741,6 +741,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_BCM2835=y
+CONFIG_MMC_SDHCI_OMAP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_FLASH=m
-- 
2.11.0

