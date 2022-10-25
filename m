Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AEBC38A2D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 13:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiJYNaL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiJYNaK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 09:30:10 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398B9DEF29;
        Tue, 25 Oct 2022 06:30:02 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id 7B21E1025EC;
        Tue, 25 Oct 2022 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666704601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0tnr5ZD8EC2va1ebYMWM4ouc4PlgDpshSSnTTqC0Pw=;
        b=qMwAso86Hp7ltBOtgNKFpe/kVMJdUg34CtwFxfD3b+e4f3STZK7P3oc9v9AaTkRQ0HcSe8
        PNGlN1mBQ13PQhsAaH+JwtO+F1kGJMdMqIZE/3otG2dGX1/kvEx5qKHC3IaIlpg4Qlu9yV
        kRaMVhOY8jxUxd/3Z1l/sMrWhwysKmo=
Received: from frank-G5.. (fttx-pool-217.61.152.57.bambit.de [217.61.152.57])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 9B149406DF;
        Tue, 25 Oct 2022 13:30:00 +0000 (UTC)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: [PATCH v5 3/6] arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
Date:   Tue, 25 Oct 2022 15:29:50 +0200
Message-Id: <20221025132953.81286-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025132953.81286-1-linux@fw-web.de>
References: <20221025132953.81286-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f049c69f-c4f7-41cc-b7ee-c69fafc39865
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

