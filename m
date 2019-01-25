From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] MIPS: DTS: jz4740: Add node for the MMC driver
Date: Fri, 25 Jan 2019 17:09:26 -0300
Message-ID: <20190125200927.21045-2-paul@crapouillou.net>
References: <20190125200927.21045-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125200927.21045-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

Add a devicetree node for the jz4740-mmc driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 6fb16fd24035..35c48e1e853f 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -132,6 +132,24 @@
 		};
 	};
 
+	mmc: mmc@10021000 {
+		compatible = "ingenic,jz4740-mmc";
+		reg = <0x10021000 0x1000>;
+
+		clocks = <&cgu JZ4740_CLK_MMC>;
+		clock-names = "mmc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <14>;
+
+		dmas = <&dmac 27 0xffffffff>, <&dmac 26 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4740-uart";
 		reg = <0x10030000 0x100>;
@@ -164,9 +182,6 @@
 		interrupts = <29>;
 
 		clocks = <&cgu JZ4740_CLK_DMA>;
-
-		/* Disable dmac until we have something that uses it */
-		status = "disabled";
 	};
 
 	uhc: uhc@13030000 {
-- 
2.11.0
