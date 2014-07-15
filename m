From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 07/11] ARM: shmobile: r8a7791: Add MMCIF0 DT node
Date: Wed, 16 Jul 2014 00:45:17 +0200
Message-ID: <1405464321-4723-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Add the MMCIF0 device to the r8a7791 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index c23e72f..6738bc9 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -365,6 +365,15 @@
 		#gpio-range-cells = <3>;
 	};
 
+	mmcif0: mmc@ee200000 {
+		compatible = "renesas,mmcif-r8a7791", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	sdhi0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee100000 0 0x200>;
-- 
1.8.5.5

