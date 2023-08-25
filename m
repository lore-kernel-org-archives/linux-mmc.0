Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E58EE49B6
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Aug 2023 13:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbjHYNzb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbjHYNzW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2023 09:55:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BFF213D
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 06:55:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so1466029a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692971718; x=1693576518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4OQDi/sFthYDrzyBFtYWst4OZy6IfZiLAmOykugLGc=;
        b=VbIOoeFjX1650zgbcbcJkTrwyzmUHlArVvfCWsJv2batLsxPCO5RBOJQpwpx09DC5H
         qETI1jIlm/k5Hs79WLxD/xiuy+Kx82UL676gRPwRpq9hyK+mErKI8IgkM1Ab2gxJ7tmI
         iu8LJxVt+Y+ZRCzQv6T2eCAv/ljYj/JV52kkU8Q1APv9LyRkhYEVpsG1sbEM5eoaCQLz
         WPuFdYq5vPfDUFL/sg9Pj4bfDHjEKDt1nVdPcgd5DcVuH0I3/wxZewumtSDltzQfwrEr
         NeG3TRQq2lFKka1ShA7rjrFVzQdEFqEfk2MRYyRMqXh9Bh6Z1Eie+9CdFBc/0t3atYB7
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971718; x=1693576518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4OQDi/sFthYDrzyBFtYWst4OZy6IfZiLAmOykugLGc=;
        b=I1ch9oPvfSODZRdxaJ7VqGp0jZM5U/R6kLJ3esy3vyydYqdIR/UMSjEGHo3FgV/s0Y
         A7M+pOZHG9+YBEyf/kypcyfre5UV6aJNoGuygWyVr/LW2E+OOKHRuUcA4vOcs0EUSW9/
         +tWTV7mvo/nnt3UrOW4ES9P4EFtweVCGlvgX24596WnnihopVRLujmTVt5QcBG6Pjdft
         HWK2QqEC5VWa+Yu+4bsJVKm6/fYiEgIsIH9nmSDKpHGIOSkAYNKK8aWk/fwaCB7o4R2d
         Oz77PIhN0FQVVM13jtgA0YEWPZS3GjkpA1zyy/UwfCrWEFN0OrUJmVklgIscpOB1FjBb
         6/Sg==
X-Gm-Message-State: AOJu0Ywa2Mpa+GmDId7RiTr8g7/U6eWUDNJnU0tjg4aKf75SriasgZmL
        H6EayRU5sufTz9xM4/RToSb5DQ==
X-Google-Smtp-Source: AGHT+IEkq63It/ry4mHQBYS8/cIH56V4AtHcFAdvj4JI6BUGBIs0N+ChYGqXiI/ZpYr2vi7ZdEq1pQ==
X-Received: by 2002:aa7:d952:0:b0:523:ae0a:a447 with SMTP id l18-20020aa7d952000000b00523ae0aa447mr15361501eds.13.1692971718331;
        Fri, 25 Aug 2023 06:55:18 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7d615000000b005256aaa6e7asm1019660edr.78.2023.08.25.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:55:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: correct minimum number of clocks
Date:   Fri, 25 Aug 2023 15:55:02 +0200
Message-Id: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In the TXT binding before conversion, the "xo" clock was listed as
optional.  Conversion kept it optional in "clock-names", but not in
"clocks".  This fixes dbts_check warnings like:

  qcom-sdx65-mtp.dtb: mmc@8804000: clocks: [[13, 59], [13, 58]] is too short

Cc: <stable@vger.kernel.org>
Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 80141eb7fc6b..10f34aa8ba8a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -69,7 +69,7 @@ properties:
     maxItems: 4
 
   clocks:
-    minItems: 3
+    minItems: 2
     items:
       - description: Main peripheral bus clock, PCLK/HCLK - AHB Bus clock
       - description: SDC MMC clock, MCLK
-- 
2.34.1

