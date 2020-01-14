Return-Path: <SRS0=RtJ+=3D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C340C33C9E
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C0624673
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 21:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCy/XZq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANVic (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:38:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANViX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2020 16:38:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so15456324wmc.3;
        Tue, 14 Jan 2020 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMlYSd9gdjSyr+fvrrUx7m71AJzwJ/EGsztEOkjtZkI=;
        b=QCy/XZq9cb8b44xp0o/+TDC5liA34MFVcL4GpiONMbdM8gdeUSZsH1x+R8ormLx550
         b5LsP0H9TqQTb81ITLUCQT3cRaSS2LYCgDyDhDihgYwCvhHjGSyfzVPXItD0K94sR8GW
         gdU5J0pR3jbq7UPdNyP3Q9LqetfUlGG+GU7TVeoIh4dAJ9d1BpvCEi3foRdKsynr/CtE
         UaBer7XAm6l6X/InpjngAem1ii1m/NTNyMKCUifts1f9l9O/LVJcbGBBaiFPSwSv1Hc3
         o7xDmMDbxqvgFHQ4FUnTKQf1CCJyP0sjiUxiDMYkxrkN3ZvelR5F+Xns+9xsvDBQIcM8
         L+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMlYSd9gdjSyr+fvrrUx7m71AJzwJ/EGsztEOkjtZkI=;
        b=sE/ewBsUW2NCVjPM2bhbXoYbpkF6wpV8GyT+thOTEU5BXZYExyjXRI70ex9EnmuNka
         5ZnAJnBhgoaJigqTcPTxcr4dx1hCzhoEfaP1wuwEEhcVX3DjU9+A6U0fAkjM1zGQDEAy
         irhSfFqnt7pCjRF7H5EZw20XrCC+2BeYIqXN2fqBknoWk3cI9YOKsFab3OOgrdEO99aW
         r+HnWHaZQLeGhpAEWdwFB3tFj6Od6XaSNGyaogge4YMt4daxvPCMYkxFBZWpibE9gNZj
         czC39SZA+1CHOIh5Jlcw1uFFT+AdLstBh7yJpT/pR86zVvpBCXDhATdY9FmPq7ylbspY
         ZS4Q==
X-Gm-Message-State: APjAAAV2JKPknFCAUOi9l1VtIp3PUNpnbQLRZKoaBtKS3QeQxu8wMJsd
        R1J/IdLjihhGJqqLz3137SE=
X-Google-Smtp-Source: APXvYqwzBCnO8hbLw9uOyBWsVUBiO+5uZBrgww1tJVYeE/kYrgQQ5myt1/iRlL4meTPgZzB4RLDuVA==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr29761712wma.66.1579037899924;
        Tue, 14 Jan 2020 13:38:19 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w17sm21639511wrt.89.2020.01.14.13.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:38:19 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [RFC PATCH v1 3/3] dt-bindings: mmc: convert rockchip dw-mshc bindings to yaml
Date:   Tue, 14 Jan 2020 22:38:09 +0100
Message-Id: <20200114213809.27166-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200114213809.27166-1-jbx6244@gmail.com>
References: <20200114213809.27166-1-jbx6244@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the Rockchip designware mobile storage host controller
device tree bindings to yaml.
Add maintainer.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  49 --------
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  | 137 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 138 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
deleted file mode 100644
index 6f629b12b..000000000
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* Rockchip specific extensions to the Synopsys Designware Mobile
-  Storage Host Controller
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Rockchip specific
-extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be
-	- "rockchip,rk2928-dw-mshc": for Rockchip RK2928 and following,
-							before RK3288
-	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
-	- "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
-	- "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip PX30
-	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
-	- "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322x
-	- "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
-	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
-	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
-
-Optional Properties:
-* clocks: from common clock binding: if ciu-drive and ciu-sample are
-  specified in clock-names, should contain handles to these clocks.
-
-* clock-names: Apart from the clock-names described in synopsys-dw-mshc.txt
-  two more clocks "ciu-drive" and "ciu-sample" are supported. They are used
-  to control the clock phases, "ciu-sample" is required for tuning high-
-  speed modes.
-
-* rockchip,default-sample-phase: The default phase to set ciu-sample at
-  probing, low speeds or in case where all phases work at tuning time.
-  If not specified 0 deg will be used.
-
-* rockchip,desired-num-phases: The desired number of times that the host
-  execute tuning when needed. If not specified, the host will do tuning
-  for 360 times, namely tuning for each degree.
-
-Example:
-
-	rkdwmmc0@12200000 {
-		compatible = "rockchip,rk3288-dw-mshc";
-		reg = <0x12200000 0x1000>;
-		interrupts = <0 75 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
new file mode 100644
index 000000000..da16916b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/rockchip-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip designware mobile storage host controller device tree bindings
+
+description:
+  Rockchip uses the Synopsys designware mobile storage host controller
+  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
+  This file documents the combined properties for
+  the core Synopsys dw mshc controller that are not already included
+  in the synopsys-dw-mshc-common.yaml file and the Rockchip specific
+  extensions.
+
+allOf:
+  - $ref: "synopsys-dw-mshc-common.yaml"
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      # for Rockchip PX30
+      - items:
+          - const: rockchip,px30-dw-mshc
+          - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK2928 and before RK3288
+      - const: rockchip,rk2928-dw-mshc
+      # for Rockchip RK3036
+      - items:
+          - const: rockchip,rk3036-dw-mshc
+          - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK322x
+      - items:
+          - const: rockchip,rk3228-dw-mshc
+          - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK3288
+      - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK3328
+      - items:
+          - const: rockchip,rk3328-dw-mshc
+          - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK3368
+      - items:
+          - const: rockchip,rk3368-dw-mshc
+          - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK3399
+      - items:
+          - const: rockchip,rk3399-dw-mshc
+          - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RV1108
+      - items:
+          - const: rockchip,rv1108-dw-mshc
+          - const: rockchip,rk3288-dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+    description:
+      Handle to "biu" and "ciu" clocks for the bus interface unit clock and
+      the card interface unit clock. If "ciu-drive" and "ciu-sample" are
+      specified in clock-names, it should also contain
+      handles to these clocks.
+
+  clock-names:
+    oneOf:
+      - items:
+        - const: biu
+        - const: ciu
+      - items:
+        - const: biu
+        - const: ciu
+        - const: ciu-drive
+        - const: ciu-sample
+    description:
+      Apart from the clock-names "biu" and "ciu" two more clocks
+      "ciu-drive" and "ciu-sample" are supported. They are used
+      to control the clock phases, "ciu-sample" is required for tuning
+      high speed modes.
+
+  rockchip,default-sample-phase:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 360
+      - default: 0
+    description:
+      The default phase to set "ciu-sample" at probing,
+      low speeds or in case where all phases work at tuning time.
+      If not specified 0 deg will be used.
+
+  rockchip,desired-num-phases:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 360
+      - default: 360
+    description:
+      The desired number of times that the host execute tuning when needed.
+      If not specified, the host will do tuning for 360 times,
+      namely tuning for each degree.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3288-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    sdmmc: dwmmc@ff0c0000 {
+      compatible = "rockchip,rk3288-dw-mshc";
+      reg = <0x0 0xff0c0000 0x0 0x4000>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+               <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+      clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+      resets = <&cru SRST_MMC0>;
+      reset-names = "reset";
+      fifo-depth = <0x100>;
+      max-frequency = <150000000>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d6ad01d71..1b16c0fdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2240,6 +2240,7 @@ L:	linux-rockchip@lists.infradead.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+F:	Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
 F:	arch/arm/boot/dts/rk3*
 F:	arch/arm/boot/dts/rv1108*
 F:	arch/arm/mach-rockchip/
-- 
2.11.0

