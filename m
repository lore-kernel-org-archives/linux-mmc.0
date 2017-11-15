From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 2/4] arm64: dts: r8a77995: Add SDHI (MMC) support
Date: Wed, 15 Nov 2017 16:25:47 +0100
Message-ID: <1510759549-30404-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-mmc@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

R-Car D3 has only one SDHI controller.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index b3113003..89cb32e 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -504,6 +504,18 @@
 			status = "disabled";
 		};
 
+		sdhi2: sd@ee140000 {
+			compatible = "renesas,sdhi-r8a77995",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			status = "disabled";
+		};
+
 		ehci0: usb@ee080100 {
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
-- 
2.7.4
