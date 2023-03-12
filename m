Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE7C6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjCLSOg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjCLSOR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:14:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396061332
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:06:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bi9so12980624lfb.2
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678644283;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=bQtiB/Tl1AOJIGiNiubvuPtlNrTJyykMFhqP4aT1ctaZJdtqGiIC3NyzYm3ID0yfLd
         sLqK0o9p5RGpAuAXiYG4yuVz9V+yh2KwXpAyaPeC/iTrYD2NSaJlR6S8UbHvoH0S4kVr
         zL3KDUngzJUhzdm8rOzaD6Qw3HuxDZUwDWBQyYySq3Ak5rfrNFLOYqMbN/0p8ZIksJr1
         HNyi5flCg9LVGKzuvjYKFgM5PYZvnCniKQkkt3oEHc6TfO2Y5xPurLH6m3atwARzLfc+
         3LRMcxEf7IFFBPN6ULCp9xy4IFrPp0ZZVdRvtTbv+jiTGGFEmXA57U36tN6fBLmQDs9T
         rbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644283;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=UdlOyRsfg0tyc4wdi9sv6key+rPHIZ75nDBGiIdPSq9c8IIvKK+7EYuXhmKdXtRzg7
         WjbrD2xR+GICDO2fx2CrQtmnQaTcVL0G94GcyIexT7UKdyTbYuEJmC5w78151OcV8v//
         DA6/f9bNlyeEFmcrRS1/XKaCVfOnX6o29sVZ7Fsn85KceHqSOe/5KwEkCSyQWW0wA8DX
         Hcfe9bS7zQMikUJNCp+Tb/nZw7CcR+rzz0zRuasNoGRvkOEepAZTKYcG9/g2thsqIb6c
         jfWSCeaxRXsdeVWsx+rylz+1gu9JI4zpHOoeOzNy4LAf0PN73QmG/6g4kSRuJfki2X48
         1euw==
X-Gm-Message-State: AO0yUKWSdf1QayHJiOdDUVH1ifsYSAWMXLN0R+ow3AAy5R1v+bq8QzBs
        1ohdjB6AE0oSBsKWqrMV/ppZkhP2YeH03Pfy
X-Google-Smtp-Source: AK7set/Ma1d8RfSn0bHL3xySPjmlzvKBegB2rPb4tCdg9ydTjl1Twj56N5LGs2IaYRjscIQK4VKanQ==
X-Received: by 2002:a05:6512:239b:b0:4d8:86c1:4786 with SMTP id c27-20020a056512239b00b004d886c14786mr2434394lfv.27.1678644283054;
        Sun, 12 Mar 2023 11:04:43 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos7885-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id u14-20020ac2518e000000b004db250355b3sm712408lfi.138.2023.03.12.11.04.42
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:04:42 -0700 (PDT)
Message-ID: <640e143a.c20a0220.39070.1ae1@mx.google.com>
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


