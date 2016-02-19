From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 6/7] ARM: shmobile: r8a7790: Set maximum frequencies for SDHI clocks
Date: Fri, 19 Feb 2016 21:16:42 +0100
Message-ID: <1455913003-6140-7-git-send-email-wsa@the-dreams.de>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40806 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992639AbcBSURU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Feb 2016 15:17:20 -0500
In-Reply-To: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Taken from the datasheet.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c9583fa6cae713..16cee3f02efb94 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -545,6 +545,7 @@
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		max-frequency = <156000000>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -556,6 +557,7 @@
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		max-frequency = <156000000>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -567,6 +569,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		max-frequency = <97500000>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -578,6 +581,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		max-frequency = <97500000>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
-- 
2.7.0

