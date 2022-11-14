Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E643C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Nov 2022 10:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiKNKux (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiKNKuw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2022 05:50:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA81A04D
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 02:50:50 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id 13so27354359ejn.3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O82IdtMN4gU2HPdWYJ4k/Ae4A8assTn2dDMpMVtowGw=;
        b=txB1X4GT186dmbeGXeIIwIamZIk2UtUpnIl9NptygNxW0hHhi8FeNkijyxN7OvDPu6
         ++YXt0DR11UBd/RSStujeTgzhiB21mBdDRsdsxJl5MXBJlArSj0m8V0NqJoWyPDNkcmb
         AObqiV9lKX0bB3k7M9c3+U2T2gNgL+7qAyZDuMm1OvqBnZzFGcktGYUQMMup7p1cN+zm
         qbil9d5nOG7Ebsl9KG1foKZNfZKAAEtgiA5OZcWWXuqLsUXP3gY23BleZZuNs0pO9kNU
         lg5RnmC0wQgDObRxj5H6RunNTwEyMgocfKVEQgXQU4cROkqO8PpZaYLc4vqBaqKNd1gb
         TUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O82IdtMN4gU2HPdWYJ4k/Ae4A8assTn2dDMpMVtowGw=;
        b=wbIwysStwg7cj7AbErBYgC9kvuOyzsKomBVl259/TzPqu2hcGMigmLcrdrUl986BlK
         s2uleC/hFBkSdu/1O3Ut1duezLBwaQv19YA1odz6gkRGuUoS7Lgl6TKfPylGhixvO72C
         qnVPUqXGhDi/V2R22jrhfA/MPtMwj7aktfGEpb7S6GlqgZsvezv3imXLhKp3Vpg42YTW
         0JlECrU7hhk/h9ZWZyet+ZeZ+uGd1Zjo+942Voq+GwQbenTEnbYiaVrBPzDpZQUSDkNS
         LCHZnsyH4mtAE2ndKdisVMpK+cB8Bz/lJLVeeH7MrymeE7BYTfBQPSb8s47cbkrAta05
         TBNA==
X-Gm-Message-State: ANoB5pkA72sjPIFD3WcHm2hkvofHBV9tjnNLBRx902OrCPSJxgJ5c3oh
        5LqH3IlsBxI81VtVnNvUnc/Q9Q==
X-Google-Smtp-Source: AA0mqf4DhiiUYgCZoIx6i3TSrYBciP3BDWtYhM4xbTCH9ibd42LoFFJte4VhLeXdm8d6RN5wXMDzUQ==
X-Received: by 2002:a17:906:414d:b0:781:951:2fb with SMTP id l13-20020a170906414d00b00781095102fbmr9849462ejk.64.1668423049581;
        Mon, 14 Nov 2022 02:50:49 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b007402796f065sm4037053ejc.132.2022.11.14.02.50.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:50:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: mmc: sdhci-msm: Document the SM6375 compatible
Date:   Mon, 14 Nov 2022 11:50:41 +0100
Message-Id: <20221114105043.36698-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114105043.36698-1-konrad.dybcio@linaro.org>
References: <20221114105043.36698-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the compatible for SDHCI on SM6375.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes in v3.

Changes in v2:
- pick up rb

 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc8a6b345d97..12def0f57e3e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -46,6 +46,7 @@ properties:
               - qcom,sm6115-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
+              - qcom,sm6375-sdhci
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
               - qcom,sm8450-sdhci
-- 
2.38.1

