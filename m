Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C72EC4332F
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Dec 2022 09:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLDJrv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Dec 2022 04:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLDJrj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2022 04:47:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F351387
        for <linux-mmc@vger.kernel.org>; Sun,  4 Dec 2022 01:47:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 1so574826lfz.4
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2022 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV9iDq9ASawaJ80Vnkd4V2c06IYqg91+S5dBHxjopKQ=;
        b=Ywq8JTIppvGS+u73xDuB2V1FMFl9uieH9iGsVs28JoExEMBFJRczI3+P86bLxbCzE8
         1aEy646UPgd2Af8q09vFWDK+vbEWz478Sv6T21j93UhiqDsFsIc5o+3VkgP1SzSyoy++
         3/SKzQl2i12sDhxT9eWoPrRbmhD11ABYZQA3dCwC9qkEETnI1VG739LObJQvmgNy+6oF
         pCkeNNF71XO/BPFx3NapEsof0aCLPfeOx4PXiCSArGNwD99ODDQAt08kW2PinqtZ3Sit
         npa0cK3x+3NSGnzrjgIa+NLTNf4/domrz0P4dODoSnRdmczWxgZQxC3eD5k7qwrL/lSf
         Tv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HV9iDq9ASawaJ80Vnkd4V2c06IYqg91+S5dBHxjopKQ=;
        b=ceuqXX7LY+upGIx5qaeb10IJV5MuCk6k3zjRmj/6LuNs/zw5upe/7JkWF3qDu2gAjP
         zwBNaQelG5piK9FGFf5AC6/A7uxCztnluc6u7MG5XeYOZJjfk89fRoAcCyTL61c/siKt
         /XD+XNbus9I5s3QpQYFl82WCBVX0KnkPrmgv+mm9IWN9JKhRFl0djRI4np/vZ1KZMTPJ
         FdULPQZuv2l/Gve4NWsTj7NUf9kgJDxdGD+N2EYs2qOjl/9aGZduEsWu8cQ3EFNYzzzw
         3A1YY6w/hDkPlc/74efp1b8n++Ji+LGQ7rwgx2jUjwNvzUYG6/KgKDEzDonkD7VE1bhS
         OOJQ==
X-Gm-Message-State: ANoB5pl1tdMvBnjCHdt1T42mTYmUUoTGQAf9eQMgtJ5kYGqtz7htc4wN
        wYzWtu6CV6f/HMpN28KBD7X8RQ==
X-Google-Smtp-Source: AA0mqf4NXpqkpNJWIOCVpnhjza3+x2Mh1nBOpGFv66z4tTQHVxxOKG6fb3yuxq20BEQywA/02mkD8g==
X-Received: by 2002:a05:6512:3153:b0:4a2:da6:d969 with SMTP id s19-20020a056512315300b004a20da6d969mr23719756lfi.671.1670147251886;
        Sun, 04 Dec 2022 01:47:31 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b00498f00420e9sm1706703lft.194.2022.12.04.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:47:31 -0800 (PST)
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
Subject: [PATCH 5/5] dt-bindings: mmc: sdhci-msm: allow dma-coherent
Date:   Sun,  4 Dec 2022 10:47:17 +0100
Message-Id: <20221204094717.74016-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SM8350, SM8450 and SM8550 SDHCI controllers for SD card are marked with
dma-coherent, so allow it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

dma-coherent was first added to SM8450... then to SM8350 (not merged
yet) and now it appeared in SM8550 patches, but I actually do not know
if this is copy-paste or real need.
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 39e303468bc4..6b89238f0565 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -83,6 +83,8 @@ properties:
       - const: cal
       - const: sleep
 
+  dma-coherent: true
+
   interrupts:
     maxItems: 2
 
-- 
2.34.1

