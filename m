From: <patrice.chotard@st.com>
Subject: [PATCH v3 06/14] ARM: dts: stm32: Add SDIO controller for stm32f746
Date: Thu, 18 Jan 2018 15:34:22 +0100
Message-ID: <1516286070-24927-7-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

stm32f746 embeds ARM_PL180 sdio IP, adds SDIO controller
nodes to allow MMC support.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ none

 arch/arm/boot/dts/stm32f746.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 5f66d15..7f55d00 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -429,6 +429,28 @@
 			status = "disabled";
 		};
 
+		sdio2: sdio2@40011c00 {
+			compatible = "arm,pl180", "arm,primecell";
+			arm,primecell-periphid = <0x00880180>;
+			reg = <0x40011c00 0x400>;
+			clocks = <&rcc 0 167>;
+			clock-names = "apb_pclk";
+			interrupts = <103>;
+			max-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		sdio1: sdio1@40012c00 {
+			compatible = "arm,pl180", "arm,primecell";
+			arm,primecell-periphid = <0x00880180>;
+			reg = <0x40012c00 0x400>;
+			clocks = <&rcc 0 171>;
+			clock-names = "apb_pclk";
+			interrupts = <49>;
+			max-frequency = <48000000>;
+			status = "disabled";
+		};
+
 		syscfg: system-config@40013800 {
 			compatible = "syscon";
 			reg = <0x40013800 0x400>;
-- 
1.9.1

