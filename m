Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC55C3DA6F
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Aug 2023 13:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbjHYNza (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbjHYNzX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2023 09:55:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D400213F
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 06:55:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso1402317a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692971720; x=1693576520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPFNeQZ6wVRfzI8X+CMFP24H+xIdOAmdyrQlfRbcMWo=;
        b=ZN01E7vC5V4lr5DN8gK8WHHWia8UvZTCNZidis4wfPTVeTWXb7LIUjOy2lUstg2QFL
         5GAg2aiShjUkSQK+8pamK94NEv+14WKP3TKGoCvA4s04POXDZOQ07bM8jTkNWPCLQGoY
         SWsNKpUONLJeLM0Zel0KZHHSgd/OC2bb/eka/nIgZ4q0zDvllFitZi/8m8NOOyaZZQUd
         kcmAthFH0TpQQWMESMcUQQ51C0EWAzsK7QnHzzLiak9o9vbiOTCXyuvBGia+Ze1Bd2Ze
         DrKM71kEzpn1GWokkIAhYGn9ktuS1TNBEsEGm4iN5+SUe/of73o5DcFx57RZFOlcNzXU
         qD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971720; x=1693576520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPFNeQZ6wVRfzI8X+CMFP24H+xIdOAmdyrQlfRbcMWo=;
        b=eYRHVkVe3v7Fcux+6rWASuNFYTzKTyHIV3a8xXQnOzwQkGMv3kowhOR3cNqMaeliw/
         JLwFzqwDd7e9P+MTLnH7/amX/NEaPKTrBoZchyGxUFAUaf6YE/zP8KsQKdmM0es5pyoL
         1j6a/BIOko00n4rTcV010SATgFzIHT6F/HBjk51bWEvWzUj3I0MDpbXOAXPRcEfrk2Fa
         e0yhiWcAilT+7Zs7NlK+x2EEmQdBbq94Mlf4z+PVCEnO6c8RUrUvuZx8BWySIDGcy0QP
         KistZY01vhTJS0KfQ3l+w3yO7lIZeNvGWh1h9aVyGovJ4WQVLEh6VCAA1QuVD1AV6DjG
         Wvww==
X-Gm-Message-State: AOJu0YwwL//9NUBtpYtKaoGvjxUfXxynodrHf28P/7uvVYYkXeJIxF0P
        YAKC+T3jV/2VgLxTl2CJgR8Vyw==
X-Google-Smtp-Source: AGHT+IFRV3jqjze/aOO11lTy2Fdk+HSPuP8nR7u8lakxQfGbHRcI9XDn413gGrhmM5E4cgTzI4fdqw==
X-Received: by 2002:aa7:c698:0:b0:527:60c:53d9 with SMTP id n24-20020aa7c698000000b00527060c53d9mr12929555edq.15.1692971719371;
        Fri, 25 Aug 2023 06:55:19 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7d615000000b005256aaa6e7asm1019660edr.78.2023.08.25.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:55:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: mmc: sdhci-msm: allow flexible order of optional clocks
Date:   Fri, 25 Aug 2023 15:55:03 +0200
Message-Id: <20230825135503.282135-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
References: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Qualcomm SDHCI controller lists optional clocks, but still expects
fixed order of them and does not allow to skip such clocks if further
one in the list is needed.  These optional clocks are truly optional,
so we need to allow the list to have different orders.  The clocks are:
 - ice: used for Inline Crypto Engine, which is actually separate block
   and merging it with SDHCI is not a requirement,
 - bus: clock for SDCC bus frequency voting,
 - cal and sleep: used for RCLK delay calibration and required for
   certain platforms for such calibration (as expressed in original
   commit 4946b3af5e8e ("mmc: sdhci-msm: Enable delay circuit
   calibration clocks")).  Only MSM8974pro has these clocks.

Relaxing the order fixes dtbs_check warnings:

  qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:3: 'ice' was expected
  qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:4: 'bus' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 10f34aa8ba8a..69a213965089 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -85,10 +85,10 @@ properties:
       - const: iface
       - const: core
       - const: xo
-      - const: ice
-      - const: bus
-      - const: cal
-      - const: sleep
+      - enum: [ice, bus, cal, sleep]
+      - enum: [ice, bus, cal, sleep]
+      - enum: [ice, bus, cal, sleep]
+      - enum: [ice, bus, cal, sleep]
 
   dma-coherent: true
 
-- 
2.34.1

