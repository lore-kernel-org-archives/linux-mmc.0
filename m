Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0DE23AE9A
	for <linux-mmc@vger.kernel.org>; Sat, 11 Oct 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172253; cv=none; b=oa4AExaoXC0oQnVXpWoAEsYKzPMyBEHKtqYF28gNF+jxzBL0gGOz1q1KUK2AVAxAvvCOX5ByDZyznnNFTasbSw0Uj/ZmUn2aPi+w3VtKILoaNhlo4res3d11pAtqLhDQkw48PKmLgSyhXeGe0RKNTYCcn80VS9AMFlj8drkwMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172253; c=relaxed/simple;
	bh=q9sxAETe5OIqVHt+Y4pP5JV4H10TxiWkP+aj8IEeAQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJB7W98hPmhj2TYvKaB/jcOizIn5zbOfV5JcF70KW2CDxu4RH/3JaSY0o/NmzrVaaIm2iaNdKMNDcpkXMWiLNC+vdr+G+SwPcQ/PnpolhWXsuSpy6QKikiJtLfPcyqRigEVXenJtJN6OJGo3nzaPK9MvhxWiPfxaPwvMD0mXs/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNE4Yrq0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNE4Yrq0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-789fb76b466so2570659b3a.0
        for <linux-mmc@vger.kernel.org>; Sat, 11 Oct 2025 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760172247; x=1760777047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4PDXn+JxUar3PSQB1k+NUTfw6C2jsat1FHf88GiI/Y=;
        b=kNE4Yrq0T8f77iHdPJ2xMbv7SCHpB/2oiJyFQN3zyOvxc4HKoYckOweT5HhLHcH8HB
         VrRxFhK5bFTfbdudl7uGxjD4fHNcGU62ARddWU3tCOCtHKrm+Gt/gB6T0btCqb69dB5O
         MroS1vlwGXz1Lvy93XzIYRbqBY4sdMg11ty5dxqYYVNdKC+WNmGd56JRYbB0UkFqZTVm
         xTucVdO842uJuY1KKJ4HV//Qa/qyrELz/7UJk8tF8fIrP0bnS2I1GX1fkYkQd9Ptq9y/
         iKrnTLEiLYwvaowalNwdmUuh02BOEEitpfLoCCPJ3/VegJB7QGNFE+soJLoRhw2YWoa9
         SCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760172247; x=1760777047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4PDXn+JxUar3PSQB1k+NUTfw6C2jsat1FHf88GiI/Y=;
        b=MXvLqqVuzv0EU3PHODN/bBRiOV2b1xH0Y+70hZ2If4oV4QBAror9wZEivzmZ1ScQ23
         VHeJjfgMGM5QGUPFY3ZdCJniFtPV0tmCU/j7hTfqYo2l71yBFbjsmn48Sc2eDcz0OEQJ
         9NDj1m9j9wuNjzySgcI2bHH5UqT+cIpnKv0IXzeAOehF4s2Z9NBzNHJbhLsD/Eyqp+3b
         cXEqtDgsJqmULCWDXN/E3149Ec4bhyRzy6/mTFxu9Ls9MlZGqldyz4Hx2zrxaJJwrNYW
         Hicv2kgadYBjUQ/XokAtpqPRMUnQxJQduqsEXU6Dfu9bE2AjRtSOZI3zw3fEyc4W8WfL
         S+fA==
X-Gm-Message-State: AOJu0YxUwtBa3KcAkujnI5Hx7MwkER4AHlGxLMZsqsxztFtGQ7CWWH/v
	HV8yynHDGlavrurr4GN6+MoPbLSqBHQpo++pViZ4PtMwtOxflNiw+hJt
X-Gm-Gg: ASbGnctabowxMQ3dN5envTstLIFUAJqqACLm/LKL5HWer1EFCTjM/1AOKbXP38LTZ4i
	zX8G1Jdp4fcz+4wcnWZ2cLHbSihhuRfBtrhVAihgYRLVMsjtzTHFetSICBYQuZB5gfK6A8dK+PJ
	dZonel2P7pcEAntDchaPHBr5C+SSoDjB0TIU7nMDsLipU6hgFJjNmBZwwfGMXmA9YeRtNyq/UYR
	R9s2wD3FXjqWCNvLsMqYhFrmbylG4UtcqyHSUYSrOGpeWeoRd8nirCndOmWpVsrFNKbc+oyoi8d
	qo+H/0vszh4Z84tUkZ4LazS16mwENwFMLRA5Pn1v/+kN65lGYYBuD2wycaE/ZZC+r4ytgmUv2fC
	x9wMeGNX7ODUj+SePF6GMx01r1javaHwHd7VY5xp4f4zepUTDmuLVLJS1eoS+ccPEXxk3SO8iwp
	HYUtk=
