Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD18C2D0BF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52361207FF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PcDOdUTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLJUAt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38966 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfLJUAe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 15:00:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id d5so3043298wmb.4;
        Tue, 10 Dec 2019 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tCXSRcOGp8AB2agMQyFNpx6A5VvIGH5Te8hf64YcWw=;
        b=PcDOdUTMeTW9ZZMJ7mDGB217v44GZWE94XzfRXSgj82kQD4ttkGWJ3WiY0/FnItCQX
         04BAre3cfoGvEIFSfolLLH22vaX4z0t//H7P+QZXopaMY79J9SkUnTP+iT5tMdQO5vs5
         oZS5mYDsL/6+4VhGFEleiew50AuJGi8pJHeMravjd2P8Ck+n/P7GyvOEstUMaMMGLN9q
         Br6Z98gUcts9ysgG+t6lV9hSnkCMY9KI11hlDFdmvAIyuonFdk0RyE6bRy/KIxWgSdxQ
         eLsNh8sDH2+BERz5j/23/mxBRz8mC2zqlD5Zvz2sen8OaB7jWNX8FrnZwCvrMwu8IvWs
         z1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tCXSRcOGp8AB2agMQyFNpx6A5VvIGH5Te8hf64YcWw=;
        b=LbLCe5zn6S+0SZIxn2kElWgWps/jPCYI3CwoU5PjpGCVlA6i4bdZRjDPuAQHCq46ee
         KAQvnL0fA93ZzhGaOtZdcWq82eOqPkjdHRV/61H+4N4LhzbplX5sUj7vpAX8NHYMvlVK
         /AVYvbUQbsNfutFzQUky1IcPL6MpegkyLF6OqTq/sZtuVmHxiFUN3NtjuCHB8RXCFqpm
         XFKLKP33UvApcI9OWrzvz5xKJFxOeBvPlh9DuzSVmRMpWGK7yJ/01LehCu9GubbPWQ+A
         FlR1gUU5XYSyjpdP2wy9x3Y6ubFhFwuYADa5sSwgt47HSxhGVuFed4pz9RFHKEx98ohO
         CXLw==
X-Gm-Message-State: APjAAAU+88aPkRPMFtJUn7Z5u3Kl51gTFmyaAzbedWQ63AJ/GzYaPcNg
        6EunshroAP7SLX5sEY2Kuso=
X-Google-Smtp-Source: APXvYqzrsvco5XJD7/5sA83REuKxpORSzOHblfQuIBFlT49tQcREjH5VmRYckMc89eWDPNGust+UUw==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr6861581wmg.86.1576008032761;
        Tue, 10 Dec 2019 12:00:32 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id t81sm4428610wmg.6.2019.12.10.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:00:32 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date:   Tue, 10 Dec 2019 21:00:21 +0100
Message-Id: <20191210200022.29696-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210200022.29696-1-martin.blumenstingl@googlemail.com>
References: <20191210200022.29696-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This documents the devicetree bindings for the SDHC MMC host controller
found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
HS200 mode (up to 100MHz clock).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
new file mode 100644
index 000000000000..862aedba680f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson SDHC controller Device Tree Bindings
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |
+  The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
+  card interface with 1/4/8-bit bus width.
+  It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - amlogic,meson8-sdhc
+        - amlogic,meson8b-sdhc
+        - amlogic,meson8m2-sdhc
+      - const: amlogic,meson-mx-sdhc
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    minItems: 1
+
+  clocks:
+    minItems: 5
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: clkin0
+      - const: clkin1
+      - const: clkin2
+      - const: clkin3
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmc@8e00 {
+      compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+      reg = <0x8e00 0x42>;
+      interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&sdhc_pclk>, <&xtal>, <&fclk_div4>, <&fclk_div3>, <&fclk_div5>;
+      clock-names = "pclk", "clkin0", "clkin1", "clkin2", "clkin3";
+    };
-- 
2.24.0

