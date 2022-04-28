Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3119C43217
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Apr 2022 08:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiD1IVm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Apr 2022 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344001AbiD1IVi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2022 04:21:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C998F64
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 01:18:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a21so4632328edb.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n6DTGfTof5sYzGDiXrMP1vMIYG1Ilv6ThHsoRQn6zzQ=;
        b=DqxLNGi/xicx1g7puca5JU7KmIbbdaRlKjOMF1YlAi8Pl03hv2z3u8widpCctheFVC
         7ldIRJrZgsEnwln2E3gAZBIR1oPdzjL2jzLSW6zggZ4BSER+3ONecAOGoXuaHahojOLj
         LNLDSn9YwYBu+sxv998eqpVCuLw3lU5hCAHi6O4pnTIwFU6Txm07mKXCb7kS43Sq3vi1
         t49zhSxfmrkVhBhcPBhG0NtqY+lQPnimbRbkghy8fIHV5wk0hPEaSwk6hLDXE7dbbBVd
         hh5+Jd3Q0n/vDLZAkdH/gdnhJQud+aUN4hWIeR/l+D6Avs5OC4/iaSmBfB9MWOCwITmR
         oo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n6DTGfTof5sYzGDiXrMP1vMIYG1Ilv6ThHsoRQn6zzQ=;
        b=a9nWzKBceu5CVeUNrMrbPkMhpMo9U0ruXt/Ef1qZBQqV5T0bTrMLOoPk1VUtQ3v9Jk
         8dG0kIAyMyXCAuUtWcz/Kw1fRUB4t8yo0pllwnC1tncsc794Bn43j/CqJItuhWQUQiYQ
         E1HYbgsblCRSRIgnj65zcJlHG9zvhcKVkNBnwBIhIo8+Tv1vCcaVTiaB1fWmPDVkwJ/6
         /FYHJJcKCn2jvpW8F5rJ8sJH1dYbSX22nJzUQbSCALfIgJ+qcHCTqcCtdBY/6IZh4CJ5
         4AZPQDsdY2MMyFhWWUQCY+uph9oEkRcUTq8Vh5LyJMI+VO7kXxTwEg36qwNXg2aXVGN1
         hFVg==
X-Gm-Message-State: AOAM532LaPOk1HmVRAC+HOjQf0+dXtofxjX7+A7QjU585nPhh5Q2r+O9
        aR57yPv2yjIhd51AB62wfXyLmg==
X-Google-Smtp-Source: ABdhPJzI1dVgNMP8B2mGDFiv76P/6lIOuogOVY09/RMyn4Ngcb0VYTUD2iJ4jMWfkJ6hiZ4u/AIbNQ==
X-Received: by 2002:a05:6402:35c5:b0:426:1bd8:94ea with SMTP id z5-20020a05640235c500b004261bd894eamr5937347edc.40.1651133900398;
        Thu, 28 Apr 2022 01:18:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906700a00b006efdb748e8dsm8007744ejj.88.2022.04.28.01.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:18:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: correct number of reg entries
Date:   Thu, 28 Apr 2022 10:18:16 +0200
Message-Id: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The binding should not allow infinite number of 'reg' entries, so add
strict limit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index dccd5ad96981..54a0edab5f8c 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -31,7 +31,7 @@ properties:
           - const: brcm,sdhci-brcmstb
 
   reg:
-    minItems: 2
+    maxItems: 2
 
   reg-names:
     items:
-- 
2.32.0

