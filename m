Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8763BC4708D
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Dec 2022 09:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLDJrj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Dec 2022 04:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLDJrg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2022 04:47:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BADBA4
        for <linux-mmc@vger.kernel.org>; Sun,  4 Dec 2022 01:47:32 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so574795lfz.4
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2022 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=janko4BgJGtkNL8mFckP2GXu+qyT3OukB4Vav5ERFlI=;
        b=TtfIZK00X69U8N7vJ76x9AKxq4Au2EonaQTQS244qskV0JbfPwZWKNum52oRCrHbjN
         F/G7VIwn9c+W4nmwga39MRt3aGUzU35rkNKfyXtIfAoAvauhyT/h0Sxo0gUCf2OrRfju
         623UhVKeej8b10C0sZhM1dTdT2pf6j11GLAtFpKSvKmt1ZLFGJdYHybX+mNaOR+8DcGP
         5LinRJ3wYjR7HOWhMaDoHKI6cYPxzoGsA8Hmlzsl2ij5+o/Uoi9UKtAq2eYeUthkA3Pv
         qWGfK3UacKPbifbDNWz4EqavTdVqcoa0g8i+F/CoXuD8ejbjjiliXW3hRB0WdVBgwoXm
         vYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=janko4BgJGtkNL8mFckP2GXu+qyT3OukB4Vav5ERFlI=;
        b=yQzfPM3MDDDRbipQXo+IYELjeHTCaBSukhRLvmfYNvjaI6DGrVdW6X4tgEP217apTJ
         Zkwqygkwck0eNX7ldcUpV9xTOWvm1SKMTqx+8bpuiG9gCMyjRRaCD+hyKsUZy0rslhK6
         s9JkVw9V3bIO8uH24M6HzKY4XtXhNJ1ZWfUzXGw2MnYWBas9D6TmLYpN64SgY9kPB9B6
         asIXK37dZkuObGA0qkMxkzEOF5vODsPqjmgTZZgJKw8nRLRGSTaXOsn6WAp/Dg2U+cnx
         ajN4zlJQP4tOzUID6pGunWvULXH8yxclICVkTNJ+L/5aSXZgiOnaJzaJLJbaYq9Symyo
         9GmA==
X-Gm-Message-State: ANoB5pm+6rPry6JjoqFzrMn54Zg0iwNEL8KooRoXrKuJNH1Xs5omY3rw
        FCTpjbbvHN1tZ/jfbQgi2Bm2rw==
X-Google-Smtp-Source: AA0mqf70DTCspnTZa1ay9+Qc++Song3setHNd0YTNsFVECp207Nslru7RAQM+uUhDMMRdNdgYgeVHg==
X-Received: by 2002:a05:6512:3983:b0:4b4:f88:90d3 with SMTP id j3-20020a056512398300b004b40f8890d3mr27581895lfu.37.1670147250857;
        Sun, 04 Dec 2022 01:47:30 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b00498f00420e9sm1706703lft.194.2022.12.04.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:47:30 -0800 (PST)
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
Subject: [PATCH 4/5] dt-bindings: mmc: sdhci-msm: drop properties mentioned in common MMC
Date:   Sun,  4 Dec 2022 10:47:16 +0100
Message-Id: <20221204094717.74016-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is no need to explicitly list properties already brought by
mmc-controller.yaml schema.

Fixes: 8574adf5222d ("dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 9e7c0e3803c6..39e303468bc4 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -136,16 +136,6 @@ properties:
     description: A phandle to sdhci power domain node
     maxItems: 1
 
-  mmc-ddr-1_8v: true
-
-  mmc-hs200-1_8v: true
-
-  mmc-hs400-1_8v: true
-
-  bus-width: true
-
-  max-frequency: true
-
   operating-points-v2: true
 
 patternProperties:
-- 
2.34.1

