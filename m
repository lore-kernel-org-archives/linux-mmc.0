From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v5 10/13] arm64: allwinner: a64: Increase the MMC max frequency
Date: Fri, 27 Jan 2017 22:38:42 +0100
Message-ID: <289ef7f8a83d156bb2aa74bede398ad0035a2429.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The eMMC controller seem to have a maximum frequency of 200MHz, while the
regular MMC controllers are capped at 150MHz.

Since older SoCs cannot go that high, we cannot change the default maximum
frequency, but fortunately for us we have a property for that in the DT.

This also has the side effect of allowing to use the MMC HS200 and SD
SDR104 modes for the boards that support it (with either 1.2v or 1.8v IOs).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
 1 file changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index acc7071a7540..9ae4f589fb1c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -129,6 +129,7 @@
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -142,6 +143,7 @@
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -155,6 +157,7 @@
 			resets = <&ccu RST_BUS_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
git-series 0.8.11
