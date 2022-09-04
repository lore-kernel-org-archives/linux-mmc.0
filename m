Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B345BC6FA86
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Sep 2022 16:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIDQCU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Sep 2022 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiIDQCT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Sep 2022 12:02:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51A32DAE;
        Sun,  4 Sep 2022 09:02:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b144so1716193pfb.7;
        Sun, 04 Sep 2022 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=L2H/oj4SnOjK2VDh3ZkTvmpNlDpNqu22JOvA8inQcug=;
        b=VV3bZrfvBEX7UoPBolh+3vNrIQnDKyTUqL/n4foHFmKH9VYZHfCYzw0w7snUwt8xEY
         OJxYAIPox2hOzRXHhNcO9J0e9qyEMrSzR21/7EEpiGM6olNbgCNlk5igGGyYtFhXG/vP
         t7VDMmea29EbZZATo29EhbIeP8iW9FIA9F14kngi4jS7TOxdIUH8Kq1hXTIwdFHohcVL
         F7L+aTF7K+5Ln+8QyEd5uTUYTIYoEeRgucHZbj3nTdLI6DCozp8LmNIqvZLipXYU8Woi
         FTWjHAQqSSs46REDRFCUDqiTU2LCSkX372Heh0J3/oVcbgNzfbEDZAUUDrK04zs0lith
         tbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=L2H/oj4SnOjK2VDh3ZkTvmpNlDpNqu22JOvA8inQcug=;
        b=wlpX3psn2Xq6uitAVH8hIHEULKo4BVPY4Dv0Vp3laaAV91RELt3NBM5xhWHlVTXA1s
         dVkmD1Rv7I7egteMA4cKkXAXIWHDv5tvXLzbj2KFnGTMaWWPbZohNo2apLdNdxbTIDSd
         M7X6p1+v/beGNe0GancSIq4dVXgWW6MIHITbRAdAyDNVMmw8RDstK5loXUO152e7gQm+
         r7OkqbXanU5G4cwT6kwVrToBPiL9rzGkMwsET1Lm7Y93dkwrKx14PhQ00floD+RItsdS
         bgrV9ta6901h0krC5W03Q1qpvKMP0WYSp3XyDdZJRrE+B5wzeeokZ0igOMDJ3S5ABtPA
         7KlQ==
X-Gm-Message-State: ACgBeo1WospMTyof2gTqHxQawlnYSMwf+xJkI7/zLR2kVbYRaNp/htIo
        gLJA1P7xKTX/X/uHxyyW8Go=
X-Google-Smtp-Source: AA6agR50fpmfSHt5deyHU15EAqv/KS8TOC8iB23bx7LsSmqyOc+NpR+MEwT+osOgHlkD77ZFcaU5dg==
X-Received: by 2002:a65:6d0f:0:b0:42b:42f8:efe0 with SMTP id bf15-20020a656d0f000000b0042b42f8efe0mr39601067pgb.197.1662307336728;
        Sun, 04 Sep 2022 09:02:16 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 205-20020a6217d6000000b0053818255880sm5739390pfx.193.2022.09.04.09.02.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2022 09:02:16 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.huang@sunplus.com,
        wells.lu@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v9 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Mon,  5 Sep 2022 00:02:01 +0800
Message-Id: <859a2c70816765f67fc058346806866551c39f7c.1662302950.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1662302950.git.tonyhuang.sunplus@gmail.com>
References: <cover.1662302950.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1662302950.git.tonyhuang.sunplus@gmail.com>
References: <cover.1662302950.git.tonyhuang.sunplus@gmail.com>
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

Changes in v9:
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

