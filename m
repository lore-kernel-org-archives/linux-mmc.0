Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F9C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3E423A5E
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbhAOWyB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbhAOWyA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 17:54:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05925C0613D3
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:53:20 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p13so12124185ljg.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwkOKiWMywT1nhekMrwy4lfU/ngaQuFn0WH4H2XVxHo=;
        b=Q03aROIejkz9Na92YUB+9Za8Mm0lQZb0mVg9pgOyrHWYHVFHcuBr7fASnBjYd3FoPd
         Af3cdgXjaAK6j7Z+MGXEm8Zc4ycyJe25w4ka5bjTCXgZnXVlk4kc9txmC55dIUx3Lvgn
         nR9o+eVIhQkKANWv/1RAktxSkE12stYCKKSHPHiNVuwhNNtX/PTbWapTpQVXxberHJPS
         9kTLqvGd2L1Ajh7omPwm12qV/a+HLfjWJ72WudFX+koMEYkAmFHNCV7XKH+xx0Qxjpo4
         B/MKI7dguNuA0LvDz3S+TGoAa0RduF/fyC2AxPqiLMYcdwlKkE79tn1KMRTvLZMU773T
         te8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwkOKiWMywT1nhekMrwy4lfU/ngaQuFn0WH4H2XVxHo=;
        b=ADneN+k9WezY51uz9lJEbaaUh/jGUhTdg0BX7/1ke73VY79q5kf7atx0lK0jog2vNO
         aAtlUqm16buP9/tbVmWkDZ5w61gEioDia7lYvIPIz3Kl4cBmx4Aa95SHuridkxOrOnfN
         Oxb2/eMpHQBSceJl4wE4kYPHrWRpurB3Z1+4w4nH94G1XLMjf60OYwJlcKuwXCV6BDog
         fDtcch1vvJ5bxViZ40b/hMoDdczbmNz5d+xLRrsoK0H4HAeGbI+z47ZOoN7i6qdou03t
         jYdQyZwMK4m+/2vLnZ0o/AA/27UnCzOPSLIQ2YnZzqQcyTStDTZJpkVEXeuwbLfzrdt2
         MHWA==
X-Gm-Message-State: AOAM531O3i6kZDooVaRALFVKkV8N27f50e40ACEsGbBoO/lcAHfWZMrn
        7jDQJAkI4/gRlhWNMpstSlVPLazbHOC5Dw==
X-Google-Smtp-Source: ABdhPJxuLgXDkNwG+bMMOfy8r+hR7M+uPpyW1ixuykiq+qKQ1a5Gf9ttl5ozg6AcnVAQptBALP7eeg==
X-Received: by 2002:a2e:b550:: with SMTP id a16mr6354870ljn.408.1610751198134;
        Fri, 15 Jan 2021 14:53:18 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id b29sm1054886lfc.12.2021.01.15.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:53:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: [PATCH] RFC: mmc: mmci: Convert bindings to DT schema
Date:   Fri, 15 Jan 2021 23:53:13 +0100
Message-Id: <20210115225313.2616477-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This converts the MMCI bindings from simple text to a proper
schema.

I can't get this to work when testing the schema and I don't
know why, possibly my fault. That is why it is RFC.

/var/linus/linux-nomadik/build-ux500/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /var/linus/linux-nomadik/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
/var/linus/linux-nomadik/build-ux500/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'cd-gpios', 'clock-names', 'clocks', 'max-frequency', 'vmmc-supply', 'vqmmc-supply' do not match any of the regexes: 'pinctrl-[0-9]+'

This appear on my machine despite:

allOf:
  - $ref: /schemas/arm/primecell.yaml#
  - $ref: /schemas/mmc/mmc-controller.yaml#

No idea why these refs are not reffed. Help.

Cc: devicetree@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/mmc/arm,pl18x.yaml    | 208 ++++++++++++++++++
 .../devicetree/bindings/mmc/mmci.txt          |  74 -------
 2 files changed, 208 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
