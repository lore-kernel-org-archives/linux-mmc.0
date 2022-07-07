Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F3CCA47F
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 08:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiGGIEm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiGGIEl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 04:04:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317F3137A
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 01:04:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 19so407172ljz.4
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 01:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6cTL70t81aTnV9x0x+mDaCfTVWwcqwkSWQQpbKRysc=;
        b=je6ZJ8G24GI5T7f3zVncXY2R3x/GyryMMiZeWydkL5djDwH1y3R7eh9Jq7GZ+VjSmb
         a+eZLklX94jyOz1YD9eehlDaxgYhFP6qzL8qeUH37Tl8CnuJ36fytFm/LKbEq5ghCWY7
         52C6lpBA/LauPnoSxudh+wPUKILLcfTJMzWPlgNch+LCoN5IgLz2Ehm9S+caQ5g3MFfv
         lfFYLqzsKAOcxRUzYSGYFwsSx9YRZZcaNuffd5QCnza1wOsBnwCksWBuR8uwRT0ydprz
         tl8NMIphq/6HsC8d9JJPNgkNAqR+qMtNZJQSjeh7/RRcJbvchImmlZUiQ7Wr3633/+3q
         N/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6cTL70t81aTnV9x0x+mDaCfTVWwcqwkSWQQpbKRysc=;
        b=j1TvsAsGjqKxU93G6WI9IvUJQUYzxOSrvcYsgMfYzCRBhUFCcac/W1PE00XMCkrH5u
         8CaNzSa08HYnoQNit9s+xULRMPvpl5Bk/5uORglZ4BXvET8cRrvfbM7GN0DQVln0ROlf
         WyJEJ0XLjMuLERNry1zkC4p8cNa8WSLo1aCxADPgbx/ppSTJuijk+0U7SzZ5LibZFKoJ
         w7Q9L8VsDT2nFa3YVncZGTLwcqXUNyVwtvyGRwA9p2/eIxQI03+PCdjKy7UO3wSwp/EL
         QCvNPn/nUXia4gZe1h4q15R/4qYQHbbunoO1gL4NATfXwwxfGYQzXlhpBEllAsVTojjt
         7Nmw==
X-Gm-Message-State: AJIora/SejFq9r0+/FnF7+0mLdXrqBCU6mpHzjiJqDqTtYTGaU5ukSmI
        6YsV5roqec8GF3ezaCKiNlHZyA==
X-Google-Smtp-Source: AGRyM1s/K+WamhzckF/8xnMBEQZ4YAGMlkNm4IeBoow2nLBL8pH0v4jvCtU+LTl5jPsnxiMxi2PgOg==
X-Received: by 2002:a05:651c:511:b0:25b:f78e:cb30 with SMTP id o17-20020a05651c051100b0025bf78ecb30mr22584914ljp.327.1657181078252;
        Thu, 07 Jul 2022 01:04:38 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b0047b0f2d7650sm6697187lfr.271.2022.07.07.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:37 -0700 (PDT)
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
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] dt-bindings: mmc: / ARM: qcom: correct reg-names and clock entries
Date:   Thu,  7 Jul 2022 09:51:46 +0200
Message-Id: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

No dependencies.  DT bindings patches are independent from DTS, so they can go
via separate tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  dt-bindings: mmc: sdhci-msm: fix reg-names entries
  dt-bindings: mmc: sdhci-msm: constrain reg-names at least for one
    variant
  ARM: dts: qcom: align SDHCI reg-names with DT schema
  arm64: dts: qcom: align SDHCI reg-names with DT schema
  ARM: dts: qcom: align SDHCI clocks with DT schema

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 40 +++++++++++++------
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 16 ++++----
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  5 ++-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 +++++------
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 24 +++++------
 arch/arm/boot/dts/qcom-msm8974pro.dtsi        |  6 +--
 arch/arm/boot/dts/qcom-sdx65.dtsi             |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
 13 files changed, 77 insertions(+), 60 deletions(-)

-- 
2.34.1

