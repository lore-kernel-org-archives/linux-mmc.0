Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF03AE198
	for <linux-mmc@vger.kernel.org>; Sun,  3 May 2026 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777797346; cv=none; b=KhopdaEuEaeJp2O1VM4toPSPmwaG7ZqPkQhy2xISxdpq5nHzkrocqFH2iXxVNFfISrj0cy6ZsOzgxBXvdc0/KOe6pXNbdLCf0+zQR3cq6IfwnLV4WVkVIKrzAB5q/yBl8pu55vphhEGPmaXxFiPeGCDox6gz0YqD6xYtJwwdRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777797346; c=relaxed/simple;
	bh=KolT8FJ8JLaoV/kgDWZGr2X7yeSGK3Ft+hcA3H6ww2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0M30uqA2LtzHXYYpyTgPXQXH4qRBK2ddAOjjD+QaIJyeoUGiK775w1o3nQkoLZJPT07Ji9oRi+w96lQRYMsncCwz6kxpSchY4S5wVHXYEozkrWxP02Yj+HXpTHSRZTwEFcGFChuzTmSubH0H4TVc9WdsjFqMipVCPK2LqCpL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy/cdvtQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy/cdvtQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82418b0178cso1516216b3a.1
        for <linux-mmc@vger.kernel.org>; Sun, 03 May 2026 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777797344; x=1778402144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQUqKpseiXlQd/VoS7FXU0gNWFtXot4K0uLQjpjqL98=;
        b=Jy/cdvtQN7FLDuq0p8i8WqQTwVyTdRSUx1OnsXyfFgS1zNGRvVEMy6f+ALXjxWLLb5
         y8tsu3MHQVaF2JcbbiwJTA3iCfPSX695h/7/F8WbWwLhJif1H3vncO2FX+EqPvtmn0Mm
         wDzhnwgTHJWbti017iSBKnUKxIr9ZgOYWhb+h3H++xJ0NUvKZSAkbweTYmSrEZHH5dlp
         3+jTtfl0UY05iCnCdZWIxMha8KPzcBDLify7j83TZEUvo/wkoWsd8GdCOuA2kJ5DgZnc
         PStG6HGuFkBszztAnvsan5hFJLclHlhahQbSFuh01GPvwaSSokxycqwec12rzChamuIG
         FDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777797344; x=1778402144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQUqKpseiXlQd/VoS7FXU0gNWFtXot4K0uLQjpjqL98=;
        b=KMr36/HfaIFenhHH1snODQ70NOdHoAi+pkPg531j6P5mb48ZEWlNyASEco4AsiltgR
         6FBWUibUR+VVE2LwEEkYwA8MG4Irm5V45aM0uj13o8VEick4sjjfTsm9Cga5jz4RdpY8
         H9HoAp+pBPAQ3yOc+5HWl7HeoScs9LG3ZkYWoTq2uaij8FLr2JoGdlQFEYJKN+pLMBxP
         VgT2RDf/T3Ld4iEoyBIRI3VThAdIEZ/PWJfT9fL5r3soiSMJqn7L8VvojeNmbzPki0WP
         SwmCNElfi0AmxyNYjbhYDqg406gmzGCKu7a40MBTVORxupK/MgCVcsYe2qgwQzVv8Acy
         LdHw==
X-Gm-Message-State: AOJu0YzvEAJiIMoxXEJWrjtktLXn5je1xBzbzQLG+/hHuozKl6hk9iJL
	3fPhAPX3MGtfM0zYHQDSBmhAsfiR/1qZuTLTncEVz5zIPQDjsgOfafGI
