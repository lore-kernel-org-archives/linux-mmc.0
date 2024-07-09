Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B412C49C;
	Tue,  9 Jul 2024 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506624; cv=none; b=u8UQJaJPxJl3TW2GNUl8Y2VrBiNt/CpVC20J6yhbsKvuzd94rWiOSuZUQzFMuzXDUWsa0a3XWXEvQWB1ibh7F1fmFaU0ogxbDO8GUdtZ9P2FaF7EmiB7cftErUD2WInuePfRqb7pR4Zv90W3X8g+LH4EsRVBEtKthDY2RtTcD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506624; c=relaxed/simple;
	bh=KlDRQVtmM8THEFm2okCe18ZiNAPaeO9CrxKIi3ZHxPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M/qeWyBDjmtYAwSg/27ReuI3+UtufkI4OcLtLDY7GM2kxdoPG08jzdcgJbkIz2s9n6nuwTfgtpxPI+7qwQ2o3Ij8xLV6o8xGwGToFEQN85uxskR6rRe0xtH2Rgy9gwi9IqfjozcrgkEXDj431/gNlaU06PDSwOmcJDKEgvgoY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+vFQtoM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+vFQtoM"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e99060b41so5076788e87.2;
        Mon, 08 Jul 2024 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720506621; x=1721111421; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShtGGv5EDAR4+wbh24vGDrCYLPGvjs8IbCaS8cbSqGs=;
        b=e+vFQtoMB9WGAbSRCeutA6MhX+9VihxbGQI+SFyFVv/wVbFoLXK792KR2hKsBtrH3q
         UCD7fe1HsZ+F78M/aVvcDBbWmk0bacb73sLapFpmzf/2OTHWC/cpYXzZ20xY/59OoqNk
         TK0HmmULlsRzq/DjZiPkRITcKu2wUgdq38y/PStI58bCf0A8zEwaH6wEq3sBVXHJhVah
         PzoBbztLb4ebom4hZhBOHM1j+gXBy6EB34FaCsnvu+j2TsOQ/vgiQ14sckp6S0RZZk9a
         6alopt0zEuyFF5agfL/amiEsLiLdQYkOIFT7Neq70SF1ufyvm1AwmqSX2CDrB35OcZrA
         ShqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506621; x=1721111421;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShtGGv5EDAR4+wbh24vGDrCYLPGvjs8IbCaS8cbSqGs=;
        b=hHNZQCziM+T9PIoVZzxG+3cA5kxh9VEIG7LCCniiTxtu5VSaLAAhxpd7K8/ljnVWDL
         VpKeNTTXzm64LqvTjtknF0XzWgX5DqXvWi1pU//t6EZyWGobPGGu5Gc2Mxo6cJgE6e8D
         1U+ZBP/bfyT3LaJtIrc1Ssg+S/RNAP4ANamEN/OfGdKhbSM/xqL8zJBMWby/fFMUWb7l
         ZbQOxQFTSuY25Q1xnAeFN0pTrGFGUd2vcPpHafXxa8zRTE7h3ZvqOyxX9v7OQEwMK4UH
         aX0806imwrr005p8Jbq/ynf2E3TF1MBLopmEO8IMPSq1IPmS6zZGvDh2C/JsVMN4ZpaS
         Znlg==
X-Forwarded-Encrypted: i=1; AJvYcCVxXK2VD6sLP2wNLN+L+VrfPYeKuQw0FZ48iWglU/ANE1Xjbb060kR3tPbdZUplxr1D6yAT3Yp48VSCUfTDYmGykv+3ozgTCx1hfKXYic++IEX2KTOyr+9ARZ4ecfO4f5qQKG5AggUwMg==
X-Gm-Message-State: AOJu0YwSZUMsnxd3xE9QJXo2wjWP8qiTR7pxO3k5n5oZ+9AdBZDsOwdJ
	Kl8f+fb7kuf8FMcXujvGsKvLh0784g/QBEGfS0khrB+u6xq9oW93
X-Google-Smtp-Source: AGHT+IHrKs/8CNW8VfLftkpz3GKY9iSu0jP4UR0SAR9FzqhgG+U76RdECOJ6HqAbEzyS5DKPUnRHsQ==
X-Received: by 2002:a05:6512:110c:b0:52e:943c:c637 with SMTP id 2adb3069b0e04-52eb99a1936mr953395e87.37.1720506620535;
        Mon, 08 Jul 2024 23:30:20 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f2375sm193478805e9.27.2024.07.08.23.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:30:20 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:30:18 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: sdhci-sprd: convert to YAML
Message-ID: <ZozY+tOkzK9yfjbo@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Covert the Spreadtrum SDHCI controller bindings to DT schema.
Rename the file to match compatible. Drop assigned-* properties as
these should not be needed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Node name adjustments in DTS are being handled as part of:
https://lore.kernel.org/lkml/cover.1720112081.git.stano.jakubek@gmail.com/

Changes in V2:
  - drop assigned-* properties, these shouldn't be needed (Krzysztof)
  - reflect this change in the commit description

 .../devicetree/bindings/mmc/sdhci-sprd.txt    |  67 -----------
 .../bindings/mmc/sprd,sdhci-r11.yaml          | 112 ++++++++++++++++++
 2 files changed, 112 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
