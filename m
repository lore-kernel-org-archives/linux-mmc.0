Return-Path: <SRS0=tofm=6M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC80C83000
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 21:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CCC206F0
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 21:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HU3s4HDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgD1VCp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD1VCo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2020 17:02:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26124C03C1AC;
        Tue, 28 Apr 2020 14:02:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so26344735wrv.10;
        Tue, 28 Apr 2020 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWCTEhvwNRaNadOXmecV0z32iIc2uE0AhWz2k37iTCw=;
        b=HU3s4HDERN8COZGxh0orthI/O45TIxFKJuushU2seXrnpAEquoc3nbgfyXTUJqzj9k
         pWwIHJRdvf+7MMaNKbXjUGwJktm/ZNmBhJGIURXrip0LQRzZSFyCXyNvgQ7ZXjd1QmP1
         uHbj+SO69myxFboNXV4sp05wy+K7U1UurOo5Y5kAUiIRcZBx714eWic2l1YD8n672rdH
         g/F01jHZhGdwWzK622G5Q70hcTHIWuh5NVqkjugxhV5GziaWtHOuYjhbapN5KABqJ3IC
         vTZfOWoajKPDWHBncj5EYFykYEpgfpHFquYckjfh5f0MQpaLMvh0xS/MJdOja7VtncDR
         k1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWCTEhvwNRaNadOXmecV0z32iIc2uE0AhWz2k37iTCw=;
        b=MIY+uFRyLNfvo4hGjGijPCOAuPmXqbHRFSK5QAK5PT5e7HwB7tFF+7IyyWkbImx5Kz
         HEaPKElV548skhdK8R8rBAhx9SBUkW1bl5vLiVP7wP8LQcWkB8ir2qTDZ1CM4woIM7CG
         sl/GcUlMD5DlUZG1aZ8a/E8RmO49F7+/FAVzOTZ/q6BB+DRTXkuwPI4J6/Y4BJmS6l7n
         qE6auvTWsQIVtNid6l/yRT9RWDEwyjeHGE6FKb+LwBpb5R5BTcc7fFulw6/9gQGQTj3N
         MPW7hoWWzZl9i0cATH0ExzVhrbATf2cssCsLe6auiDejTpM8I7TmZZ8G16lRMuX/AAXc
         YbQA==
X-Gm-Message-State: AGi0PuYB6n2v9Japr7Mzmb4e8JO4Hk7wmH6LMP/cFEoqCNbUrOlNFYVy
        DB2t+qvRyzwOWf1L/7vCR3w=
X-Google-Smtp-Source: APiQypLK5mVgspHODgpms7tHVmrk9rRXZgJplGen8SCZv1xfJziKnPAg1m+4drZuLFAUuML0sAcakw==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr34348682wru.417.1588107762824;
        Tue, 28 Apr 2020 14:02:42 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x18sm4709243wmi.29.2020.04.28.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:02:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        yinxin_1989@aliyun.com, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, linux.amoon@gmail.com, jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date:   Tue, 28 Apr 2020 23:02:28 +0200
Message-Id: <20200428210229.703309-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428210229.703309-1-martin.blumenstingl@googlemail.com>
References: <20200428210229.703309-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 83 +++++++++++++++++++
 .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |  8 ++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
new file mode 100644
index 000000000000..1ca44529f622
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
+      - const: clkin0
+      - const: clkin1
+      - const: clkin2
+      - const: clkin3
+      - const: pclk
+      - const: mod_clk
+      - const: sd_clk
+      - const: tx_clk
+      - const: rx_clk
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
+    #include <dt-bindings/clock/meson-mx-sdhc-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sdhc: mmc@8e00 {
+      compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+      reg = <0x8e00 0x42>;
+      interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+      #clock-cells = <1>;
+      clocks = <&xtal>,
+               <&fclk_div4>,
+               <&fclk_div3>,
+               <&fclk_div5>,
+               <&sdhc_pclk>,
+               <&sdhc SDHC_CLKID_MOD_CLK>,
+               <&sdhc SDHC_CLKID_SD_CLK>,
+               <&sdhc SDHC_CLKID_TX_CLK>,
+               <&sdhc SDHC_CLKID_RX_CLK>;
+      clock-names = "clkin0", "clkin1", "clkin2", "clkin3", "pclk",
+                    "mod_clk", "sd_clk", "tx_clk", "rx_clk";
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
2.26.2

