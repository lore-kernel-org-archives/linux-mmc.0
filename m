From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] ARM: shmobile: r8a7790 dtsi: Remove unnecessary MMC options
Date: Wed, 29 Oct 2014 15:09:39 +0100
Message-ID: <1414591779-22954-4-git-send-email-geert+renesas@glider.be>
References: <1414591779-22954-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1414591779-22954-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As of commit 423f6c2e977de73b ("mmc: sdhi: update sh_mobile_sdhi_of_data
for r8a7790"), the driver takes care of r8a7790 specific MMC options.
Hence they can be removed from the dtsi.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[geert: Rebased, reworded, added reference]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0f18db0319af9e56..34f22587555a95ae 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -426,7 +426,6 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
 		dma-names = "tx", "rx";
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -437,7 +436,6 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		dmas = <&dmac0 0xc9>, <&dmac0 0xca>;
 		dma-names = "tx", "rx";
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -448,7 +446,6 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
 		dma-names = "tx", "rx";
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -459,7 +456,6 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
 		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
 		dma-names = "tx", "rx";
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
-- 
1.9.1

