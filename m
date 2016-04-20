From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new clocking model
Date: Wed, 20 Apr 2016 18:20:43 +0800
Message-ID: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0089.outbound.protection.outlook.com ([207.46.100.89]:51264
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753896AbcDTKaI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 06:30:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, scott.wood@nxp.com, Rob Herring <robh+dt@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>

Provide clocks property instead of clock-frequency for QorIQ eSDHC
dts node to adapt to the new clocking model, so that the driver
could get clock value by the common clk API and the u-boot could
remove the clock fixup.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
index 20835ae..ddbe562 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
@@ -36,5 +36,5 @@ sdhc: sdhc@114000 {
 	compatible = "fsl,esdhc";
 	reg = <0x114000 0x1000>;
 	interrupts = <48 2 0 0>;
-	clock-frequency = <0>;
+	clocks = <&clockgen 4 1>;
 };
-- 
2.1.0.27.g96db324

