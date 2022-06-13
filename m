Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C8CCA47F
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jun 2022 20:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349182AbiFMUq6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351004AbiFMUqS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2022 16:46:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D863C2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u18so5983486plb.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2022 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9XPhK7Tm81pQe79Pw/2MjwDbiQKz3NoZ1HTS8NF7C1c=;
        b=F2qUogG4H3Jjl3npZp4G8zxj5VwYoGiLao3dgfGymTrX/oAPiQGn3mOFB8Aa+UMNwu
         v5Z6W9i6W2Ot5rqZv1adfZJvS9wJeIJRXo0fLayHSnF3cdRyizVd1eLWixP1qNIGAgvo
         9FLcJJNs7V8bAmdG1+/ecJnhty4JBvUL7BpTNgGuOzjg1TjtbBBdwKIC4Ntc2rq7i4wr
         07z7+uOBedF97bHLPZMM3Cvf3yill2Qqzzw9K4W9d/uMKsboEDcDYKfRx8wBv9a3Zfso
         rpkToSmUyp7c+W9K4ELOXeHFnqufW+HuupcJ2eCtpXsaP9qXCKdZtijdplpw3jtk3J3V
         hZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9XPhK7Tm81pQe79Pw/2MjwDbiQKz3NoZ1HTS8NF7C1c=;
        b=j4jfgr/Q7D3Ff5HM1cJR76Hwe6UisCqgDdcuWDDRMoTU1PoTWSdYjg4Jx8jEfd66vH
         Gu29eyzRek9JQ7VGMs9jmhZLfwi0XoE37o5uCKYtEVEkF2/REZ4NeWJ4a7ul9FiHOvmV
         0ri38PPl2JPcX2Aff9O103MuiYHdfhofG9pzcFewFbT/SpMKqiY7sLEh/x9ftMJMVIHm
         Nh7zBIxi1AfdcVwprojVhaeEmtPKFkn6lA7eetKTAgy0NXcx8b8JY7jLALRya96A+qBC
         Q94agIqaJm/Z8gb67ZPwo3Qjl49V5+tQdaUJCwvmp2lE2wYH8+I2WxXz5eKercA/oxXx
         VpqA==
X-Gm-Message-State: AJIora/DxhaS2BFyWHO8QiyWKsGWhB4rSus4VF9d50nNQhzR8YrtqAtc
        FO1n/vS1R62f1fsfz8Zo5g4kYw==
X-Google-Smtp-Source: ABdhPJw44rPeyDOXLR9BU2JaWMAaNNQFCALOuvD6GgvfqdGFiGEthYrxts1XE7vjVSLg0hMvvDsPQg==
X-Received: by 2002:a17:902:e54a:b0:166:50b6:a08b with SMTP id n10-20020a170902e54a00b0016650b6a08bmr689960plf.90.1655150257089;
        Mon, 13 Jun 2022 12:57:37 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:36 -0700 (PDT)
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
Subject: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset: Add AMD Pensando SR Reset Controller bindings
Date:   Mon, 13 Jun 2022 12:56:50 -0700
Message-Id: <20220613195658.5607-8-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Document bindings for AMD Pensando Elba SR Reset Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../reset/amd,pensando-elbasr-reset.yaml      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
new file mode 100644
index 000000000000..03bb86ebcfd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Reset Controller Device Tree Bindings
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
+  See also:
+  - dt-bindings/reset/amd,pensando-elba-reset.h
+
+properties:
+  $nodename:
+    pattern: "^reset-controller@[0-9a-f]+$"
+
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
+    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        spi@0 {
+          reg = <0>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          rstc: reset-controller@0 {
+            compatible = "amd,pensando-elbasr-reset";
+            reg = <0>;
+            #reset-cells = <1>;
+          };
+        };
+    };
+
+...
-- 
2.17.1

