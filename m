Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540F7C43334
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Jun 2022 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbiFCJt4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Jun 2022 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiFCJty (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2022 05:49:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D51EAFD
        for <linux-mmc@vger.kernel.org>; Fri,  3 Jun 2022 02:49:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er5so9432915edb.12
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jun 2022 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcskUL/YxKVHi0SJFnrMIlY4WGD3EyAiKigPR2KkRlY=;
        b=KmcNPkMHLYTQ2u4xOEzuAGzAw2BxerOp2EFO6RYMwuwAmhs9YMA9jiTMXFjdrn8B0T
         g2xc+bEd3wnfdop23wye+enxPlHLsaOhEcT1CqK5u1aOj7Cz93J2d/af8r++8M5vBBT+
         hHb6OsaFUEn/2XlkOA3e34pI0VN8UZwE99OBT2EkiQaULud/eHPWMH5umlI00c22ovGW
         MEqJ/zQXCVu5OmAJiO7udpON2xZmTfItLSe/khzE7N2ne4e4kF9B1lGPoynXMrxVsZwb
         Xik/WNi5QCCD3WfyV63eW3BewDT7q4lGVUY7+nVzVeFizOY4ircRhWHdrjTiRt5zn14H
         qPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcskUL/YxKVHi0SJFnrMIlY4WGD3EyAiKigPR2KkRlY=;
        b=JY3dYybReLr0P9h2pTc5kzbwaDD+0KNVGAoiAPiSMzUh0XqV73iPiik9g8MQzMKFt6
         zoy0LvIT13T4DtfczWEb4nqTD4f79ubXEChcednWkMZw1eLULuZPzsfe4hx5A3ZrmDp/
         GacfuZHtDJUeJVkNJHcucbWE3O54PnbzEIvZofLQFY23hdi2wvo2C55sR/k3BWXAZx4d
         w8tVIcrCvHdPWcbwmIdmG2B+5QN5aN5q+Rh0Woz2v2AVclSocg1TRGuHt1W6OVK6Q18Y
         S5wXmj9CujtKUGbQe8C/hKcYon+YtBwIUcN1qC4ENOKQviOmShD/PYqxlWSGglySLZ+8
         oB9w==
X-Gm-Message-State: AOAM530uNYoagj3ku/d4d0P6GHPhI8B5Lq4SvKpgL6GrepoPL5gWwsxO
        XW2Hs4VxdPhvfwySzyU29RGEsQ==
X-Google-Smtp-Source: ABdhPJw1mLgVG5DL3JieRuG/BBYBbsC2SOMvJFC0jlKl5g39mhNigbnuF55FhOi7YLa8lAqCj3fVKA==
X-Received: by 2002:aa7:d758:0:b0:42d:b3ca:d647 with SMTP id a24-20020aa7d758000000b0042db3cad647mr9837164eds.63.1654249791585;
        Fri, 03 Jun 2022 02:49:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y22-20020aa7ca16000000b0042dcbc3f302sm3669561eds.36.2022.06.03.02.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:49:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] mmc: samsung,exynos-dw-mshc: convert to dtschema
Date:   Fri,  3 Jun 2022 11:49:43 +0200
Message-Id: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I will take the DTS patches via Samsung SoC.  The MMC dt-bindings patch
probably via MMC or Rob's tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  ARM: dts: exynos: align MMC node name with dtschema
  arm64: dts: exynos: align MMC node name with dtschema
  dt-bindings: mmc: samsung,exynos-dw-mshc: convert to dtschema

 .../bindings/mmc/exynos-dw-mshc.txt           |  94 ----------
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  | 162 ++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi             |   6 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |   6 +-
 4 files changed, 168 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml

-- 
2.34.1

