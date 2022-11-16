Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B557C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 10:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiKPKPz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 05:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiKPKPd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 05:15:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94142B62E
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 02:15:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bs21so29103858wrb.4
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 02:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFNBqUbq7QtJBrTFvdvHZDXMUJZQ6lA9hFG9lR0t9+Q=;
        b=EronlhrHxpZss+/Nij6KcTtyp8A6x7b6YP/pXKReUcgy4hEcDUH2YkNvOH4YPIInVa
         bcMaf87KToLk8RI8N9e4YCVGWkcotshZZjYgHvb5Qs1ABk3gXGbGNuxkWGKsHr2F/yAv
         vQ8HVsYfTnfRUYxp5C77jmE7w+WddGZwUP3NI+HI2STQWv1DtJgDPZhAZHLGVNtLlxiF
         B7klhlWB8ZxhqstTZr2hY3mslv1kipyOeaXiHVlU5Rn5Fmbx1Rky/Q7lTzLYCQ7oWFkx
         T3z9rIlPcNiDyfaWTKyE9q9GTO6JUhtTEdqe8eY5A39Fy05eFUMzJ0kX0gJzLFdPqaNE
         5zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFNBqUbq7QtJBrTFvdvHZDXMUJZQ6lA9hFG9lR0t9+Q=;
        b=X2I2xy5IUY+R0vSAZZtdEQNBboDKR0LbMKBQvINa6fk/PxgJq7xsXkIFFTUzQ+ZqCs
         YJ3KYiebR3LkVNWEV6legqOeOUDYlsq2h0tl0U2Be89hsV4qPCxW2PuSDvd6CmLRTBDK
         Alq1BkX6wSq4QHa0yjMOUthgeb/hZT1Va23yvBZzIAlP7+QBoyW2Qx4liGl/XaJCrOzF
         ocClfa+c7Vyf1t1148uNbRifXqDct3Csskal96YoVxxKyTx+NZMIDauWsD3qNLbWZcPq
         8zvW+vrjb+WeWJg1gJ3FrpQ9k9xqK0/KnSsH008v3/3AKtPUFKc6G7PiajNIvcFNFVze
         Qewg==
X-Gm-Message-State: ANoB5pkJ2c8YfDhZxjdE4cw8qzI9jN8oKP6G2D4l0Cmx15xQlvMcP+bs
        CYOfPBsz2nbbIFyKcRmH9mbPxA==
X-Google-Smtp-Source: AA0mqf7lEtfuHhZttiInCJa3i7vFKG84cjr+0N93WM/sR9X8A3fops/U1IJS2YSJlTTFA38xzfW7qw==
X-Received: by 2002:adf:dc09:0:b0:236:7180:6ccc with SMTP id t9-20020adfdc09000000b0023671806cccmr13581889wri.573.1668593726318;
        Wed, 16 Nov 2022 02:15:26 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b003cfa81e2eb4sm1718366wmq.38.2022.11.16.02.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:15:25 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:15:24 +0100
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: Document the SM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.10.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Document the compatible for SDHCI on SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc8a6b345d97..f0b7e6d0ecbf 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -49,6 +49,7 @@ properties:
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
               - qcom,sm8450-sdhci
+              - qcom,sm8550-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
   reg:

---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-sdhci-1ae5ac4924e5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
