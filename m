Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BF30FC1B
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343597; cv=none; b=fYvMuI3zAomQyCCscWY5kSF+AHQJqJ6u4BpRNH67NByWLc7G58HgHmhxdkYKDdaAvmnay3ZJ7NiP+qWDhCBSdaLh4rHSsxjavHf/AXxa9ozYOhODAz8eyPEgCzyAq1jbBcEyxz5H0dtVeahnN1fPvNnvXZxJlajpw6RVNKsMXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343597; c=relaxed/simple;
	bh=B7vKSaFJ1y2uLWgpvzLkk44p15ePtxd5WCQe3Lt924I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FopNO2wby9mqFaAft8ltapjlDAs6PJrXbf3oT3TdQAhckWfULfeQsb+/AzBFAZdhTtAqnnUJsB6vxRoSNmfAAt7ZoRDD0gPd+YVdPX0kce5zc6wfdS1cEoMbzyEw3SvBa8dbkUyXe2iGA+F54gAqA73pMlc4B4gx5QQmDJHGO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV6Lx3yR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV6Lx3yR"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so1264561a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781343595; x=1781948395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOrSjvFk/ov14IcMt5MBgZ1bR+CpKC1/mEab6ONapJE=;
        b=jV6Lx3yRAvhOJQB0pGFrPQGh0SsSFTqyqbk2qFnNzkQv2NpZ9cXT5J/X7xnmhFktY4
         laXJz9uIBR+MsasqdhGJj05RskYCQbLwvpTjbnsywgCUN2N+uDklci36OI4/56ZyOcos
         PCo2i+pPnKTFDOayCvPPYAUE2+I9Qe9tUoNe+u2ORs2Rdgnc9YixxTXH4kWDV7LFR/5m
         6TcSvptQmlrgz3BvbC+7VFwgE72lLP7hIFhBMOnu+6rHHInLJJazhiEutkim1BdDefiK
         qX35CYuS4KE+Es/Eo8yEsnyWkW3IbVLkYYdGxOQ36vkjgB2ZDJCs2KnWBGAE3cabpvC/
         6dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781343595; x=1781948395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IOrSjvFk/ov14IcMt5MBgZ1bR+CpKC1/mEab6ONapJE=;
        b=YIpEUaHB1UflZAZwB0mrqNrdJMYIG+k0VuY2WSDW/4NNf1qxLvOeR0dngeVKYq3jrq
         ibmHqOq4+Nb3Rsaw6JXWLY3SyKCRSjhqtpmDhUNY7kCWFZoy5XYj7763bVUTg+tK/BH2
         bAcmdW3ueSLv8k74GhzsiE/YkLDUrjMAX6Fqwpkf2hPyelPg/OgkmkNjNrIuEu5PVdzN
         NCcc05l+XQmilDUvYLN3+qrklhq5agYRhIIA6DK4i6DncTAc6BFsckzK+nT8ry3Z4NP1
         fHOIaquqa2MG9GVveP6Vzzx51/EaLiyCsBkMKFYVVrlVaiDbURIMMB/uE7JtYXSg0ep1
         m2/A==
X-Gm-Message-State: AOJu0YyNaGPcTULSFLF4HFHFNd25afWQY5U3RoydeT1lK1yl0bZr0b+A
	n881+4vvktzC6pEKgyGfhbMQoJfzjlSTvRNuq3Z+3E1E1jNDWKWtM0F/
X-Gm-Gg: Acq92OHEES7BxIprQgaZVVnEkn/MBO24tx65Hcb42UpCOPhM4UgdctI12MNu1Fg/XNA
	i3F1ditD8QvKgCqxfkH9Y7BXtnPmf6QvFuR8s8x8OwVT5rGLNr7Ua5BWhNoCX9Kyii7QjW9Qhrj
	pdPi0UQcCHBQhXGdwjG+mVj7AHB9hU44ZsUk62c5MdzPAsavnOyNEDjRlPzW0wPeJXYbVBhL/7P
	scalSoY73yrLXWPtyqpMnlDjyT6+yhwdGVmed0ZytoTT0Yh/SQM9WzRgD9PMFRP5In1lTdCokBa
	HBY3yV4M6BBvl4mS01BIP/tJ5SCaWKsrkbOOJi6Jyo85IME3olrYaJ5fpm2FwXY0jnpfSZ37V2R
	pIMpsQNSWevGN1h3vHfU4tszlHiWhZWYRrENukLp4WLzUp1/gs9TSn8ynJRYlX2yFz/C+6L3jbt
	mzccJv4gaH93RBEs7to+N9QdFGPq/C/Xl7Qn75eIlKxCVf
X-Received: by 2002:a05:6a21:350d:b0:3b4:8f18:326 with SMTP id adf61e73a8af0-3b783dbce10mr7874789637.10.1781343595291;
        Sat, 13 Jun 2026 02:39:55 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.61.84])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm4155826a12.0.2026.06.13.02.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 02:39:54 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 13 Jun 2026 09:39:40 +0000
Subject: [PATCH v4 2/2] dt-bindings: mmc: st,sdhci: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-st-mmc-v4-2-b3c385617c16@gmail.com>
References: <20260613-st-mmc-v4-0-b3c385617c16@gmail.com>
In-Reply-To: <20260613-st-mmc-v4-0-b3c385617c16@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2

Convert STMicroelectronics sdhci-st MMC/SD controller binding to
DT schema.

The 'icn' clock and 'top-mmc-delay' register region are optional in
the text binding and remain so in the YAML schema. minItems: 1 is
set on clock-names and reg-names to match the flexibility of their
paired clocks and reg properties, preserving compatibility with
existing in-tree DTS nodes that provide only a single clock or
register entry.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------------
 .../devicetree/bindings/mmc/st,sdhci.yaml          |  92 +++++++++++++++++
 2 files changed, 92 insertions(+), 110 deletions(-)

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
index 000000000000..0bf4fc3ca699
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/st,sdhci.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/st,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics SDHCI-ST MMC/SD Controller
+
+maintainers:
+  - Peter Griffin <peter.griffin@linaro.org>
+
+description:
+  The STMicroelectronics SDHCI-ST MMC/SD host controller is compliant with
+  the SD Host Controller Interface (SDHCI) specification and is used to
+  interface with MMC, SD and SDIO cards. The ST SDHCI controller extends the
+  standard SDHCI capabilities with platform-specific configurations such as
+  additional register regions, clock inputs, and delay control mechanisms
+  required for signal timing adjustments to support high-speed modes across
+  different ST SoCs.
+
+allOf:
+  - $ref: mmc-controller.yaml#
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
+      - description: MMC controller base registers
+      - description: FlashSS Top registers for TX/RX DLL delay configuration
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: mmc
+      - const: top-mmc-delay
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Clock for the MMC controller
+      - description: Interconnect (ICN) clock
+
+  clock-names:
+    minItems: 1
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

