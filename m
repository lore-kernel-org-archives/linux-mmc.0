Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE7EC43217
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Nov 2022 17:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiKOR2j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiKOR2h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2022 12:28:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4D9FFD
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2022 09:28:36 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k19so18455399lji.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2022 09:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liGvN8jbPDWPFBcKz2XKooL1E4NpfbDZme1QvgIlf+k=;
        b=aBh56Fch88bdtMiVczgOaevciiG2Ou1kl90Wi+0Ms9XJS+qjcYTMjQ0pLCoWeKCKdA
         d6qCTj28DcHhHhKJQxPswcE3OCQp55Mhbqy3YMnmc/NmX3lKydBG51H4fBNeFofo/WSR
         bBahM6bblHtU4cEhYFdIMAOyvA8Eg1saD68BoortJwnGcl1Eul8MAaaYW0f8xcogEKYu
         0yn6w07XfD3N0vGMLMlALT+KoX0sskCAMx3o65l7SwaAngi9UIwpfwNgeWbmSbbo7pUb
         41TU9sdiFPTB3TtP5MXVsj4kdWNko/+s6gSMQ0qW8bB7UUMc9l/2o7AiycGlm/OyUSFe
         Doig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liGvN8jbPDWPFBcKz2XKooL1E4NpfbDZme1QvgIlf+k=;
        b=7f5vnfFZDeLdiKSQ4mZYR1zHLVJJ+XQzPwo7u1PW+qdaC/UC20q614PyxgbGGFiD2U
         Brdia+3bTku0XdSs5M62T+aZtHs8Gpj74GXlZVviNiD3enB+Kn8/AAzDqILsR9GS4GQo
         mAd4P3rqAq8AVe0SijRgFvp/OQo03rzXCaeN/Wioqw54llQc7vfv/rbSENO38/mLnJ0D
         6HLj1ViiHhcucL3/sMUC/aohHoxJdTMQVyUB1X13Hvq4NvQaKZFD9XhA8/SQwKlQaFBG
         oK460Uwvr63RkmfsAu06KouqIGN/qHnOUhVdyGGWVEqfdlomT4TbXIbKEXjgmzX+iaFv
         l6OQ==
X-Gm-Message-State: ANoB5pk1aGnBO4H16xIpHoxJG3QgHEIKy0km2vzBJa+08fO+MagsJ8nH
        3K+hieDkJXBfmh61eBrjmVmxhg==
X-Google-Smtp-Source: AA0mqf7kFYtoShG3Ec+K7wsHA+5VGZ4wbmkF5LBpCHRy/fXgPLFgn6vfYqCmvLICUQhXL/933z6vUA==
X-Received: by 2002:a2e:300f:0:b0:277:7eef:1d97 with SMTP id w15-20020a2e300f000000b002777eef1d97mr6815192ljw.516.1668533315312;
        Tue, 15 Nov 2022 09:28:35 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id b42-20020a0565120baa00b00496d3e6b131sm2261511lfv.234.2022.11.15.09.28.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 09:28:34 -0800 (PST)
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
Subject: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document SM8350 SDHCI
Date:   Tue, 15 Nov 2022 18:28:25 +0100
Message-Id: <20221115172828.14372-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the SDHCI on SM8350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 12def0f57e3e..31dfaff0048d 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -49,6 +49,7 @@ properties:
               - qcom,sm6375-sdhci
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
+              - qcom,sm8350-sdhci
               - qcom,sm8450-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
-- 
2.38.1

