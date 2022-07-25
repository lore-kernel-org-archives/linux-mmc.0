Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BECCA473
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jul 2022 05:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiGYFCW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jul 2022 01:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFCV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2022 01:02:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5257654;
        Sun, 24 Jul 2022 22:02:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y24so9375849plh.7;
        Sun, 24 Jul 2022 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=oLq6ut1onZYrozbywvMK0WLmli+rZOozqKd6RzzXJRQ=;
        b=AX6no/npOC+H02syql4sRTqrUNLnbQQ6a59+vkFzEUbyI1rIyKhK5leFBSwo9JC9/Q
         icGOvprd9gdvu/OUjiLsmemATTluNDUrTpcWAP3T+gtTJnpV0a6KAOZEFqmxLVLceTaH
         bCKWGZgSmkEeWTswn7u0Q8oFLS17Gxf8T12P9KxGOXHDBdoZnjQv3+O+pyHBNc1W8aiK
         oWOt4GlE331cR0S5j5TffsfiH63Kw9aAQ2wg624FFtiwlW4VrumrYyEs4Lzz61ZXn7/Y
         V/boE3WxaSQuVRjd5xEZMcST4EUhI3Fe5Bt3Cujh5i2TYTq5pcs8KOM2Y8hScf7IrA7N
         LEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oLq6ut1onZYrozbywvMK0WLmli+rZOozqKd6RzzXJRQ=;
        b=xbtNrr0fTfPUNgdcn709k/lQBByQn7+0FL39GOvk9iu9bBxxDXNajlLThcYw7lqLqE
         ZwFz9tCKoxoOd9r5qhYH7SNirycdCono5KQu5BtPRjdINVR23be/39JCrCKWqS+2PKsE
         vv/QJJzvSG7XdJbTEmXAOzWaNn2XDhToQ/RBcMKgVHVu8TOcNGaDMv+oIoYAbXimf/AI
         iM3PpKGvA9kNb3/Ds9NSGKDvBaIRQF6JIiLENwMKY4jrYq07P+31kxcsCtFsIL3VRVoR
         LDOYz4vFRwgPQEz7p7Mr8tOAC4UqxK9za+GPvV/TdN6/XmfAc73sCFh51a57UqhusUdV
         6BNw==
X-Gm-Message-State: AJIora86RodyTV514A69ED3zpYmqIAIr165MKmbontQIyMJf2l1P6/Sy
        S2biBlLkwC9k8Cl62XBUGNw=
X-Google-Smtp-Source: AGRyM1snbbMhrQb6BcVRtW6qq576EN/9rTfpWbBuSecy9EuhV0nq2Fyr0q3QIcLtCXs73FmE2s5rJw==
X-Received: by 2002:a17:90a:4e81:b0:1f2:12a9:7a4e with SMTP id o1-20020a17090a4e8100b001f212a97a4emr12407260pjh.130.1658725337944;
        Sun, 24 Jul 2022 22:02:17 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x194-20020a6286cb000000b0052ad49292f0sm8347423pfd.48.2022.07.24.22.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2022 22:02:17 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kerenl@vger.kernel.org, p.zabel@pengutronix.de,
        kuba@kernel.org, davem@davemloft.net,
        colin.foster@in-advantage.com, vladimir.oltean@nxp.com,
        tonyhuang.sunplus@gmail.com, wells@sunplus.com,
        tony.huang@sunplus.com
Subject: [PATCH v8 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Mon, 25 Jul 2022 13:01:38 +0800
Message-Id: <6f398010c73e941e73521598fd7b55e84aea1c7e.1658719324.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1658719324.git.tonyhuang.sunplus@gmail.com>
References: <cover.1658719324.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1658719324.git.tonyhuang.sunplus@gmail.com>
References: <cover.1658719324.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add MMC YAML file for Sunplus SP7021.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v5:
 - Addressed comments from Krzysztof.

Changes in v6:
 - Addressed comments from Krzysztof.
 - To substitute MMC for mmc. To substitute YMAL for ymal.
 - Remove max-frequency.
 - Fixed wrong file name.

Changes in v7:
 -No change.

Changes in v8:
 -No change.

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 62 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
new file mode 100644
index 0000000..50f2119
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus MMC Controller
+
+maintainers:
+  - Tony Huang <tonyhuang.sunplus@gmail.com>
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-mmc
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
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc0: mmc@9c003b00 {
+        compatible = "sunplus,sp7021-mmc";
+        reg = <0x9c003b00 0x180>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x4e>;
+        resets = <&rstc 0x3e>;
+        bus-width = <8>;
+        max-frequency = <52000000>;
+        non-removable;
+        disable-wp;
+        cap-mmc-highspeed;
+        mmc-ddr-3_3v;
+        no-sdio;
+        no-sd;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d4..cdd809a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18869,6 +18869,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
+
 SUNPLUS OCOTP DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 S:	Maintained
-- 
2.7.4

