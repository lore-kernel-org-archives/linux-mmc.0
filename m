Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA38AC6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjCLSVB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjCLSUn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:20:43 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD3734C14
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:13:26 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id bp27so2684986lfb.6
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678644645;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=PBtszNtCxKGWRKYQQJfsSTR8sim9jfDrP5gXHzPSCHxXcDzYiUOSV4yQsSSshpVjp4
         hc3ettuojx74iXJDL2yw3qCDHh79p+ctVfR+L3AmOpZriYcFIH6uHthH7PaBq8VXiqG2
         IkC/gZNqAVnJHmgf8h8iSIjXS4tPb3wtychQ9rDjKY8x31F7ss5+S/Ux34wpOHbi1yAA
         hJcmn+RrnE/hv1bii1XS8wrvz2SZuuNOlaOsQUxYSVqCeyRsskYxsyS/ZSd6Sz/kK4Ua
         cbng/XEukVSHpwD5kLC7vJ3HX6s1GpRKq6PmJOPRyzmrTFOkiNXMc9yaUgRb6xkMPX30
         bWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644645;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=mzUnWPwyyjB4z1Tt21GbCzh6R+bXjFWdZeEsW+M5PSk/+P4/e/TUpCuFmMmEPZ0sl7
         0pZXrrLRr4DJCf4LhdQHpLh9XR4Z6JMT29FzMlHEaYhXlm7yDuh7mZV3620fg2hsDVSN
         5tO1oi64D8H60ZCWYOOUoQqpVa9q2Euxv68lH1v6zaEtlKBngVRTq11HXTrJO67WG6oE
         u6aziV9IJhDkFtxGtjpBZZRg1/aS3k1AfuwwLCPS3OM3bmbVu8fCQjvZXQGpSwsmO/wR
         /RdQGj3sKLP8z3iJYcoy3SXwFKS3yarqe7m/IKKyaDNsQkXQ7Dw6OFxxJrybBUbOYpS6
         /YEQ==
X-Gm-Message-State: AO0yUKU3KN0ntgL4opz2NT9Rtird+GegeCjczIKDsyGOaePrVCZoTq9O
        Cep2dVpL20iExLCG5aFeRtKLpDYYLXtFAbu0
X-Google-Smtp-Source: AK7set/IiI1C607Z3rQ3WZBYI1U5VrJYLd14oT76ax3jFVXkXMjF7FPMmfpY6VPw6DjZAibNaPS36g==
X-Received: by 2002:ac2:510c:0:b0:4cd:7fe0:24 with SMTP id q12-20020ac2510c000000b004cd7fe00024mr2606748lfb.27.1678644645549;
        Sun, 12 Mar 2023 11:10:45 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos7885-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id w16-20020a19c510000000b004dc4b00a1f3sm720684lfe.253.2023.03.12.11.10.45
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:10:45 -0700 (PDT)
Message-Id: <1678644516.665314-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678644516.665314-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 20:58:50 +0300
Subject: [PATCH v5 1/3] dt-bindings: exynos-dw-mshc-common: add exynos7885
 variants
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some Samsung Exynos boards using the arm64 architecture have DW MMC
controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
systems the 64-bit FIFO registers must be accessed in two 32-bit halves.

Add two new compatible strings, "samsung,exynos7885-dw-mshc" and
"samsung,exynos7885-dw-mshc-smu" respectively, to denote exynos7885
boards that need this quirk. But it's very possible that all
"samsung,exynos7-dw-mshc" boards are actually affected.
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index fdaa18481..3eebaed2c 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -22,6 +22,8 @@ properties:
       - samsung,exynos5420-dw-mshc-smu
       - samsung,exynos7-dw-mshc
       - samsung,exynos7-dw-mshc-smu
+      - samsung,exynos7885-dw-mshc
+      - samsung,exynos7885-dw-mshc-smu
       - axis,artpec8-dw-mshc
 
   reg:
-- 
2.38.3


