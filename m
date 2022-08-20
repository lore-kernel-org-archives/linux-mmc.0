Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F21C3F6B0
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 19:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiHTT6e (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiHTT6b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:58:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC015FE9
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g8so2868136plq.11
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=di2SPGU5x1pTiaeM4K+fw8L7yPhLD/oZqXCEZ+r+vdc=;
        b=Kt3Dgo1jDXx7s0mZOIqmWuvVIfmApyXitJu3xxj8Ufsl5L2t88PxrUvhKRtjtOGMqn
         0HTS0DzqdQovD+OK2qgjp9Cn6p5AMCmRsnD5jsCn1EXqTSbRmbHTmVdlxr706KBOV7lZ
         IDMO6vHu4HcSqlnP9KARqlDfunDglJ+paNmYYFWAxmq6XXrA0kl2uRBSmEXZ4Pwe1tuF
         3rtmKPYCv89sKqnOAc51aN7Rj1eZ2nV453xWCszHObWdckDgLilkftxJwINRus2PaIA6
         B65DJR/iR8hcPntsfDNStrSpNrbHD7X3mzScjMlsBrY/m+4KutloRN33y7EVvv2cNQzp
         fM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=di2SPGU5x1pTiaeM4K+fw8L7yPhLD/oZqXCEZ+r+vdc=;
        b=xItBDdPGaJy4XwFfd88YoZK3ROOALxZA13ZsaEoEG85KB29Xkuvw1wSX3spWvwIhmw
         DFNyHBjBFo8t1xgvV4TmTtWVhVvW1glVkWJoO+vNnR30vKs0B6CLTiBkP2NCHtpza4cZ
         CTAzELJE8UgnVIp9nC36kfNQrLz0aeAsdKMKADaGFN6nVLlGooDrWCqGIC4VS732MZVA
         yxVzxd0X3GN7/y88mNc8+1hoqsv+7CccvyVK57i67MJmScDWnDk/0OOmNpougrqDIVgj
         Sy4UDBJO5I0AhXkuCm9U7Zpwy/593jn6D68Uk2VqZHLraEAS6PUOxrT6pYusvQXJVQlC
         A9tA==
X-Gm-Message-State: ACgBeo2aMzfOVRtxt3BxJLA4/fLQcenTRpCTkHyJ3LjTtIeAq/6s1AI+
        8RDsh0FSOQeXhwOm0gubN2vF5A==
X-Google-Smtp-Source: AA6agR7i3yPKVE4Kp5uSMKmrbyXdBYlktP2wELeOCMKvIwDlFLhtppJXK5q4nU97XkKr/2FPPx0bUg==
X-Received: by 2002:a17:90b:3b47:b0:1fa:d988:c916 with SMTP id ot7-20020a17090b3b4700b001fad988c916mr11885488pjb.240.1661025508471;
        Sat, 20 Aug 2022 12:58:28 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:27 -0700 (PDT)
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
Subject: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Sat, 20 Aug 2022 12:57:39 -0700
Message-Id: <20220820195750.70861-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add support for the AMD Pensando Elba SoC System Resource chip
using the SPI interface.  The Elba SR is a Multi-function Device
supporting device register access using CS0, smbus interface for
FRU and board peripherals using CS1, dual Lattice I2C masters for
transceiver management using CS2, and CS3 for flash access.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../bindings/mfd/amd,pensando-elbasr.yaml     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml

diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
new file mode 100644
index 000000000000..ded347c3352c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Resource Controller bindings
+
+description: |
+  AMD Pensando Elba SoC Resource Controller is a set of
+  miscellaneous control/status registers accessed on CS0,
+  a designware i2c master/slave on CS1, a Lattice rd1173
+  dual i2c master on CS2, and flash on CS3.  The /dev interfaces
+  created are /dev/pensr0.<CS>.  Hardware reset of the eMMC
+  is implemented by a sub-device reset-controller which accesses
+  a CS0 control register.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amd,pensando-elbasr
+
+  spi-max-frequency:
+    description: Maximum SPI frequency of the device in Hz.
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+patternProperties:
+  '^reset-controller@[a-f0-9]+$':
+    $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        sysc: system-controller@0 {
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
+
+        i2c1: i2c@1 {
+            compatible = "amd,pensando-elbasr";
+            reg = <1>;
+            spi-max-frequency = <12000000>;
+        };
+
+        i2c2: i2c@2 {
+            compatible = "amd,pensando-elbasr";
+            reg = <2>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        flash@3 {
+            compatible = "amd,pensando-elbasr";
+            reg = <3>;
+            spi-max-frequency = <12000000>;
+        };
+    };
+
+...
-- 
2.17.1

