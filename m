Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9ECCA47E
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Jun 2022 12:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiFZMDt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Jun 2022 08:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiFZMDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Jun 2022 08:03:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFBDFD01
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c65so9428614edf.4
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vd+zawx4alYNKXvrzvWX3T7QNroTB1jkcMWzPCe+yb8=;
        b=f1Ei/ZROxc6rwWsOopyw759wUyGIExHza0zyyIstNK3LWT0uUsoD3IP7D3hyou15RI
         Tbo005PH5a7UUaGSvGFwndErKTZS3KrADbSt33luz+66ueBzCMzp0Fn5WWuNOFsHob9b
         AVjzABQZZvWRdkXtBg7xkMMKTiR1rTo0R67J4iHOpCcb3FG3vz6Jqnw5urg9Bw7XeiK+
         Xig/P5hBcdqK/6Rb0PL9G+pLKCmpY0NQRXTEWEOTgGXdWCmIUHcyYG8n5T8nbrNmdEP+
         tvf/TaTPk2bI4suQE1eujy7I1I31JUAvgEsh2JEL8H0O9vnnV47rgA6+pPkWB/ygmDcC
         nbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vd+zawx4alYNKXvrzvWX3T7QNroTB1jkcMWzPCe+yb8=;
        b=dlBNb0hbqFhjNOFYKT9BpiJh+EvcjYjCIt31HOAkUYZXqpf/L5UEdKHknZhlZ9g3aO
         062q7BrKLtLdbXYMWPX2vx/tciNdkmny5qkJduvZ7jyX/JLt1DHqvJ7PyMMUYxy4yjD2
         Bht1rfpeHwp8eZRcW93jib/kcSSes0rGPZCF3IktNlcunBdVsYR2Ayk386opr+tV354s
         WK/QV8ke+/gY/JVt5fgyqeQQJZlpAkXU/wJc7zYMLq4oBL+wqAA7QIW4dpxOASoPiw0x
         V1b+ZBv6vvClDtVIHzwy1MIq566hbmXWTqLce0zyWHNomIVyX1gH5Zjrp0hwklySuOQF
         IUcA==
X-Gm-Message-State: AJIora9IReR7T/74GnGzt9AD0/z7eMxq9pEGXVVt7eG52qTPJzme1nX1
        kOn/ad2ip9/uq+QXi3y4gnSCsg==
X-Google-Smtp-Source: AGRyM1t4ltiV03YyTrXt5bzoh7znOQMJ/6bYzfVH/7bO6TQ7puLdKXmFxhzUtxTqwrwTKoMlpB3bfQ==
X-Received: by 2002:a05:6402:5207:b0:435:a27b:88f7 with SMTP id s7-20020a056402520700b00435a27b88f7mr10765188edd.22.1656245026331;
        Sun, 26 Jun 2022 05:03:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm3751585ejz.120.2022.06.26.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 05:03:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] ARM: dts: exynos: align SDHCI node name with dtschema
Date:   Sun, 26 Jun 2022 14:03:38 +0200
Message-Id: <20220626120342.38851-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The node names should be generic and DT schema expects "mmc".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 6f0ca3354e39..5c4ecda27a47 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -316,7 +316,7 @@ keypad: keypad@100a0000 {
 			status = "disabled";
 		};
 
-		sdhci_0: sdhci@12510000 {
+		sdhci_0: mmc@12510000 {
 			compatible = "samsung,exynos4210-sdhci";
 			reg = <0x12510000 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -325,7 +325,7 @@ sdhci_0: sdhci@12510000 {
 			status = "disabled";
 		};
 
-		sdhci_1: sdhci@12520000 {
+		sdhci_1: mmc@12520000 {
 			compatible = "samsung,exynos4210-sdhci";
 			reg = <0x12520000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -334,7 +334,7 @@ sdhci_1: sdhci@12520000 {
 			status = "disabled";
 		};
 
-		sdhci_2: sdhci@12530000 {
+		sdhci_2: mmc@12530000 {
 			compatible = "samsung,exynos4210-sdhci";
 			reg = <0x12530000 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -343,7 +343,7 @@ sdhci_2: sdhci@12530000 {
 			status = "disabled";
 		};
 
-		sdhci_3: sdhci@12540000 {
+		sdhci_3: mmc@12540000 {
 			compatible = "samsung,exynos4210-sdhci";
 			reg = <0x12540000 0x100>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

