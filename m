Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE426C74A44
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Mar 2023 16:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCHQAK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Mar 2023 11:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjCHP7l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Mar 2023 10:59:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7ADC889B
        for <linux-mmc@vger.kernel.org>; Wed,  8 Mar 2023 07:59:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso1642321wmi.4
        for <linux-mmc@vger.kernel.org>; Wed, 08 Mar 2023 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3gnd/d/MLXJUAK0HLanbIn82QxPIkJ3zZK4UMU0euI=;
        b=rl8Drhy1ZHKjf0fTHD6/H53KQSiQI5SLJ7WfDX+eVtbeHnMlZ9yaESFaS0f1MQYon0
         oWcgidFWp0iYsFqXb9LaIvrzJVY557trMGZasbEDTaS7V08K+RociKRgNs1D2yTdwnhy
         Ve1Q7thOnHad90nPMxRFpuTfrdoi5j+1pW0itPn/xnen7r98T8TofWMt/9lqPvWcam9M
         D7di7CYxIZRHjoWmfX2R+wy3MCdp6mhZI6k+n53bIZUMrCur1cbM7pgC9soEeK4b24Ln
         ONNd9aICsTEvhbUi1y5HQ0lqg51hpSOAANrvT0hK8SrklnrqXig7GW5R1y+2HI8LPk9w
         LkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3gnd/d/MLXJUAK0HLanbIn82QxPIkJ3zZK4UMU0euI=;
        b=Uxpy2Ckb/5PHRFEz6VSel0L54UK1YmA+LDesfaX7qXMb0Ig0kaVJoQjQWWduXo1BL6
         82jC6UW/IcKadMLrjxM+QOTSizDinzeTpDNN0HUpfqh3Ab4rtULKqZR6VgzraosQWQY5
         P1IO9dKICczoMK8ZcvpmmDhRFmMpKn0DxDN/6AaPpW4uVUSCNfFd8uIPe0s0iDBdQyaj
         hdMv5fhlYo5pho3ld5Ywo6MybmMoudZc1Ibn8uY2X7d+TX/Ey8WkMzRUqHyDA08n0SMQ
         hrQpJegd/C6c1H+rLkegCdpsFrRxHH0qRKvRE9KuAboAWN8F2whNg3pOMTj5beKS48px
         XwQg==
X-Gm-Message-State: AO0yUKUSM7Mq9QdU8ZqupBkcQzIjzi0bFnZBpJaN7WfioNT35P5Vx56l
        5vpOG22ljEURNIWFbgpQ5cuIsg==
X-Google-Smtp-Source: AK7set90j7W0DmZbPdYoUas5/sJDtvyaCTDeMr9rAzDAu0F/Vq88d/1lOJkxSxkDGM0IOQv3za/mdQ==
X-Received: by 2002:a05:600c:3111:b0:3eb:399d:ab24 with SMTP id g17-20020a05600c311100b003eb399dab24mr15404956wmo.28.1678291150619;
        Wed, 08 Mar 2023 07:59:10 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2548430wmf.2.2023.03.08.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:59:09 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH v2 2/7] dt-bindings: ufs: qcom: Add ICE phandle and drop core clock
Date:   Wed,  8 Mar 2023 17:58:33 +0200
Message-Id: <20230308155838.1094920-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308155838.1094920-1-abel.vesa@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ICE will have its own devicetree node, so drop the ICE core clock
and add the qcom,ice property instead.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patch was not part of the v1.

 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..a0c93c2d7a42 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -70,6 +70,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   reg:
     minItems: 1
     maxItems: 2
@@ -140,8 +144,8 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 9
-          maxItems: 9
+          minItems: 8
+          maxItems: 8
         clock-names:
           items:
             - const: core_clk
@@ -152,7 +156,6 @@ allOf:
             - const: tx_lane0_sync_clk
             - const: rx_lane0_sync_clk
             - const: rx_lane1_sync_clk
-            - const: ice_core_clk
         reg:
           minItems: 2
           maxItems: 2
@@ -166,8 +169,8 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 11
-          maxItems: 11
+          minItems: 10
+          maxItems: 10
         clock-names:
           items:
             - const: core_clk_src
@@ -177,7 +180,6 @@ allOf:
             - const: iface_clk
             - const: core_clk_unipro_src
             - const: core_clk_unipro
-            - const: core_clk_ice
             - const: ref_clk
             - const: tx_lane0_sync_clk
             - const: rx_lane0_sync_clk
-- 
2.34.1

