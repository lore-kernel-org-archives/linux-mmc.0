Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B13CCA47B
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 09:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiGNJKy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 05:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiGNJKu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 05:10:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB52B1BC
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 02:10:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n18so1791487lfq.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yas1EK+Lg1tB+k2/KKrOSpNmOwlnNNkyZMQY2cJgMdc=;
        b=vjjPOwMoQLpDt3HEOqYUUUodyCCgSNFmWzdk99MWY7QCQr7YwfC1uAEkoyX8kjaUzj
         oV5Vh3L5ox15ZxfBvadHW2p5xQEj7tX7+3E7tFzyb6fN/L5hR+ra1y2/7QlhlmD0pJp+
         XK7KjicnR3sq1sCUIRETdas1I9hRBj6oIO39moM5vD3tdhs/a7VdLUe//CbReO5UakEi
         bSLOjfQRUHyWwDoPuJUHjeSM+K/Or1yhMjI3gt+4oCXd31v+3P5jkHLRVi75OKQYrvjP
         dwcUJPlcVcLKZr8EAW+XDnr83SLWtIfFsQjZ98D2tcrA5aUJQe+hNmIhFm4IBQRFTJux
         mCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yas1EK+Lg1tB+k2/KKrOSpNmOwlnNNkyZMQY2cJgMdc=;
        b=Lcn/Lct8pM48T5Ga7kXyiXeMaA6UTXOPpvkKTWKJkOeSsGEDkmLQcvh7mEKHAZW//A
         hkkkR9k+xScwfLwDfFllH5BddtT+uiOwA/wp9WOUWOBMCvYXFs094Wv7D1rsDi/UHFDn
         PaOIrQ4PL7voeVg3hELKxM4iQU8sd1jL47LYoRQ56VljOXwXCNeUKXYGu4ge2LR0zL77
         g0Z3qrw+fNPSlDagS3jV505GODUBujSonrSOADIcT63Fd1UBx7miI8k81MyMDSKqylil
         YDbPjThpHivoCIzXeIcNOF1sUMLLyoNPlnWDWIs9hphrFua1WBB4MaU4+9MKEaS9Mm4g
         8GSA==
X-Gm-Message-State: AJIora9yEwfkkj4IyGZ3GRMZla2xs/fTaLNT73fZw6BdjBeC10PFUxKd
        O2/U6ukRdpEVO7wR7lTBvvLOXA==
X-Google-Smtp-Source: AGRyM1sLJwQoozs92CJqWSGGa9WPh444ya80rvOJn8Q+ePhAzDhHUOJKjery6nvv8cgsM1CQ+4xNbA==
X-Received: by 2002:a05:6512:3ca6:b0:489:cebe:a944 with SMTP id h38-20020a0565123ca600b00489cebea944mr4534921lfv.387.1657789846824;
        Thu, 14 Jul 2022 02:10:46 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004790ef191e3sm250006lfs.216.2022.07.14.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:10:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 0/3] dt-bindings: mmc: / ARM: qcom: add MSM8998 and cleanup driver of_device_id
Date:   Thu, 14 Jul 2022 11:10:39 +0200
Message-Id: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Rationale/background:
https://lore.kernel.org/linux-devicetree/CAD=FV=WGxQF4vPuRi7kWKoqTpe0RFsgH+J82C=sQbmncK_AFpw@mail.gmail.com/

Changes since v2
================
1. Add Rb tags.
2. Add a comment to SDHCI driver to hopefully prevent re-adding of compatibles
(suggested by Doug).

Changes since v1
================
1. Add Rb tags.
2. Rework driver patch (now last in the series), after talk with Doug.

Best regards,
Krzysztof

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>

Krzysztof Kozlowski (3):
  dt-bindings: mmc: sdhci-msm: add MSM8998
  arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
  mmc: sdhci-msm: drop redundant of_device_id entries

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
 drivers/mmc/host/sdhci-msm.c                  | 29 +++----------------
 3 files changed, 6 insertions(+), 26 deletions(-)

-- 
2.34.1

