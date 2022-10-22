Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF9C04A95
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Oct 2022 09:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJVJ4C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Oct 2022 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJVJzm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2022 05:55:42 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D045301011;
        Sat, 22 Oct 2022 02:09:00 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id D415F60406;
        Sat, 22 Oct 2022 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666429540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0tnr5ZD8EC2va1ebYMWM4ouc4PlgDpshSSnTTqC0Pw=;
        b=f+HX7AxOXEhU94NT54g1eTsKTgL8+mTIqD19sYWf20al3RSAFUn21Mx2RcajqwH32XrP6b
        5YqPpo+x07Bh84CtjH5ZXFDqvKjPEY+heOBWqDbcLDOAD2oYvv48NfQaZdKMTg6KAsjxoH
        54eUbHWjL/shbQElje5vXKU3W/VAtck=
Received: from frank-G5.. (fttx-pool-80.245.73.148.bambit.de [80.245.73.148])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 1964C405AF;
        Sat, 22 Oct 2022 09:05:39 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
Date:   Sat, 22 Oct 2022 11:05:29 +0200
Message-Id: <20221022090530.16265-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022090530.16265-1-linux@fw-web.de>
References: <20221022090530.16265-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: da3b6cee-fbd9-477b-9dcb-927f929ae418
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

First 3 clocks for mt2712 need to be "source", "hclk", "source_cg"
so swap last 2 of mmc0 to match the binding.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index e6d7453e56e0..9dc0794fcd2e 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -766,9 +766,9 @@ mmc0: mmc@11230000 {
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_MSDC30_0>,
 			 <&pericfg CLK_PERI_MSDC50_0_HCLK_EN>,
-			 <&pericfg CLK_PERI_MSDC30_0_QTR_EN>,
-			 <&pericfg CLK_PERI_MSDC50_0_EN>;
-		clock-names = "source", "hclk", "bus_clk", "source_cg";
+			 <&pericfg CLK_PERI_MSDC50_0_EN>,
+			 <&pericfg CLK_PERI_MSDC30_0_QTR_EN>;
+		clock-names = "source", "hclk", "source_cg", "bus_clk";
 		status = "disabled";
 	};
 
-- 
2.34.1

