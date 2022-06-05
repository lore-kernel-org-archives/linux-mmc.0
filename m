Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C98CCA484
	for <linux-mmc@archiver.kernel.org>; Sun,  5 Jun 2022 13:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbiFENdX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 5 Jun 2022 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiFENdW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2022 09:33:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C738DA3
        for <linux-mmc@vger.kernel.org>; Sun,  5 Jun 2022 06:33:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso8688858wmh.3
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2022 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iD0AT9Ulc1i16U7giR4n88maA1Cd/1tBAzCeefFKFTY=;
        b=ILnwRkHVIcM9WPFdbjX0m54y//OEZHvWFBEO5lTy+DYw3ARheHtNZ2jKwQIcWJP1bw
         SSpxhIMnPMWIck/KeG0x3/JHuGPfZRqBDkBkMDiwMgWVsnVfWeUeN4OHJnu4PWABD422
         MhP0I7MNeQgfFtQ6NamRDRMb7hRrFQVkrizly2s7TYYpFPBkmCmwPlSAaUtLT/3cDBWB
         TaLnbLz/325+osIuWILxSyB8V5CM0A48RrOHE6DwXYRA1MKYjNPLq1n3zExaHujZydWA
         BowYDDQkhKDTvauumfUdu8PGed5QENOWO780QH2I8BZaO+JKJGmlkLWAT3ZA6zTA2fc+
         mHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iD0AT9Ulc1i16U7giR4n88maA1Cd/1tBAzCeefFKFTY=;
        b=PyF6RFFRYRdY7BhN4xkNFYZ/GBGVyRKwKLaX1hC9AhdL6QFX5dCoBS8SPmISn0toB1
         oF+Bc7wR/LFw47v+sfakBkcPFhnW8kU//XJD9afWcI/fTogX91KkjIb2dCwuFJKl8ecL
         DciB6uaZv7EKqZQ5QdzL7AUGRfN1qvvmTlPPAB7bC3EKCCnVotzRw059FY9drCtkpu8K
         wTtv855GWXcQddQSCsH4VLNISRZJDBA8l4/v/HtDISCB4k1KnKLKRnaeHhIa+WUnUfqx
         aWX7mdq8BrhmHeN+jxg8jXYV0kkmFZQYBMpuYlgpo54WPC7gIqQkS4AQ3ETNWZKEcMys
         8NMg==
X-Gm-Message-State: AOAM532SMTFDGVf/wljkz7c0SD4wgxsmK13/GcuwJu4YdN6z0Vmkox/g
        mVPxKESpOlFuYvhEovLnuAmBeA==
X-Google-Smtp-Source: ABdhPJzy3arg2urk/arEHLc/LofFxNLx6PWCgGfxODw4J3E1atFORuRSw5c2jxJ1KoeetRxv07o/xw==
X-Received: by 2002:a05:600c:378d:b0:39c:4950:aef8 with SMTP id o13-20020a05600c378d00b0039c4950aef8mr5251629wmr.96.1654435997986;
        Sun, 05 Jun 2022 06:33:17 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id n187-20020a1c27c4000000b0039c151298b7sm18217076wmn.10.2022.06.05.06.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 06:33:17 -0700 (PDT)
From:   mail@conchuod.ie
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atul Khare <atulkhare@rivosinc.com>
Subject: [PATCH v1 2/6] dt-bindings: i2c: convert ocores binding to yaml
Date:   Sun,  5 Jun 2022 14:32:57 +0100
Message-Id: <20220605133300.376161-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220605133300.376161-1-mail@conchuod.ie>
References: <20220605133300.376161-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Convert the open cores i2c controller binding from text to yaml.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/i2c/i2c-ocores.txt    |  78 -----------
 .../devicetree/bindings/i2c/i2c-ocores.yaml   | 132 ++++++++++++++++++
 2 files changed, 132 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
