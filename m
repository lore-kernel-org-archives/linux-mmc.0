From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v1 3/5] ARM: imx28evk: add mmc dt support
Date: Tue, 13 Mar 2012 16:47:06 +0800
Message-ID: <1331628428-24017-4-git-send-email-b29396@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331628428-24017-1-git-send-email-b29396@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, rdunlap@xenotime.net, vinod.koul@linux.intel.com
List-Id: linux-mmc@vger.kernel.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   14 ++++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/imx28-dt.c    |    2 ++
 3 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 9758dc4..61350ab 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -21,6 +21,20 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
+        apb@80000000 {
+                apbh@80000000 {
+			mmc1: ssp@80010000 {
+				slot-8bit;
+				status = "okay";
+			};
+
+			mmc2: ssp@80012000 {
+				slot-8bit;
+				status = "okay";
+			};
+		};
+	};
+
 	ahb@80080000 {
 		fec@800f0000 {
 			phy-mode = "rmii";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index acf0dab..71c7bfb 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -46,6 +46,39 @@
 				#interrupt-cells = <1>;
 				reg = <0x80000000 0x2000>;
 			};
+
+			ssp@80010000 {
+				compatible = "fsl,imx28-mmc";
+				reg = <0x80010000 2000>;
+				/* <irq_err irq_dma> */
+				interrupts = <96 82>;
+				dma_channel = <0>;
+				status = "disabled";
+			};
+
+			ssp@80012000 {
+				compatible = "fsl,imx28-mmc";
+				reg = <0x80012000 2000>;
+				interrupts = <97 83>;
+				dma_channel = <1>;
+				status = "disabled";
+			};
+
+			ssp@80014000 {
+				compatible = "fsl,imx28-mmc";
+				reg = <0x80014000 2000>;
+				interrupts = <98 84>;
+				dma_channel = <2>;
+				status = "disabled";
+			};
+
+			ssp@80016000 {
+				compatible = "fsl,imx28-mmc";
+				reg = <0x80016000 2000>;
+				interrupts = <99 85>;
+				dma_channel = <3>;
+				status = "disabled";
+			};
 		};
 
 		apbx@80040000 {
diff --git a/arch/arm/mach-mxs/imx28-dt.c b/arch/arm/mach-mxs/imx28-dt.c
index 78d1129..429b88e 100644
--- a/arch/arm/mach-mxs/imx28-dt.c
+++ b/arch/arm/mach-mxs/imx28-dt.c
@@ -23,6 +23,8 @@ static const struct of_dev_auxdata imx28_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl011", MX28_DUART_BASE_ADDR, "duart", NULL),
 	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC0_BASE_ADDR, "imx28-fec.0", NULL),
 	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC1_BASE_ADDR, "imx28-fec.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP0_BASE_ADDR, "mxs-mmc.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP1_BASE_ADDR, "mxs-mmc.1", NULL),
 	{ /* sentinel */ }
 };
 
-- 
1.7.0.4
