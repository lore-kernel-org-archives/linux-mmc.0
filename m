From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] Powerpc/t4240: change the compatible flags for t4240qds board
Date: Mon, 8 Jul 2013 15:16:03 +0800
Message-ID: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:27493
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab3GHIFx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 04:05:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>

In order to make a difference between different T4240 board.
Specify T4240QDS board the unique compatible flags for t4240qds
eSDHC host.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index bd611a9..08b47d0 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -397,7 +397,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
-		compatible = "fsl,t4240-esdhc", "fsl,esdhc";
+		compatible = "fsl,t4240qds-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
 	};
 /include/ "qoriq-i2c-0.dtsi"
-- 
1.8.0


