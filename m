Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DACCCA47C
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiGLOnF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiGLOnE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 10:43:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F5BAAAC
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:43:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bx13so10147822ljb.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ya4IX6aXZnfGLTgjCrxYJj58Us6/c6dgWp4HrtPsHjg=;
        b=FXYsU7ly87F6wYfaTWoiieSaNZcXj4m5ARLB2+oLmk8ZGHhuDeq5p2kADp6tZTS8pf
         jH231exCwusuketydoCydTEfgKAOaP4JWSUa8qhRKntdxBt0AoJOj/M0kFBRVZ7f+/4Y
         qN06BX2hrlJsBphFdELj5M9zb5c1NZTBrNQ52NNBkXDTrkf0/tPPbFp2ELrXJHPRvXyX
         6xK6c70XGIxZbDsbopIMLNvhNWIHFB148igi+S+jMJOUb/8yC7uhoPD1Dlg0ucKQVcyq
         UnpvInJev8eIUiqBd+k8EKq+GRHyjHLilRotYperMJIiJCsP1BfBQE2C7QNdXgYjsUYl
         TblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ya4IX6aXZnfGLTgjCrxYJj58Us6/c6dgWp4HrtPsHjg=;
        b=DZbz3mCvTiRSMJRrU6BMaBCY5KYxyFgqvFD8vsHYqfGSB0S4gE/WsskUFxNNyaTBul
         8T+L8XdPRfa6almwiJShzEHXGpQoewni8M1rZK8ULFhYta0pXp8hYe3ba5SxzJWUQQqR
         laYGeEvzWVc0T7Eh/HSYZYpdTH+GkO3pnxi0yvIuFnEQVszsIMuYzDP0b2523CSNFx0v
         QixRxbZZfFjK5Mym9Uc1nviReAnm2rSV56III50XnfG8e4sODVavR0YeYOBxDObRaXLJ
         odcmXR9jl6qrq22RxD0q2DlajiThytUbaPlR1p+UOIcml3QMmBlO08KDlzAWYa4QOGAn
         TGAw==
X-Gm-Message-State: AJIora8nFBmgWAX9EFQlF2RYzXPw4rRfjN99CM/bL20qZpBzJYIfY0oR
        lZpg5oq7QoKAxzmomLtP8v048khmkkv7iAjw
X-Google-Smtp-Source: AGRyM1u3532cC5WBtGnIdYIeyjGVVbUGQwnn3owEYWqzk8kJyfj5OWr/QzPaDhFTtgk57pgzjO68Kg==
X-Received: by 2002:a2e:8501:0:b0:249:17a0:ebf8 with SMTP id j1-20020a2e8501000000b0024917a0ebf8mr13334851lji.125.1657636980684;
        Tue, 12 Jul 2022 07:43:00 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b00489e88d6a72sm737577lfr.198.2022.07.12.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:42:59 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names per variants
Date:   Tue, 12 Jul 2022 16:42:42 +0200
Message-Id: <20220712144245.17417-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
References: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes since v2:
1. Fix commit title typo.
2. Add Rb tag.

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

