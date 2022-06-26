Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F25C43334
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Jun 2022 12:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiFZMDv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Jun 2022 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiFZMDu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Jun 2022 08:03:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB22DDEA2
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so13540666ejc.10
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MR+U/uv/sFjluVAnKsew00EB++5ncTIGVWbEuuMWfRM=;
        b=JNj4ATZc5CVCi2t3fTINxa9ELhyZk3hwB02+pcG9CQN437fmTf8vKSI64OID3H9baH
         fyJeHzSoP7gJVId+LA2Cszj4LKY4faXwXCkORt5umeUDtcWDAql8fzw7gteTcyPidPZy
         UfDi373pp3n+3DHY5YFfLgPoMm+e669GUtVyLCsWksZi7YHXRhrh0zIfB7Sav8yZkKez
         JjbBLjD8wnvxCrQnAQR1YCxWHaVHPkpV/vhnQmeAm6qYDGqWT9kJGrNZpokSU4gMD1FI
         rZmdFKoZgmopisozOBwR/fOQ0aaisEtKnq57vqRfaSym5M8qHcXMmkJ5dT0AuM/gMCQd
         cv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MR+U/uv/sFjluVAnKsew00EB++5ncTIGVWbEuuMWfRM=;
        b=DXk9pDW6JDuFDq4K0YJAeawAw2DhQKAmg9eE3524kk5U/Ti3digjQyZmiCu1SMHmBm
         pFFdcWAADo8n7BSSe08cKAHfKTZm+A9DCFxVPd0/TU4Y5SG9XCY6Iq1nq3F1ebz7Qvjj
         FV1j4u1YlLQJNdK8HesaV6M7eezSs5bWMpwyg/PTGuDKS6MGBTEOsBwbjwSpLdqNakG1
         jtf8/NMf5vgqRjRcU2ITAOw6ART8SGN3AtgRZaVskd4PxpTg4GdML8EdHcG2/y5wQf10
         sskL0Dc/N2s6GuL6w6/Bd/DRxj3BzeY+lwK7PZjZf2P5gh/cQ4hahLKiERbmF5ngmcHx
         Di6g==
X-Gm-Message-State: AJIora8261L59NBC1whrCBwn+XTnNg2zD0pHDxxTHOCsfwoJkwieqWNh
        7gpXBDw9M8b0xVOBTZKxHGdtvA==
X-Google-Smtp-Source: AGRyM1vrX+NQCvsTSQ4ytCg0vIbGH4yopPHMm15pqoZyIntBxfRtbiGZkb36GyWsAjk2WTcZJeXiaA==
X-Received: by 2002:a17:906:72cd:b0:722:d84b:30e3 with SMTP id m13-20020a17090672cd00b00722d84b30e3mr7889852ejl.726.1656245027347;
        Sun, 26 Jun 2022 05:03:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm3751585ejz.120.2022.06.26.05.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 05:03:46 -0700 (PDT)
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
Subject: [PATCH 2/5] ARM: dts: s3c24xx: align SDHCI node name with dtschema
Date:   Sun, 26 Jun 2022 14:03:39 +0200
Message-Id: <20220626120342.38851-3-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/s3c2416.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 4f084f4fe44f..4660751cb207 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -45,7 +45,7 @@ uart_3: serial@5000c000 {
 		status = "disabled";
 	};
 
-	sdhci_1: sdhci@4ac00000 {
+	sdhci_1: mmc@4ac00000 {
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4AC00000 0x100>;
 		interrupts = <0 0 21 3>;
@@ -56,7 +56,7 @@ sdhci_1: sdhci@4ac00000 {
 		status = "disabled";
 	};
 
-	sdhci_0: sdhci@4a800000 {
+	sdhci_0: mmc@4a800000 {
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4A800000 0x100>;
 		interrupts = <0 0 20 3>;
-- 
2.34.1

