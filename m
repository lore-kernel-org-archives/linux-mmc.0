Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6620FCCA47B
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 08:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiGKI3z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiGKI3x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 04:29:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8891EEC8
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:29:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u14so5339782ljh.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECmDrApCWmsy6bTxbWAJtF1tb5Jnxl9Hmbc7aLUQ7zs=;
        b=oc6SX5BfT6fMqrx+BbEtw0q8Ed8qK5l+j90ZAz+9xdJ25Woju5BEhRm4dCPVua7FVY
         zWs6IgK8XBHs8im6KsI5Vyqx19oKQT09IBwEsEl6PRSIr55fVrCeCLxynNoAoeYozPcI
         Jx5tCjylNt8VH3Aau7SZX48ZhaZuaAkh/4m/7mDSi8ECJTdDtV6ZyEYBWNOJ58zLl9it
         TB/IkamP0veGlXRApjAHP7walbdH6sIXa7P+SMwLqal3+PG28PbmFnEgWcfT9wQ/yMfx
         dNVudd7OMTXTHnZIl8Kqhhz+uFHC6UjFLUkaa401EjeDp7ptx1LD4YAFdhIdDfIJ6yxC
         lkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECmDrApCWmsy6bTxbWAJtF1tb5Jnxl9Hmbc7aLUQ7zs=;
        b=6GdJuC+ZKIqBbN19yfL/bxGorpGppQfUOggeaHcI6hYdCDDRI8+5oteDj39fK31Wla
         K2k2qRThOv8cPAhtoPF3KaydlfR8J2mtzQFeUkcocGt4BEysLKtBQ99NDhBn2mY6lJug
         L4cL/L5DQN8itnhWs616HlBylOmARHLTEHJs+6u5w2QWCq0XA4aovRkq1QpO8l4HxsC/
         5dKdbVySKOeXWCu7AgkhgCpvZ7d8x8EH9dxO9N13nF0yVeP8fJHYW/NyoNKRxPz29vRp
         0LTwiJws8Ca3eSdxnnvguvKmB+aa3XL1wQToLDQRwVLVoetJN9GPaBJK7UllQ7jefBxt
         /5vg==
X-Gm-Message-State: AJIora9cEs3sKPSU+PSr2oL16WvKCFeb/FDCrZe520HBQUHSs5B7vY77
        srHI2evrMoj9uPC4aSeHTJ3QqQ==
X-Google-Smtp-Source: AGRyM1uQLnnh/Pu9iJAGaTHhyYJeXAp8YyKuN7dPfR9tj5ox+SHwzeeUfcNoeW4io7jwBOYyPmtzVQ==
X-Received: by 2002:a05:651c:50f:b0:25d:64a7:d358 with SMTP id o15-20020a05651c050f00b0025d64a7d358mr4895586ljp.523.1657528190568;
        Mon, 11 Jul 2022 01:29:50 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u2-20020a05651206c200b00488ab8914b5sm1401504lff.213.2022.07.11.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:29:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names perp variants
Date:   Mon, 11 Jul 2022 10:29:37 +0200
Message-Id: <20220711082940.39539-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The entries in arrays must have fixed order, so the bindings and Linux
driver expecting various combinations of 'reg' addresses was never
actually conforming to guidelines.

The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
v2 or v3, so it is not entirely accurate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rework the patch based on Doug's feedback.
---
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc6e5221985a..2f0fdd65e908 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -49,33 +49,11 @@ properties:
 
   reg:
     minItems: 1
-    items:
-      - description: Host controller register map
-      - description: SD Core register map
-      - description: CQE register map
-      - description: Inline Crypto Engine register map
+    maxItems: 4
 
   reg-names:
     minItems: 1
     maxItems: 4
-    oneOf:
-      - items:
-          - const: hc
-      - items:
-          - const: hc
-          - const: core
-      - items:
-          - const: hc
-          - const: cqhci
-      - items:
-          - const: hc
-          - const: cqhci
-          - const: ice
-      - items:
-          - const: hc
-          - const: core
-          - const: cqhci
-          - const: ice
 
   clocks:
     minItems: 3
@@ -177,6 +155,43 @@ required:
 allOf:
   - $ref: mmc-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdhci-msm-v4
+    then:
+      properties:
+        reg:
+          minItems: 2
+          items:
+            - description: Host controller register map
+            - description: SD Core register map
+            - description: CQE register map
+            - description: Inline Crypto Engine register map
+        reg-names:
+          minItems: 2
+          items:
+            - const: hc
+            - const: core
+            - const: cqhci
+            - const: ice
+    else:
+      properties:
+        reg:
+          minItems: 1
+          items:
+            - description: Host controller register map
+            - description: CQE register map
+            - description: Inline Crypto Engine register map
+        reg-names:
+          minItems: 1
+          items:
+            - const: hc
+            - const: cqhci
+            - const: ice
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

