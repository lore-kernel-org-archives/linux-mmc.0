From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/6] ARM: dts: dra7: use "ti,pbias-dra7" compatible string for pbias
Date: Wed, 2 Sep 2015 16:17:29 +0530
Message-ID: <1441190853-7133-3-git-send-email-kishon@ti.com>
References: <1441190853-7133-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441190853-7133-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, linux@arm.linux.org.uk, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use "ti,pbias-dra7" compatible string which is specifically added
for DRA7 SoCs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1e29ccf..d6bc6db 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -122,7 +122,7 @@
 					#size-cells = <1>;
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-dra7", "ti,pbias-omap";
 						reg = <0xe00 0x4>;
 						syscon = <&scm_conf>;
 						pbias_mmc_reg: pbias_mmc_omap5 {
-- 
1.7.9.5