new file mode 100644
index 000000000000..2e1157560d7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM PrimeCell MultiMedia Card Interface (MMCI) PL180 and PL181
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description:
+  The ARM PrimeCells MMCI PL180 and PL181 provides an interface for
+  reading and writing to MultiMedia and SD cards alike. Over the years
+  vendors have use the VHDL code from ARM to create derivative MMC/SD/SDIO
+  host controllers with very similar characteristics.
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+  - $ref: /schemas/mmc/mmc-controller.yaml#
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - arm,pl180
+          - arm,pl181
+          - arm,pl18x
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - description: The first version of the block, simply called
+          PL180 and found in the ARM Integrator IM/PD1 logic module.
+        items:
+          - const: arm,pl180
+          - const: arm,primecell
+      - description: The improved version of the block, found in the
+          ARM Versatile and later reference designs. Further revisions
+          exist but get detected at runtime by reading some magic numbers
+          in the PrimeCell ID registers.
+        items:
+          - const: arm,pl181
+          - const: arm,primecell
+      - description: Wildcard entry that will let the operating system
+          inspect the PrimeCell ID registers to determine which hardware
+          variant of PL180 or PL181 this is.
+        items:
+          - const: arm,pl18x
+          - const: arm,primecell
+
+  dmas:
+    description: Two or zero DMA channels for RX and TX DMA.
+    items:
+      - description: RX DMA channel
+      - description: TX DMA channel
+
+  dma-names:
+    description: One "tx" channel for transmit and one "rx" channel
+      for receive.
+    items:
+      - const: rx
+      - const: tx
+
+  power-domains: true
+
+  resets:
+    maxItems: 1
+
+  reg:
+    description: the MMIO memory window must be exactly 4KB (0x1000) and the
+      layout should provide the PrimeCell ID registers so that the device can
+      be discovered. On ST Micro variants, a second register window may be
+      defined if a delay block is present and used for tuning.
+
+  interrupts:
+    description: The first interrupt is the command interrupt and corresponds
+      to the event at the end of a command. The second interrupt is the
+      PIO (polled I/O) interrupt and occurs when the FIFO needs to be
+      emptied as part of a bulk read from the card. Some variants have these
+      two interrupts wired into the same line (logic OR) and in that case
+      only one interrupt may be provided.
+
+  st,sig-dir-dat0:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, bus signal direction pins used for
+      DAT[0].
+
+  st,sig-dir-dat2:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, bus signal direction pins used for
+      DAT[2].
+
+  st,sig-dir-dat31:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, bus signal direction pins used for
+      DAT[3] and DAT[1].
+
+  st,sig-dir-dat74:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, bus signal direction pins used for
+      DAT[7] and DAT[4].
+
+  st,sig-dir-cmd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, CMD signal direction used for
+      pin CMD.
+
+  st,sig-pin-fbclk:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, feedback clock FBCLK signal pin
+      in use.
+
+  st,sig-dir:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, signal direction polarity used for
+      pins CMD, DAT[0], DAT[1], DAT[2] and DAT[3].
+
+  st,neg-edge:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, data and command phase relation,
+      generated on the sd clock falling edge.
+
+  st,use-ckin:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, use CKIN pin from an external
+      driver to sample the receive data (for example with a voltage switch
+      transceiver).
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    mmc@5000 {
+      compatible = "arm,pl180", "arm,primecell";
+      reg = <0x5000 0x1000>;
+      interrupts-extended = <&vic 22 &sic 1>;
+      clocks = <&xtal24mhz>, <&pclk>;
+      clock-names = "mclk", "apb_pclk";
+    };
+
+    mmc@80126000 {
+      compatible = "arm,pl18x", "arm,primecell";
+      reg = <0x80126000 0x1000>;
+      interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+      dmas = <&dma 29 0 0x2>, <&dma 29 0 0x0>;
+      dma-names = "rx", "tx";
+      clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
+      clock-names = "sdi", "apb_pclk";
+      max-frequency = <100000000>;
+      bus-width = <4>;
+      cap-sd-highspeed;
+      cap-mmc-highspeed;
+      cd-gpios  = <&gpio2 31 0x4>;
+      st,sig-dir-dat0;
+      st,sig-dir-dat2;
+      st,sig-dir-cmd;
+      st,sig-pin-fbclk;
+      vmmc-supply = <&ab8500_ldo_aux3_reg>;
+      vqmmc-supply = <&vmmci>;
+    };
+
+    mmc@101f6000 {
+      compatible = "arm,pl18x", "arm,primecell";
+      reg = <0x101f6000 0x1000>;
+      clocks = <&sdiclk>, <&pclksdi>;
+      clock-names = "mclk", "apb_pclk";
+      interrupt-parent = <&vica>;
+      interrupts = <22>;
+      max-frequency = <400000>;
+      bus-width = <4>;
+      cap-mmc-highspeed;
+      cap-sd-highspeed;
+      full-pwr-cycle;
+      st,sig-dir-dat0;
+      st,sig-dir-dat2;
+      st,sig-dir-dat31;
+      st,sig-dir-cmd;
+      st,sig-pin-fbclk;
+      vmmc-supply = <&vmmc_regulator>;
+    };
+
+    mmc@52007000 {
+      compatible = "arm,pl18x", "arm,primecell";
+      arm,primecell-periphid = <0x10153180>;
+      reg = <0x52007000 0x1000>;
+      interrupts = <49>;
+      interrupt-names = "cmd_irq";
+      clocks = <&rcc 0>;
+      clock-names = "apb_pclk";
+      resets = <&rcc 1>;
+      cap-sd-highspeed;
+      cap-mmc-highspeed;
+      max-frequency = <120000000>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
deleted file mode 100644
index 4ec921e4bf34..000000000000
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-* ARM PrimeCell MultiMedia Card Interface (MMCI) PL180/1
-
-The ARM PrimeCell MMCI PL180 and PL181 provides an interface for
-reading and writing to MultiMedia and SD cards alike.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the mmci driver. Using "st" as
-the prefix for a property, indicates support by the ST Micro variant.
-
-Required properties:
-- compatible             : contains "arm,pl18x", "arm,primecell".
-- vmmc-supply            : phandle to the regulator device tree node, mentioned
-                           as the VCC/VDD supply in the eMMC/SD specs.
-
-Optional properties:
-- arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
-                           the ID provided by the HW
-- resets                 : phandle to internal reset line.
-			   Should be defined for sdmmc variant.
-- vqmmc-supply           : phandle to the regulator device tree node, mentioned
-                           as the VCCQ/VDD_IO supply in the eMMC/SD specs.
-specific for ux500 variant:
-- st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
-- st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
-- st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
-- st,sig-dir-dat74       : bus signal direction pin used for DAT[4] to DAT[7].
-- st,sig-dir-cmd         : cmd signal direction pin used for CMD.
-- st,sig-pin-fbclk       : feedback clock signal pin used.
-
-specific for sdmmc variant:
-- reg			 : a second base register may be defined if a delay
-                           block is present and used for tuning.
-- st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
-- st,neg-edge            : data & command phase relation, generated on
-                           sd clock falling edge.
-- st,use-ckin            : use ckin pin from an external driver to sample
-                           the receive data (example: with voltage
-			   switch transceiver).
-
-Deprecated properties:
-- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
-- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
-
-Example:
-
-sdi0_per1@80126000 {
-	compatible = "arm,pl18x", "arm,primecell";
-	reg = <0x80126000 0x1000>;
-	interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
-
-	dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
-	       <&dma 29 0 0x0>; /* Logical - MemToDev */
-	dma-names = "rx", "tx";
-
-	clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
-	clock-names = "sdi", "apb_pclk";
-
-	max-frequency = <100000000>;
-	bus-width = <4>;
-	cap-sd-highspeed;
-	cap-mmc-highspeed;
-	cd-gpios  = <&gpio2 31 0x4>; // 95
-	st,sig-dir-dat0;
-	st,sig-dir-dat2;
-	st,sig-dir-cmd;
-	st,sig-pin-fbclk;
-
-	vmmc-supply = <&ab8500_ldo_aux3_reg>;
-	vqmmc-supply = <&vmmci>;
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdi0_default_mode>;
-	pinctrl-1 = <&sdi0_sleep_mode>;
-};
-- 
2.29.2

