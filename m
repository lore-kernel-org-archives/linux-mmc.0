Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37DEC33CB8
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC532072B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH4r+JhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAPPWq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:22:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAPPWm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 10:22:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so19594114wru.4;
        Thu, 16 Jan 2020 07:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LsH7czZ77eDMxF4wbNHacuwRCGc1WBcBdXO9iXysJbo=;
        b=mH4r+JhXoeagE6PiTbc6pRzluy7DzFZ0F++JyGBKU6hjzSR8DQjOAzvSGpesQzR/F9
         VEcONTLwNDax+GlRnkYIBoU/jV6h9pGaGMJrKn//QblfK2i+wsEHUdDvwomO+AsZA9c2
         u+cMfW6gNHITjvhJrylp0+Ey/lkvUu2OswdOSzglJ5DY7x4eDnUEyXqxbyoD4gQ91wyL
         w6LXmhUB04z/FxCHu+E5ypdB2f2KUrGrgKF/FeUzxA2DS8s7dPyhoV4vG3YfcGzmwr9E
         xFS9qcPv34KlTl4UDYBKV9fmUVCXbqKTfSZuZN9wR+XizCunE20D290hk+DA8vAr3yMV
         dWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LsH7czZ77eDMxF4wbNHacuwRCGc1WBcBdXO9iXysJbo=;
        b=BJZ/Yycx/vWIboPxF+UkrFhykDmm4ggOGogp6NoomFh0Zxq92NsWa7zPybLGMnEhDb
         hDGPCubG7bhZYCC+kaYTAP87svlweR9dyhBI3UC/uqRtQOiPRVbueEA9u33K5FU+xgMR
         xhTxj6UvwMatsAef37Ft6HeqbBD4flrZAhqV6miGBL9TTtgmQlraeWlcMhM+Bi1uScss
         Uhhq+eDujsPiYmz2KFeohEUzDqoftPpQYAavvPJ7bfnUomAE8WLo2hB3ZP/gXUgZceSt
         oCEg3NinWVavWR7prvNo/bT+5Ho5pNj6tTIfUBYlDCKN91KsyeiEAOA6m7be2UxUuyBc
         IPCA==
X-Gm-Message-State: APjAAAUf59dEWtpQK8Aupxlw9zKP5r0TPHS1zpmotFpvcYXVLanXLZVM
        SINPA49SD/qMVni3+todtEg=
X-Google-Smtp-Source: APXvYqxw5yacxAQSHmYZ5lD5jGwTfC1KLANnrykrFSU1QP5L6IjTSFat+2AumcLNvsGkFI5ty0//lA==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr4028251wru.150.1579188159692;
        Thu, 16 Jan 2020 07:22:39 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w8sm18193wmd.2.2020.01.16.07.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 07:22:39 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/3] dt-bindings: mmc: convert rockchip dw-mshc bindings to yaml
Date:   Thu, 16 Jan 2020 16:22:29 +0100
Message-Id: <20200116152230.29831-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200116152230.29831-1-jbx6244@gmail.com>
References: <20200116152230.29831-1-jbx6244@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Current dts files with 'dwmmc' nodes are manually verified.
In order to automate this process rockchip-dw-mshc.txt
has to be converted to yaml. In the new setup
rockchip-dw-mshc.yaml will inherit properties from
mmc-controller.yaml and synopsys-dw-mshc-common.yaml.
'dwmmc' will no longer be a valid name for a node and
should be changed to 'mmc'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  49 --------
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  | 123 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 124 insertions(+), 49 deletions(-)
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
index 000000000..2f70f5ef0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -0,0 +1,123 @@
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
+  This file documents the combined properties for the core Synopsys dw mshc
+  controller that are not already included in the synopsys-dw-mshc-common.yaml
+  file and the Rockchip specific extensions.
+
+allOf:
+  - $ref: "synopsys-dw-mshc-common.yaml#"
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+# Everything else is described in the common file
+properties:
+  compatible:
+    oneOf:
+      # for Rockchip RK2928 and before RK3288
+      - const: rockchip,rk2928-dw-mshc
+      # for Rockchip RK3288
+      - const: rockchip,rk3288-dw-mshc
+      - items:
+          - enum:
+            # for Rockchip PX30
+            - rockchip,px30-dw-mshc
+            # for Rockchip RK3036
+            - rockchip,rk3036-dw-mshc
+            # for Rockchip RK322x
+            - rockchip,rk3228-dw-mshc
+            # for Rockchip RK3328
+            - rockchip,rk3328-dw-mshc
+            # for Rockchip RK3368
+            - rockchip,rk3368-dw-mshc
+            # for Rockchip RK3399
+            - rockchip,rk3399-dw-mshc
+            # for Rockchip RV1108
+            - rockchip,rv1108-dw-mshc
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
+    minItems: 2
+    items:
+      - const: biu
+      - const: ciu
+      - const: ciu-drive
+      - const: ciu-sample
+    description:
+      Apart from the clock-names "biu" and "ciu" two more clocks
+      "ciu-drive" and "ciu-sample" are supported. They are used
+      to control the clock phases, "ciu-sample" is required for tuning
+      high speed modes.
+
+  rockchip,default-sample-phase:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 360
+    default: 0
+    description:
+      The default phase to set "ciu-sample" at probing,
+      low speeds or in case where all phases work at tuning time.
+      If not specified 0 deg will be used.
+
+  rockchip,desired-num-phases:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 360
+    default: 360
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
+    sdmmc: mmc@ff0c0000 {
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

