Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1319CCA485
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 08:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiGGIEq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiGGIEn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 04:04:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CEA313A7
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 01:04:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so29773453lfg.7
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/f9p62fMS99xM7mHr2HHjGLpTbZceR2Zn1lLek1ud1w=;
        b=qcCCSCFt2Fd3xS6h0fNJd8tshWFUhAnilR0zaFXiYC+2gr9VkWb1raxklvKrDw6hlY
         dAPVWf/k1xdeharGHf7BNCouDaAdRErvrpC2wTWIp6eRyFwEw//K9DvEr9pXrm0eMM98
         ajJNzpUIKBBSa0ITyfQfshw1WcAKt3vIi5Iax3LvgTHmzFgkdoxJKuUkFoeK4sIVaHo0
         izNTxua9Yuk1XQBqYn8WrDw7bG2XIqfdtUZ/i4qew913Lmc2Jx2aOkPasA5aYuaylm4v
         1mgTkBoxM9t1sI9y+fK8lLdFgxcZ25BvWviYXcOot4tFhtkMJRA14QfEYhmkmt0Pvvfz
         u1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/f9p62fMS99xM7mHr2HHjGLpTbZceR2Zn1lLek1ud1w=;
        b=gaQvgWxIMQkM/G2Po/XCRjK/t/9x/Crlv2wKDVpTBeSh5b+S0VknRONnhNX0U/OS4c
         AYefnJNQmt141vuoebMwAhkFPOWtph63rnrzrbj9Tk3Ij8LFkffWAr/3ZyFLZxBNho44
         9SiFJyMDyEjI4h+Nreofi8JKAxZxkcTVywfpZHw/gP59TxlBMLi5RTOJJTy1xRE9QPr7
         YqLfrQLhaOF0na5rU+UideoRR+FscGWzBKD6cjxYth0hxlczubJYrWtdua0a+W1Q9Z8Q
         d0hBcxyTcqR4m1RoUc0NzJAqH/ygPIYcYiK7GZlPR8Z4lalMD9cEY15zm4yOWXods07R
         Zczw==
X-Gm-Message-State: AJIora8cSXfwK/isMHPpu+1x/a6ZhDCSeaDDOE/txfqulTstNUnwT+g7
        aNz4Yfxop/kad0QxVpRCK5z4fg==
X-Google-Smtp-Source: AGRyM1uyxLr6utQh6WzGkS/o4ElVNUkS91rxr9fiBUrexVoQfiiRTZ7YoxUejt5fjwk0KqBV2M5Tag==
X-Received: by 2002:a05:6512:169f:b0:482:f605:c19c with SMTP id bu31-20020a056512169f00b00482f605c19cmr10449081lfb.592.1657181079425;
        Thu, 07 Jul 2022 01:04:39 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b0047b0f2d7650sm6697187lfr.271.2022.07.07.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:39 -0700 (PDT)
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
Subject: [PATCH 1/5] dt-bindings: mmc: sdhci-msm: fix reg-names entries
Date:   Thu,  7 Jul 2022 09:51:47 +0200
Message-Id: <20220707075151.67335-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Bindings before conversion to DT schema expected reg-names without
"_mem" suffix.  This was used by older DTS files and by the MSM SDHCI
driver.

Reported-by: Douglas Anderson <dianders@chromium.org>
Fixes: edfbf8c307ff ("dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 31a3ce208e1a..10707c4f7184 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -59,22 +59,22 @@ properties:
     maxItems: 4
     oneOf:
       - items:
-          - const: hc_mem
+          - const: hc
       - items:
-          - const: hc_mem
-          - const: core_mem
+          - const: hc
+          - const: core
       - items:
-          - const: hc_mem
-          - const: cqe_mem
+          - const: hc
+          - const: cqhci
       - items:
-          - const: hc_mem
-          - const: cqe_mem
-          - const: ice_mem
+          - const: hc
+          - const: cqhci
+          - const: ice
       - items:
-          - const: hc_mem
-          - const: core_mem
-          - const: cqe_mem
-          - const: ice_mem
+          - const: hc
+          - const: core
+          - const: cqhci
+          - const: ice
 
   clocks:
     minItems: 3
-- 
2.34.1

