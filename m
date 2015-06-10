From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 6/6] mmc: sdhci-esdhc-imx: add compatible string in binding doc
Date: Wed, 10 Jun 2015 16:50:44 +0800
Message-ID: <1433926244-29244-7-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0109.outbound.protection.outlook.com ([157.56.110.109]:43904
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753445AbbFJIsg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Jun 2015 04:48:36 -0400
In-Reply-To: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, aisheng.dong@freescale.com, haibo.chen@freescale.com, linux-arm-kernel@lists.infradead.org

Add a compatible string in binding doc to avoid checkpatch
warning.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 5d0376b..1c522ac 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -15,6 +15,7 @@ Required properties:
 	       "fsl,imx6q-usdhc"
 	       "fsl,imx6sl-usdhc"
 	       "fsl,imx6sx-usdhc"
+	       "fsl,imx7d-usdhc"
 
 Optional properties:
 - fsl,cd-controller : Indicate to use controller internal card detection
-- 
1.9.1

