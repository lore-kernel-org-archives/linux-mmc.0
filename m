From: Tim Kryger <tim.kryger@linaro.org>
Subject: [PATCH v4 4/8] ARM: dts: Specify clocks for SDHCIs on bcm11351
Date: Thu, 5 Dec 2013 11:20:40 -0800
Message-ID: <1386271244-3927-5-git-send-email-tim.kryger@linaro.org>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Axel Lin <axel.lin@ingics.com>
Cc: Device Tree List <devicetree@vger.kernel.org>, Linaro Patches List <patches@linaro.org>, Tim Kryger <tim.kryger@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Specify the external clock label in each SDHCI node.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 9b99c52..25ca128 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -118,6 +118,7 @@
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sdio1_clk>;
 		status = "disabled";
 	};
 
@@ -125,6 +126,7 @@
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sdio2_clk>;
 		status = "disabled";
 	};
 
@@ -132,6 +134,7 @@
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sdio3_clk>;
 		status = "disabled";
 	};
 
@@ -139,6 +142,7 @@
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
 		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sdio4_clk>;
 		status = "disabled";
 	};
 
-- 
1.8.0.1
