Return-Path: <SRS0=AKDL=CB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B5C433E1
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6A32072D
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199534;
	bh=p7s6/RTngu5wO+BXh/RckmKOH+s+BJOz4PP9eHTqfjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXLiRODRRrliHfffiZSBk/IPwOjGxHd/x3xRS0NTnOJ00rR8a91tsMtuh1arLE54G
	 b4sMfr3612Ifb6jkw8wiW1CMlOg5fyGP5bDwOUOF/exVtdLDTJCMFlMTcyGoNZ+HB0
	 S2iQ994XPt8GEHXqRmVFf+riSozRpNNNvljJVQ04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHWQSg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgHWQRg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:36 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56912072D;
        Sun, 23 Aug 2020 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199456;
        bh=p7s6/RTngu5wO+BXh/RckmKOH+s+BJOz4PP9eHTqfjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGNoYo8F+u5NxDsg/u+guoF6LVbrYlOdkltihyzc6zveKIDkwzfULbcZHjwfVJg0C
         Xmk2S2MUUOG7JdQ1C+N6UxwYOvGhgFHd5Az7ofdPWAYCF1FCRSLlVBGEcREVJq3DLY
         fI1g8/7lamehuBVzD/kMOxUBfZiw4aLmNN4xXulk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from USDHC
Date:   Sun, 23 Aug 2020 18:15:49 +0200
Message-Id: <20200823161550.3981-21-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The USDHC on i.MX 8QXP has its own compatible described in bindings
and used in the driver (with its own quirks).  Remove additional
fsl,imx7d-usdhc compatible to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: mmc@5b010000:
    compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long
    From schema: /ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

  arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: mmc@5b010000:
    compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 61bccb69f09e..26c4fcdfe290 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -362,7 +362,7 @@
 		};
 
 		usdhc1: mmc@5b010000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+			compatible = "fsl,imx8qxp-usdhc";
 			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b010000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
@@ -374,7 +374,7 @@
 		};
 
 		usdhc2: mmc@5b020000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+			compatible = "fsl,imx8qxp-usdhc";
 			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b020000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>,
@@ -388,7 +388,7 @@
 		};
 
 		usdhc3: mmc@5b030000 {
-			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+			compatible = "fsl,imx8qxp-usdhc";
 			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x5b030000 0x10000>;
 			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
-- 
2.17.1

