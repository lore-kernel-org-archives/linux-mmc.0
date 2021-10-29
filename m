Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684BFC43217
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 05:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE2A611AD
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 05:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhJ2GAL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 02:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhJ2GAL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 02:00:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02078C061570;
        Thu, 28 Oct 2021 22:57:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i5so6130223pla.5;
        Thu, 28 Oct 2021 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qilzTx6TKK1X+2aRAIiO3aVZc8CXREHsHyrRBETIot4=;
        b=lU4nUMph8i9q2C8bIZ/BKpadyc4ghsVdUFLfEzeqtr5ErQryzg3wTk+0ujgkM995gt
         9XmlJeDAwgxJ+n5j+/EOVIsUWMuMCUmLDVRDSA0G3MuJOLsmLYei3OVuc/k2YQFfq2ll
         fQ/X+OF9EQuo1rXtbT3SqqYN9Vl4Ue+LyaB0jcskF6XWvA++9+HklJRCv5fVucaMvoza
         sq/eV8A3o5ubk3OqTJxxp/d6IhPiywO+EQuLpiO8jK8NaROv44uSSd/rCyy3teDt2L8u
         9oomdSo8owLqasDldzBh/+SRnb4sEzHc1srM9kRBTI9IIw0IBz1TccZpG35GClbWxvEu
         X4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qilzTx6TKK1X+2aRAIiO3aVZc8CXREHsHyrRBETIot4=;
        b=ogqwqEbe2xOMxTlx+7bWlrHtEQC8xcVeCYynVkHgI2Ov3M+CiRXbFP4ObzsT/tevRj
         bQpjw3r5KLj2Qkjy6fI3Fj/6LJZz7yonpOWjJ004eRyfpypd1YGsY7+XMKPCNEt7z9nH
         ec9X49mAuGR7mtj+4m6eABr89Ds9ia+rQTaGULHUqCUhtXkfpY0ZagPwUUGHM37zVJQ7
         gCAU4YatSsihzu0z+ha6wGKrEh6s5WcWuHyIcdbMW8gYE0Ndcw60Y3Y9XEDQgCjjxObf
         +H9ttLqJlnOXuHlLNfcj2oU1VkrFZVcdig4v6dV5No6kgUdr1kzbX69M3y949bAdzOa9
         MAnQ==
X-Gm-Message-State: AOAM5333MdjwXrIGiYGJ775TeYeFZ4/79gGasFN+jsv1JK+2YrbKVk63
        G7JRJmyk1LaXGwm1gxgRQmE=
X-Google-Smtp-Source: ABdhPJyELenixa98NTfnnP0X7reuNL/m3LZPbfhNOsTmaUI8wavozCk3RtUf6ZTo4kfm36E/L20mkA==
X-Received: by 2002:a17:90a:4f83:: with SMTP id q3mr9206356pjh.127.1635487062442;
        Thu, 28 Oct 2021 22:57:42 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id mr2sm3599648pjb.25.2021.10.28.22.57.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 22:57:42 -0700 (PDT)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     ulf.hansson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH 2/2] devicetree bindings mmc Add bindings doc for Sunplus SP7021
Date:   Fri, 29 Oct 2021 13:57:35 +0800
Message-Id: <1635487055-18494-3-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add devicetree bindings mmc Add bindings doc for Sunplus SP7021

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
 .../devicetree/bindings/mmc/sunplus-sd2.yaml       | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
new file mode 100644
index 0000000..02f0479
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus-sd2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SD/SDIO controller
+
+maintainers:
+  - lh.kuo <lh.kuo@sunplus.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-card1
+      - sunplus,sp7021-sdio
+
+  reg:
+    items:
+      - description: Base address and length of the SD/SDIO registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  pinctrl-names:
+    description:
+      A pinctrl state named "default" must be defined.
+    const: default
+
+  pinctrl-0:
+    description:
+      A phandle to the default pinctrl state.
+
+  max-frequency: true
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - pinctrl-names
+  - pinctrl-0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mmc1: mmc@9C003e80 {
+       compatible = "sunplus,sp7021-card1";
+       reg = <0x9c003e80 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc CARD_CTL1>;
+       resets = <&rstc RST_CARD_CTL1>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
+       max-frequency = <52000000>;
+    };
+    sdio: mmc@9C008400 {
+       compatible = "sunplus,sp7021-sdio";
+       reg = <0x9c008400 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc CARD_CTL1>;
+       resets = <&rstc RST_CARD_CTL1>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&pins_sdio>;
+       max-frequency = <52000000>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0fb096d..83464c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17951,6 +17951,7 @@ SUNPLUS SD/SDIO HOST CONTROLLER INTERFACE DRIVER
 M:	LH Kuo <lh.kuo@sunplus.com>
 L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
 F:	drivers/mmc/host/Kconfig
 F:	drivers/mmc/host/Makefile
 F:	drivers/mmc/host/sunplus_sd2.*
-- 
2.7.4

