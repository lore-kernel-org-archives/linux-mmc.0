Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95DC25B08
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiHTT6m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiHTT6e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:58:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F258B23BD4
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u22so6744491plq.12
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=Klg3A3HrC6BDodvLklTbiYx2mxjckpW5j4Mk64dlIWo=;
        b=hefQx/OIX0sYRllNPCZM0yXrau/nMHUh/bvsXdAyXn0d3FP222WoJVQJIMJ9DWbMuC
         VEX3mFiQ7wG7qniOyPpsMiZ3/q8xJWjdxNq+OHaSzsljTupz0Rn+JbpllG9einHtTU0V
         Ket+IcgRpFY22zlzd5sNyOWusCQpHHNwEXTzMfY5XBfCc0alr4Cn3mart9hkKexdIwDX
         98rqXg8WE8WMahsHPtTqB5V1qUmepBd4CrFGwdBogFoGUFJiwJS+Y1fZBJIjUqP9mGVz
         wmpEhqScwmJ56DIpXxot97Zly+yy3w6kAvlY0QUkMKt3RtkhPar2YtBfFF3ZP7HWBBXu
         Dcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=Klg3A3HrC6BDodvLklTbiYx2mxjckpW5j4Mk64dlIWo=;
        b=U8V2tAkccxJ8g9HZOAnDrKtb5aOqJWePzbc3MUzRNBF41YjNHgloSsrd+h5vv/EspN
         1spKAUbaXZrsMO/kavWaFb6xsvn7wJ804sjlddonV0gO4mYOuhn5RzsxcRPiIhhCTAfu
         Z+twmnV7nUk7JZknqDv/bg0WWQ+mvBHVPbA7pDvcRGZdg8Qnom7a7kMTyihHKFqOux8v
         Hf2kOqQUMp+L71aDMVqufGieTXopEyoHsXRmooBSWWAZv8jT/PXPlnOfGi2vv83WJ1iM
         JU3fUacyGWiPqCr5RlaqgzZpRJy89RuGlEFxoE0VC3czZ8JNWKlQOHayy6hzUIik/dwJ
         OTDQ==
X-Gm-Message-State: ACgBeo2OIrkeP1pnmmf0NXV8Yqqo8/P+uQynlmVONu6Y4igBwhqwIcn0
        iiZ1pjGJog28AP4zsdGsJby37Q==
X-Google-Smtp-Source: AA6agR6wA+vcuG6mkLW7/jrTeHDP0/xxGtqSMWUBkf1+CqT8XQBAs5bf9E7qrUoDojtbzAxKdPZr3g==
X-Received: by 2002:a17:902:ec8e:b0:16d:d156:2bf1 with SMTP id x14-20020a170902ec8e00b0016dd1562bf1mr12882035plg.17.1661025512392;
        Sat, 20 Aug 2022 12:58:32 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:30 -0700 (PDT)
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
Subject: [PATCH v6 07/17] dt-bindings: reset: amd,pensando-elbasr-reset: Add AMD Pensando SR Reset Controller bindings
Date:   Sat, 20 Aug 2022 12:57:40 -0700
Message-Id: <20220820195750.70861-8-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Document bindings for AMD Pensando Elba SR Reset Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../reset/amd,pensando-elbasr-reset.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
new file mode 100644
index 000000000000..0fdc6cc5ecdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Reset Controller
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+description: |
+  AMD Pensando Elba SoC reset controller driver which supports a resource
+  controller connected to the Elba SoC over a SPI bus.  The Elba reset
+  controller must be defined as a child node of the Elba SPI bus
+  chip-select 0 node.
+
+properties:
+  compatible:
+    const: amd,pensando-elbasr-reset
+
+  reg:
+    const: 0
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        spi@0 {
+            compatible = "amd,pensando-elbasr";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            spi-max-frequency = <12000000>;
+
+            rstc: reset-controller@0 {
+                compatible = "amd,pensando-elbasr-reset";
+                reg = <0>;
+                #reset-cells = <1>;
+            };
+        };
+    };
+
+...
-- 
2.17.1