X-Gm-Gg: AeBDietErfZlZvyTM2ZCbwtunq0NQvMqMEIur3fIMKHv3wRYZ6L5B2tFBVHrMguICec
	9mXVxIplc2Nme2KAt42UrVTSbQopeUYIWc/VLFqww56TLW3qG8nqU4dG2Phgx35LWKwuemFKQ+A
	6RpS/3+EB8Y65sLzuNnCl71ZfhWLkfwSOAuGcYfxWj1cG2REg1kASV2xzfI/rMrc19gkJ293GOL
	8xufalINvpcFKZYn/76Um2y7YdGCAeBpnkgTY6uaR4v1N4QNe5horPlq4t2roQUEsdatggge19X
	nT4P4lQ5/ss/swqReeCtcLtXi+x0iPy3oFVGa/11UkskJ31dQdYZEnfoH0M8B+Ldao28V9ItNgV
	CqwtjwucdtfFVKe9VTKQOkasu+E6AxfSYz5ehkI62/V+E9T77EOU/hbQoaIy6IDgwt/fiXBWf5y
	PIy4hdeJ1OUy5Sat9OKZLNjAmOXb+DVKrY6h7GQTNrkHm7FRtIv9/+/bI=
X-Received: by 2002:a05:6a00:4145:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-8352d15f72cmr4706161b3a.16.1777797344272;
        Sun, 03 May 2026 01:35:44 -0700 (PDT)
Received: from Black-Pearl.localdomain ([60.243.224.75])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-835446b1b0asm1578142b3a.8.2026.05.03.01.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:35:43 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sun, 03 May 2026 08:35:30 +0000
Subject: [PATCH v2 2/2] dt-bindings: mmc: st,sdhci: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-st-mmc-v2-2-11ae3216d2ce@gmail.com>
References: <20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com>
In-Reply-To: <20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2

Convert STMicroelectronics sdhci-st MMC/SD controller binding to DT schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------------
 .../devicetree/bindings/mmc/st,sdhci.yaml          |  93 +++++++++++++++++
 2 files changed, 93 insertions(+), 110 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
