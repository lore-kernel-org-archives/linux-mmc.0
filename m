From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v5, 1/5] ARM64: dts: ls2080a: add device configuration node
Date: Fri, 4 Mar 2016 17:38:37 +0800
Message-ID: <1457084321-10003-2-git-send-email-yangbo.lu@nxp.com>
References: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0060.outbound.protection.outlook.com ([157.56.110.60]:20384
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756532AbcCDKVK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2016 05:21:10 -0500
In-Reply-To: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, scott.wood@nxp.com, leoyang.li@nxp.com, xiaobo.xie@nxp.com, Rob Herring <robh+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>

Add the dts node for device configuration unit that provides
general purpose configuration and status for the device.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
Changes for v4:
	- None
Changes for v5:
	- Added this patch
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 2b23d03..6ad4710 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -191,6 +191,12 @@
 			clocks = <&sysclk>;
 		};
 
+		dcfg: dcfg@1e00000 {
+			compatible = "fsl,ls2080a-dcfg", "syscon";
+			reg = <0x0 0x1e00000 0x0 0x10000>;
+			little-endian;
+		};
+
 		serial0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-- 
2.1.0.27.g96db324

