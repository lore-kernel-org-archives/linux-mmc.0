From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 4/5] powerpc: dts: t4240: add syscon support for DCFG node
Date: Fri, 27 Nov 2015 11:20:16 +0800
Message-ID: <1448594417-22515-5-git-send-email-yangbo.lu@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0143.outbound.protection.outlook.com ([207.46.100.143]:60156
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753757AbbK0Dm4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 22:42:56 -0500
In-Reply-To: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: scottwood@freescale.com, X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

Add syscon support for DCFG node, so that the driver could use
syscon regmap interface to access the device config module registers.
And the CONFIG_MFD_SYSCON should be enabled for this.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- None
Changes for v3:
	- Added this patch
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 68c4ead..5f148b2 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -941,7 +941,9 @@
 /include/ "qoriq-mpic4.3.dtsi"
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,t4240-device-config", "fsl,qoriq-device-config-2.0";
+		compatible = "fsl,t4240-device-config",
+				"fsl,qoriq-device-config-2.0",
+				"syscon";
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
-- 
2.1.0.27.g96db324

