From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 4/6] mmc: sdhci-esdhc-imx: using specific compatible string in binding doc
Date: Wed, 27 May 2015 18:13:29 +0800
Message-ID: <1432721611-31214-5-git-send-email-aisheng.dong@freescale.com>
References: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0116.outbound.protection.outlook.com ([157.56.111.116]:49824
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751796AbbE0KOp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 May 2015 06:14:45 -0400
In-Reply-To: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, b51421@freescale.com, linux-arm-kernel@lists.infradead.org

From: Dong Aisheng <b29396@freescale.com>

Using specific compatible string in binding doc to make the binding
more clear.
It's also used to avoid checkpatch warning in the future like follows:
WARNING: DT compatible string "fsl,imx6sx-usdhc" appears un-documented --
check ./Documentation/devicetree/bindings/
+       { .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },

total: 0 errors, 1 warnings, 18 lines checked

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 415c557..5d0376b 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -7,7 +7,14 @@ This file documents differences between the core properties described
 by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
 
 Required properties:
-- compatible : Should be "fsl,<chip>-esdhc"
+- compatible : Should be "fsl,<chip>-esdhc", the supported chips include
+	       "fsl,imx25-esdhc"
+	       "fsl,imx35-esdhc"
+	       "fsl,imx51-esdhc"
+	       "fsl,imx53-esdhc"
+	       "fsl,imx6q-usdhc"
+	       "fsl,imx6sl-usdhc"
+	       "fsl,imx6sx-usdhc"
 
 Optional properties:
 - fsl,cd-controller : Indicate to use controller internal card detection
-- 
1.9.1

