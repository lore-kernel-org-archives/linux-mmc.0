Return-Path: <SRS0=AKDL=CB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED6C433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB692072D
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199463;
	bh=sQld/rHqgvWMEGDYoBvDchJJetnYPftabvD886fB5Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tEORQEHNVA2nsobMcjg0a/ynK+Uev536bvGO2X7pZu2MVxkuYEVJacWpzzEgX/w8f
	 tu1Q1TkT23VmC3awqE7YCfjx93+WVm9SlRBFcIe9vJt7SNbrRHKc1/HbL0oPB9Ks7+
	 78opBtY3ZWoU2XHkedam8kOeUHGqXA5SQXJlMFTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHWQRm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgHWQR0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:26 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269932076D;
        Sun, 23 Aug 2020 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199446;
        bh=sQld/rHqgvWMEGDYoBvDchJJetnYPftabvD886fB5Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wY4K7oe3cC/0huZbBIyhotqb9FgN9nL+Ghie/J1XqWk+hu2foVGRXX+rYUew4b1Yj
         u/V+EQTvWwGmcTMA0z1atfQpJxu/IQnq4wjxMXJ8cvQEacwG1elHKuyhCsGXml9BTT
         IccFjTRwut+1LETjAo0m2lfT0M7yQzZVpgEo+OOQ=
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
Subject: [PATCH 19/22] arm64: dts: imx8mm: Remove i.MX7 compatible from USDHC
Date:   Sun, 23 Aug 2020 18:15:47 +0200
Message-Id: <20200823161550.3981-19-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The USDHC on i.MX 8M Mini has its own compatible described in bindings
and used in the driver (with its own quirks).  Remove additional
fsl,imx7d-usdhc compatible to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: mmc@30b40000: compatible: ['fsl,imx8mm-usdhc', 'fsl,imx7d-usdhc'] is too long
    From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: mmc@30b40000: compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 76f040e4be5e..38bf41184489 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -784,7 +784,7 @@
 			};
 
 			usdhc1: mmc@30b40000 {
-				compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mm-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_IPG_ROOT>,
@@ -798,7 +798,7 @@
 			};
 
 			usdhc2: mmc@30b50000 {
-				compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mm-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_IPG_ROOT>,
@@ -812,7 +812,7 @@
 			};
 
 			usdhc3: mmc@30b60000 {
-				compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mm-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_IPG_ROOT>,
-- 
2.17.1

