From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v6 3/6] mmc: sdhci-esdhc-imx: add imx7d support in bingding doc
Date: Tue, 11 Aug 2015 19:38:28 +0800
Message-ID: <1439293111-21077-4-git-send-email-haibo.chen@freescale.com>
References: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0127.outbound.protection.outlook.com ([65.55.169.127]:39936
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933911AbbHKLgb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Aug 2015 07:36:31 -0400
In-Reply-To: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: johan.derycke@barco.com, mkl@pengutronix.de, haibo.chen@freescale.com, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Add a required property "fsl,imx7d-usdhc" in binding doc.
Add an optional property "fsl,tuning-step" in binding doc.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 211e778..dca56d6 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -15,6 +15,7 @@ Required properties:
 	       "fsl,imx6q-usdhc"
 	       "fsl,imx6sl-usdhc"
 	       "fsl,imx6sx-usdhc"
+	       "fsl,imx7d-usdhc"
 
 Optional properties:
 - fsl,wp-controller : Indicate to use controller internal write protection
@@ -27,6 +28,11 @@ Optional properties:
   transparent level shifters on the outputs of the controller. Two cells are
   required, first cell specifies minimum slot voltage (mV), second cell
   specifies maximum slot voltage (mV). Several ranges could be specified.
+- fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
+  The uSDHC use one delay cell as default increasing step to do tuning process.
+  This property allows user to change the tuning step to more than one delay
+  cells which is useful for some special boards or cards when the default
+  tuning step can't find the proper delay window within limited tuning retries.
 
 Examples:
 
-- 
1.9.1

