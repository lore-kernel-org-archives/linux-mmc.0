Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C9C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4974122B4E
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 14:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392846AbhAROS2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 09:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbhAROSU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2021 09:18:20 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F0C061575
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jan 2021 06:17:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u25so24302863lfc.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jan 2021 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4cLRkD5fMwA8Gc20pqhJAXTwKJ6eAulUDWsudxs4dBs=;
        b=eUGXgEqnkJ/7zQ8WZ3tYl6gC+d8tiyn4lC7t8LQyyIOFIqMWEIfuIRF5tuiqcHcLXf
         ml7OgG6+Cd4wLWRY32OEHCodUSa6uZFm7XMDRy0D3h+n3+swtl8czdNJVjuSzHHZ5ZjM
         nGAcoyNgrFVhODd1Q9a1LHlrxmiUwWBbkZd58M0gAuaopC+aWD8EMKFDdUhzZ3IQgXsI
         ld74e+h5P8r30GscJ8JzIrynxz+esVOzMLulrnnqWt0jzRJhQjbXt3co3WeAdEs8VTba
         1cFP39uqXsnMFlW/ZHPjV2bWoP2V6bSV6r96YfgpWCdoici2yPxnPjBXZIxowLip3Jjr
         zC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4cLRkD5fMwA8Gc20pqhJAXTwKJ6eAulUDWsudxs4dBs=;
        b=XxcNOsfRTw1y9IjIixuC/5tjfDvJfEHL+0ffQd9pQqOENvZkzhejfCstiFrZW7sC5Y
         GIiaKXTbxah+Wh7SX76VdVvkQTq8X2tTwiMDkr1ndVRHni9ylHBhfi8OzpESLO1Bf/ku
         5ETSoEBGwxdMseRt2B9oBPfUIKl6t2aRmdOXYi0IrvTyZW1KVssH0OIJqZyyHTE2tpsK
         icMhhkzvrHUdCr+1TOUL7zqdIFRADSBFLy/olZ+VyTMtBcoK4Smb3zhcPBU0kd0zftC5
         xnYS1uRVBioQBJuDKrofZbxlko1+/xtHVNOk7jdUg5eexFiezzLwiMP2PZK4j/CJS0TX
         Mv2g==
X-Gm-Message-State: AOAM531j6SET2BrZxxPsEPW7IOQmGnl3+rWkScvmNzmXSjyg+ZgWcS+g
        PoQsrfsZNe8QFmwilTDF5dvh9W4atj355A==
X-Google-Smtp-Source: ABdhPJwVkGjH38o/DgaLFGP8QWPyUTY3reaUbkdfFfLsZbCVMY2rKjo0Bc+ArcAz9YYxiNbc61XYMg==
X-Received: by 2002:a05:6512:491:: with SMTP id v17mr11504155lfq.148.1610979457888;
        Mon, 18 Jan 2021 06:17:37 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id a24sm1907358lfg.256.2021.01.18.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:17:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: [PATCH v2] mmc: mmci: Convert bindings to DT schema
Date:   Mon, 18 Jan 2021 15:17:34 +0100
Message-Id: <20210118141734.2722369-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This converts the MMCI bindings from simple text to a proper
schema.

Cc: devicetree@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use unevaluatedProperties: false instead of
  additionalProperties: false and refs start working.
- Define clocks to 1 or 2 items.
- Define interrupts to 1 or 2 items.
---
 .../devicetree/bindings/mmc/arm,pl18x.yaml    | 216 ++++++++++++++++++
 .../devicetree/bindings/mmc/mmci.txt          |  74 ------
 2 files changed, 216 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
new file mode 100644
index 000000000000..7b8f189acc61
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -0,0 +1,216 @@
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
+  - $ref: mmc-controller.yaml#
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
+  clocks:
+    description: One or two clocks, the "apb_pclk" and the "MCLK"
+      which is the core block clock. The names are not compulsory.
+    minItems: 1
+    maxItems: 2
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
+    minItems: 1
+    maxItems: 2
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
+unevaluatedProperties: false
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

