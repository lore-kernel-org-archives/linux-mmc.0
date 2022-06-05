Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A1DCCA482
	for <linux-mmc@archiver.kernel.org>; Sun,  5 Jun 2022 16:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351256AbiFEQhX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 5 Jun 2022 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351264AbiFEQhV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2022 12:37:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F411581D
        for <linux-mmc@vger.kernel.org>; Sun,  5 Jun 2022 09:37:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y19so24801299ejq.6
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2022 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpJNIbDh5NM9/LA2AXZHwtz/xCPVDe8SAImpETpoj8g=;
        b=N9WRr0SIGIfSFM1PV7FLX2k9vuTtnv+OpLRrnWNIealggkrkAi9bsjCW9CnSPLRObN
         lS7qIMAzFXFReiLBgrT0iRLFdTkfp8z09PaggPksP0+PDv1qtm7BroNK9yvw058yhuN7
         FFIFKXeTiKOfKBvkiHW0xo10xLINSLnjRVgmxFoudAv2z1Wt0mI/57Zrb9D63DuZZ1Zw
         lEokOzlcQ+q53a/CisoDm4pK3KQr3beLJR1/ng1i9irUGuPZKHPF3fF4UFwlRp+Z5cJN
         7jRYUTZ3oycb4eEONRoIG81o3yRkQRbmfB2hOGqgbEEr2+R5IS9hTfvNwhyWlicFEYf1
         nFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpJNIbDh5NM9/LA2AXZHwtz/xCPVDe8SAImpETpoj8g=;
        b=WPE8qhETIXpPLJ7w4Fk6h4/BVWH/IglksaSRLMjC/jg7DzwFd9EmQI+ujNZCQEa7YN
         wjoOXQ5ZDC85ZKOjxb1MLgzIjExy+sOttmemt/QB7IhUN075TduZ9EHHNV98I+nUwk0b
         iqZf9RS5951ZqQF4W/vyIGPKkbym7qSyuScxHgvZxbyL7YVqOp6G79G9j1Z300PFB5BH
         4QLEGNMiWVzvGFRRbZlaVJ4PB8CEo/+1FWcr0zPwFtX3ZA0+S8VVaOTnvof1TP0/VlB1
         I1W9TaIbE9NxoFv3oKk8xjCJ4R53RFnr7uplffJRTdC/No7E+xRfkc0m3rLgcNV9oYOh
         /+GQ==
X-Gm-Message-State: AOAM5315nAofW2XEyrK9r4rWZ6MIj2+IaDKdPKperyVvys+J5g//GCMR
        yBYpuz1zjygHZIhl4P3ckQo5Iw==
X-Google-Smtp-Source: ABdhPJztniir6tQ6LTLX/OoMdaiw1BZXZp8MyvP7iQNKlVUY67EqcXTbg1sqLsQY+A9kaaJfZyfuNg==
X-Received: by 2002:a17:907:7e95:b0:6fe:e27a:357b with SMTP id qb21-20020a1709077e9500b006fee27a357bmr17626740ejc.404.1654447037621;
        Sun, 05 Jun 2022 09:37:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709064a0300b006ff0b457cdasm5346770eju.53.2022.06.05.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:37:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] arm64: dts: exynos: align MMC node name with dtschema
Date:   Sun,  5 Jun 2022 18:37:08 +0200
Message-Id: <20220605163710.144210-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The node names should be generic and MMC controller dtschema expects
"mmc".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 75b548e495a0..bd6a354b9cb5 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1820,7 +1820,7 @@ usbhost_dwc3: usb@15a00000 {
 			};
 		};
 
-		mshc_0: mshc@15540000 {
+		mshc_0: mmc@15540000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -1833,7 +1833,7 @@ mshc_0: mshc@15540000 {
 			status = "disabled";
 		};
 
-		mshc_1: mshc@15550000 {
+		mshc_1: mmc@15550000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -1846,7 +1846,7 @@ mshc_1: mshc@15550000 {
 			status = "disabled";
 		};
 
-		mshc_2: mshc@15560000 {
+		mshc_2: mmc@15560000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.34.1

