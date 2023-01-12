Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B7EC5479D
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Jan 2023 02:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjALCZD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjALCZB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 21:25:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528844C6B
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:25:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so18753163plb.13
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkEROvqe/oVHJlSyZq7hsGS4ZpUmek5M63T+j5fOoH4=;
        b=gX1EBfM5eKWBoii+opdXBsRWzaFlw02zX5dde//6NSrjWw2nr6mZdxDXIxoxD1Pzyn
         /3/buM1oz3c20zSA1+Bwg3OAgZRvLf7I3sXIvg7Tcjck9DAqFQqGCbbgdgoaseJbLmbY
         cMtdu3P+iQYzYITV05fTP3pfZhnQ7GlRxbaFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkEROvqe/oVHJlSyZq7hsGS4ZpUmek5M63T+j5fOoH4=;
        b=iI2b0imookM+KLzp93cw9D3s4CqHHK8wj2nkXjwZFtM0PIm9tulYycVAFsA0rbo3f+
         C4MvST+Rtz/G7M4w5Ns2FTB4jrrfrD0g03sVAUoM2g/OsCa+7tJvAsd5+ecGNmh64U0y
         Z5sTkMmUMj/OdO706UH0q10ufvt7oMraos9TPt/5d4j6SNm0u4K6Vn88lqcPdNNGFO4V
         sBnXvJ74JpOHRLROlYbhXPnF5mC3XoUcDOOGwXvV7G/Szi+tSkVNSLMcH9bpZvBw0UIE
         INXy01MBbWg+QAqFPJ3zdNGg2d16SEe8cczo3K3sFuu4XZoxF2ZFFB3CPiMF0gLuAsMz
         w2Gw==
X-Gm-Message-State: AFqh2kpHG1BEf2/ECG1FDFV2vPSvWlOydtrCnc6rG51AYhuHEx38FeWo
        qd3SCSUze3CVclx6B4MVlddz7A==
X-Google-Smtp-Source: AMrXdXuaAq/L6J1Jg8f3kc4rr5mUT9ZsDq0JHYzBRUlY9Dq33gC0Y5NDgslhThYKJI3RuLEqDR6Qcg==
X-Received: by 2002:a17:902:8543:b0:192:9454:7b32 with SMTP id d3-20020a170902854300b0019294547b32mr46715926plo.40.1673490300487;
        Wed, 11 Jan 2023 18:25:00 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00193020e8a90sm10759135pln.294.2023.01.11.18.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:25:00 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Date:   Wed, 11 Jan 2023 18:24:16 -0800
Message-Id: <20230112022416.8474-9-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112022416.8474-1-doug@schmorgal.com>
References: <20230112022416.8474-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a compatible for the pxav1 controller in the PXA168, along with
optional pinctrl properties to use for an errata workaround.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 3d46c2525787..09455f9fa8de 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell PXA SDHCI v2/v3
+title: Marvell PXA SDHCI v1/v2/v3
 
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
@@ -34,6 +34,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - mrvl,pxav1-mmc
       - mrvl,pxav2-mmc
       - mrvl,pxav3-mmc
       - marvell,armada-380-sdhci
@@ -61,6 +62,22 @@ properties:
       - const: io
       - const: core
 
+  pinctrl-names:
+    description:
+      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
+      SDIO CMD and GPIO mode.
+    items:
+      - const: default
+      - const: state_cmd_gpio
+
+  pinctrl-0:
+    description:
+      Should contain default pinctrl.
+
+  pinctrl-1:
+    description:
+      Should switch CMD pin to GPIO mode as a high output.
+
   mrvl,clk-delay-cycles:
     description: Specify a number of cycles to delay for tuning.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.34.1

