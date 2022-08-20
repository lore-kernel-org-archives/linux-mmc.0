Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB84EC32796
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiHTT60 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiHTT6T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:58:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09915FE9
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v23so1476283plo.9
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=NTXAxyQL3waGEJkz3JFJl11ykh+V7CnflPyyCrkRmVo=;
        b=aDa+MkMjVsjqpzMdLGR6xZaO83PwMwIyrZk1GxVo53E9S8vjB9rlObTewiew3FvTg9
         PsmXG+TvLB+kgfj/mcJ2XaywU1rNXrEAUj3nPhpqmZ5YSLfTolGBVp2+oxHN3xxXv0V6
         QyCuqJhpn2pRir62TbQzOyzsahTjKTvVsI2BqP3rWHEB8nifJPHLG1boGRd10ty1mUKH
         iqj6LJQH+pu00fdELeJ+itJKXkM2mmWwl3xm2HTPAgoHIacTVprXbH+2jD1X+/PhvKv1
         1c207Zornyjs8wquci/ZHDxlHF5mWGFuKOFM5SSeE5m7llxoQKCNdgE0dsrSJ+oasP6n
         Xz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=NTXAxyQL3waGEJkz3JFJl11ykh+V7CnflPyyCrkRmVo=;
        b=UzKfywt6UhytZXRMamveJ5gz7OYlD6Ck5yzKSXivk8zGcHg6SWJhQkf+dQe3mbauuv
         nHQ/vUejElAH++KlQmZAJb0R9PymH0v6L4ViHmn4VvzL8vakCX8pitB8olP73T5nIoHH
         MHi9RaAM07bkm2LdtFDEnovsod/F4xPINdy2WpF9JUnUvwbVPJfSE/i7Mtd+W4WMEhFf
         CqanroGlG8HGhtd/dUONoVBvEfOfcCgyLevMe4zxIfTVFeLsDTnQ5RnFrNoKeN7HG1XX
         /xZS5xvsACKG6xgvUYQM0SQFyLTKvmpLeqWltD3RJLc54F8aQ4fiBX8aOHPL8DXUh5Co
         cvQg==
X-Gm-Message-State: ACgBeo2+vZ6nUBz8VTbZNHhkeiawEODTV/BS1oDN17WpcdczN7l5AAxz
        PmFCIDWIWFqss0cYKMUj3Mmgpg==
X-Google-Smtp-Source: AA6agR4lIy2KV6bT/mtcoUBCfdxboF9vk9E8rQOlcdA7QKnG74sjDawFROrHf2Z3OgHjdJ4lYC890g==
X-Received: by 2002:a17:902:70c7:b0:170:9030:8219 with SMTP id l7-20020a17090270c700b0017090308219mr13177138plt.163.1661025498268;
        Sat, 20 Aug 2022 12:58:18 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:17 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 02/17] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Sat, 20 Aug 2022 12:57:35 -0700
Message-Id: <20220820195750.70861-3-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 4207fed62dfe..964b610eeef2 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -17,12 +17,14 @@ properties:
   compatible:
     items:
       - enum:
+          - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -118,6 +120,15 @@ required:
   - interrupts
   - clocks
 
+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

