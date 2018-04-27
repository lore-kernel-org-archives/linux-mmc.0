From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 02/14] ARM: dts: dra71-evm: Add "vqmmc-supply" property for mmc2
Date: Fri, 27 Apr 2018 17:38:53 +0530
Message-ID: <20180427120905.3665-3-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add "vqmmc-supply" property for mmc2 to indicate the supply connected
to the IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index ebc4bbae981e..64c57d87ca2f 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -204,6 +204,7 @@
 	pinctrl-2 = <&mmc2_pins_ddr_rev20 &mmc2_iodelay_ddr_conf>;
 	pinctrl-3 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev20_conf>;
 	vmmc-supply = <&evm_1v8_sw>;
+	vqmmc-supply = <&evm_1v8_sw>;
 };
 
 &mac {
-- 
2.17.0
