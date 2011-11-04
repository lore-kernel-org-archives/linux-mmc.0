From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/4] omap4: mmc: Pass SoC and board data for omap4 mmc from dt
Date: Fri, 4 Nov 2011 17:20:40 +0530
Message-ID: <1320407441-29697-4-git-send-email-rnayak@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

Pass all omap4-hsmmc related data from device tree.
Currenly limited to only omap4-panda and omap4-sdp
boards.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   23 ++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   33 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi      |   46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 4c3069f..07c5433 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -105,3 +105,26 @@
 &i2c4 {
 	clock-frequency = <400000>;
 };
+
+&mmc1 {
+	ti,hsmmc-nr-slots = <1>;
+	vmmc-supply = <&vmmc>;
+	slot@1 {
+		linux,mmc_cap_4_bit_data;
+		linux,mmc_cap_8_bit_data;
+		ti,hsmmc-has-special-reset;
+	};
+};
+
+&mmc5 {
+	ti,hsmmc-nr-slots = <1>;
+	vmmc-supply = <&vwl1271>;
+	slot@1 {
+		ti,hsmmc-slot-name = "wl1271";
+		linux,mmc_cap_4_bit_data;
+		linux,mmc_cap_power_off_card;
+		ti,hsmmc-ocr-mask = <0x80>;
+		ti,hsmmc-nonremovable;
+		ti,hsmmc-has-special-reset;
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index adc7faf..d37d416 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -125,3 +125,36 @@
 		reg = <0x1e>;
 	};
 };
+
+&mmc1 {
+	ti,hsmmc-nr-slots = <1>;
+	vmmc-supply = <&vmmc>;
+	slots@1 {
+		linux,mmc_cap_4_bit_data;
+		linux,mmc_cap_8_bit_data;
+		ti,hsmmc-has-special-reset;
+	};
+};
+
+&mmc2 {
+	ti,hsmmc-nr-slots = <1>;
+	vmmc-supply = <&vaux1>;
+	slots@1 {
+		linux,mmc_cap_4_bit_data;
+		linux,mmc_cap_8_bit_data;
+		ti,hsmmc-nonremovable;
+		ti,hsmmc-ocr-mask = <0x20000>;
+		ti,hsmmc-has-special-reset;
+	};
+};
+
+&mmc5 {
+	ti,hsmmc-nr-slots = <1>;
+	slots@1 {
+		linux,mmc_cap_4_bit_data;
+		linux,mmc_cap_power_off_card;
+		ti,hsmmc-nonremovable;
+		ti,hsmmc-ocr-mask = <0x80>;
+		ti,hsmmc-has-special-reset;
+	};
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 447f482..f4e0540 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -25,6 +25,11 @@
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
+		mmc3 = &mmc3;
+		mmc4 = &mmc4;
+		mmc5 = &mmc5;
 	};
 
 	cpus {
@@ -205,5 +210,46 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
 		};
+
+		mmc1: mmc@0x4809c000 {
+			compatible = "ti,omap-hsmmc0", "ti,omap4-hsmmc";
+			reg = <0x4809c000 0x400>;
+			ti,hwmods = "mmc1";
+			ti,hsmmc-supports-dual-volt;
+			ti,hsmmc-dma-mask = <0xffffffff>;
+			ti,hsmmc-has-pbias;
+		};
+
+		mmc2: mmc@0x480b4000 {
+			compatible = "ti,omap-hsmmc1", "ti,omap4-hsmmc";
+			reg = <0x480b4000 0x400>;
+			ti,hwmods = "mmc2";
+			ti,hsmmc-dma-mask = <0xffffffff>;
+			ti,hsmmc-has-pbias;
+		};
+
+		mmc3: mmc@0x480ad000 {
+			compatible = "ti,omap-hsmmc2", "ti,omap4-hsmmc";
+			reg = <0x480ad000 0x400>;
+			ti,hwmods = "mmc3";
+			ti,hsmmc-dma-mask = <0xffffffff>;
+			ti,hsmmc-has-pbias;
+		};
+
+		mmc4: mmc@0x480d1000 {
+			compatible = "ti,omap-hsmmc3", "ti,omap4-hsmmc";
+			reg = <0x480d1000 0x400>;
+			ti,hwmods = "mmc4";
+			ti,hsmmc-dma-mask = <0xffffffff>;
+			ti,hsmmc-has-pbias;
+		};
+
+		mmc5: mmc@0x480d5000 {
+			compatible = "ti,omap-hsmmc4", "ti,omap4-hsmmc";
+			reg = <0x480d5000 0x400>;
+			ti,hwmods = "mmc5";
+			ti,hsmmc-dma-mask = <0xffffffff>;
+			ti,hsmmc-has-pbias;
+		};
 	};
 };
-- 
1.7.1