deleted file mode 100644
index a37c9455b244..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-Device tree configuration for i2c-ocores
-
-Required properties:
-- compatible      : "opencores,i2c-ocores"
-                    "aeroflexgaisler,i2cmst"
-                    "sifive,fu540-c000-i2c", "sifive,i2c0"
-                    For Opencore based I2C IP block reimplemented in
-                    FU540-C000 SoC.
-                    "sifive,fu740-c000-i2c", "sifive,i2c0"
-                    For Opencore based I2C IP block reimplemented in
-                    FU740-C000 SoC.
-                    Please refer to sifive-blocks-ip-versioning.txt for
-                    additional details.
-- reg             : bus address start and address range size of device
-- clocks          : handle to the controller clock; see the note below.
-                    Mutually exclusive with opencores,ip-clock-frequency
-- opencores,ip-clock-frequency: frequency of the controller clock in Hz;
-                    see the note below. Mutually exclusive with clocks
-- #address-cells  : should be <1>
-- #size-cells     : should be <0>
-
-Optional properties:
-- interrupts      : interrupt number.
-- clock-frequency : frequency of bus clock in Hz; see the note below.
-                    Defaults to 100 KHz when the property is not specified
-- reg-shift       : device register offsets are shifted by this value
-- reg-io-width    : io register width in bytes (1, 2 or 4)
-- regstep         : deprecated, use reg-shift above
-
-Note
-clock-frequency property is meant to control the bus frequency for i2c bus
-drivers, but it was incorrectly used to specify i2c controller input clock
-frequency. So the following rules are set to fix this situation:
-- if clock-frequency is present and neither opencores,ip-clock-frequency nor
-  clocks are, then clock-frequency specifies i2c controller clock frequency.
-  This is to keep backwards compatibility with setups using old DTB. i2c bus
-  frequency is fixed at 100 KHz.
-- if clocks is present it specifies i2c controller clock. clock-frequency
-  property specifies i2c bus frequency.
-- if opencores,ip-clock-frequency is present it specifies i2c controller
-  clock frequency. clock-frequency property specifies i2c bus frequency.
-
-Examples:
-
-	i2c0: ocores@a0000000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "opencores,i2c-ocores";
-		reg = <0xa0000000 0x8>;
-		interrupts = <10>;
-		opencores,ip-clock-frequency = <20000000>;
-
-		reg-shift = <0>;	/* 8 bit registers */
-		reg-io-width = <1>;	/* 8 bit read/write */
-
-		dummy@60 {
-			compatible = "dummy";
-			reg = <0x60>;
-		};
-	};
-or
-	i2c0: ocores@a0000000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "opencores,i2c-ocores";
-		reg = <0xa0000000 0x8>;
-		interrupts = <10>;
-		clocks = <&osc>;
-		clock-frequency = <400000>; /* i2c bus frequency 400 KHz */
-
-		reg-shift = <0>;	/* 8 bit registers */
-		reg-io-width = <1>;	/* 8 bit read/write */
-
-		dummy@60 {
-			compatible = "dummy";
-			reg = <0x60>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.yaml b/Documentation/devicetree/bindings/i2c/i2c-ocores.yaml
new file mode 100644
index 000000000000..1693ffffbe31
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-ocores.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OpenCores I2C controller
+
+maintainers:
+  - Peter Korsgaard <peter@korsgaard.com>
+  - Andrew Lunn <andrew@lunn.ch>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu740-c000-i2c # Opencore based IP block FU740-C000 SoC
+              - sifive,fu540-c000-i2c # Opencore based IP block FU540-C000 SoC
+          - const: sifive,i2c0
+      - const: opencores,i2c-ocores
+      - const: aeroflexgaisler,i2cmst
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  clock-frequency:
+    description: |
+      Desired I2C bus clock frequency in Hz. As only Standard and Fast
+      modes are supported, possible values are 100000 and 400000.
+      Note:
+      clock-frequency property is meant to control the bus frequency for i2c bus
+      drivers, but it was incorrectly used to specify i2c controller input clock
+      frequency. So the following rules are set to fix this situation:
+      - if clock-frequency is present and neither opencores,ip-clock-frequency nor
+        clocks are, then clock-frequency specifies i2c controller clock frequency.
+        This is to keep backwards compatibility with setups using old DTB. i2c bus
+        frequency is fixed at 100 KHz.
+      - if clocks is present it specifies i2c controller clock. clock-frequency
+        property specifies i2c bus frequency.
+      - if opencores,ip-clock-frequency is present it specifies i2c controller
+        clock frequency. clock-frequency property specifies i2c bus frequency.
+    default: 100000
+
+  reg-io-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      io register width in bytes
+    enum: [1, 2, 4]
+
+  reg-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      device register offsets are shifted by this value
+
+  regstep:
+    description: |
+      deprecated, use reg-shift above
+    deprecated: true
+
+  opencores,ip-clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Frequency of the controller clock in Hz. Mutually exclusive with clocks.
+      See the note above.
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+oneOf:
+  - required:
+      - opencores,ip-clock-frequency
+  - required:
+      - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c@a0000000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "opencores,i2c-ocores";
+      reg = <0xa0000000 0x8>;
+      interrupts = <10>;
+      opencores,ip-clock-frequency = <20000000>;
+
+      reg-shift = <0>;	/* 8 bit registers */
+      reg-io-width = <1>;	/* 8 bit read/write */
+
+      dummy@60 {
+        compatible = "dummy";
+        reg = <0x60>;
+      };
+    };
+
+    i2c@b0000000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "opencores,i2c-ocores";
+      reg = <0xa0000000 0x8>;
+      interrupts = <10>;
+      clocks = <&osc>;
+      clock-frequency = <400000>; /* i2c bus frequency 400 KHz */
+
+      reg-shift = <0>;	/* 8 bit registers */
+      reg-io-width = <1>;	/* 8 bit read/write */
+
+      dummy@60 {
+        compatible = "dummy";
+        reg = <0x60>;
+      };
+    };
+...
-- 
2.36.1

