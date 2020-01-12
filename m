Return-Path: <SRS0=SKJ7=3B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02369C33CA9
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Jan 2020 00:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4B52071A
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Jan 2020 00:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vZ3qFYvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbgALAZY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:25:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40076 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbgALAZX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jan 2020 19:25:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so5197063wrn.7;
        Sat, 11 Jan 2020 16:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRYfuTJuy4ICmcEVYmYYaJ9iq8iqh3Fd6F2pqTPly4U=;
        b=vZ3qFYvjxPQnSXjLDUC2VIqRG1l5EmaQe6BwYk/le+x0rNyTYMiiTy7tYkf/z0eAy+
         BA0bcljF3UTSGyq7u1Wsb8or9I0ddWWKb4xR13jdqzd/xJvxy0wF8WmjL8YUYd5M/asy
         91Ea+lHlxn6rmY79AL0ex0ZFDc69lgvIMVwpyG5ikv5f9iH6Vz9K8QsupKPxhGN4grlX
         H8CYutfnwVMKL9V07i4wAPask6eNF6PYMgqpzoeuIcVKg3kNYIB5/9CTfbYMlt0o7coI
         FXy+yngMsfjR0uucp+IzRYdFSXOsnKHReCzKx2AOQElGRG+8X29B20wEmnfLaxbNUhM3
         Sb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRYfuTJuy4ICmcEVYmYYaJ9iq8iqh3Fd6F2pqTPly4U=;
        b=TGhQpDYumLRomnSbT+Iqp7KNl6/+QdQpwk3+50GcF7rCws8So1Mqb6ZLjpCLHT+1/S
         igajTX7AIGroViffGydnvR2ux6zT6zIkNJyRZo2h9lDV+iFpyd4T26OvsX2zsH5W/6Re
         TxzErXj7YeUpnjAAWNqVAI7J1KNqm5Xz8XKsckGPehtudFmjRx8SwQ3BfYq1ZH5gUox7
         aho332wNM59w27zTvbgJrnOgb7CVlH3jWBIJiT3yLsOwj2Ntp7Xc1VYssaUqzrygXtbA
         P6squnx5f4lXzGug9aDEI2pGaF/T/GD7WEFsmWb0bp9AOTptEfcZls9a++ErQzWLiEEP
         r/bw==
X-Gm-Message-State: APjAAAVtHAIqSVIAOgPjhy20fUAvZtUmtaykog4+WyuU/HE/bdu+44Of
        lwfXU4YU0EkBtwPDBsrg+dE=
X-Google-Smtp-Source: APXvYqzfkMPyJclbK5x1eGwqJu5YGbbeqrV0pR+3CV5gs2Vxkv//LYzheqNHhBRiJG4TWNach+NvlQ==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr10351489wrx.44.1578788720393;
        Sat, 11 Jan 2020 16:25:20 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id t5sm8407389wrr.35.2020.01.11.16.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 16:25:19 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 1/3] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date:   Sun, 12 Jan 2020 01:24:57 +0100
Message-Id: <20200112002459.2124850-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112002459.2124850-1-martin.blumenstingl@googlemail.com>
References: <20200112002459.2124850-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This documents the devicetree bindings for the SDHC MMC host controller
found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
HS200 mode (up to 100MHz clock). It embeds an internal clock controller
which outputs four clocks (mod_clk, sd_clk, tx_clk and rx_clk) and is
fed by four external input clocks (clkin[0-3]). "pclk" is the module
register clock, it has to be enabled to access the registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 83 +++++++++++++++++++
 .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |  8 ++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
new file mode 100644
index 000000000000..74632692ce26
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
@@ -0,0 +1,83 @@
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
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    minItems: 9
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: mod_clk
+      - const: sd_clk
+      - const: rx_clk
+      - const: tx_clk
+      - const: clkin0
+      - const: clkin1
+      - const: clkin2
+      - const: clkin3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/meson-mx-sdhc-clkc.yaml>;
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sdhc: mmc@8e00 {
+      compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+      reg = <0x8e00 0x42>;
+      interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+      #clock-cells = <1>;
+      clocks = <&sdhc_pclk>,
+               <&sdhc SDHC_CLKID_MOD_CLK>,
+               <&sdhc SDHC_CLKID_SD_CLK>,
+               <&sdhc SDHC_CLKID_TX_CLK>,
+               <&sdhc SDHC_CLKID_RX_CLK>,
+               <&xtal>,
+               <&fclk_div4>,
+               <&fclk_div3>,
+               <&fclk_div5>;
+      clock-names = "pclk", "mod_clk", "sd_clk", "tx_clk", "rx_clk",
+                    "clkin0", "clkin1", "clkin2", "clkin3";
+    };
diff --git a/include/dt-bindings/clock/meson-mx-sdhc-clkc.h b/include/dt-bindings/clock/meson-mx-sdhc-clkc.h
new file mode 100644
index 000000000000..ad9f6e4dc426
--- /dev/null
+++ b/include/dt-bindings/clock/meson-mx-sdhc-clkc.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define SDHC_CLKID_SRC_SEL	0
+#define SDHC_CLKID_DIV		1
+#define SDHC_CLKID_MOD_CLK	2
+#define SDHC_CLKID_SD_CLK	3
+#define SDHC_CLKID_TX_CLK	4
+#define SDHC_CLKID_RX_CLK	5
-- 
2.24.1

