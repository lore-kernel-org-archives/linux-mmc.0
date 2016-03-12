From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 09/10] ARM: shmobile: r8a7790: Set maximum frequencies for SDHI clocks
Date: Sat, 12 Mar 2016 10:15:11 +0100
Message-ID: <1457774112-16958-10-git-send-email-wsa@the-dreams.de>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48810 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbcCLJPg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 Mar 2016 04:15:36 -0500
In-Reply-To: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Taken from the datasheet.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 6d435e10a4de0c..318ba8129c3463 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -597,6 +597,7 @@
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		max-frequency = <156000000>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -608,6 +609,7 @@
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		max-frequency = <156000000>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -619,6 +621,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		max-frequency = <97500000>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -630,6 +633,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		max-frequency = <97500000>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
-- 
2.7.0

