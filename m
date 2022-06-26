Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E122FCCA47E
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Jun 2022 12:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiFZMDx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Jun 2022 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiFZMDv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Jun 2022 08:03:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C094AFD01
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d2so1821870ejy.1
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yjkgvEiJ4GrRJrHNAHcvts5jioX9D/GIh99TWRnRa0=;
        b=A6xk36Vh/mThrY6yGG3ZUgY1Ng1muWPAoE/bEJ91XSdE3UG8Mi9UTVVZzfRgVkTFwp
         EQg33gTqux0JduDhefjV1rfCJmoJepRYm7ueqZPo60V46sRoXxquIrDWogcb5oo2kcU7
         lW6Iz6vc2PuA/yFsmwwcQ3UvjfsZF8MsGAB1vK577/5cj1gaz4HmMIlzDUIhwcSItZH3
         uMmBStzJZb2ExHB5qINHXiwWJzabz+scFjAgxoZKdvMNoth89SX7KouuPTTY0pdYdYzk
         vfnoBYLc4jKXzg4rHqhEzYSP0G20oP8XwZCSdZCr7BIAgEn2UM+AnE6Eh6f44+OH35jb
         UbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3yjkgvEiJ4GrRJrHNAHcvts5jioX9D/GIh99TWRnRa0=;
        b=1LmaMNUlRv4s/mZDQ/7jFxdXZlRxn1qQjTVEQqvuBeuiH4mbmcioyqsNuv3BAnXkgv
         vxRRQkLfVXYbK+XFZQ25Qs0ZKl3S15j8DrMop+2TM/qRAQK9z1cOFiHL18sYsSF4hmRs
         J3QHuqfQ44pn72Di9KpvpmaForVW0vJfDYWUI6Odx5fka9VH84LdRaZKA5hQ7PVA/05W
         vS4DhmjisOnoMXFpDUrb2egJoY3njJ+khwDSs+/p0ztpKqKj+YVL/Afu2DSygsTFzRGu
         w6L3KZpOH4pqZ3jtlvGXRZU+kmPI/R6dgn6WziEr5FlTfr4CmTQvRT3kPIJk3v8usxt4
         Nckg==
X-Gm-Message-State: AJIora9GNVk7ZD1FEHPScAYJsWJYrgoMW30r1xn5QKbGBCPcHQfkoyNj
        ymx9jOrbP1D6r6EADa+67VDRBg==
X-Google-Smtp-Source: AGRyM1sCPXT2h1HtpFnOqOWfck5y567fVV8puBnBUED9+Vxuk+jQ6+6AvNxkHTBLpiio6VY27A1hiA==
X-Received: by 2002:a17:907:9958:b0:6e7:f67a:a1e7 with SMTP id kl24-20020a170907995800b006e7f67aa1e7mr7869317ejc.400.1656245028362;
        Sun, 26 Jun 2022 05:03:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm3751585ejz.120.2022.06.26.05.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 05:03:47 -0700 (PDT)
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
Subject: [PATCH 3/5] ARM: dts: s3c64xx: align SDHCI node name with dtschema
Date:   Sun, 26 Jun 2022 14:03:40 +0200
Message-Id: <20220626120342.38851-4-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/s3c64xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 67a7a66e11d5..c03df6355500 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -59,7 +59,7 @@ vic1: interrupt-controller@71300000 {
 			#interrupt-cells = <1>;
 		};
 
-		sdhci0: sdhci@7c200000 {
+		sdhci0: mmc@7c200000 {
 			compatible = "samsung,s3c6410-sdhci";
 			reg = <0x7c200000 0x100>;
 			interrupt-parent = <&vic1>;
@@ -70,7 +70,7 @@ sdhci0: sdhci@7c200000 {
 			status = "disabled";
 		};
 
-		sdhci1: sdhci@7c300000 {
+		sdhci1: mmc@7c300000 {
 			compatible = "samsung,s3c6410-sdhci";
 			reg = <0x7c300000 0x100>;
 			interrupt-parent = <&vic1>;
@@ -81,7 +81,7 @@ sdhci1: sdhci@7c300000 {
 			status = "disabled";
 		};
 
-		sdhci2: sdhci@7c400000 {
+		sdhci2: mmc@7c400000 {
 			compatible = "samsung,s3c6410-sdhci";
 			reg = <0x7c400000 0x100>;
 			interrupt-parent = <&vic1>;
-- 
2.34.1

