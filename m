Return-Path: <SRS0=RtJ+=3D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB32C33C9E
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F5E24670
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBHWWVAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgANViW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:38:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANViW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2020 16:38:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so15502911wma.1;
        Tue, 14 Jan 2020 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lyq/c1AgxoTJINV62PbqBxPW5tduqNDJRviUR+FmcZw=;
        b=TBHWWVAByHjO/Kk+MfYkgDgcXPrgROnYZ7wyB8tkL74IrZuXQH9DZYG1ZQfKK5fvyJ
         XQr6wcCLEvFKNeb2t6eoQ8KeTKuCv7PQabxMXQOH4hP+kEfwW6AWK1MXR9tdPaNIsbmA
         OWfGgmgtJHmmeyms+F6MpOVtq0k51GyVzFZgXPmd9vJsV7cy1PWVnsI6RSBpL2PUzA0N
         wrvvwL84Yu0VFqsnA3XaTu1Sq+7Iyua6dl2f2Jyh6QjS1OXJ++e/PubmIcMLouQUINA7
         Vj4AoJt1f8IQh6VLt3LDYKZ5rXGdGZo2iIl/h38Z3sRXNfgwJrQN9mUxN9EoX0yRxoe8
         Zkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lyq/c1AgxoTJINV62PbqBxPW5tduqNDJRviUR+FmcZw=;
        b=dg7aJja7+UQ9CPwMiTEot0cF4PfI1kaNCP5ufvRll+MZtlINz0/5NIxdEo27+LyvIc
         4okjqbStNpWZusDl3c0YVHomavYwr49ZXVGUX3YTl4/eeU2CkRYio+6McwHvjXSidXj2
         R+UDKG4ro8jIs42htoZrC8C3IL+xiKhjgdTzV/3nehmHSi+NDixxq+2imN25ovEex2GS
         RJfy9gZisvNUdileDpZh/UMjDz8eRngMkP2+A3fTsaqcgOpC4vlMyLutT2IECZ6CGRwE
         gHfhlDBLSXjuqE8cgGTcDbi7JguwXobZDGCQrxEWG+c7GsduCxv4V2hw2y0anti78GgJ
         tY3w==
X-Gm-Message-State: APjAAAXOD8z3LjcrLvAm53LOYT2m/Njp7BUqRlRMBEL3mVfk40xeRAOn
        fxER47ni9WWxnQ6YQUXYCS8=
X-Google-Smtp-Source: APXvYqye+1PquDTXjIE8bARitin7+TssZrCHdlXAha5Y+IZ8hxKiG8rZ6B8PEZrOd4sPq3lWA99Y0w==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr30161927wmd.115.1579037898908;
        Tue, 14 Jan 2020 13:38:18 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w17sm21639511wrt.89.2020.01.14.13.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:38:18 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [RFC PATCH v1 2/3] dt-bindings: mmc: convert synopsys dw-mshc bindings to yaml
Date:   Tue, 14 Jan 2020 22:38:08 +0100
Message-Id: <20200114213809.27166-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200114213809.27166-1-jbx6244@gmail.com>
References: <20200114213809.27166-1-jbx6244@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the Synopsys designware mobile storage host controller
device tree bindings to yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/mmc/synopsys-dw-mshc-common.yaml      |  81 ++++++++++++
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 141 ---------------------
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |  88 +++++++++++++
 3 files changed, 169 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