deleted file mode 100644
index eb7eb1b529f0..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-* Spreadtrum SDHCI controller (sdhci-sprd)
-
-The Secure Digital (SD) Host controller on Spreadtrum SoCs provides an interface
-for MMC, SD and SDIO types of cards.
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci-sprd driver.
-
-Required properties:
-- compatible: Should contain "sprd,sdhci-r11".
-- reg: physical base address of the controller and length.
-- interrupts: Interrupts used by the SDHCI controller.
-- clocks: Should contain phandle for the clock feeding the SDHCI controller
-- clock-names: Should contain the following:
-	"sdio" - SDIO source clock (required)
-	"enable" - gate clock which used for enabling/disabling the device (required)
-	"2x_enable" - gate clock controlling the device for some special platforms (optional)
-
-Optional properties:
-- assigned-clocks: the same with "sdio" clock
-- assigned-clock-parents: the default parent of "sdio" clock
-- pinctrl-names: should be "default", "state_uhs"
-- pinctrl-0: should contain default/high speed pin control
-- pinctrl-1: should contain uhs mode pin control
-
-PHY DLL delays are used to delay the data valid window, and align the window
-to sampling clock. PHY DLL delays can be configured by following properties,
-and each property contains 4 cells which are used to configure the clock data
-write line delay value, clock read command line delay value, clock read data
-positive edge delay value and clock read data negative edge delay value.
-Each cell's delay value unit is cycle of the PHY clock.
-
-- sprd,phy-delay-legacy: Delay value for legacy timing.
-- sprd,phy-delay-sd-highspeed: Delay value for SD high-speed timing.
-- sprd,phy-delay-sd-uhs-sdr50: Delay value for SD UHS SDR50 timing.
-- sprd,phy-delay-sd-uhs-sdr104: Delay value for SD UHS SDR50 timing.
-- sprd,phy-delay-mmc-highspeed: Delay value for MMC high-speed timing.
-- sprd,phy-delay-mmc-ddr52: Delay value for MMC DDR52 timing.
-- sprd,phy-delay-mmc-hs200: Delay value for MMC HS200 timing.
-- sprd,phy-delay-mmc-hs400: Delay value for MMC HS400 timing.
-- sprd,phy-delay-mmc-hs400es: Delay value for MMC HS400 enhanced strobe timing.
-
-Examples:
-
-sdio0: sdio@20600000 {
-	compatible  = "sprd,sdhci-r11";
-	reg = <0 0x20600000 0 0x1000>;
-	interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-
-	clock-names = "sdio", "enable";
-	clocks = <&ap_clk CLK_EMMC_2X>,
-		 <&apahb_gate CLK_EMMC_EB>;
-	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
-	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
-
-	pinctrl-names = "default", "state_uhs";
-	pinctrl-0 = <&sd0_pins_default>;
-	pinctrl-1 = <&sd0_pins_uhs>;
-
-	sprd,phy-delay-sd-uhs-sdr104 = <0x3f 0x7f 0x2e 0x2e>;
-	bus-width = <8>;
-	non-removable;
-	no-sdio;
-	no-sd;
-	cap-mmc-hw-reset;
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml b/Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml
new file mode 100644
index 000000000000..b08081bc018b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sprd,sdhci-r11.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SDHCI controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,sdhci-r11
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    items:
+      - description: SDIO source clock
+      - description: gate clock for enabling/disabling the device
+      - description: gate clock controlling the device for some special platforms (optional)
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: sdio
+      - const: enable
+      - const: 2x_enable
+
+  pinctrl-0:
+    description: default/high speed pin control
+    maxItems: 1
+
+  pinctrl-1:
+    description: UHS mode pin control
+    maxItems: 1
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: state_uhs
+
+patternProperties:
+  "^sprd,phy-delay-(legacy|mmc-(ddr52|highspeed|hs[24]00|hs400es)|sd-(highspeed|uhs-sdr(50|104)))$":
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: clock data write line delay value
+      - description: clock read command line delay value
+      - description: clock read data positive edge delay value
+      - description: clock read data negative edge delay value
+    description:
+      PHY DLL delays are used to delay the data valid window, and align
+      the window to the sampling clock. Each cell's delay value unit is
+      cycle of the PHY clock.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc@50430000 {
+      compatible = "sprd,sdhci-r11";
+      reg = <0x50430000 0x1000>;
+      interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&aon_prediv CLK_EMMC_2X>,
+               <&apahb_gate CLK_EMMC_EB>,
+               <&aon_gate CLK_EMMC_2X_EN>;
+      clock-names = "sdio", "enable", "2x_enable";
+
+      pinctrl-0 = <&sd0_pins_default>;
+      pinctrl-1 = <&sd0_pins_uhs>;
+      pinctrl-names = "default", "state_uhs";
+
+      bus-width = <8>;
+      cap-mmc-hw-reset;
+      mmc-hs400-enhanced-strobe;
+      mmc-hs400-1_8v;
+      mmc-hs200-1_8v;
+      mmc-ddr-1_8v;
+      non-removable;
+      no-sdio;
+      no-sd;
+
+      sprd,phy-delay-mmc-ddr52 = <0x3f 0x75 0x14 0x14>;
+      sprd,phy-delay-mmc-hs200 = <0x0 0x8c 0x8c 0x8c>;
+      sprd,phy-delay-mmc-hs400 = <0x44 0x7f 0x2e 0x2e>;
+      sprd,phy-delay-mmc-hs400es = <0x3f 0x3f 0x2e 0x2e>;
+    };
+...
-- 
2.34.1

