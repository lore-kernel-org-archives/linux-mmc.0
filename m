From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH RESEND 3/3] ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP
Date: Fri, 22 Jun 2018 15:46:17 +0530
Message-ID: <20180622101617.11157-4-kishon@ti.com>
References: <20180622101617.11157-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622101617.11157-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <ssantosh@kernel.org>, kishon@ti.com
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Enable CONFIG_MMC_SDHCI_OMAP so that TI's K2G SoC
can use sdhci-omap driver for MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/keystone_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 2536c231eea1..21a6ce4ef9bc 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -170,7 +170,10 @@ CONFIG_USB_DWC3=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_SDHCI_OMAP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.17.1