new file mode 100644
index 000000000..aae84a4bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys Designware Mobile Storage Host Controller Common Properties
+
+allOf:
+  - $ref: "mmc-controller-common.yaml"
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+properties:
+  resets:
+    maxItems: 1
+    description:
+      phandle + reset specifier pair, intended to represent hardware
+      reset signal present internally in some host controller IC designs.
+      See Documentation/devicetree/bindings/reset/reset.txt for details.
+
+  reset-names:
+    const: reset
+    description:
+      Request name for using "resets" property.
+      (It will be used together with "resets" property.)
+
+  clock-frequency:
+    description:
+      Should be the frequency (in Hz) of the ciu clock.  If this
+      is specified and the ciu clock is specified then we'll try to set the ciu
+      clock to this at probe time.
+
+  fifo-depth:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The maximum size of the tx/rx fifo's. If this property is not
+      specified, the default value of the fifo size is determined from the
+      controller registers.
+
+  card-detect-delay:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 0
+    description:
+      Delay in milli-seconds before detecting card after card
+      insert event. The default value is 0.
+
+  data-addr:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Override fifo address with value provided by DT. The default FIFO reg
+      offset is assumed as 0x100 (version < 0x240A) and 0x200(version >= 0x240A)
+      by driver. If the controller does not follow this rule, please use
+      this property to set fifo address in device tree.
+
+  fifo-watermark-aligned:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Data done irq is expected if data length is less than
+      watermark in PIO mode. But fifo watermark is requested to be aligned
+      with data length in some SoC so that TX/RX irq can be generated with
+      data done irq. Add this watermark quirk to mark this requirement and
+      force fifo watermark setting accordingly.
+
+  dmas:
+    maxItems: 1
+    description:
+      List of DMA specifiers with the controller specific format as described
+      in the generic DMA client binding.
+      Refer to dma-controller.yaml for details.
+
+  dma-names:
+    const: rx-tx
+    description:
+      Request names for generic DMA client binding.
+      Refer to dma-controller.yaml for details.
diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
deleted file mode 100644
index 7e5e427a2..000000000
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-* Synopsys Designware Mobile Storage Host Controller
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core mmc properties described by mmc.txt and the
-properties used by the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be
-	- snps,dw-mshc: for controllers compliant with synopsys dw-mshc.
-* #address-cells: should be 1.
-* #size-cells: should be 0.
-
-# Slots (DEPRECATED): The slot specific information are contained within
-  child-nodes with each child-node representing a supported slot. There should
-  be atleast one child node representing a card slot. The name of the child node
-  representing the slot is recommended to be slot@n where n is the unique number
-  of the slot connected to the controller. The following are optional properties
-  which can be included in the slot child node.
-
-	* reg: specifies the physical slot number. The valid values of this
-	  property is 0 to (num-slots -1), where num-slots is the value
-	  specified by the num-slots property.
-
-	* bus-width: as documented in mmc core bindings.
-
-	* wp-gpios: specifies the write protect gpio line. The format of the
-	  gpio specifier depends on the gpio controller. If a GPIO is not used
-	  for write-protect, this property is optional.
-
-	* disable-wp: If the wp-gpios property isn't present then (by default)
-	  we'd assume that the write protect is hooked up directly to the
-	  controller's special purpose write protect line (accessible via
-	  the WRTPRT register).  However, it's possible that we simply don't
-	  want write protect.  In that case specify 'disable-wp'.
-	  NOTE: This property is not required for slots known to always
-	  connect to eMMC or SDIO cards.
-
-Optional properties:
-
-* resets: phandle + reset specifier pair, intended to represent hardware
-  reset signal present internally in some host controller IC designs.
-  See Documentation/devicetree/bindings/reset/reset.txt for details.
-
-* reset-names: request name for using "resets" property. Must be "reset".
-	(It will be used together with "resets" property.)
-
-* clocks: from common clock binding: handle to biu and ciu clocks for the
-  bus interface unit clock and the card interface unit clock.
-
-* clock-names: from common clock binding: Shall be "biu" and "ciu".
-  If the biu clock is missing we'll simply skip enabling it.  If the
-  ciu clock is missing we'll just assume that the clock is running at
-  clock-frequency.  It is an error to omit both the ciu clock and the
-  clock-frequency.
-
-* clock-frequency: should be the frequency (in Hz) of the ciu clock.  If this
-  is specified and the ciu clock is specified then we'll try to set the ciu
-  clock to this at probe time.
-
-* fifo-depth: The maximum size of the tx/rx fifo's. If this property is not
-  specified, the default value of the fifo size is determined from the
-  controller registers.
-
-* card-detect-delay: Delay in milli-seconds before detecting card after card
-  insert event. The default value is 0.
-
-* data-addr: Override fifo address with value provided by DT. The default FIFO reg
-  offset is assumed as 0x100 (version < 0x240A) and 0x200(version >= 0x240A) by
-  driver. If the controller does not follow this rule, please use this property
-  to set fifo address in device tree.
-
-* fifo-watermark-aligned: Data done irq is expected if data length is less than
-  watermark in PIO mode. But fifo watermark is requested to be aligned with data
-  length in some SoC so that TX/RX irq can be generated with data done irq. Add this
-  watermark quirk to mark this requirement and force fifo watermark setting
-  accordingly.
-
-* vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
-  specified we'll defer probe until we can find this regulator.
-
-* dmas: List of DMA specifiers with the controller specific format as described
-  in the generic DMA client binding. Refer to dma.txt for details.
-
-* dma-names: request names for generic DMA client binding. Must be "rx-tx".
-  Refer to dma.txt for details.
-
-Aliases:
-
-- All the MSHC controller nodes should be represented in the aliases node using
-  the following format 'mshc{n}' where n is a unique number for the alias.
-
-Example:
-
-The MSHC controller node can be split into two portions, SoC specific and
-board specific portions as listed below.
-
-	dwmmc0@12200000 {
-		compatible = "snps,dw-mshc";
-		clocks = <&clock 351>, <&clock 132>;
-		clock-names = "biu", "ciu";
-		reg = <0x12200000 0x1000>;
-		interrupts = <0 75 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		data-addr = <0x200>;
-		fifo-watermark-aligned;
-		resets = <&rst 20>;
-		reset-names = "reset";
-	};
-
-[board specific internal DMA resources]
-
-	dwmmc0@12200000 {
-		clock-frequency = <400000000>;
-		clock-freq-min-max = <400000 200000000>;
-		broken-cd;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		vmmc-supply = <&buck8>;
-		bus-width = <8>;
-		cap-mmc-highspeed;
-		cap-sd-highspeed;
-	};
-
-[board specific generic DMA request binding]
-
-	dwmmc0@12200000 {
-		clock-frequency = <400000000>;
-		clock-freq-min-max = <400000 200000000>;
-		broken-cd;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		vmmc-supply = <&buck8>;
-		bus-width = <8>;
-		cap-mmc-highspeed;
-		cap-sd-highspeed;
-		dmas = <&pdma 12>;
-		dma-names = "rx-tx";
-	};
diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
new file mode 100644
index 000000000..6f85a21d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys Designware Mobile Storage Host Controller Binding
+
+allOf:
+  - $ref: "synopsys-dw-mshc-common.yaml"
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+properties:
+  compatible:
+    const: snps,dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+    description:
+      Handle to "biu" and "ciu" clocks for the
+      bus interface unit clock and the card interface unit clock.
+
+  clock-names:
+    items:
+      - const: biu
+      - const: ciu
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  # The MSHC controller node can be split into two portions, SoC specific and
+  # board specific portions as listed below.
+  - |
+    dwmmc0@12200000 {
+      compatible = "snps,dw-mshc";
+      clocks = <&clock 351>, <&clock 132>;
+      clock-names = "biu", "ciu";
+      reg = <0x12200000 0x1000>;
+      interrupts = <0 75 0>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      data-addr = <0x200>;
+      fifo-watermark-aligned;
+      resets = <&rst 20>;
+      reset-names = "reset";
+    };
+  # [board specific internal DMA resources]
+  - |
+    dwmmc0@12200000 {
+      clock-frequency = <400000000>;
+      clock-freq-min-max = <400000 200000000>;
+      broken-cd;
+      fifo-depth = <0x80>;
+      card-detect-delay = <200>;
+      vmmc-supply = <&buck8>;
+      bus-width = <8>;
+      cap-mmc-highspeed;
+      cap-sd-highspeed;
+    };
+  # [board specific generic DMA request binding]
+  - |
+    dwmmc0@12200000 {
+      clock-frequency = <400000000>;
+      clock-freq-min-max = <400000 200000000>;
+      broken-cd;
+      fifo-depth = <0x80>;
+      card-detect-delay = <200>;
+      vmmc-supply = <&buck8>;
+      bus-width = <8>;
+      cap-mmc-highspeed;
+      cap-sd-highspeed;
+      dmas = <&pdma 12>;
+      dma-names = "rx-tx";
+    };
-- 
2.11.0

