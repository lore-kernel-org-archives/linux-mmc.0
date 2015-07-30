From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 7/7] ARM: dts: dra72-evm: Fix spurious card insert/removal interrupt
Date: Thu, 30 Jul 2015 13:43:40 +0530
Message-ID: <1438244020-4244-8-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

ldo1_reg in addition to being connected to the io lines is also
connected to the card detect line. On card removal, omap_hsmmc
driver does a regulator_disable causing card detect line to be
pulled down. This raises a card insertion interrupt and once the
MMC core detects there is no card inserted, it does a
regulator disable which again raises a card insertion interrupt.
This happens in a loop causing infinite MMC interrupts.

Fix it by making ldo1_reg as always_on.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index c5d8e7d..45f11a0 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -295,6 +295,7 @@
 					regulator-name = "ldo1";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
 					regulator-boot-on;
 				};
 
-- 
1.7.9.5
