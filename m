From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 13/14] ARM: dts: dra7: Add high speed modes capability to MMC1/MMC2 dt node
Date: Fri, 27 Apr 2018 17:39:04 +0530
Message-ID: <20180427120905.3665-14-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

While the supported UHS mode can be obtained from CAPA2
register, SD Host Controller Standard Specification
doesn't define bits for MMC's HS200 and DDR mode capability.
Add properties to indicate MMC HS200 and DDR speed mode capability in
dt node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ae2f8dd46328..9dcd14edc202 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1086,6 +1086,8 @@
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
 			max-frequency = <192000000>;
+			mmc-ddr-1_8v;
+			mmc-ddr-3_3v;
 		};
 
 		hdqw1w: 1w@480b2000 {
@@ -1104,6 +1106,9 @@
 			max-frequency = <192000000>;
 			/* SDR104/DDR50/SDR50 bits in CAPA2 is not supported */
 			sdhci-caps-mask = <0x7 0x0>;
+			mmc-hs200-1_8v;
+			mmc-ddr-1_8v;
+			mmc-ddr-3_3v;
 		};
 
 		mmc3: mmc@480ad000 {
-- 
2.17.0
