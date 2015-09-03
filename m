From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 6/6] ARM: dts: omap5: use "ti,pbias-omap5" compatible string for pbias
Date: Thu, 3 Sep 2015 12:20:42 +0530
Message-ID: <1441263042-12942-7-git-send-email-kishon@ti.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441263042-12942-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, linux@arm.linux.org.uk, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use "ti,pbias-omap5" compatible string which is specifically added
for OMAP5.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b1a1263..76ef595 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -187,7 +187,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap5", "ti,pbias-omap";
 						reg = <0x60 0x4>;
 						syscon = <&omap5_padconf_global>;
 						pbias_mmc_reg: pbias_mmc_omap5 {
-- 
1.7.9.5