X-Google-Smtp-Source: AGHT+IHIBtYr4kZkVJMMgsx5CGtaN+MoT5AMsvXZeqpen1KOa5fs69vzGtUrVk4aCFZbvjs/plf8Ag==
X-Received: by 2002:a05:6a00:2d92:b0:781:1550:1ac7 with SMTP id d2e1a72fcca58-793857098aemr18639763b3a.6.1760172247152;
        Sat, 11 Oct 2025 01:44:07 -0700 (PDT)
Received: from Black-Pearl.localdomain ([157.50.164.155])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7992d09659esm5401090b3a.45.2025.10.11.01.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:44:06 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 11 Oct 2025 08:40:24 +0000
Subject: [PATCH v3 2/2] dt-bindings: mmc: ti,omap2430-sdhci: convert to DT
 schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-ti-sdhci-omap-v3-2-9487ef2de559@gmail.com>
References: <20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com>
In-Reply-To: <20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI OMAP SDHCI Controller binding to YAML format.
Changes during Conversion:
- Define new properties like "clocks", "clock-names",
  "ti,needs-special-reset", "ti,needs-special-hs-handling",
  "pbias-supply", "cap-mmc-dual-data-rate" and "power-domains" to
  resolve dtb_check errors.
- Remove "pinctrl-names" and "pinctrl-<n>"
  from required as they are not necessary for all DTS files.
- Remove "ti,hwmods" property entirely from the YAML as the
  DTS doesn't contain this property for the given compatibles and the
  text binding is misleading.
- Add "clocks", "clock-names", "max-frequency" and "ti,needs-special-reset"
  to the required properties based on the compatible and the text binding
  doesn't mention these properties as required.
- Add missing strings like "default-rev11", "sdr12-rev11", "sdr25-rev11",
  "hs-rev11", "sdr25-rev11" and "sleep" to pinctrl-names string array
  to resolve errors detected by dtb_check.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 -----
 .../devicetree/bindings/mmc/ti,omap2430-sdhci.yaml | 202 +++++++++++++++++++++
 2 files changed, 202 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
