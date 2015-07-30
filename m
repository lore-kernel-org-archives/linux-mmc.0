From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/7] ARM: dts: dra72-evm: Set max clock frequency of MMC1 and MMC2
Date: Thu, 30 Jul 2015 13:43:36 +0530
Message-ID: <1438244020-4244-4-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

MMC1 supports SDR104 and MMC2 supports HS200 both of which requires
192MHz clock. Set the maximum operating clock frequency to 192 MHz.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 3998d37..c5d8e7d 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -508,6 +508,7 @@
 	 * is a viable alternative
 	 */
 	cd-gpios = <&gpio6 27 0>;
+	max-frequency = <192000000>;
 };
 
 &mmc2 {
@@ -519,6 +520,7 @@
 	vmmc-supply = <&evm_3v3>;
 	bus-width = <8>;
 	ti,non-removable;
+	max-frequency = <192000000>;
 };
 
 &dra7_pmx_core {
-- 
1.7.9.5
