From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 03/15] ARM: dts: dra72x-mmc-iodelay: Add a new pinctrl group for clk line without pullup
Date: Wed, 25 Apr 2018 18:24:37 +0530
Message-ID: <20180425125449.19755-4-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425125449.19755-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

During a short period when the bus voltage is switched from 3.3v to 1.8v,
(to enumerate UHS mode), the mmc module is disabled and the mmc IO lines
are kept in a state according to the programmed pad mux pull type.

According to 4.2.4.2 Timing to Switch Signal Voltage in "SD Specifications
Part 1 Physical Layer Specification Version 5.00 February 22, 2016", the
host should hold CLK low for at least 5ms.

In order to keep the card line low during voltage switch, the pad mux of
mmc1_clk line should be configured to pull down.

Add a new pinctrl group for clock line without pullup to be used in boards
where mmc1_clk line is not connected to an external pullup.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi b/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
index 088013c6dc6e..c9351eaf97f0 100644
--- a/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
+++ b/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
@@ -51,6 +51,17 @@
 		>;
 	};
 
+	mmc1_pins_default_no_clk_pu: mmc1_pins_default_no_clk_pu {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+		>;
+	};
+
 	mmc1_pins_sdr12: mmc1_pins_sdr12 {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
-- 
2.17.0
