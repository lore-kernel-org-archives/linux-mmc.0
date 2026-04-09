Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA03806DC
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720662; cv=none; b=WP1FQ/+MKzDL8YuIyF9a9aDvPWs6atSAbcJDZTrfo1Q7ESbUlJtrLuCduUSzieFACzfoLP09aWpc43w+zQmA6pXP4eXJ/AQdBQMU9JM6sOPJDj7xkYOAwaOTsta4LlMa1saloaRlk/aHit4pVt/31x5vtJmqH1htrt+BfQLPAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720662; c=relaxed/simple;
	bh=+neZOOjWdQVdJTB55it/1EVZihaYU1w2cBZD5co5sdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=icBRQb3SKi8aBI1ItuwgXvTa0Y9EubWG/2UStSIMy6j6ydv1cbY3V7VcxRJm8jKwRnhJSQZ717nhfbuKw2NkLA52s7lfLmAe5MxcoXIgC9wezANvlmg5MlqXYdbA7voXr82UAw2tcH3DC8XYmdZp1tyrv6OEj+x/Sico75EPnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9D/ZN9U; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9D/ZN9U"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76c067bc51so242044a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775720659; x=1776325459; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYfS1O2yf/ne7E+3AVEnMmfiNz3xkDVuJUPn1EUTtNA=;
        b=U9D/ZN9UkT5WL4NuOegARnUGpzGgz38xr3IVzRvyeypvpireAcRi+usa1l7JFikcKS
         f9bDSRDeKdT/VfqhW2MVZ89QMpHsKvgGvA2fpK9rR2mu4/kC5BPgDAGuHA5INZzAlt3I
         oVYHYrd5Fje1XY6RHE7UEHHDu+dGLw++h4P/l+K2GJeU9sad7P3Mdxb8by7FXw1eoUPc
         Al5tNxiq+azvvqNs0XK7P8JiiaBr8oY/VGD0LNB/OCQQaPXFyj01vK/l7rqfGP+rz1yE
         aSlcGCJxCXKuHeUPtJla/ITnw8j7taZcXcZTBOYtdQYljY2iEj8d2quQIlVV4M8e0V4b
         ePmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720659; x=1776325459;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYfS1O2yf/ne7E+3AVEnMmfiNz3xkDVuJUPn1EUTtNA=;
        b=GkAnV94vH6wKznmuXEVG89UlbLis6a+ee2T0EUXiLsgvVkkyhEmjvXhlDvMJphZmZ5
         bTTMPimbpv7ZHN74A+F5z1yIXu1dgOp/teIdaY3OIDUWyQS/muLHB4VnedupV7aOx+NC
         te51nHPXg1GoimuHods7IMAHXQ5BXNPS2R1y+sUYDJ8tbWDFTe5RwQpuFC1Uw/Osu1NC
         1voZXv/QCY1o4AybWM2ULMJWcGDeuITVeUyrnTADU0hA+0Wh3EHHEXQkC32KMA7s883F
         s2T3SAWUsd4t24IJKgnwLFqRLM9uIzA08hrba56ilSB0dL0G1RdYckKTF0Sv6+TI5v/p
         2l0A==
X-Gm-Message-State: AOJu0YxrsYQX01h/fyQpQKbivfATrXN0JeJoXSgOhbqhYuosZIEaYwr/
	3d0Pawc/i6Ukxy8JATpaKfWS25zjDKNR0zSww3PlUgcvVxDMp6FuNtRr
X-Gm-Gg: AeBDievMbs/a3GCXK4/BJmslgAErQDXj1F5Z7NVpA4opBzRO80seTEHtm/Lr4nUfdiJ
	5/cbx4qvs2AL9yXTdgzHY2zKKlyqSpCNPqiSsX4CaUu97ypptQV/8meRSqr3USKxNflK5vTzqbg
	KQAeb42MQQi0+lJ2V8NgEbOktlI24jCO6LcbvM5Xbre6+hWZx17bTW3SdRgOJKvd4CZJhvCgyCv
	aDQ6saF3P+FTXCPhbQhpbXXktCWetEwb0WC+Hrdt6bTBxmdEVum7GQKbkyRTmXYK7Dk+d1ZeHsf
	KOvz/tAMABxaI/XvOy1sR+T+D7ZRLdgCsTAAAPqeqdyolsa7b7AhEiEpQ+Gaof8csZ0nbkiqE0C
	bFkVLpdQ40lmIWoJkhFYczojH0nwWPlYBUwNx+fQAhZ5VRFzsJ0G/WYeoQ/nqHtVVEiXgUOKkL8
	GuL3bnCqp01TaVUkSE/m/Dpf7VEbQjSCleQTbIWIPrGrBy1wCPfQ==
X-Received: by 2002:a05:6a20:7f86:b0:398:7866:e8e8 with SMTP id adf61e73a8af0-39fc82e89a3mr3171074637.31.1775720659419;
        Thu, 09 Apr 2026 00:44:19 -0700 (PDT)
Received: from Black-Pearl.localdomain ([157.50.173.193])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c76c6475b56sm21226965a12.1.2026.04.09.00.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 00:44:19 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 09 Apr 2026 07:43:16 +0000
Subject: [PATCH] dt-bindings: mmc: st,sdhci: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-st-mmc-v1-1-4c54321c3535@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJRY12kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNz3eIS3dzcZN1kSwOzxBRL07Q0C2MloOKCotS0zAqwQdGxtbUAWNW
 1kFgAAAA=
X-Change-ID: 20260327-st-mmc-c906ad95ff83
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.1

Convert STMicroelectronics sdhci-st MMC/SD controller binding to DT schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 -------------------
 .../devicetree/bindings/mmc/st,sdhci.yaml          | 122 +++++++++++++++++++++
 2 files changed, 122 insertions(+), 110 deletions(-)

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
index 000000000000..22060fe6e364
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/st,sdhci.yaml
@@ -0,0 +1,122 @@
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
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - mmc
+        - top-mmc-delay
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - mmc
+        - icn
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: mmcirq
+
+  pinctrl-names:
+    const: default
+
+  resets:
+    maxItems: 1
+    description: Phandle to reset line of host controller.
+
+  vqmmc-supply:
+    description: Regulator supplying I/O voltage (Vcc/Vdd for SD/eMMC).
+
+  non-removable:
+    type: boolean
+    description:
+      Indicates a non-removable device (e.g., eMMC). Also used for mmcss config.
+
+  bus-width:
+    description: Number of data lines.
+    enum: [1, 4, 8]
+
+  max-frequency:
+    enum: [50000000, 100000000, 200000000]
+    default: 50000000
+    description:
+      Maximum bus frequency. Used to configure CCONFIG3 in mmcss.
+
+  sd-uhs-sdr50:
+    type: boolean
+
+  sd-uhs-sdr104:
+    type: boolean
+
+  sd-uhs-ddr50:
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - pinctrl-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stih407-clks.h>
+    sdhci@9060000 {
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

---
base-commit: e77a5a5cfe43b4c25bd44a3818e487033287517f
change-id: 20260327-st-mmc-c906ad95ff83

Best regards,
--  
Charan Pedumuru <charan.pedumuru@gmail.com>

