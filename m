Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D0E50285;
	Sat,  6 Jul 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720272816; cv=none; b=K8nOu9hNO+fekOHM3Uh8YJbY8N5Xe8pcU3o1j/zKIcsG+YTvS3cRAJBnd4K8jz5ldsARfwpB+EDqWMPvv/Qbin7x2E64km9Ki+TzWogaOXZR5OvTpehLeu/0M/g4d0xrmuQu2uXvLQbo9thy+D5n1zOIHSLKtDC4Q88p7uN5eco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720272816; c=relaxed/simple;
	bh=65bZJJmOm8R1QkVqY8ukfBhTeQrrey9GA2nRERDUUuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rs7nzDGi9eQ6NXFcIhA8td+6/LRwbvbZJrW8ll7l+yn0XTKgo59xQukHyfrV+kNd5KWZKicE3ZyWq/k1n5FSJw5+gAKhpNQeODiQHFwtUgz2E6u+XCdOGcqVSqhLtmRqUyTBn98hJv7FAQ1RrAD09rEpPt3W8QHG3dBb9NYgrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0xGflf6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0xGflf6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso16456605e9.2;
        Sat, 06 Jul 2024 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720272813; x=1720877613; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIoT7ZBfIhmIp8CBtQ1Sfwkn0lYW/qF5loxt2bM++CA=;
        b=A0xGflf60rNENGHMmXWd2iL40qNQQ+yF3LgsV3OC6nKr0sv6GdVY2eNwdVxxurPa06
         4YUHkn2MIZZtuRSTc1EyiR5TA6qNxxbpeOf/EjwpLBZpU8JTqdaQvCBrmjFgL5g/qwKT
         RkNHuAsZVsODVwnMWy58IWsi9fbaPJb4F7ofgSfqLv3xqCYMrXG3bWSd7LJd6qTLGQl6
         p30ofpaP98ltUzAgOKvVvaj3u/7TbLkSUQzEG6Rj2V7hrEwKqVyUE2y2Pomg7nO8udtd
         VNKwJyUpeSob8J3qbdVS6HuJtJSCvu5bIUlUiK98ntzrw9vx1YkR0dl7TW8XVhC8SV5Y
         WfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720272813; x=1720877613;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIoT7ZBfIhmIp8CBtQ1Sfwkn0lYW/qF5loxt2bM++CA=;
        b=Ac2Ah+NOudm3n6ZqTuu9Fzj6BP6hr1r7XCKE4XrBUdltHuF0jVVg0xstXNj5UeVHpl
         g1Ppt/qhDGPnS8I9tzK6d4lRdXrUi2/dkPlBmILFlAxsq25OxwgjkyZ3boY53LIUYqht
         MFyHpJ4/DmDLqXLPyKXwAUrws46WKUJatBvJTGYnNHeyOUxunVl7J8dvzU8V2ZZeoAJh
         fQSx6a2QtfQYOL6mYNIJyRCAMeeFtBLpDGfBoytBCG3UJoNqjdDjHwsZgP8fFBCocvvv
         gnFizsEHt/V2uC1h+4DrWXndH+8oSFu6CdpdGMQ7Y8D2w6/RL2IfcvW0paZ5dRMIW3mn
         QguQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo3dCvDwNpc2G1HMt/0eltIymwpW5U5CnY5WfCa+rY+QfPdvovS38Ni0VyB69ymoa1g/8cAHk9Dmmgox38X9QnNI14FWirCSrRxbA5uBe0iKH+Sr5TIyhnFhFHHabQwB6UgEpZmvuWRA==
X-Gm-Message-State: AOJu0Yy2+fPHr91L/DbTPw1M/aFwHl+PLc+AMwnPn9SARKRRhPIe3A83
	V2u2bNUzDhakc+aPTAvm5VErG9SK+1AMXQliNaXr0OunafyRzxKu
X-Google-Smtp-Source: AGHT+IGyLdMJkQD2YIPfyHwXPNVPWRLLzrCzTeATKrNq75NyGmHq1Rx8jxCFqP6frOsCMjHGmFjR4Q==
X-Received: by 2002:a7b:cd95:0:b0:425:63a9:f96e with SMTP id 5b1f17b1804b1-4264a428f87mr51263685e9.36.1720272812800;
        Sat, 06 Jul 2024 06:33:32 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28333dsm97774285e9.40.2024.07.06.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 06:33:32 -0700 (PDT)
Date: Sat, 6 Jul 2024 15:33:30 +0200
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
Subject: [PATCH] dt-bindings: mmc: sdhci-sprd: convert to YAML
Message-ID: <ZolHqsBnQxSo6SbT@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Covert the Spreadtrum SDHCI controller bindings to DT schema.
Rename the file to match compatible.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Node name adjustments in DTS are being handled as part of:
https://lore.kernel.org/lkml/cover.1720112081.git.stano.jakubek@gmail.com/

 .../devicetree/bindings/mmc/sdhci-sprd.txt    |  67 ----------
 .../bindings/mmc/sprd,sdhci-r11.yaml          | 120 ++++++++++++++++++
 2 files changed, 120 insertions(+), 67 deletions(-)
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
index 000000000000..3cf4a41e4ed8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml
@@ -0,0 +1,120 @@
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
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
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
+      assigned-clocks = <&aon_prediv CLK_EMMC_2X>;
+      assigned-clock-parents = <&clk_l0_409m6>;
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

