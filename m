Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4269CA0ECE
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 04:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjILE4n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjILEz7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 00:55:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50C2D4A
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:53:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso6764247a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494402; x=1695099202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0wmcdmkVNbn0/L3PZmaokyWaGN3oFJGgoH9joABJEY=;
        b=JcyiNTbyQwRldigLuD+30Zvt28sMZYspMCFD8d+tsVn4GSuD9fgHkalT6M1nkTtEfe
         NAZNaahE+pNGMH0XJF8oqAfsXIJ+2OywD+/LJQ5GELuK+P8wr8renCVIqeYAHhsDbUbS
         3sTG43vsMG7nZb/gmT8YRnuy+ACy+7sn73FhtlkshkzcF9QtJGjgZ3DJKEkht3NLD9cO
         h7UZE6ylymxJWklv7OK55KtFjYXttX+J9NbtHJ43lbFavbhhAsoN25g0uNUA1dGcToKC
         78us+WPNzf410dm+teDx6DBFzs5mvYwBPMod0Rf7t4gggmw02ERqNwM2la9wKo9as/Yx
         8PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494402; x=1695099202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0wmcdmkVNbn0/L3PZmaokyWaGN3oFJGgoH9joABJEY=;
        b=G0N9dPzd/d9LYUnEpXIJDzIqu5CEr9YGp+wkLTrlW2+1jeYhGlZ4oEgUai1YBxYc/F
         kF8LHcizuiRfYB/Fka6se8yZAcba7HlFMURgQ5ReMN28fGiYGwZ/6iGta/jN902zkwhy
         nA65p1bbVL7EekThE2aLuvtZ/S6o8NKMCDcq8hgnDSdxwpBbfnUh2YIz7FEDwhmXxLac
         kt1Hg/ePGAxYlcTfg8lVmI21IPaa93ETy4xEG09BLUZd0sW+cxm0OdBCAHMHadJBrMqP
         wwCOXmr5uzObxsctZugpotAn7zClD2wZtazL+dz3QtBTiZuhio6Vr+/r8+F2rZETeTVB
         4CcA==
X-Gm-Message-State: AOJu0YxQGnFgIkbpskXx613i2zzYiLXIQ+RxWMpJ5c+IeNVeT5j/ykDt
        xcNQIu52oonR8ZqJ4JPkz4ArNQ==
X-Google-Smtp-Source: AGHT+IHIPViShMk+/t7cd11iyQpPz7PeJFn4FiDSD1OX75yRHQ2nJLSa6BJ+uD252JH202P3SGnqmA==
X-Received: by 2002:a05:6402:1287:b0:523:2e30:aaee with SMTP id w7-20020a056402128700b005232e30aaeemr9655209edv.32.1694494402040;
        Mon, 11 Sep 2023 21:53:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:21 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 32/37] arm64: dts: renesas: add initial DTSI for RZ/G3S SoC
Date:   Tue, 12 Sep 2023 07:51:52 +0300
Message-Id: <20230912045157.177966-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add initial DTSI for RZ/G3S SoC. Files in commit has the following
meaning:
r9a08g045.dtsi		RZ/G3S family SoC common parts
r9a08g045s33.dtsi	RZ/G3S R0A08G045S33 SoC specific parts

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 139 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |  14 ++
 2 files changed, 153 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
new file mode 100644
index 000000000000..7971e44a5a0a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S SoC
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r9a08g045-cpg.h>
+
+/ {
+	compatible = "renesas,r9a08g045";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			reg = <0>;
+			device_type = "cpu";
+			#cooling-cells = <2>;
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A08G045_CLK_I>;
+		};
+
+		L3_CA55: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-size = <0x40000>;
+		};
+	};
+
+	extal_clk: extal-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scif0: serial@1004b800 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004b800 0 0x400>;
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF0_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF0_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		cpg: clock-controller@11010000 {
+			compatible = "renesas,r9a08g045-cpg";
+			reg = <0 0x11010000 0 0x10000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#reset-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller@11020000 {
+			compatible = "renesas,r9a08g045-sysc";
+			reg = <0 0x11020000 0 0x10000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "lpm_int", "ca55stbydone_int",
+					  "cm33stbyr_int", "ca55_deny";
+			status = "disabled";
+		};
+
+		pinctrl: pinctrl@11030000 {
+			compatible = "renesas,r9a08g045-pinctrl";
+			reg = <0 0x11030000 0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 152>;
+			clocks = <&cpg CPG_MOD R9A08G045_GPIO_HCLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_GPIO_RSTN>,
+				 <&cpg R9A08G045_GPIO_PORT_RESETN>,
+				 <&cpg R9A08G045_GPIO_SPARE_RESETN>;
+		};
+
+		sdhi0: mmc@11c00000  {
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x11c00000 0 0x10000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A08G045_SDHI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@12400000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0x12400000 0 0x40000>,
+			      <0x0 0x12440000 0 0x60000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
new file mode 100644
index 000000000000..3351f26c7a2a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S R9A08G045S33 SoC specific part
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a08g045.dtsi"
+
+/ {
+	compatible = "renesas,r9a08g045s33", "renesas,r9a08g045";
+};
-- 
2.39.2

