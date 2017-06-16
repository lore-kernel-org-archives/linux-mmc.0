From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 16/16] ARM: dts: dra7: Add supported MMC/SD modes in MMC dt
 nodes
Date: Fri, 16 Jun 2017 18:15:44 +0530
Message-ID: <20170616124544.15046-17-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On DRA7 family SoCs, MMC1 controller supports SDR104,
SDR50, DDR50, SDR25 and SDR12 UHS modes (These UHS modes
are not supported in beagle-x15 because it's not possible
to switch IO lines supply voltage to 1.8v).

MMC2 controller supports HS200 and DDR modes. (Since some of the
boards like am57xx-evm reva3, beagle-x15 and am57xx idk has
3.3v line connected to IO lines, HS200 cannot be supported
in these boards).

MMC3 controller supports SDR12, SDR25 and SDR50 modes.

MMC4 controller supports SDR12 and SDR25 modes.

Add these supported modes in device-tree file.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts              |  1 +
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts |  1 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts       |  6 ++++++
 arch/arm/boot/dts/am57xx-idk-common.dtsi      |  1 +
 arch/arm/boot/dts/dra7.dtsi                   | 14 ++++++++++++++
 5 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 875291d1bdd7..bdf39d47948f 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -90,4 +90,5 @@
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_rev20 &mmc2_iodelay_ddr_conf>;
+	/delete-property/ mmc-hs200-1_8v;
 };
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index 5a77b334923d..17a25a74a005 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -36,6 +36,7 @@
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_3_3v_rev11 &mmc2_iodelay_ddr_3_3v_rev11_conf>;
+	/delete-property/ mmc-hs200-1_8v;
 };
 
 /* errata i880 "Ethernet RGMII2 Limited to 10/100 Mbps" */
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index d6689106d2a8..8d9bdf10a7be 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -25,6 +25,11 @@
 	pinctrl-1 = <&mmc1_pins_hs>;
 
 	vmmc-supply = <&ldo1_reg>;
+	/delete-property/ sd-uhs-sdr104;
+	/delete-property/ sd-uhs-sdr50;
+	/delete-property/ sd-uhs-ddr50;
+	/delete-property/ sd-uhs-sdr25;
+	/delete-property/ sd-uhs-sdr12;
 };
 
 &mmc2 {
@@ -32,6 +37,7 @@
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_3_3v_rev11 &mmc2_iodelay_ddr_3_3v_rev11_conf>;
+	/delete-property/ mmc-hs200-1_8v;
 };
 
 /* errata i880 "Ethernet RGMII2 Limited to 10/100 Mbps" */
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 47b5b384809f..bf5bf8f52c79 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -413,6 +413,7 @@
 	bus-width = <8>;
 	ti,non-removable;
 	max-frequency = <96000000>;
+	/delete-property/ mmc-hs200-1_8v;
 };
 
 &dcan1 {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 52ce3fab483f..22b0ade96237 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1046,6 +1046,11 @@
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
 			max-frequency = <192000000>;
+			sd-uhs-sdr104;
+			sd-uhs-sdr50;
+			sd-uhs-ddr50;
+			sd-uhs-sdr25;
+			sd-uhs-sdr12;
 		};
 
 		mmc2: mmc@480b4000 {
@@ -1058,6 +1063,10 @@
 			dma-names = "tx", "rx";
 			status = "disabled";
 			max-frequency = <192000000>;
+			sd-uhs-sdr25;
+			sd-uhs-sdr12;
+			mmc-hs200-1_8v;
+			mmc-ddr-1_8v;
 		};
 
 		mmc3: mmc@480ad000 {
@@ -1071,6 +1080,9 @@
 			status = "disabled";
 			/* Errata i887 limits max-frequency of MMC3 to 64 MHz */
 			max-frequency = <64000000>;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
 		};
 
 		mmc4: mmc@480d1000 {
@@ -1083,6 +1095,8 @@
 			dma-names = "tx", "rx";
 			status = "disabled";
 			max-frequency = <192000000>;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
 		};
 
 		mmu0_dsp1: mmu@40d01000 {
-- 
2.11.0
