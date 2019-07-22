From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 01/18] ARM: bcm283x: Reduce register ranges for UART,
 SPI and I2C
Date: Mon, 22 Jul 2019 07:54:32 +0200
Message-ID: <1563774880-8061-2-git-send-email-wahrenst@gmx.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-mmc@vger.kernel.org

The assigned register ranges for UART, SPI and I2C were too wasteful.
In order to avoid overlapping with the new functions on BCM2711
reduce the ranges.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 4b21ddb..2d191fc 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -397,7 +397,7 @@

 		uart0: serial@7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
-			reg = <0x7e201000 0x1000>;
+			reg = <0x7e201000 0x200>;
 			interrupts = <2 25>;
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
@@ -428,7 +428,7 @@

 		spi: spi@7e204000 {
 			compatible = "brcm,bcm2835-spi";
-			reg = <0x7e204000 0x1000>;
+			reg = <0x7e204000 0x200>;
 			interrupts = <2 22>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
 			dmas = <&dma 6>, <&dma 7>;
@@ -440,7 +440,7 @@

 		i2c0: i2c@7e205000 {
 			compatible = "brcm,bcm2835-i2c";
-			reg = <0x7e205000 0x1000>;
+			reg = <0x7e205000 0x200>;
 			interrupts = <2 21>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
 			#address-cells = <1>;
--
2.7.4
