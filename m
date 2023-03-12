Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7825C6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCLRC6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCLRCw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:02:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705203B0D0
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:02:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g17so12870286lfv.4
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678640557;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMzb4+f+2BylShTzIH+kD9h/2l/yJ2pk3VVMD+904ak=;
        b=RHfdExJkVNyb19zb66t1zUImrpH4RxTBYgdk1Qd4QhHn3TgVOwudPhcWf9QDOpaAoC
         5Xx0RyY+EwlfqbJNoff7utYdI8fZd4z58Bx4msllGasQY+TvSiHwG//A4dKXkJzvqgrI
         9qd/M5f/5yHeyCUNuaHo6kiQ0RTaoypDq33xnnSx8jxJ3aBJplb8E7sDK/nAlK3uC9wJ
         XscPj7q/te6qcv5HQPEj1iE8qYfqrgSjWkRcsDbuNKBTaEafgr3wOo0tNA6aNQY2Yck2
         a71eQcZ2igkBq7zMfIeWRzQrjqAzgame3oo90biA6F1pMazB5qlDr0V4zoin9QRYoBdk
         FIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640557;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMzb4+f+2BylShTzIH+kD9h/2l/yJ2pk3VVMD+904ak=;
        b=fL1KF5JSufmfEeNr7w2KX+w+qwVMsNc0wUsDZpjJqyYuWbe9wCdf0GMSirecwEcc/x
         aR9L7CjJHHOwMqNd8Z82JIPKG/HsJWDqimCrzcfLYNlyEFyf44ZWqYX4ll1Vn5r8+QK3
         ampTJutIN4OJVrAs8xVjJ/Faf6ZHldALsNd+rQyhe+XsyIRpkwJiwHPW8kkDwMHRIR3J
         0AsdtzUEZ1IPy61FLeKzJWdA1gxXfO5CsAilu+Coua1tJqwP5WQWBCINFudDAX50kzwG
         QywvID4Dvr7bDqYoIjTK4s5JExBjNjqQ3s95Nsjho8itEgd0F04yvUz2Gw3iqZ0AhFgr
         z6Dw==
X-Gm-Message-State: AO0yUKWXLosJGQlr+zQq0KqIlHH7Sl0RTfOYAZPbxCGWHtB89bLPw+s0
        8Yjj6Yrw6kXLBaA2TEt2r9ZCPmShvaBic7Hg
X-Google-Smtp-Source: AK7set9LZTzjyvYFE/cEbq/7GBLW8138BZRdk+oocYdEvt3dulwOhV8xyFPGwd7ZBA7cqGUqaYQGBw==
X-Received: by 2002:a19:c206:0:b0:4e8:3ee5:7e2e with SMTP id l6-20020a19c206000000b004e83ee57e2emr1024088lfc.52.1678640557481;
        Sun, 12 Mar 2023 10:02:37 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos78xx-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id f2-20020ac25322000000b004ccff7c56a8sm703697lfh.27.2023.03.12.10.02.36
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:02:37 -0700 (PDT)
Message-Id: <1678640497.9030156-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678640497.9030156-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 19:59:29 +0300
Subject: [PATCH v4 1/3] dt-bindings: exynos-dw-mshc-common: add exynos78xx
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
 1 file changed, 2 insertions(+)

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
-- 
2.38.3


