From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v5 4/6] ARM: dts: imx7d-sdb: add eMMC5.0 support
Date: Mon, 10 Aug 2015 16:18:06 +0800
Message-ID: <1439194688-18335-5-git-send-email-haibo.chen@freescale.com>
References: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0136.outbound.protection.outlook.com ([65.55.169.136]:38720
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753382AbbHJIQS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Aug 2015 04:16:18 -0400
In-Reply-To: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: johan.derycke@barco.com, mkl@pengutronix.de, haibo.chen@freescale.com, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

imx7d-sdb board has a eMMC5.0 on usdhc3. This eMMC support HS400.
This patch add usdhc3 support for HS400

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index fdd1d7c..8059458 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -241,6 +241,19 @@
 	status = "okay";
 };
 
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	fsl,tuning-step = <2>;
+	non-removable;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
1.9.1

