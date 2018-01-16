From: <patrice.chotard@st.com>
Subject: [PATCH v2 08/15] ARM: dts: stm32: Add pin map for SDIO controller on stm32f4
Date: Tue, 16 Jan 2018 13:30:52 +0100
Message-ID: <1516105859-3525-9-git-send-email-patrice.chotard@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Andrea Merello <andrea.merello@gmail.com>

This patch adds the pin configuration for SDIO controller on
stm32f4.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2 _ none

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index ae94d86..3520289 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -338,6 +338,37 @@
 					slew-rate = <3>;
 				};
 			};
+
+			sdio_pins: sdio_pins@0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDIO_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDIO_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>, /* SDIO_CK */
+						 <STM32_PINMUX('D', 2, AF12)>; /* SDIO_CMD */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_od: sdio_pins_od@0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDIO_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDIO_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>; /* SDIO_CK */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDIO_CMD */
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
 		};
 	};
 };
-- 
1.9.1
