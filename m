Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC12C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiGLOnC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGLOnA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 10:43:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C296BB7D5
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:42:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n18so12602433lfq.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duo15aJQ11HVOFnF0u0+cfPbWBklkXMRH+jQvhcfDM0=;
        b=W2+TJoZL15WjMJkW5SsQPLZXpaZePymWoty4EwF3TZbktoOiu1oZPeMbtFEtHe19QJ
         e9b8dgtWv4fGxppHggk3KEa3VLczIcJdIad99jGM3y6R7LPWIuB4yEM5Dp/TC+SpncmY
         U4VnwLoo2Mujm3raxn3ml075Af48QYckFEKp/Vr2X/HCRlugUG2MaFLWt6P7FQY3449R
         Hne4eQXbM0YXnsx4uTZsM7HL4TzOS+1WP9UHxuVm8kS5NBd+95f8RxFoalgBUtWBmev3
         egRzYdsGON2qSd7LKkNVLWvBepKpeJTV7EOPX0GKaIQOT4TX0wNuCDFrQAhi6gTMBLx4
         asFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duo15aJQ11HVOFnF0u0+cfPbWBklkXMRH+jQvhcfDM0=;
        b=hSW5pAJuYMcGLLeB7HBEwdSTL7734uQ9zZN4Eu2SCO1k1T1jpQlTZrtDgQLOT8ujQd
         675MyhSCrshJxb/hhk0CwycfSUA9j1QAflCGmNXdKrEmXdw4rOQRTaydCOuvd8v2q+wR
         ed89cLIsiX5bUUVtf96xtuSeYTDJbofypULPLXIGqLcKHT0e495+V7BEDtueXogp650/
         NAaBL8cg0AOZInapxoYROmCJfSW4Vqh+sho5k47uLzWfyKZo9fkJHBkbHy8sFUTz426f
         4H3H1FWRdqEUW9h8XqszUTdmCiKMBfVHJ3TYUAUKNSVYxyCc8a6dkzXFfjYjbdsKN7YS
         UqTg==
X-Gm-Message-State: AJIora8Q4Ybu4dcIgtF/3IUIau4LsfVJ8mUfzDluS1JMkGFir2poTL6G
        taplHJNCTBJOE2HQVSFfgb3WUg==
X-Google-Smtp-Source: AGRyM1uv/sWosfiNGc4Z3vNfnR7RVSVKABYb7xResLOIpsGi9cEr3Rl8/H2Bx7x3+kYsHUZGoHcOJw==
X-Received: by 2002:a05:6512:3342:b0:489:e36b:60e4 with SMTP id y2-20020a056512334200b00489e36b60e4mr5896293lfd.674.1657636976614;
        Tue, 12 Jul 2022 07:42:56 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b00489e88d6a72sm737577lfr.198.2022.07.12.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:42:56 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/5] dt-bindings: mmc: / ARM: qcom: correct reg-names and clock entries
Date:   Tue, 12 Jul 2022 16:42:40 +0200
Message-Id: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

No dependencies.  DT bindings patches are independent from DTS, so they can go
via separate tree.

Changes since v2
================
1. Add Rb tags.
2. Correct typo in subject of patch 2.

Changes since v1
================
1. Add Rb tags.
2. Rework reg-names constraints according to Doug's feedback.

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  dt-bindings: mmc: sdhci-msm: fix reg-names entries
  dt-bindings: mmc: sdhci-msm: constrain reg-names per variants
  arm64: dts: qcom: align SDHCI reg-names with DT schema
  ARM: dts: qcom: align SDHCI reg-names with DT schema
  ARM: dts: qcom: align SDHCI clocks with DT schema

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 16 ++---
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  5 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 ++++----
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 24 ++++----
 arch/arm/boot/dts/qcom-msm8974pro.dtsi        |  6 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi             |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
 13 files changed, 87 insertions(+), 71 deletions(-)

-- 
2.34.1

