Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACFC00A5A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 03:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjASDob (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Jan 2023 22:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjASDmT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2023 22:42:19 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243706CCCA
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:40:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bj3so1159905pjb.0
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VVkJKiJ32kgmrV9HwlRJqykEjqFOh7CBZW3HRZVDDmc=;
        b=AYoOQ/8J91aj/79GYchUN5wJYIBudinYvCvZHpawYHMzb+k2DSRr1R1uVRBxEeofqo
         LzyW1cJAQjiKJMpSTrXcqWYdzoFP2mabaNPAfxBeciFXkh7cXm4eqy3GOwWMksVTTLUI
         WadLMrWa67XUAHDgEnXHXoGTfo1qLudHckfnDNMfrClKiZ/HJZev7fNG5VSng3BxkQtx
         QjurQkREyFtFMLXzrt7PVeLW6lcdSbUSsmLjdxns1fImjXPAhp/chEEz+ZpqISxfVuXy
         PQ7pj2gDNoLopkiz4HUs9lc9hjnZP8pdrQtpezvIr2b7qcNtYt90n33wvKAS0cXxDC2p
         A1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVkJKiJ32kgmrV9HwlRJqykEjqFOh7CBZW3HRZVDDmc=;
        b=cZGoRVOvkNWYNde3/hN7cvrarsHDVloI56JsebOmPdWSwqPN1PdMyrcOmZ/dhxZO6I
         QXOZzVzNjEyxOckLEvjiK9yNGK/Z22QTikaKsESe7l1xMQ0FHxV0zXk3E8A4mUwAl1jm
         m1ZqDrlyRseL/Pxiq99kPAQPQqtqx/S2nM/uh3W3DyRae0B+WuRFut+3nwwX50onfb0u
         lP6K6s/dJ5ccfZ2X09HrpsLLBwReHYnJioPY1md56BeLCvxTyJ17w0WAHhUJcVtyC1Qq
         6PDKofv30J2i7f26qYERyvAhXYou3U3V/3RxoArs0lDqnYi5ioCbj8srMEs+8QeZAE7G
         f/kg==
X-Gm-Message-State: AFqh2krUtC2I/9e2uCGFDuST0e/jPI29bIe1ai+efFtWeySxdv9nrU2u
        PlnMQuU+e9n9XnkAru3sac195g==
X-Google-Smtp-Source: AMrXdXspfuChE5/UxncH6rROQNGpPzZT2cnNcxd08fIyPsy5yYzclyc4tmpYZH1QhU+EWILFVKcqtw==
X-Received: by 2002:a05:6a21:3990:b0:b6:157c:d72b with SMTP id ad16-20020a056a21399000b000b6157cd72bmr9990976pzc.33.1674099615188;
        Wed, 18 Jan 2023 19:40:15 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:14 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 05/15] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
Date:   Wed, 18 Jan 2023 19:39:08 -0800
Message-Id: <20230119033918.44117-6-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the AMD Pensando Elba SoC system registers compatible

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Brad Larson <blarson@amd.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd010431..f4b0ed4ff03c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,6 +38,7 @@ properties:
               - allwinner,sun8i-h3-system-controller
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
+              - amd,pensando-elba-syscon
               - brcm,cru-clkset
               - freecom,fsg-cs2-system-controller
               - fsl,imx93-aonmix-ns-syscfg
-- 
2.17.1

