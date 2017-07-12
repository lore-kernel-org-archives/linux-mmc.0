From: Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 2/3] ARM: dts: r8a7743: Add MMCIF0 support
Date: Wed, 12 Jul 2017 11:03:24 +0100
Message-ID: <1499853805-5915-3-git-send-email-chris.paterson2@renesas.com>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Biju Das <biju.das@bp.renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Paterson <chris.paterson2@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Add the MMCIF0 device to the r8a7743 device tree.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0d02191..f62e858 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -641,6 +641,22 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		mmcif0: mmc@ee200000 {
+			compatible = "renesas,mmcif-r8a7743",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 315>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 315>;
+			reg-io-width = <4>;
+			max-frequency = <97500000>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
-- 
1.9.1
