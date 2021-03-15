Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1056C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 11:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBF264E86
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 11:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCOK7c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhCOK7R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2021 06:59:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC751C061574
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 03:59:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e7so56167407lft.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IX3c+BvdW2MbIRrohHrHzeOTWCyEVTQ6egFSSTYD1gI=;
        b=N6ypNPcYdtZUPSs5hOmzjV3imMNL+kiDANniGS0qabm2mCDY/vxPCF5gSdCTP55KEY
         3cVqGuve/fH8zAUBGiHDu9VfK7GzDikdzrHdMqybrXz0zsrPMUiItnZi74x/MfakWJuh
         AIJkANB8SYOeK0cHghGGdre5QsVhhL7PnZMcr9qY7vsB7VW7KmbXQBMpxAXAyPAPTC/j
         npMJn46hyyKhmZbPoKZdOwdvHxMaGldjcxxod/tf090r9wOboCK4wRSM7e271pNiU5qm
         OcubqBhUl2cxCIc73tRrpqHNupCQfZ2c6HkVKVS/i+YlRlkMVLRsNB5CpvqBDwYInueH
         dgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IX3c+BvdW2MbIRrohHrHzeOTWCyEVTQ6egFSSTYD1gI=;
        b=DFnpo3NypW16BRRvHQJk03T9VT8k6H02wmYbJ+HQiup/o+b7tN/4f5ByMfCZMOBflF
         QHMksOau0v0/gllGxkUHNmOwQvPsV3MDLfxndyJnqoQp8dWvrxGT19WX4GIImeJo1cc1
         KtEzD9VQeGwV3ebUYMbZQJnkWlRrL71kkBDN/Zcjbzpg3jVkX7ko3lzPklH9MR5EQZ2t
         0u+mVsyttiFEIkDTY10xti6UodnHAZWHLz+oSiiipVyeTL7inM0ZmNDKYOO1gyVeINpw
         JTUdd0NDCtwps2/v1Wi+6/Kywp5CVyDt/dJUqKxU2FZFChxW/dkB+MQAlbywhIM6BfU1
         1SLA==
X-Gm-Message-State: AOAM53141qGqRh7j4kGSVoHjilk5zYRX1kdHWe1jVfjPpaTWsVAtjoI3
        oS3ixcg0Kav7JctpX2+EFQ/cNw==
X-Google-Smtp-Source: ABdhPJyM7tMXEQcaokEWLz2z1piYy4iMjFfpMMcb92jiqnOHoZmgCw1x6xCYmagSEe/C6Y3NeMnWYw==
X-Received: by 2002:a19:c18f:: with SMTP id r137mr7230977lff.519.1615805955201;
        Mon, 15 Mar 2021 03:59:15 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id g21sm2617188lfr.212.2021.03.15.03.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:59:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: Convert the BCM4329 bindings to YAML and extend
Date:   Mon, 15 Mar 2021 11:59:11 +0100
Message-Id: <20210315105911.138553-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This converts the BCM4329 family bindings to YAML schema, and
extends and fixes the bindings like this:

- Name the bindings after the first chip (BCM4329) since
  wildcards like 43xx are nowadays frowned upon by the DT
  binding reviewers. We call this the "BCM4329 family"
- Add compatible strings for all the variants that seem to
  exist in the wild. (Derived from firmware listings.)
- Support specific-to-generic compatible strings (as already
  in use in DTS files).
- Add required reg property (SDIO function number)
- Add reset-gpios property (some systems wire this to a GPIO
  line).
- I have only listed Arend as maintainer for now, volunteers
  can be added.

Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Cc: Wright Feng <wright.feng@infineon.com>
Cc: Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc: Julian Calaby <julian.calaby@gmail.com>
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Specify specific-to-generic compatible strings such as
  "brcm,bcm4334-fmac", "brcm,bcm4329-fmac"
