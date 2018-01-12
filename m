From: <patrice.chotard@st.com>
Subject: [PATCH 06/14] ARM: dts: stm32: Add SDIO controller for stm32f429
Date: Fri, 12 Jan 2018 13:16:00 +0100
Message-ID: <1515759368-16946-7-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, Andrea Merello <andrea.merello@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

stm32f429 embeds ARM_PL180 sdi IP, adds SDIO controller
node to allow MMC support.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 10099df..ede77e0 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -511,6 +511,17 @@
 			};
 		};
 
+		sdio: sdio@40012c00 {
+			compatible = "arm,pl180", "arm,primecell";
+			arm,primecell-periphid = <0x00880180>;
+			reg = <0x40012c00 0x400>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SDIO)>;
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
