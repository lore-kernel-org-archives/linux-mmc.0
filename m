Return-Path: <SRS0=7kHn=62=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E28AC2D0F8
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAEF20784
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 20:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PTmxPWiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgELUmL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 May 2020 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgELUmK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 May 2020 16:42:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861EC061A0C;
        Tue, 12 May 2020 13:42:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y16so10399474wrs.3;
        Tue, 12 May 2020 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/MZ64ZWZPbBAmbiWuLigvdZwA3g/awfq0AQNrERjSW4=;
        b=PTmxPWiwDZDGYCjKZ8QYcYteajpWaoU+FHqh/Fd/j3e9FugQqZvJxkat1mTzhWlUj0
         p4uyInI8YT1FaBaYoEYGy5Am22fVXXHnwLx8CbzMTrI/FWjTdnNdETF3FWZF89SAw4G9
         zhwiMuUMcneIuaZIBnJPsRrJBtBffgsVUzX8DJZuhXQWptPErwfDJfMzI4V8c1WezEiU
         qsf99zj1r2EsldSuO36gnrU6Lb62C4LkeMWpj7tUHFCqR8efmGBbJK5Sg6r/7r1DUrjA
         k+9gojzChGBsAQwlYdd8D5FYe2KrsGQcF9Kplcqq5v8XSs+nR9Wz/nfnp5Nw4WOWjGHm
         92Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/MZ64ZWZPbBAmbiWuLigvdZwA3g/awfq0AQNrERjSW4=;
        b=q5fxUTbiKVdBEckZ/yhBvNJ/8FJGA2UnwjSWmo5ZoBpwWbgPoP2H4GIghmuKm3rtkc
         5yL/kjYfSU/VuRZCovOcZ9veiFEvTdOfIPPH0SI6lA5klzFf+j3YY3q9FU9viVYFZG5p
         He6NVG6r7Mzlt21q9AD2v+L481VCs7ar1TGpk7A5oNpftOy+JQXP6Y9kxJSAxBGi6Vwy
         1ts9lI/3GeC2NrShcAqkKBIBhANn6n0748buH5uWsUEixqfm+ISMbkM5WVBsUyoT8RHH
         D/YI6VOKpAu+8IvvJp3R5M4/d3fTr5nWmU/Haoa1xSFIZKXve0reRub/e+eBb6nerhvU
         er2g==
X-Gm-Message-State: AGi0PuYJrig3UfimYyuZm14uE9kEtIm+KaCrS0IGK+QK72wZzE2NDTzH
        CNHXwPb2ayLD+0/pzlBTgao=
X-Google-Smtp-Source: APiQypKSqwokjgO1sG2iKMzr92VhmMH+KtjvFcAiHoJtsyLNUFs5UEumQH1xlmtwzSpwIe8Ap1/X2w==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr14850805wrq.261.1589316128310;
        Tue, 12 May 2020 13:42:08 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a24sm32813210wmb.24.2020.05.12.13.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:42:07 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, yinxin_1989@aliyun.com,
        linux-arm-kernel@lists.infradead.org, lnykww@gmail.com,
        linux.amoon@gmail.com, jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v7 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date:   Tue, 12 May 2020 22:41:46 +0200
Message-Id: <20200512204147.504087-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512204147.504087-1-martin.blumenstingl@googlemail.com>
References: <20200512204147.504087-1-martin.blumenstingl@googlemail.com>
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
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
new file mode 100644
index 000000000000..7a386a5b8fcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
@@ -0,0 +1,68 @@
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
+      - const: clkin0
+      - const: clkin1
+      - const: clkin2
+      - const: clkin3
+      - const: pclk
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
+    sdhc: mmc@8e00 {
+      compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+      reg = <0x8e00 0x42>;
+      interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&xtal>,
+               <&fclk_div4>,
+               <&fclk_div3>,
+               <&fclk_div5>,
+               <&sdhc_pclk>;
+      clock-names = "clkin0", "clkin1", "clkin2", "clkin3", "pclk";
+    };
-- 
2.26.2

