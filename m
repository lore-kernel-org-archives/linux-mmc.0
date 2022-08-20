Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4312C25B08
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiHTT6c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiHTT63 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:58:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE56479
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p18so6752058plr.8
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=2Na4L6Xa/1uu7YylwEePPP9ETbiBvw5nj60ibbWpCTE=;
        b=a9V3D9wuMS6prN8rUYdyUZX6fpGi+FRkPzO69Q6kw1t5OceyCRQOjt7w83h3VGAmMU
         HNf+u51EaPo+3fxT4DOrmkR0mBzmgo3NIeI5aknUXHTuBDnB7vYz7B/3eH8Hj0EUEqk3
         YLbFA73FKUkCz1zFlBsUDUN4rYSQX62cz5oNgyw8kVEjUoqLwfVN65rl6d2sAjVRRuCs
         DAN7wr3o7gY2qvSB/3L4ds6UwZrpjqvGxEPvUkBXcNJEIaJMEm475leelMAtcyvzMZj6
         BaXX6ayvqDm/jHvlUxLpr4hJnM05MBNhc6pY8diQ3gVnr0Aqfloz6S5dBSpKnOWz8eJA
         0ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=2Na4L6Xa/1uu7YylwEePPP9ETbiBvw5nj60ibbWpCTE=;
        b=t7blcJuUiEFyMPK8IbxXFn8MvZekMLV9/JAG9s0SYJ0Qs9rput7CNpmsKuT8slLV/A
         r+gMA2CYox4SWh9XuX7xyWMTJrIbS52u4hzLiPSVjfviai4tcMywb9RX5aYsEV5UBTv6
         zD6rlJr74g/HCocIxtG92fMaqUpcB+AIM3Xsvil5kn7ct/MtJmDTZIm3fL3ixWzUPbgP
         8WY7eXl3cAW8d9CqWg5YzISGk3yp+504OUm7HlfniqRCeppOtv7glN5XdMZpWEsTz+vU
         +zWrB/d+uL/eXDDPJe6mgChtMpWidRmKqfS1nZ3iqW/1rnU5/wB6gdmD0HScU1Eex0lx
         /ckA==
X-Gm-Message-State: ACgBeo2XNrwRapfZJ7NFT4LfK1SzFt7D+s59F8G0XAJP42VLrpnrdy3D
        76MYRcAoCkZNDiRkhd7hWdtDRw==
X-Google-Smtp-Source: AA6agR4C0HSq6DXsMwBxsQEhmJfsvMKW08eFxzvRY/J5a6Zi96O/DvEWwAk5qv+nSumVeBUZwTfRBw==
X-Received: by 2002:a17:90a:9f96:b0:1fa:b4fb:6297 with SMTP id o22-20020a17090a9f9600b001fab4fb6297mr14833546pjp.80.1661025505887;
        Sat, 20 Aug 2022 12:58:25 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:25 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 05/17] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
Date:   Sat, 20 Aug 2022 12:57:38 -0700
Message-Id: <20220820195750.70861-6-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add the AMD Pensando Elba SoC system registers compatible.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index c10f0b577268..b6ae68851752 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,6 +38,7 @@ properties:
               - allwinner,sun8i-h3-system-controller
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
+              - amd,pensando-elba-syscon
               - brcm,cru-clkset
               - freecom,fsg-cs2-system-controller
               - hisilicon,dsa-subctrl
-- 
2.17.1

