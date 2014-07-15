From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 10/11] ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
Date: Wed, 16 Jul 2014 00:45:20 +0200
Message-ID: <1405464321-4723-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Add references to the transmit and receive DMA channels in the four
SDHI nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 465008a..2ea3b2a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -388,6 +388,8 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -397,6 +399,8 @@
 		reg = <0 0xee120000 0 0x200>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		dmas = <&dmac0 0xc9>, <&dmac0 0xca>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -406,6 +410,8 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -415,6 +421,8 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
-- 
1.8.5.5

