From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 11/11] ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
Date: Wed, 16 Jul 2014 00:45:21 +0200
Message-ID: <1405464321-4723-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Add references to the transmit and receive DMA channels in the three
SDHI nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ff0d415..88be0cc 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -381,6 +381,8 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -389,6 +391,8 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -397,6 +401,8 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.8.5.5

