Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8945ACCA47E
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Jun 2022 12:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiFZMEA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Jun 2022 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiFZMDx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Jun 2022 08:03:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD72F5BE
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z7so9384932edm.13
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jun 2022 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zmPJgqjOhKNxFG0WLIBtjuHyrzK8bUH/JzPK1c1kpc=;
        b=WDacz+9KjhgEyr47IP9SwrI9knAGT37osRX03n2ARJEhWu2jCngSpFB/Ad0DmtKluA
         MqeCkie5cUPZ2B+VzIbl+ABTq/IhjCfX0OJ8rb7JwNNnG/ZFANAR5xAFCmQQw6QaJWU7
         6c8enZnQaa3fkYTw2VfrZy3JGDW3jwte1YJhx7tj+lsqXM9o8Jhpi5+4FWsg+PRDm1s8
         oQIN9sVTikAgfkf5+CQ9ZH0jYVu1TxRuZTjGCexI3YItIfZ05KDwIQG1TPPbgKlbiu3G
         fCMDe5H1AK4soeoz7PPIQa5lnCMphMuAxWSc286w1yrAGvJHv61dSQeCSOUiC8vxOWAq
         SB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zmPJgqjOhKNxFG0WLIBtjuHyrzK8bUH/JzPK1c1kpc=;
        b=sbZV6EJJrh/jjNR5YqNghpwiRqMy4u5bKHiezWofMacxsdXecxI+2NWQGBT7SMYDBJ
         sQ7gEF4mIHNFqPz7trePVAerLnWRjPQJLbXGPaJ40zacLVrtdQ/LZOLP4hNw0ROrTfqf
         Shw8XemLGJyMHboLYdVntImRcMLYdi9tcuytpeGMwnZuwnD9hQp5LI6pp/mhehsv6Wun
         wuQMnH7gnlaqs5NfhmNLrV68tGXiCbIJNraWstQBQVFEnpSq6CJ/j4ZM7dIrJvaNM/rN
         nFwgw7FC5CEELG0vEABV+dFtEwzcoNSV6hXMDyBrNtbKRyp0GMCICQZpnNtANSezGE3/
         hREA==
X-Gm-Message-State: AJIora8SSTV4Ep4JMGcK2FLJCVRPhmh2I+qkBuwll60/UHwYE0rUUj9J
        n8j4TciURILKwcdu6+5prP9BXQ==
X-Google-Smtp-Source: AGRyM1t4tdIH5gDOHb7Z/tDF1bjiE1v9aeT3gyFwsF5yUDnE/VscnS05VH0cdHCya9w56xeLJJWUvQ==
X-Received: by 2002:a50:ff0e:0:b0:433:5d15:eada with SMTP id a14-20020a50ff0e000000b004335d15eadamr10461999edu.102.1656245030325;
        Sun, 26 Jun 2022 05:03:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm3751585ejz.120.2022.06.26.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 05:03:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] dt-bindings: mmc: samsung,s3c6410-sdhci: convert to dtschema
Date:   Sun, 26 Jun 2022 14:03:42 +0200
Message-Id: <20220626120342.38851-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the Samsung SoC SDHCI Controller bindings to DT schema.

The original bindings were quite old and incomplete, so add during
conversion typical (already used) properties like reg, clocks,
interrupts.

The bindings were not precising the clocks, although the upstream DTS
and Linux driver were expecting bus clocks in certain patterns in any
order.  Document the status quo even though it is not a proper approach
for bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mmc/samsung,s3c6410-sdhci.yaml   | 81 +++++++++++++++++++
 .../devicetree/bindings/mmc/samsung-sdhci.txt | 32 --------
 2 files changed, 81 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml b/Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
new file mode 100644
index 000000000000..5d873a60f650
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/samsung,s3c6410-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC SDHCI Controller
+
+maintainers:
+  - Jaehoon Chung <jh80.chung@samsung.com>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - samsung,s3c6410-sdhci
+      - samsung,exynos4210-sdhci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 5
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: hsmmc
+      - pattern: "^mmc_busclk.[0-3]$"
+      - pattern: "^mmc_busclk.[0-3]$"
+      - pattern: "^mmc_busclk.[0-3]$"
+      - pattern: "^mmc_busclk.[0-3]$"
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: mmc-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos4210-sdhci
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: hsmmc
+            - const: mmc_busclk.2
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmc@12510000 {
+        compatible = "samsung,exynos4210-sdhci";
+        reg = <0x12510000 0x100>;
+        interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clock CLK_SDMMC0>, <&clock CLK_SCLK_MMC0>;
+        clock-names = "hsmmc", "mmc_busclk.2";
+        bus-width = <4>;
+        cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
+        pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
+        pinctrl-names = "default";
+        vmmc-supply = <&ldo21_reg>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
deleted file mode 100644
index 42e0a9afa100..000000000000
--- a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* Samsung's SDHCI Controller device tree bindings
-
-Samsung's SDHCI controller is used as a connectivity interface with external
-MMC, SD and eMMC storage mediums. This file documents differences between the
-core mmc properties described by mmc.txt and the properties used by the
-Samsung implementation of the SDHCI controller.
-
-Required SoC Specific Properties:
-- compatible: should be one of the following
-  - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
-    controller.
-  - "samsung,exynos4210-sdhci": For controllers compatible with Exynos4 sdhci
-    controller.
-
-Required Board Specific Properties:
-- pinctrl-0: Should specify pin control groups used for this controller.
-- pinctrl-names: Should contain only one value - "default".
-
-Example:
-	sdhci@12530000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12530000 0x100>;
-		interrupts = <0 75 0>;
-		bus-width = <4>;
-		cd-gpios = <&gpk2 2 0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
-	};
-
-	Note: This example shows both SoC specific and board specific properties
-	in a single device node. The properties can be actually be separated
-	into SoC specific node and board specific node.
-- 
2.34.1

