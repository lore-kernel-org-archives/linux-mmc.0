From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] ARM: dts: r8a7793: Add MMCIF0
Date: Thu, 21 Apr 2016 13:27:28 +1000
Message-ID: <20160421032728.GD11116@verge.net.au>
References: <1460995360-11417-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44137 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbcDUD1b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 23:27:31 -0400
Content-Disposition: inline
In-Reply-To: <1460995360-11417-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com

On Mon, Apr 18, 2016 at 06:02:40PM +0200, Ulrich Hecht wrote:
> Same as on r8a7794.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
> This revision adds the missing dma-names and power-domains entires spotted
> by Sergei and Simon.

Thanks, we are back to one using one dma controller for now so I adjusted
your patch and queued up the following:

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 18 Apr 2016 18:02:40 +0200
Subject: [PATCH] ARM: dts: r8a7793: Add MMCIF0

Same as on r8a7794.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index bddc31283bd9..fc552629ed4a 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -507,6 +507,18 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	mmcif0: mmcif@ee200000 {
+		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	scifa0: serial@e6c40000 {
 		compatible = "renesas,scifa-r8a7793",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.7.0.rc3.207.g0ac5344