- Also allow just "brcm,bcm4329-fmac" for legacy platforms.
- Use this scheme in the example.
---
 .../net/wireless/brcm,bcm4329-fmac.yaml       | 101 ++++++++++++++++++
 .../net/wireless/brcm,bcm43xx-fmac.txt        |  38 -------
 2 files changed, 101 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
new file mode 100644
index 000000000000..b5fcc73ce6be
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4329 family fullmac wireless SDIO devices
+
+maintainers:
+  - Arend van Spriel <arend@broadcom.com>
+
+description:
+  The Broadcom Single chip MAC part for the BCM4329 family and
+  later Cypress chips in the same family named CYW4373 and similar.
+  These chips also have a Bluetooth portion described in a separate
+  binding.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm43143-fmac
+              - brcm,bcm4341b0-fmac
+              - brcm,bcm4341b4-fmac
+              - brcm,bcm4341b5-fmac
+              - brcm,bcm4329-fmac
+              - brcm,bcm4330-fmac
+              - brcm,bcm4334-fmac
+              - brcm,bcm43340-fmac
+              - brcm,bcm4335-fmac
+              - brcm,bcm43362-fmac
+              - brcm,bcm4339-fmac
+              - brcm,bcm43430a0-fmac
+              - brcm,bcm43430a1-fmac
+              - brcm,bcm43455-fmac
+              - brcm,bcm43456-fmac
+              - brcm,bcm4354-fmac
+              - brcm,bcm4356-fmac
+              - brcm,bcm4359-fmac
+              - cypress,cyw4373-fmac
+              - cypress,cyw43012-fmac
+          - const: brcm,bcm4329-fmac
+      - const: brcm,bcm4329-fmac
+
+  reg:
+    description: SDIO function number for the device, for most cases
+      this will be 1.
+
+  interrupts:
+    maxItems: 1
+    description: Out-of-band (OOB) IRQ line for waking up the host
+      in response to WLAN activity. This corresponds to the HOST_WAKE
+      line into the chip.
+
+  interrupt-names:
+    description: Name for the OOB IRQ, this must be set to "host-wake".
+    const: host-wake
+
+  brcm,drive-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Drive strength used for the SDIO pins on the device in mA.
+    minimum: 0
+    maximum: 32
+
+  reset-gpios:
+    maxItems: 1
+    description: A GPIO line connected to the WL_RST line, if present
+      this shall be flagged as active low.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    mmc@80118000 {
+      compatible = "arm,pl18x", "arm,primecell";
+      reg = <0x80118000 0x1000>;
+      clocks = <&clk 0>, <&clk 1>;
+      clock-names = "mclk", "apb_pclk";
+      interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+      bus-width = <4>;
+      non-removable;
+      vmmc-supply = <&wl_bt_reg>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      wifi@1 {
+        compatible = "brcm,bcm4334-fmac", "brcm,bcm4329-fmac";
+        reg = <1>;
+        interrupt-parent = <&gpio>;
+        interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-names = "host-wake";
+        reset-gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
deleted file mode 100644
index cffb2d6876e3..000000000000
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Broadcom BCM43xx Fullmac wireless SDIO devices
-
-This node provides properties for controlling the Broadcom wireless device. The
-node is expected to be specified as a child node to the SDIO controller that
-connects the device to the system.
-
-Required properties:
-
- - compatible : Should be "brcm,bcm4329-fmac".
-
-Optional properties:
- - brcm,drive-strength : drive strength used for SDIO pins on device in mA
-	(default = 6).
- - interrupts : specifies attributes for the out-of-band interrupt (host-wake).
-	When not specified the device will use in-band SDIO interrupts.
- - interrupt-names : name of the out-of-band interrupt, which must be set
-	to "host-wake".
-
-Example:
-
-mmc3: mmc@1c12000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
-	vmmc-supply = <&reg_vmmc3>;
-	bus-width = <4>;
-	non-removable;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-		interrupt-parent = <&pio>;
-		interrupts = <10 8>; /* PH10 / EINT10 */
-		interrupt-names = "host-wake";
-	};
-};
-- 
2.29.2

