Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3688C433F5
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865CE611C4
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhKFO0J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 Nov 2021 10:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhKFO0I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2021 10:26:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FDC061570;
        Sat,  6 Nov 2021 07:23:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a9so10862955pgg.7;
        Sat, 06 Nov 2021 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Llpw+7NeLTS8m5u2NuY67826xOGs0cYfxGPe+YbITY=;
        b=hZU4MJJ+gMpk0uTtchXcvo9QOHa+iJjgjsc8tgPuWNyDPvOVY/zpKtUACHwn6Zy5+z
         R7INr0l5ggWya+IXM4KHSpO6HRt9in1w6OaOJN+BScDPOwY3MgIJjvjEaFQwCMKhIfus
         MCaYBcxCszQgWBO68b7NJcBaTTvwv6nagzHZJHJg+I2kpFhjIbidU0Wpc1aXIHi8e9UC
         nYarplvAu0xmaWj2JZFaSC+w7K7igqEkuuntTGbXD8z8GqL0RKrx6BhQAj3+HxqMlOAi
         DhPs01gATR2VBa3OxmcTo57i83fs/K2bw5vdmcIAyv9F2IoFLGiU8WS//ZithGWHRYqO
         eRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Llpw+7NeLTS8m5u2NuY67826xOGs0cYfxGPe+YbITY=;
        b=KXmgM5twIBvuznsvuI5Om9403o9PNpEAQTb3K2Gm6Ggn2dxLnusXQ0ClMcHLuwMwu/
         sG7mvrcBkluhcDcLR+PRbEy0nBmR0tGhiMB0piwrajyPM+FrJCL4tFIrygCxRpN622Ky
         +k94CwHrI+oviUAzzjeS83EltgnO7Wc3Ho5A7mNMiM07SHZ7MrsSMMskgpwP32wFGsoK
         MPOr2RToE9d4zSYVffW+oj1Ng/fUl1uETsNwiOKSaz42VjT7PKSeXJ/zPoRnY2OiVpZV
         l5YlcEVRFHlqKNw163MXRKeNpyZsCQeWNS6mqPCKGeuq1AEJxusjbu2lvOtCp72qt1/Q
         QkGA==
X-Gm-Message-State: AOAM533SDLsDUCmaUUKztGRgHMzQl+4QtPqL4spN6xmrJc7qcwbA+EgE
        14FR6LgOwP4egTX4Ih6dkng=
X-Google-Smtp-Source: ABdhPJzcp+J1f1E3VGoX9u2MPbi2mw6eoQAJ9AYvEfmOjPMR3xOkwpm31I0sseKuT2rvZspGDx5+Zw==
X-Received: by 2002:a63:154:: with SMTP id 81mr49610491pgb.38.1636208606638;
        Sat, 06 Nov 2021 07:23:26 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m4sm10859258pjs.1.2021.11.06.07.23.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Nov 2021 07:23:26 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
X-Google-Original-From: Tony Huang <tony.huang@sunplus.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Tony Huang <tony.huang@sunplus.com>
Subject: [PATCH 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Sat,  6 Nov 2021 22:23:17 +0800
Message-Id: <1636208598-18234-2-git-send-email-tony.huang@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
References: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add mmc yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tony.huang@sunplus.com>
---
 .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 64 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
new file mode 100644
index 0000000..fc5a5f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: sunplus MMC controller
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - tony.huang <tony.huang@sunplus.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-emmc
+      - sunplus,i143-emmc
+      - sunplus,q645-emmc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
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
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    mmc0: mmc@9c003b00 {
+        compatible = "sunplus,sp7021-emmc";
+        reg = <0x9c003b00 0x180>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc CARD_CTL0>;
+        resets = <&rstc RST_CARD_CTL0>;
+        bus-width = <8>;
+        max-frequency = <52000000>;
+        non-removable;
+        disable-wp;
+        cap-mmc-highspeed;
+        mmc-ddr-3_3v;
+        no-sdio;
+        no-sd;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..179e60a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tony.huang@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplu-mmc.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

