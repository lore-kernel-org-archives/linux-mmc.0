Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B1C74A4B
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 13:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCLNKt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCLNKs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 09:10:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256046149
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 06:10:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t11so12449252lfr.1
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678626645;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tDIef+aPGuB5wQknGJ7abVMxEUnE+NE/6MUxxwCrbfI=;
        b=pwjwvhewwzQOGqI2K3Tqc7LxSiEHSIcstRvb3Twy/gCLKI7hlDm8T1Skpe/ZTJfnmj
         mMh4z3qNrf0YDLlG/S3pVkALJSWLxXPUzx85Hsjng+3e9QIU0nffVFKAaLbHQiNgvTat
         82k8ngWcq/wxvc5PdmG84oqUJYN8uDD+HCZzH0j4JA6u3eX5pWwyqGtkQNqUOkOlDS+K
         TACcUV2A38z0t1htRQRoLQ90XsENlHsCXO7j3HXI8mhxzRXLtkDhu0pq3wyMsrxlAE4I
         cP7KzlO40DyDIfJOEibn3vTdxozDkUA0JDSsHN+44rhP+2ansbg5rj1bhPnRYl0ee1v/
         Bc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626645;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDIef+aPGuB5wQknGJ7abVMxEUnE+NE/6MUxxwCrbfI=;
        b=SgdJOsjUxhcZ80rUCPrwhogxSP0tPZ/X+l6dijJFwJ99x180/0i2jIAu69ruG71FI4
         xBeDacWFa9OOQPicdkAMkiggyXucqiN1AL0znzvB0aWXdMs7EGMa5h/j8jEl4g9vwr1o
         RvyXQFkWfMXSXlH9NXgs/RhlFNkg6PWlgiysu/hVdV3tI+hMHqU7ERgC5wm3RvxakEY2
         /sQvJ+m6XZYIHy0O+gQbs4CE6Evxm/3U/FGW3vkfj/P/+cu+JWvrFyBWP9tj6ZnHYfJ8
         2b0Naql5ysaexx6VCLdKrxhpxZXLahq9XqC4JKhw1fgXrAclNuXRZq6un7Zbbty88mGG
         WTiA==
X-Gm-Message-State: AO0yUKXtwcoYMknH2s1I3NWHnvnH4ol1nVD0TNObSkqqc9602w9dGe+w
        yg/pGk1DZVkHkpK/f8IuWEpbMqHnZ8rD5gF3
X-Google-Smtp-Source: AK7set97070teV9xxDqwA+2TgPU4J5RP76RaY++xCxksiwFA/bmWgyRn9GZ58tnGCFGKLwqMgJQPWQ==
X-Received: by 2002:ac2:554a:0:b0:4e8:3fc2:32a8 with SMTP id l10-20020ac2554a000000b004e83fc232a8mr617480lfk.27.1678626645356;
        Sun, 12 Mar 2023 06:10:45 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos78xx-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id r2-20020a2e94c2000000b0029335c12997sm648289ljh.58.2023.03.12.06.10.44
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:10:45 -0700 (PDT)
Message-Id: <1678626510.1783316-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678626510.1783316-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 16:03:15 +0300
Subject: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
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

Add two new compatible strings, "samsung,exynos78xx-dw-mshc" and
"samsung,exynos78xx-dw-mshc-smu" respectively, to denote exynos78xx
boards that need this quirk. But it's very possible that all
"samsung,exynos7-dw-mshc" boards are actually affected.
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi                      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index fdaa18481..a72a67792 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -22,6 +22,8 @@ properties:
       - samsung,exynos5420-dw-mshc-smu
       - samsung,exynos7-dw-mshc
       - samsung,exynos7-dw-mshc-smu
+      - samsung,exynos78xx-dw-mshc
+      - samsung,exynos78xx-dw-mshc-smu
       - axis,artpec8-dw-mshc
 
   reg:
diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 23c2e0bb0..4b94ac9da 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -294,7 +294,7 @@ pmu_system_controller: system-controller@11c80000 {
 		};
 
 		mmc_0: mmc@13500000 {
-			compatible = "samsung,exynos7-dw-mshc-smu";
+			compatible = "samsung,exynos78xx-dw-mshc-smu";
 			reg = <0x13500000 0x2000>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.38.3


