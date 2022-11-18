Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6543C43219
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 14:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiKROgO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 09:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242507AbiKROfI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 09:35:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47118FB3E
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:33:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g2so5853118wrv.6
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SvRgFTn6+Gybi1+j9eb6DiJcXSsUC9wg7dcCoAYlxo=;
        b=rNdR543njIXd/vTYoC3ISLSjkRryowY2q1V07GqmJUyFH4lwy6TTyxgMjsP8O4AKdA
         CYLwLsgpri/smVj6DDW62FZNw93QkK3gqpHq2HQk379M1DV3NrFNIwncfoYKjJVi6+6E
         XVZ28lFTylYIhRpbfkpcf1cFDgj8AhxK3mbcTrqXN5bB6aJhMjaM/XZ9G5HSewQfRdRp
         UFEMd90M0jfE54YuwnblNTl6tI2fn3oHsoKZxXEXOOPnqozVO3GHjDFwnsp/uG/HGse1
         N+lyHJbxaUEA7S4WxaHcA7nZPgRoXhiwU22v+tCG2qO21jjs1yb9dLbV1ygsljh87xjA
         0o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SvRgFTn6+Gybi1+j9eb6DiJcXSsUC9wg7dcCoAYlxo=;
        b=dmN9GBNzxjJoboYzJEIfo0xVXp6/NZ8VJzP8H5KiALDHSgIDhwbGKrpKyHpCRMwuUW
         8ZTCw0xk8AwhWSGEy4RJmVZFLAkTahxBNOj+i0aij2PkB3k8inQj+02sWKnfJJeQ8laN
         0ck2u8+rApm/lhhTAMN8aVENJNcIHelUFkEZtf9QtriC9Nd4poNVu31M/tEf5f1XtvsW
         Kwbrd5+L+SMdb1t3Hm3DpNPAWmoZCrsSCBAwP4MGrIW1N7dq7ShglNGvf69eWKkCIGXZ
         SU4iU3upI2B2mh2RhdWPbVuHzVSlUi5NOIGvTegArkojVwKDVhsE0jwnhg+P5CdY0qAA
         NecQ==
X-Gm-Message-State: ANoB5pmvsknKKX29dKo0Pf6hkDhvBs3UBCw877kOg8Z18tmPV0KG/ghf
        9cksc1OrvoADRLlKtsljVrlFAA==
X-Google-Smtp-Source: AA0mqf6QQq479fIUCOCgvip5Pl5AI82bEkY7FqOFZ5rXBu8KR0A3F1ydYiGUSPadA491uLfZ1bpajw==
X-Received: by 2002:a5d:452d:0:b0:241:c5ec:d0d with SMTP id j13-20020a5d452d000000b00241c5ec0d0dmr804402wra.441.1668782028313;
        Fri, 18 Nov 2022 06:33:48 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c1c1500b003cfb7c02542sm5436726wms.11.2022.11.18.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:33:47 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 15:33:38 +0100
Subject: [PATCH 12/12] dt-bindings: net: convert mdio-mux-meson-g12a.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v1-12-3f025599b968@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert MDIO bus multiplexer/glue of Amlogic G12a SoC family bindings
to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/net/amlogic,g12a-mdio-mux.yaml        | 80 ++++++++++++++++++++++
 .../bindings/net/mdio-mux-meson-g12a.txt           | 48 -------------
 2 files changed, 80 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml b/Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml
new file mode 100644
index 000000000000..ec5c038ce6a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/amlogic,g12a-mdio-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MDIO bus multiplexer/glue of Amlogic G12a SoC family
+
+description:
+  This is a special case of a MDIO bus multiplexer. It allows to choose between
+  the internal mdio bus leading to the embedded 10/100 PHY or the external
+  MDIO bus.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: mdio-mux.yaml#
+
+properties:
+  compatible:
+    const: amlogic,g12a-mdio-mux
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: peripheral clock
+      - description: platform crytal
+      - description: SoC 50MHz MPLL
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: clkin0
+      - const: clkin1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mdio-multiplexer@4c000 {
+        compatible = "amlogic,g12a-mdio-mux";
+        reg = <0x4c000 0xa4>;
+        clocks = <&clkc_eth_phy>, <&xtal>, <&clkc_mpll>;
+        clock-names = "pclk", "clkin0", "clkin1";
+        mdio-parent-bus = <&mdio0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mdio@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        mdio@1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@8 {
+                compatible = "ethernet-phy-id0180.3301",
+                             "ethernet-phy-ieee802.3-c22";
+                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+                reg = <8>;
+                max-speed = <100>;
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt b/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
deleted file mode 100644
index 3a96cbed9294..000000000000
--- a/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Properties for the MDIO bus multiplexer/glue of Amlogic G12a SoC family.
-
-This is a special case of a MDIO bus multiplexer. It allows to choose between
-the internal mdio bus leading to the embedded 10/100 PHY or the external
-MDIO bus.
-
-Required properties in addition to the generic multiplexer properties:
-- compatible : amlogic,g12a-mdio-mux
-- reg: physical address and length of the multiplexer/glue registers
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk"   : peripheral clock.
-  * "clkin0" : platform crytal
-  * "clkin1" : SoC 50MHz MPLL
-
-Example :
-
-mdio_mux: mdio-multiplexer@4c000 {
-	compatible = "amlogic,g12a-mdio-mux";
-	reg = <0x0 0x4c000 0x0 0xa4>;
-	clocks = <&clkc CLKID_ETH_PHY>,
-		 <&xtal>,
-		 <&clkc CLKID_MPLL_5OM>;
-	clock-names = "pclk", "clkin0", "clkin1";
-	mdio-parent-bus = <&mdio0>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	ext_mdio: mdio@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	int_mdio: mdio@1 {
-		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		internal_ephy: ethernet-phy@8 {
-			compatible = "ethernet-phy-id0180.3301",
-				     "ethernet-phy-ieee802.3-c22";
-			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <8>;
-			max-speed = <100>;
-		};
-	};
-};

-- 
b4 0.10.1