deleted file mode 100644
index ccf82b4ee838..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
+++ /dev/null
@@ -1,110 +0,0 @@
-* STMicroelectronics sdhci-st MMC/SD controller
-
-This file documents the differences between the core properties in
-Documentation/devicetree/bindings/mmc/mmc.txt and the properties
-used by the sdhci-st driver.
-
-Required properties:
-- compatible:		Must be "st,sdhci" and it can be compatible to "st,sdhci-stih407"
-			to set the internal glue logic used for configuring the MMC
-			subsystem (mmcss) inside the FlashSS (available in STiH407 SoC
-			family).
-
-- clock-names:		Should be "mmc" and "icn".  (NB: The latter is not compulsory)
-			See: Documentation/devicetree/bindings/resource-names.txt
-- clocks:		Phandle to the clock.
-			See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-- interrupts:		One mmc interrupt should be described here.
-- interrupt-names:	Should be "mmcirq".
-
-- pinctrl-names:	A pinctrl state names "default" must be defined.
-- pinctrl-0:		Phandle referencing pin configuration of the sd/emmc controller.
-			See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-- reg:			This must provide the host controller base address and it can also
-			contain the FlashSS Top register for TX/RX delay used by the driver
-			to configure DLL inside the flashSS, if so reg-names must also be
-			specified.
-
-Optional properties:
-- reg-names:		Should be "mmc" and "top-mmc-delay". "top-mmc-delay" is optional
-			for eMMC on stih407 family silicon to configure DLL inside FlashSS.
-
-- non-removable:	Non-removable slot. Also used for configuring mmcss in STiH407 SoC
-			family.
-			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
-
-- bus-width:		Number of data lines.
-			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
-
-- max-frequency:	Can be 200MHz, 100MHz or 50MHz (default) and used for
-			configuring the CCONFIG3 in the mmcss.
-			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
-
-- resets:		Phandle and reset specifier pair to softreset line of HC IP.
-			See: Documentation/devicetree/bindings/reset/reset.txt
-
-- vqmmc-supply:		Phandle to the regulator dt node, mentioned as the vcc/vdd
-			supply in eMMC/SD specs.
-
-- sd-uhs-sdr50:	To enable the SDR50 in the mmcss.
-			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
-
-- sd-uhs-sdr104:	To enable the SDR104 in the mmcss.
-			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
-
-- sd-uhs-ddr50:		To enable the DDR50 in the mmcss.
-			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
-
-Example:
-
-/* Example stih416e eMMC configuration */
-
-mmc0: sdhci@fe81e000 {
-	compatible	= "st,sdhci";
-	reg		= <0xfe81e000 0x1000>;
-	interrupts	= <GIC_SPI 127 IRQ_TYPE_NONE>;
-	interrupt-names	= "mmcirq";
-	pinctrl-names	= "default";
-	pinctrl-0	= <&pinctrl_mmc0>;
-	clock-names	= "mmc";
-	clocks		= <&clk_s_a1_ls 1>;
-	bus-width	= <8>
-
-/* Example SD stih407 family configuration */
-
-mmc1: sdhci@9080000 {
-	compatible	= "st,sdhci-stih407", "st,sdhci";
-	reg		= <0x09080000 0x7ff>;
-	reg-names	= "mmc";
-	interrupts	= <GIC_SPI 90 IRQ_TYPE_NONE>;
-	interrupt-names	= "mmcirq";
-	pinctrl-names	= "default";
-	pinctrl-0	= <&pinctrl_sd1>;
-	clock-names	= "mmc";
-	clocks		= <&clk_s_c0_flexgen CLK_MMC_1>;
-	resets		= <&softreset STIH407_MMC1_SOFTRESET>;
-	bus-width	= <4>;
-};
-
-/* Example eMMC stih407 family configuration */
-
-mmc0: sdhci@9060000 {
-	compatible	= "st,sdhci-stih407", "st,sdhci";
-	reg		= <0x09060000 0x7ff>, <0x9061008 0x20>;
-	reg-names	= "mmc", "top-mmc-delay";
-	interrupts	= <GIC_SPI 92 IRQ_TYPE_NONE>;
-	interrupt-names	= "mmcirq";
-	pinctrl-names	= "default";
-	pinctrl-0	= <&pinctrl_mmc0>;
-	clock-names	= "mmc";
-	clocks		= <&clk_s_c0_flexgen CLK_MMC_0>;
-	vqmmc-supply	= <&vmmc_reg>;
-	max-frequency	= <200000000>;
-	bus-width	= <8>;
-	non-removable;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	sd-uhs-ddr50;
-};
diff --git a/Documentation/devicetree/bindings/mmc/st,sdhci.yaml b/Documentation/devicetree/bindings/mmc/st,sdhci.yaml
new file mode 100644
index 000000000000..96edf6d51e6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/st,sdhci.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/st,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics SDHCI-ST MMC/SD Controller
+
+description:
+  The STMicroelectronics SDHCI-ST MMC/SD host controller, which is
+  compliant with the SD Host Controller Interface (SDHCI) specification and
+  is used to interface with MMC, SD and SDIO cards. The ST SDHCI controller
+  extends the standard SDHCI capabilities with platform-specific
+  configurations such as additional register regions,clock inputs, and delay
+  control mechanisms required for signal timing adjustments which are
+  necessary to support high-speed modes and ensure reliable data transfer
+  across different ST SoCs.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+maintainers:
+  - Peter Griffin <peter.griffin@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: st,sdhci
+      - items:
+          - const: st,sdhci-stih407
+          - const: st,sdhci
+
+  reg:
+    minItems: 1
+    items:
+      - description: Base address and size of the MMC controller registers
+      - description: Base address and size of the MMC delay/auxiliary registers
+
+  reg-names:
+    oneOf:
+      - items:
+          - const: mmc
+      - items:
+          - const: mmc
+          - const: top-mmc-delay
+
+  clocks:
+    items:
+      - description: Clock for the MMC controller
+      - description: Interconnect (ICN) clock
+
+  clock-names:
+    items:
+      - const: mmc
+      - const: icn
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: mmcirq
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stih407-clks.h>
+    mmc@9060000 {
+        compatible = "st,sdhci-stih407", "st,sdhci";
+        reg = <0x09060000 0x7ff>, <0x9061008 0x20>;
+        reg-names = "mmc", "top-mmc-delay";
+        interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "mmcirq";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_mmc0>;
+        clock-names = "mmc", "icn";
+        clocks = <&clk_s_c0_flexgen CLK_MMC_0>,
+                 <&clk_s_c0_flexgen CLK_RX_ICN_HVA>;
+        bus-width = <8>;
+    };
+...

-- 
2.54.0

