From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH v4 7/8] ARM: shmobile: r8a7790: Set maximum frequencies for
 SDHI clocks
Date: Tue, 30 Jun 2015 17:57:16 +0100
Message-ID: <1435683436.23818.69.camel@codethink.co.uk>
References: <1435683177.23818.60.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435683177.23818.60.camel@codethink.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Taken from the datasheet.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4bb2f4c17321..618b38938b24 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -490,6 +490,7 @@
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		max-frequency = <156000000>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -500,6 +501,7 @@
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		max-frequency = <156000000>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -510,6 +512,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		max-frequency = <97500000>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -520,6 +523,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		max-frequency = <97500000>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
 		status = "disabled";
-- 
2.1.4




