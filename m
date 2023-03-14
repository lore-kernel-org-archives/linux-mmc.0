Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB631C6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 12:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjCNM7Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 08:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjCNM6z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 08:58:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24800E04C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 05:54:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r27so19852121lfe.10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678798387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MiNq49jj5N76vOjmnLvIQjHj4KSRTiJUui/5+4fP1s=;
        b=wdJzO3UEjmyr/ATGQDkJ0xfndGvOpq/ViTdQSAvDC2mPNnu2nrDobEXXYTGTnxGMwJ
         fk70CemObsJEZQsuXubgHB7fzAG89tftKlJN1OggT3kFx7/ZyjeWbfX9sl/1sF2BEpW6
         V2B+7kLPx4nWwo35rIbnrZYPruMiVbvgP2BZoXWmQ0zotX2iSfZ1uLxB6+IDgX1knr0E
         bDLYs1ULZsJrLhzuT5iobBUw0ab4tMmAUGaDnmoyAf61CY5XqxEy+KkArlOPIK9le92r
         NmA77gTRMY/1hyvji5zOcN9v7aca/YcCzxXZjgeV2CDGBz6uYSW4f6L48/mcrLlIM6eG
         3eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MiNq49jj5N76vOjmnLvIQjHj4KSRTiJUui/5+4fP1s=;
        b=54nsdUy3xyqj5b2HtQQdjK55oU+kGP+9WQdl/rCDE2HpCuMW6BEQB9cTIdU4gVbiK+
         Tk5xBjH1XVAluXO7fR/GQaeXlsIbL1Gf+mKPqbIS9WTGRAaJJTYRCYKLulWCNKvW0nBS
         iL4bxZieU5n1xhJzjRG17K95GS0cA3FOcyD1+q+8iIpA9NbvG6o1+XnJGyRrOt4d3Pn2
         JqRXabfUFm+R1wvHhtI3EjFoJwGPfRiI/EP9CoUYTfkPo03/G3lH2qxoajWizrGOZieU
         s4p6t623fXc8KPAj4ul9FEExEbTbYTP1ZbJZXbhfWAr2rjp3lYdYsjLGK/7I3gTO36fb
         PntA==
X-Gm-Message-State: AO0yUKWVuaLJVbpBgZ+91MwhDlgk4f255sko3m9hG00sFDyGWjw/rxMW
        gk+Ztk8MW9UqA8V1372tTTZ+lw==
X-Google-Smtp-Source: AK7set8VKJrgRZQmRB5O8ZRHtIgj6S97HoqVRdvQ+bdeVt0+Ot8plS+62FwVZz74fIgpHE6Yl4Y7XA==
X-Received: by 2002:ac2:4354:0:b0:4cc:73ff:579a with SMTP id o20-20020ac24354000000b004cc73ff579amr609441lfl.38.1678798386805;
        Tue, 14 Mar 2023 05:53:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] QCM2290 compatibles
Date:   Tue, 14 Mar 2023 13:52:55 +0100
Message-Id: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACduEGQC/x2N0QrCMAwAf2Xk2UDXqTB/RUTSmLnAbEszRRj7d
 4OPd3DcBiZNxeDSbdDko6YlO/SHDnim/BTUhzPEEIcw9EdcS1XGGMdw5/KqtBqekvB4pkkkBfA
 wkQmmRplnT/N7WVzWJpN+/6frbd9/94JWunkAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=1135;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IVVr6i/KawvLqgguv8RbQtO5KAqHsyGmBYNRJ1zL87s=;
 b=W0b4hLXBOA8niOLA8fKdilzR5RN4jcIicLpxxMuwCxGKwdtorkzQeCG0KRkBUbfGtPhGN+20WiF1
 9tOrl1oNDvSI33bPrrkLp5i9LoYhpz7RyDAT9iAeJDJncuAa08eM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document a couple of compatibles for IPs found on the QCM2290 that don't
require any specific driver changes

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      dt-bindings: watchdog: qcom-wdt: add QCM2290
      dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI DMA
      dt-bindings: nvmem: Add compatible for QCM2290
      dt-bindings: mmc: sdhci-msm: Document QCM2290 SDHCI
      dt-bindings: usb: dwc3: Add QCM2290 compatible
      dt-bindings: thermal: tsens: Add QCM2290

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml       | 1 +
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml      | 1 +
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml  | 1 +
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml      | 2 ++
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml  | 1 +
 6 files changed, 7 insertions(+)
---
base-commit: ec0fa9a0a6fac454745c930bdb8619d0a354bac9
change-id: 20230314-topic-2290_compats-5bec96afeeb0

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

