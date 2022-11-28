Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43FEC4708A
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 02:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiK1CpH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiK1CpE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2022 21:45:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DC11466
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:45:03 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h193so8722241pgc.10
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QblcRigJwoZRgJNZ6iEUB9TwI9CjJLNnmBpOtD0NOv4=;
        b=X3sSZ+vFG6pKcKMZiHZGfHhEOFIOeF/8wlewh8ih5nKEHqeWHGRbNzi7PT3jvF2Zep
         gL4Yqon1S38u2PIODz45DeUfheiQLdKs5WcMngFJHGdY9DH+fNXqB0G5r76thAU0cuN8
         lVtRjMTVe7nPolWSbVdIATDJx0CrgN4ovsMHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QblcRigJwoZRgJNZ6iEUB9TwI9CjJLNnmBpOtD0NOv4=;
        b=lHP50i8+XK7AxY5cv1+HpPNbSYwq683cDJkMpXdzK3eU+6ceA2F62EfMvIbPZ3wGpe
         jUQBUX5EA2USv9ArEwGYUTRtmSqpDdUMwj50NkPpZ3QuqWlze5HukPHBhKkfhNOZwhEC
         HeDlhrxmQVkbsckJVEQlQF/gPk7gCkdl4vPRDdu18JkSkBZxr7uyE3GGCk2AD8rQgbvQ
         BgvJ4T2GVtuldHUgT6zAmTnShE7OyixghU716Hx9S0AMnqn1bBVL3EgyWKLTwaCGrYoR
         AZN5PpLCbscImtQa0bCBi2kAEwiWA4AduKF4+8w80lMweATiw4zyZRIqg9WuVFmCIWDI
         y8rQ==
X-Gm-Message-State: ANoB5pkKy+yFRoYpnVgaJHIAHljiAawgGh10i/FTMGUAyC2s4fWpgdOi
        4/mz92spL2imZZQuYnzz1MA0kw==
X-Google-Smtp-Source: AA0mqf6H2EO/npUQnxPso24DXuIYncg32lomcwgcRx/74I+rJHmoea/NN4qLk23bdx3Tq/BPyk+ylA==
X-Received: by 2002:a63:1f0f:0:b0:439:4c73:821c with SMTP id f15-20020a631f0f000000b004394c73821cmr25484433pgf.109.1669603502519;
        Sun, 27 Nov 2022 18:45:02 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b005752201d4ffsm1431568pff.213.2022.11.27.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:45:02 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Date:   Sun, 27 Nov 2022 18:44:07 -0800
Message-Id: <20221128024407.224393-9-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128024407.224393-1-doug@schmorgal.com>
References: <20221128024407.224393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a compatible for the pxav1 controller in the PXA168, along with
optional pinctrl properties to use for an errata workaround.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 1c87f4218e18..e3fb34853921 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell PXA SDHCI v2/v3 bindings
+title: Marvell PXA SDHCI v1/v2/v3 bindings
 
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
@@ -34,6 +34,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - mrvl,pxav1-mmc
       - mrvl,pxav2-mmc
       - mrvl,pxav3-mmc
       - marvell,armada-380-sdhci
@@ -61,6 +62,25 @@ properties:
       - const: io
       - const: core
 
+  pinctrl-names:
+    description:
+      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between SDIO CMD and
+      GPIO mode.
+    minItems: 2
+    items:
+      - const: default
+      - const: state_cmd_gpio
+
+  pinctrl-0:
+    description:
+      should contain default pinctrl.
+    maxItems: 1
+
+  pinctrl-1:
+    description:
+      should switch CMD pin to GPIO mode as a high output.
+    maxItems: 1
+
   mrvl,clk-delay-cycles:
     description: Specify a number of cycles to delay for tuning.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.34.1

