Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A6C43460
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 07:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4F66128C
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 07:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhD3HWg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Apr 2021 03:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhD3HWg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2021 03:22:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A9DC06174A;
        Fri, 30 Apr 2021 00:21:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j28so17421982edy.9;
        Fri, 30 Apr 2021 00:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HpxUMjyXbZkzEt83poK9Tqo10qlhUK6WE4i1dvnGncw=;
        b=ZsHFvBVbicZVJzVSsqNQid4JAMFYeUIOyZkOT+udNp/f2A7H3Ir3UKS53jJytqxmv8
         iJG2ptyRSUGte9cJhvHEHulQvv7oUkBSztznpLxf2vnpsCQ1sne0057OgdNPYLDB/NsA
         yXSWowl3PYQpJRyTe9JppcrjzdDsShy6T79ti+2NEPRIpcy+fy5SAAMmo/6W6tb04euY
         HymDgJeREiYV1PeQxBcBiILvEIgwZpkIqexAR+AM+S+3uTKXXm3zZifVPM1F+Fxoo7Oz
         ahqqY704luqoKc5s8jniTuMFq/z8a6qRykKvsn/rVTzpmoeMleaQ7qhtp0JuA9j9cA3a
         PSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HpxUMjyXbZkzEt83poK9Tqo10qlhUK6WE4i1dvnGncw=;
        b=XocVrZnguNp/dhH4ZoMu0jKV2FTakvZsDd2BYY/DbNWYvpjUG0SjqT27bJcW40xOf6
         0T8BWth2kZAparHRMbfcCEVkvh4UjtVI/J+ROqcZxDgyHKMirYbdtyCHOixa7OokyjlK
         2dkDCO7BNzwHvyA5P0wlpA9xijQB+u/AXlpW8/Ezi0IuQT3SbPFDvN8uuXyRq09q4vG3
         WBizpg1YRoqf5rLN1QvoOC0KCmIRd8sCG0z/e1mP02wWx4+08y2MLr8mGwTaAzRn8LDd
         BRKGgMje/RJGEBuZOL+nT6gEowvqPFOJVHmvUx3TqHhJiksu0WkYKZaElhd0FiRxIsjV
         a88A==
X-Gm-Message-State: AOAM533B/VjgsUigVNR/T0NNL+4T0IpRJiUZdSGMNLQWO7OYPtnfATSL
        +6vi9mCFNcfRmEjaYr1eOks=
X-Google-Smtp-Source: ABdhPJxdQhNnPfC5GJPB2i3YmP+3TesomiWl9A9y9B69mHJpWDPDlaPa7tM76eTnXZ2arO7+qw1GHw==
X-Received: by 2002:a50:eb47:: with SMTP id z7mr2208979edp.68.1619767306753;
        Fri, 30 Apr 2021 00:21:46 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cw13sm1378858ejb.113.2021.04.30.00.21.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Apr 2021 00:21:46 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     shawn.lin@rock-chips.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, Jisheng.Zhang@synaptics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1] dt-bindings: mmc: snps,dwcmshc-sdhci: fix rockchip,txclk-tapnum
Date:   Fri, 30 Apr 2021 09:21:38 +0200
Message-Id: <20210430072138.6537-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A test with the command below gives this error:
mmc@fe310000: rockchip,txclk-tapnum: missing size tag in [[8]]

With this added to a dts file:
rockchip,txclk-tapnum = <0x8>;

A look at the driver shows that:
DLL_TXCLK_TAPNUM_DEFAULT	0x8

Adding the default value to the dts files is not needed.
Every clock is divided into 32 taps equally and
the max value is 31.

Fix rockchip,txclk-tapnum property in snps,dwcmshc-sdhci.yaml by
adding a minimum, maximum and default.

In the driver the function of_property_read_u8() is used,
but with dtbs_check the notifications only disappear in YAML
by changing uint8 to uint32.
The driver has no limit check for rockchip,txclk-tapnum.

make ARCH=arm64 dtbs_check

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index e6c9a2f77..f43d8d829 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -48,7 +48,10 @@ properties:
 
   rockchip,txclk-tapnum:
     description: Specify the number of delay for tx sampling.
-    $ref: /schemas/types.yaml#/definitions/uint8
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+    default: 8
 
 
 required:
-- 
2.11.0

