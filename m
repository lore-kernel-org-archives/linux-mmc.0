Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA8CC3A5A7
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Dec 2022 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiLDJrd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Dec 2022 04:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLDJrb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2022 04:47:31 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545A3186D6
        for <linux-mmc@vger.kernel.org>; Sun,  4 Dec 2022 01:47:30 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q7so10277978ljp.9
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2022 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GccF7ob3XNHDsWukO3JP0Wi8T2Hdw6MMBFnO2OSTh1A=;
        b=AOOQWKhB0eM1snLNVJXxJ88RKnUmw1wOQGkdAV3MIpX+smm7OZiVUrXnMmw3iGjsje
         i5bX6ND0rB9MVdLTcNO1QBQamLrAXcEqZHS1FQ67LO4JcISpgNaUm6mOSccz32H+b9EJ
         VzlHtWtwn0poo7BNMlW+ovG2h2nUixyNut/xsGmxIIu7Ibni+TX8eJknx2pkIY810syt
         pggK7xOtQAjIQFFt+g5xOhMlzZdpwh8RYrtDDFVdjZFqnBpdu/n9kCfc2EvoGN9QhyfA
         2U2I5NoM3fTlxSzkbPfa8qHpdbplFSqwCLsfLpmjr6/GFgXl01Rwt7cl3aUOqoe7T91F
         fhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GccF7ob3XNHDsWukO3JP0Wi8T2Hdw6MMBFnO2OSTh1A=;
        b=1yWSM3Z2b+DiyZLr8kyfzaGToyzRsNNNdiXlVl0HI9Wv1Kz0s9tdfcadP+bv5E/d41
         LMMC3vdSMQDtyq0YWxaKq19SQCbq6mD6TBC94YzJoFrNePdtAfBkztt5T8+dyDbIGl0b
         pxx9xqbhTQJR5gCi/WGZW+q0mLvxDud2bV6A7HDUoqoQ9VI4ry1A7vF85UfNANbmxfPd
         ZOYHfQrH4IxQK534XPafQnzQakHxeuJzmgosvOswm+1XdTDHDrchPnSgRXJgA3OUX9bn
         W14TF36RoTxW/aAYYgEJ5R+sJWVVrQdNqnRh3/YnkyaS8ipEHMwAS7xKJOfKI6lK3h2V
         ufOQ==
X-Gm-Message-State: ANoB5pkaSr4nrxotiWCOGF0ksGe9gdnfF8/49uFaNaYJ9wZzTW6L/wC1
        Uz1SdQlgeUTbYtlwQKpdc79Jug==
X-Google-Smtp-Source: AA0mqf58UjkLL7Uh9snXz12mO9rEgH0hWAJWrRl1TIzjjfsGMx9zfSyJ2ILROJMiJQtCLPUGUHFUqQ==
X-Received: by 2002:a2e:2e0e:0:b0:279:7455:9d6e with SMTP id u14-20020a2e2e0e000000b0027974559d6emr18302515lju.235.1670147248670;
        Sun, 04 Dec 2022 01:47:28 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b00498f00420e9sm1706703lft.194.2022.12.04.01.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:47:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, abel.vesa@linaro.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: mmc: sdhci-am654: cleanup style
Date:   Sun,  4 Dec 2022 10:47:14 +0100
Message-Id: <20221204094717.74016-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Cleanup coding style without functional changes:
1. Drop unnecessary quotes from $ref.
2. Use simple enum for compatible enumeration and sort entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-am654.yaml  | 61 ++++++++++---------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index c4c73ee1422c..676a74695389 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mmc/sdhci-am654.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mmc/sdhci-am654.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI AM654 MMC Controller
 
@@ -16,12 +16,13 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: ti,am654-sdhci-5.1
-      - const: ti,j721e-sdhci-8bit
-      - const: ti,j721e-sdhci-4bit
-      - const: ti,am64-sdhci-8bit
-      - const: ti,am64-sdhci-4bit
-      - const: ti,am62-sdhci
+      - enum:
+          - ti,am62-sdhci
+          - ti,am64-sdhci-4bit
+          - ti,am64-sdhci-8bit
+          - ti,am654-sdhci-5.1
+          - ti,j721e-sdhci-4bit
+          - ti,j721e-sdhci-8bit
       - items:
           - const: ti,j7200-sdhci-8bit
           - const: ti,j721e-sdhci-8bit
@@ -59,67 +60,67 @@ properties:
 
   ti,otap-del-sel-legacy:
     description: Output tap delay for SD/MMC legacy timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-mmc-hs:
     description: Output tap delay for MMC high speed timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-sd-hs:
     description: Output tap delay for SD high speed timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-sdr12:
     description: Output tap delay for SD UHS SDR12 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-sdr25:
     description: Output tap delay for SD UHS SDR25 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-sdr50:
     description: Output tap delay for SD UHS SDR50 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-sdr104:
     description: Output tap delay for SD UHS SDR104 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-ddr50:
     description: Output tap delay for SD UHS DDR50 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-ddr52:
     description: Output tap delay for eMMC DDR52 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-hs200:
     description: Output tap delay for eMMC HS200 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,otap-del-sel-hs400:
     description: Output tap delay for eMMC HS400 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
@@ -129,55 +130,55 @@ properties:
 
   ti,itap-del-sel-legacy:
     description: Input tap delay for SD/MMC legacy timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0x1f
 
   ti,itap-del-sel-mmc-hs:
     description: Input tap delay for MMC high speed timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0x1f
 
   ti,itap-del-sel-sd-hs:
     description: Input tap delay for SD high speed timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0x1f
 
   ti,itap-del-sel-sdr12:
     description: Input tap delay for SD UHS SDR12 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0x1f
 
   ti,itap-del-sel-sdr25:
     description: Input tap delay for SD UHS SDR25 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0x1f
 
   ti,itap-del-sel-ddr50:
     description: Input tap delay for MMC DDR50 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0x1f
 
   ti,itap-del-sel-ddr52:
     description: Input tap delay for MMC DDR52 timing
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0x1f
 
   ti,trm-icp:
     description: DLL trim select
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 0xf
 
   ti,driver-strength-ohm:
     description: DLL drive strength in ohms
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum:
       - 33
       - 40
@@ -187,11 +188,11 @@ properties:
 
   ti,strobe-sel:
     description: strobe select delay for HS400 speed mode.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   ti,clkbuf-sel:
     description: Clock Delay Buffer Select
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   ti,fails-without-test-cd:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1