deleted file mode 100644
index f91e341e6b36c410275e6f993dd08400be3fc1f8..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* TI OMAP SDHCI Controller
-
-Refer to mmc.txt for standard MMC bindings.
-
-For UHS devices which require tuning, the device tree should have a "cpu_thermal" node which maps to the appropriate thermal zone. This is used to get the temperature of the zone during tuning.
-
-Required properties:
-- compatible: Should be "ti,omap2430-sdhci" for omap2430 controllers
-	      Should be "ti,omap3-sdhci" for omap3 controllers
-	      Should be "ti,omap4-sdhci" for omap4 and ti81 controllers
-	      Should be "ti,omap5-sdhci" for omap5 controllers
-	      Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
-	      Should be "ti,k2g-sdhci" for K2G
-	      Should be "ti,am335-sdhci" for am335x controllers
-	      Should be "ti,am437-sdhci" for am437x controllers
-- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
-	     (Not required for K2G).
-- pinctrl-names: Should be subset of "default", "hs", "sdr12", "sdr25", "sdr50",
-		 "ddr50-rev11", "sdr104-rev11", "ddr50", "sdr104",
-		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
-		 "hs200_1_8v",
-- pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
-
-Optional properties:
-- dmas:		List of DMA specifiers with the controller specific format as described
-		in the generic DMA client binding. A tx and rx specifier is required.
-- dma-names:	List of DMA request names. These strings correspond 1:1 with the
-		DMA specifiers listed in dmas. The string naming is to be "tx"
-		and "rx" for TX and RX DMA requests, respectively.
-
-Deprecated properties:
-- ti,non-removable: Compatible with the generic non-removable property
-
-Example:
-	mmc1: mmc@4809c000 {
-		compatible = "ti,dra7-sdhci";
-		reg = <0x4809c000 0x400>;
-		ti,hwmods = "mmc1";
-		bus-width = <4>;
-		vmmc-supply = <&vmmc>; /* phandle to regulator node */
-		dmas = <&sdma 61 &sdma 62>;
-		dma-names = "tx", "rx";
-	};
diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2430-sdhci.yaml b/Documentation/devicetree/bindings/mmc/ti,omap2430-sdhci.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7683481204b2e222847244b67f9ae2684db93028
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,omap2430-sdhci.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/ti,omap2430-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI OMAP SDHCI Controller
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+description:
+  For UHS devices which require tuning, the device tree should have a
+  cpu_thermal node which maps to the appropriate thermal zone. This
+  is used to get the temperature of the zone during tuning.
+
+properties:
+  compatible:
+    enum:
+      - ti,omap2430-sdhci
+      - ti,omap3-sdhci
+      - ti,omap4-sdhci
+      - ti,omap5-sdhci
+      - ti,dra7-sdhci
+      - ti,k2g-sdhci
+      - ti,am335-sdhci
+      - ti,am437-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: fck
+      - const: mmchsdb_fck
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  pinctrl-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 14
+    items:
+      enum:
+        - default
+        - default-rev11
+        - hs
+        - sdr12
+        - sdr12-rev11
+        - sdr25
+        - sdr25-rev11
+        - sdr50
+        - ddr50-rev11
+        - sdr104-rev11
+        - ddr50
+        - sdr104
+        - ddr_1_8v-rev11
+        - ddr_1_8v
+        - ddr_3_3v
+        - hs-rev11
+        - hs200_1_8v-rev11
+        - hs200_1_8v
+        - sleep
+
+  pinctrl-0:
+    maxItems: 1
+
+  pinctrl-1:
+    maxItems: 1
+
+  pinctrl-2:
+    maxItems: 1
+
+  pinctrl-3:
+    maxItems: 1
+
+  pinctrl-4:
+    maxItems: 1
+
+  pinctrl-5:
+    maxItems: 1
+
+  pinctrl-6:
+    maxItems: 1
+
+  pinctrl-7:
+    maxItems: 1
+
+  pinctrl-8:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  pbias-supply:
+    description:
+      It is used to specify the voltage regulator that provides the bias
+      voltage for certain analog or I/O pads.
+
+  cap-mmc-dual-data-rate:
+    description:
+      A characteristic or capability associated with MultiMediaCard (MMC)
+      interfaces, specifically indicating that the MMC controller
+      supports Dual Data Rate (DDR) mode.
+    type: boolean
+
+  ti,needs-special-reset:
+    description:
+      It indicates that a specific soft reset sequence is required for
+      certain Texas Instruments devices, particularly those with
+      HSMMC (High-Speed MultiMediaCard) controllers.
+    type: boolean
+
+  ti,needs-special-hs-handling:
+    description:
+      It's presence in an MMC controller's DT node signals to the Linux kernel's
+      omap_hsmmc driver that this particular IP block requires special software
+      handling or workarounds to correctly manage High-Speed (HS) modes like
+      SDR25, SDR50, SDR104, DDR50.
+    type: boolean
+
+  ti,non-removable:
+    description:
+      It indicates that a component is not meant to be easily removed or
+      replaced by the user, such as an embedded battery or a non-removable
+      storage slot like eMMC.
+    type: boolean
+    deprecated: true
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      It represents the speed at which a clock signal associated with a device
+      or bus operates, measured in Hertz (Hz). This value is crucial for configuring
+      hardware components that require a specific clock speed.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: sdhci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,dra7-sdhci
+              - ti,k2g-sdhci
+    then:
+      required:
+        - max-frequency
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,k2g-sdhci
+    then:
+      required:
+        - clocks
+        - clock-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am335-sdhci
+              - ti,am437-sdhci
+    then:
+      required:
+        - ti,needs-special-reset
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@4809c000 {
+        compatible = "ti,dra7-sdhci";
+        reg = <0x4809c000 0x400>;
+        interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+        max-frequency = <192000000>;
+        sdhci-caps-mask = <0x0 0x400000>;
+        bus-width = <4>;
+        vmmc-supply = <&vmmc>; /* phandle to regulator node */
+        dmas = <&sdma 61>, <&sdma 62>;
+        dma-names = "tx", "rx";
+    };
+...

-- 
2.51.0

