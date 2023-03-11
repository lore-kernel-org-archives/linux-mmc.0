Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9370BC74A5B
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 18:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCKSWa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 13:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCKSW2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 13:22:28 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1161319
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:21:47 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m6so10764794lfq.5
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678558900;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zgZZFa9GT3KgzmxYSLg5VRVJ2/WUIFA9QnWnNW5nD4w=;
        b=mNtGjGWdDstEdiYUuvC/HXFG+z/PPk4RvfFsbGxt4IT/xfq93mn20/nH81OLJxf1RT
         Yv36QxydbcaNpcuxk1VqiuJhGMpOMhx8OOYfc8sqpI1WtLtxHU7Dym6+lDtMBIJby6Ia
         tFHa+b4tPUGHR5CaX/ptcNfvHUdCm/nAeH1gqNcrGkerig3VA4kFDPFprJIL92+3O2k+
         viZUsN5KjmLD4U2iBinhzp6KrVqyAisr4j2iv5/B/kLkn4GEAGC4jeeXwFoKrZQ1AIAh
         X9Lf3L87QHNoXyiNZYfgTSgcya+z6RPyEU4gY3DeG6G2kYrEjiEco0NbpmY+yxIIUP1b
         uYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678558900;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgZZFa9GT3KgzmxYSLg5VRVJ2/WUIFA9QnWnNW5nD4w=;
        b=7H6krAou/GmUwvy161oHy07YpUWVrXYfdCoKV5Vd6Zw+GBRmDqpQ/pNmBI3n5cp35h
         PI3fegxxJa8jSlotnVRPOm2fOUifowAaH9b/J4nwLqtgN8lwtie8Dj33+u7LT96OZdxx
         sA7HfASitOqDzdybWS75Ybtut35MQKxohnUtIM4Ay3V3WNpNVz578hsfP5WfBXl/MXlj
         qlsycXw8OQVwH/PO5LQ4Ki0qaq3Xo6jCZ/fLllseApHS3D5dSyOD7Kbr8h5gsAjdoTBX
         eBMdvL9TqvpgRmfvye49scnz/9d/JXC11Pt7FNV066Cg7lJ+egZcKO4J37VZ/9UzE0bC
         EUBg==
X-Gm-Message-State: AO0yUKWgclseycECDR/Xslh5WllthfJnNW1AuFn2dbNPzhxdLHijRVWl
        u7+0t5sCt44aVL4vJNhm8iM/a/ADV4bF/1iS55M=
X-Google-Smtp-Source: AK7set/dsCM8nSmhcj4GaWC0Aejx2GNjuzxmx6GUbh5avv7VmGK2OknrAUvaAvnOc18BzQZRXdUE3g==
X-Received: by 2002:a05:6512:20d:b0:4db:456a:9a1 with SMTP id a13-20020a056512020d00b004db456a09a1mr8313956lfo.66.1678558900240;
        Sat, 11 Mar 2023 10:21:40 -0800 (PST)
Received: from 0001-dt-bindings-synopsys-dw-mshc-common-add-fifo-access-.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id r15-20020ac25a4f000000b004db50b52c08sm387004lfn.102.2023.03.11.10.21.39
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 10:21:40 -0800 (PST)
Message-Id: <1678558770.495747-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678558770.495747-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 21:15:37 +0300
Subject: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some Samsung Exynos boards using the arm64 architecture have DW MMC
controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
index 8dfad89c7..d025b38ca 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
@@ -57,6 +57,13 @@ properties:
       force fifo watermark setting accordingly.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  fifo-access-32bit:
+    description:
+      Specifies that this device requires accesses to its 64-bit registers
+      to be done as pairs of 32-bit accesses, even on architectures where
+      readq is available.
+    $ref: /schemas/types.yaml#/definitions/flag
+
   dmas:
     maxItems: 1
 
-- 
2.38.3


