Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFA6C3A5A7
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Dec 2022 09:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLDJrh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Dec 2022 04:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLDJrg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2022 04:47:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F065183BB
        for <linux-mmc@vger.kernel.org>; Sun,  4 Dec 2022 01:47:31 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so14156287lfb.13
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2022 01:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srKBWWOhJxYyjQwFZkBs/XLc9rLtWfdgyHo2JMkH7Vk=;
        b=VFdR1I3gqvoJOg0RDy0RBE3NAkURp4Oxnx1mtTBCPMzIiwf798wsfSZFQwyzrlhQAT
         sVcF4zuOzTDKxXMDL3ydljMPQHXXDdQ3PIqZD/SQp4bZqC44gwiMjkVjxGXi0C+FD+uC
         MHyxEWbft5Sa+CT1qmG0o322ZeKZSf9hxJaQ9blkmYfwvtBT3shA+MbSMLQbdDDxi5Gf
         jBn2uvBq1SFLCUfFA5CX+gOXMB1ouYcCLpxMGn4JtEqQh+fOin8JOJj8zLUv124z5jxt
         rFe6vjshig4dNr446ocPcWHlvYURqm5bpcl983g8HRwWwdNcxd+hx4yOlnjsMRVf0sYo
         muuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srKBWWOhJxYyjQwFZkBs/XLc9rLtWfdgyHo2JMkH7Vk=;
        b=jBtxPFNicXUSbuDLPMopX3ZZGh7yPjbY5Kbi/wHgVBCszCrBsfNaCXi/9/SI4vKH/2
         6i/gZUntUsRy6uhy70wMRU2cYWacOp/Lfzx9fn2QPvD7CH53sCXGaYwhOwDdzvsuUH3Y
         IAnLuQ7Qhz1VPjrVr0T/v1ird8Aii8IjKIJGVFwX/6En1Fyp2O2+SE8xFRs/xfTIbJ9E
         yaADBIJLs4nkkXqpxiYPN8FxYpvsDxuj7Y+E5pnrS7a8pOFwrA45fqNQRffM9ZnBWate
         EKOnDJEXjRAaJRtY/ZEFkGcq+f7SNYHWoli1T77OTtlRj5jl7TT5oZWh1FXWKKaXEinf
         c4nA==
X-Gm-Message-State: ANoB5pm5BopU+2o8f8AvrypPMRauYHg7YwOwTPRN9Jts5pMHE0s6IvQY
        AAHh7YCYAGuDYTauPmhxxlxmIQ==
X-Google-Smtp-Source: AA0mqf4lr/mGSjU8QsCMm+HChH3211vl5JOKt8EuaZDBBHJQjmbqjp3DrpMuS+qmcLkLrjWxQjk+4w==
X-Received: by 2002:ac2:4f05:0:b0:497:aa48:8fe7 with SMTP id k5-20020ac24f05000000b00497aa488fe7mr29383228lfr.612.1670147249756;
        Sun, 04 Dec 2022 01:47:29 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b00498f00420e9sm1706703lft.194.2022.12.04.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:47:29 -0800 (PST)
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
Subject: [PATCH 3/5] dt-bindings: mmc: sdhci-msm: cleanup style
Date:   Sun,  4 Dec 2022 10:47:15 +0100
Message-Id: <20221204094717.74016-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Drop unnecessary quotes from $ref.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 2736c9a79f65..9e7c0e3803c6 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/mmc/sdhci-msm.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm SDHCI controller (sdhci-msm)
 
-- 
2.34.1

