From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Thu, 21 Apr 2016 13:27:33 +1000
Message-ID: <20160421032733.GE11116@verge.net.au>
References: <1460995377-11478-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1460995377-11478-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44152 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbcDUD1g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 23:27:36 -0400
Content-Disposition: inline
In-Reply-To: <1460995377-11478-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com

On Mon, Apr 18, 2016 at 06:02:56PM +0200, Ulrich Hecht wrote:
> Same as on r8a7791.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7793.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Thanks.

We are back to one DMA controller this week so I updated your patch and
queued up the following.

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 18 Apr 2016 18:02:56 +0200
Subject: [PATCH] ARM: dts: r8a7793: Add SDHI controllers

Same as on r8a7791.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index fc552629ed4a..a93d509732a8 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -507,6 +507,39 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	sdhi0: sd@ee100000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee100000 0 0x328>;
+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	sdhi1: sd@ee140000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee140000 0 0x100>;
+		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI1>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	sdhi2: sd@ee160000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee160000 0 0x100>;
+		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI2>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
+		dma-names = "tx", "rx", "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	mmcif0: mmcif@ee200000 {
 		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
2.7.0.rc3.207.g0ac5344

