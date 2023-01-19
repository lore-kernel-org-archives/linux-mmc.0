Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2CFC38142
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 03:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjASDlI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Jan 2023 22:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASDk4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2023 22:40:56 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794A5F3AA
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:39:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k18so1118105pll.5
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 19:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kudYK68TKVp96VTs/Z2G9y6K9uac1w5PwvTjxWPWhog=;
        b=VuUym+QbQ/y7/+6BcQS8DraTXW0ibrEYQipwh9a7+P7xuu/wdp+8A+vNbebgvwHupn
         81y3Kpx+KKNati4Kz4YYzUFNQLZ5PAU9K6V+dJu8JXG/BtDooSPje7hajOMylLRaS5UA
         HX0F8E0xPsCjEWn6IDMLcQHxkc4NuH9bPmUQPkpU1n3V0reinnD6ioQnLpqcM9PxGIMO
         675PfHIS/8Dco0Es9RlfXwTVLl8M26C7/mKeN6r1HVBGMNa98EjsxGF6KgYnBIYLVNbf
         gkKQLYKnNWGYWaXziAgJqyjEWsoGxvvofDTjszVnx8Td2k5cdplTtmhMS52mQQWT/otG
         wonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kudYK68TKVp96VTs/Z2G9y6K9uac1w5PwvTjxWPWhog=;
        b=NHDd0eUGWbbbQPm+SD2Tc/tVi0q3l7GUtisC047n84eNlsxuFBNrMmZlpxcppoJepd
         iWBFVHf9QAeg2ySPMb/79gi06vmtX+5LrW29R0M99iDzC3MQyWPL/tnRJSLWG1OkRrch
         ZV8IDp3XxbeGUY92v6ekQzHwmLn2K+A/+SWpEPSagF/SnUVXCaBVFc250X8yiFf4YP70
         zk8oBZWD3atePfCCcvXCeCThTIKhP8GVfzE4WlxaR1o/gMqQtKFHnexl8EaCw/008C89
         kfdS/b6Qd6QhjZ4aS8x33ES3JCyAGPKIia5ypWe71gJn1UUu1GjR1aOfh55v0/xnM0vt
         ptdg==
X-Gm-Message-State: AFqh2koB4WQ2ij1VP8Ywm8KSdu+3oGlDwfotfVPGEKp5n8+prx72PJUj
        z8jDiMiPdkL2cm8nPHGykKEiyw==
X-Google-Smtp-Source: AMrXdXsH5evpf5+gOZqFAYVG0372ZyN0AxzV0HyzUFqbfAnXJurzGZqH5wa5o5+lRTWDLC++WhKydA==
X-Received: by 2002:a05:6a20:c21a:b0:b8:cb15:d6db with SMTP id bt26-20020a056a20c21a00b000b8cb15d6dbmr8192063pzb.23.1674099594760;
        Wed, 18 Jan 2023 19:39:54 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:39:54 -0800 (PST)
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
Subject: [PATCH v9 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:39:05 -0800
Message-Id: <20230119033918.44117-3-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables.

Signed-off-by: Brad Larson <blarson@amd.com>

---

Changes since v6:
- Add reset-names and resets properties
- Add if/then on property amd,pensando-elba-sd4hc to set reg property
  values for minItems and maxItems

---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 8b1a0fdcb5e3..f7dd6f990f96 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -16,12 +16,14 @@ properties:
   compatible:
     items:
       - enum:
+          - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -111,12 +113,36 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  reset-names:
+    items:
+      - const: hw
+
+  resets:
+    description:
+      optional. phandle to the system reset controller with line index
+      for mmc hw reset line if exists.
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
 
+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+else:
+  properties:
+    reg:
+      minItems: 1
+      maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

