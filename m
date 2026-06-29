Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC964508EB
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750419; cv=none; b=o+HebrGmLIQmIfC47tzSUD78Cw/Bl6fIAWg6+nDMWlO3fm20dxukDTnrotVAw42RM7OJz068AroHLrelkFDk4/86PKFTOT9BGgWtymx7buHgxLYpMzs9OWcuCcyUsDE2zKL2mTCasURflr7Z8vvn8C6vRpZn9f2IYZk2k0SCMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750419; c=relaxed/simple;
	bh=kr4KgZY6gUQRsa4bmbkMgjmyvOZ0b0C64H86jSFTYpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIdpg4i83UToG98GfdgHhlnWpBr/2/ZF22QArznZLjusnIRCIAH13zYDKsIm91PIgT22QITgfikqNBOcp7e7uhAdg1EYoo5tkgerMRfgb0mPR7fnrKipYLA3aTrCpauU6Df7gW+pgherdR1t+d2EGGjTCpPKruEDX5LMQYiVLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxLQMN2s; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxLQMN2s"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-139f3eaaa49so1149813c88.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782750417; x=1783355217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzD5qwer7lN3cs3aCecnlGIOZWp59qV1QyyQWTexqnY=;
        b=dxLQMN2sgUT/VIXo3yvOjU3xg81YmRnfGreWOIjIWDGAE+kf7my4983uRZ6LnMickK
         1WF0anaf/F7RyghZ+N4skZ3a/P+212fkU7k26Ky6GnetViIDNLIcrkH9tbDy+kZ9TA4l
         71qy6GS3TVQCXxH7QfJSnGIxBJx554LukTzvVsdVphQ9qEI1zaeMJlR5A5rPP+feRo9v
         9pxN5kubC40FCBNbjsPinFixmdU9T5qDtl+44aQNGtQuuD3kUookzuMqKa8gtYEXuVNz
         2HcxLaKivR1tdYdA7ytEK6DH5fdxT1jU3RZ1w+UaA39REFdODaUnjnCBZYCp5s7LwHWL
         nOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782750417; x=1783355217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nzD5qwer7lN3cs3aCecnlGIOZWp59qV1QyyQWTexqnY=;
        b=i/Jb0lfJMm6VOjhUjvd5o8H58fJ2gUd9izGXGlFg7fXA3qPp5cc3bb0mIiv5JLynEQ
         bdLe41cdYU395sazwy2kal/nC7s9Pmd1ZaRPPXo45qFW32ludwFbxfNPkQ64faRBSov/
         ptIENG7KfMYbb2CE0Lim+WxzEGKMO7reL9xu9JZD/i20qS2I9m/VMEyKT4rcCsp3ovVc
         hrMCrPZnoD8/RokM++1QEfVUidUZF2SEBie/1O1mXYElrMeaghaUdy5HD6WY8Eb6PXM9
         cLoetukh+yJdUr9fo2QUlsuw96JgmCkAiaUt7lZOOJeOCeMxKdyz+L33ir/YcCiyZ2ui
         kH7w==
X-Gm-Message-State: AOJu0Yy8h2BOsY2V/LgOXxPAlb5bvfjOUFDpYvbh0qre7eW6wUsJeJnx
	s9Eg5J1I3rJcIlRfQ75iY5GXEfgFtYzI2CouenPU+7lqeyPwsL70P9TCyeSBRw==
X-Gm-Gg: AfdE7clfZBUSoqgIXXKHN2w3nBTyxaDZsjuSThBC1dwRX+UAyxXT0r7jrnA2Xn1gBgc
	stFEiVkZojxn6FIpDSKMk5ah7KTyx3sxkklD3XgvrZnXtC/MQFgy/mYwi+BaVXBb4GCtRyrEYfV
	FXHbFWOLpz0U0Y/qRGV56wKqPZqFwraZ6ZAPPvXVNusxSWSjDtR1S2mbFKU+sEz3k6EaPApn/vY
	/0I38m68REQi3slpd+D8CgN0tWAqwST8qpAOuaTPD30sYa12pWQBPSrNxPE5gF5LS70TnCW2FKf
	cy7OmlMLjyQ9TuPcrheGQix/ZC3sFH3mLq/yy0tdJkmLwd/+5UzvOKsq58ltwh0llU+EU1bwneo
	NFDva4GSt6EWWc0bY5rP0TFlHv4ZlqFThQz9K9C7H5jv03CYJ1nj3G1w893f4ThMX5G5S6rY6nI
	4qZuQi0Veksx6AUBm0nYTKkyXCj/BOPZ6rqmU=
X-Received: by 2002:a05:7022:79f:b0:137:e6a1:c4b3 with SMTP id a92af1059eb24-13b2a0a0e57mr117216c88.0.1782750416413;
        Mon, 29 Jun 2026 09:26:56 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.62.174])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-139d912197bsm80851896c88.15.2026.06.29.09.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:26:55 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Mon, 29 Jun 2026 16:26:40 +0000
Subject: [PATCH v5 2/2] dt-bindings: mmc: st,sdhci: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-st-mmc-v5-2-3cf0e639bff8@gmail.com>
References: <20260629-st-mmc-v5-0-3cf0e639bff8@gmail.com>
In-Reply-To: <20260629-st-mmc-v5-0-3cf0e639bff8@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2

Convert STMicroelectronics sdhci-st MMC/SD controller binding from
text format to YAML DT schema.
Changes during conversion:
- Preserve optional 'icn' clock and 'top-mmc-delay' register region
  via minItems: 1 on their respective properties.
- Conditionally require reg-names when two reg entries are present
  via an allOf if/then block, preventing silent runtime failure in
  devm_platform_ioremap_resource_byname().
- Constrain max-frequency to enum [200000000, 100000000, 50000000]
  with a default of 50000000, matching the driver's behaviour in
  sdhci-st.c.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------------
 .../devicetree/bindings/mmc/st,sdhci.yaml          | 105 ++++++++++++++++++++
 2 files changed, 105 insertions(+), 110 deletions(-)

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
index 000000000000..798af599d374
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/st,sdhci.yaml
@@ -0,0 +1,105 @@
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
+  - if:
+      properties:
+        reg:
+          minItems: 2
+      required:
+        - reg
+    then:
+      required:
+        - reg-names
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
+  max-frequency:
+    enum: [200000000, 100000000, 50000000]
+    default: 50000000
+
+required:
+  - reg
+  - compatible
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

