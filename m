From: <patrice.chotard@st.com>
Subject: [PATCH v3 09/14] ARM: dts: stm32: Enable SDIO controller on stm32f469
 disco board
Date: Thu, 18 Jan 2018 15:34:25 +0100
Message-ID: <1516286070-24927-10-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: devicetree@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Andrea Merello <andrea.merello@gmail.com>

This patch adds SDIO-related DT nodes required by stm32f469 board

There is a hardware issue on these boards, it misses a pullup on
the GPIO line used as card detect to allow correct SD card
detection. To allow correct card detection "broken-cd" property
is used.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ none


 arch/arm/boot/dts/stm32f469-disco.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 318fb12..ebb97c3 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -66,6 +66,13 @@
 		serial0 = &usart3;
 	};
 
+	mmc_vcard: mmc_vcard {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	soc {
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
@@ -120,6 +127,18 @@
 	};
 };
 
+&sdio {
+	status = "okay";
+	vmmc-supply = <&mmc_vcard>;
+	cd-gpios = <&gpiog 2 0>;
+	cd-inverted;
+	broken-cd;
+	pinctrl-names = "default", "opendrain";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_pins_od>;
+	bus-width = <4>;
+};
+
 &usart3 {
 	pinctrl-0 = <&usart3_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
