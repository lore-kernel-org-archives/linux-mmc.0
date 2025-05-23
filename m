Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896A183CC3;
	Fri, 23 May 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020250; cv=none; b=QkeaCyNbqf530PtS2zwr6kCNZtChbuQNEs8cXCmdkqb7uXN1sOG8FN1jy4lxUC3iPOdk/HCU4QPyYf1NzicFFi2nQ/Se5ZvnJTWYq5Awuwu/iIrz+WOc6ZtM8NhMfUZSY/Y9jRvuXnwwp9uLfu54/g69Dsu9Upf9BH4qI1LJeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020250; c=relaxed/simple;
	bh=2G7wOQLRpm+82VaBLtRAd7WMRfx1AS6zQEfMrxhNEa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pSw2z5vF8FdtdrRKPTWG9+7u7YnnxPgcLCiqqfX49UzmNiloccSJ/M6uDs4bXhelQXwaFlO1SkJj/IC45sj5ajo5H0KwK9dRCfNQIUu+fZXqycRj7WP7dWNu8rlPhUipJQpH0kgR0jB8Cs7y4jaGY7mO1Tx0oDlDkC6thwjZZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGcHUzr6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGcHUzr6"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b26ee6be1ecso64309a12.0;
        Fri, 23 May 2025 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748020248; x=1748625048; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzJrfoZ9iFtXIAm5eo34VLWMHgVC6oLJRxOXDvgaT5U=;
        b=NGcHUzr6872Wq8SfgMexCp4OyZyLGJU5I3hD3Kuv8LSPWPadjS/f+TCssgthCxKVRt
         aVdPp+1vSLpSIcScTeeVBWKXpWFqVM6QqQSJWHsvLngcjM3RbeJYgMGlGTdViSIzJgOq
         vs4ME9SYnEE4e6aQTA3cooPladB0wwg5jzWm/p/tG2svZ9bNHYR9JYdjbX11BwT2Z9Wx
         DtfoTP0enNKwt+1IkNV3MKcUF2fRKkEENZNiZzQr9d46ehkg5iHn0PFdIKgycXbLxem4
         jj0OgwBLviMIMpuRIyxsxF2TvLHCe79N7k/wT+ju1Wu71a9AppbzPhDPdsBR/9p4BdpU
         daSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020248; x=1748625048;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzJrfoZ9iFtXIAm5eo34VLWMHgVC6oLJRxOXDvgaT5U=;
        b=D4FvDO4xTtJWoVZtZOcWaagP1xcUVdxC9psjlNaSFJKyN7NE2qOF2oP/mWw/Ycy/xA
         HGS2XmQ9sBK+VuypLXHac8RxZwDxRPqGbN6wKROYrjldrKlaZrU8hUdsbTf+Jpp9uVmX
         K+ftGI/g4K5kQJ+Uc78C2KHS/qLUD9x/cMVXayCeMhmx2DzVLIyX1nxB7dU7aSs11O3N
         pU4O8oAYXTtKpOMZc/eWbsFSAdMl1foM3kge/TbDWt3BzcfYBV9EKKBaMs/wpMz/DbdS
         qxi11nxcnDVssuZFnrnRfJrWE3GE2PXNhqrgZRt0+xECHtv6ZyZEocfZliGNWl0E6LLZ
         qIwA==
X-Forwarded-Encrypted: i=1; AJvYcCXKyjEfn8XDYN7BoF7vD80McroZWKhfpBr18Z7TS6unTbgei8ltRTlV57ajB0MaeMa6Lr61jwX/aljNTHoh@vger.kernel.org, AJvYcCXZNIVtPNRld8xoVMpWu3mX/HM++ked8lC8JxsCieEjUZ2VIs+MhFPZCrR/RLq4Z/o2vRPWdIDPJQeD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9N1YYvyyqjjks5ojzUSW412S3GcY1WBM+4i+EfIcSxhqPNCp
	JvJRRRoPWiE43dOXGYe7Y0FW5LwJuXA9MIlb/yR+uo9tVjhujQj+Fd0N
X-Gm-Gg: ASbGncsHZq+I5qJTaECc+f2c2dEJsW3X/9LSTrDXgxtqZqAwdl/cRmcbmBwGIXjj9vj
	sGj3wAIWHZTSklzIefT5E7oCCq/+Gv1vTTeFjEaN/El+oK8mp3pBXXRajEJ5xry+GMWbhwI8sMM
	iDGkBuzFt3GeRyy5Kxr5JpkpSr35bqo6nNJUUCiGyzVkUVexjaf+qnemNAPsKJR9nERgVkuY1/d
	tQMJvvSFooh7Rtm/hB++rQM5q3EVMgF4YEX4SLF0GaDe09WGQ9tjbmNBx+THOT2dxLqYSxhi0To
	gIQ4Vr3+q0AWnwt8Q4tsVKJz0SJSYukdjNsZSUN8cFgIn7N28GfKSS7SaHfJ0PyFI3uwoSY=
X-Google-Smtp-Source: AGHT+IEzuGifaAlrHeN43SgRQbfw1SzMlTqAm82w7voGLPNl/97pXXsmFURaB2Rx27I2PO12CGGHmg==
X-Received: by 2002:a17:902:e544:b0:22f:a4aa:b82b with SMTP id d9443c01a7336-23414f62af9mr2453045ad.21.1748020247662;
        Fri, 23 May 2025 10:10:47 -0700 (PDT)
Received: from Black-Pearl. ([223.230.93.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-231d4ebabdasm126183845ad.185.2025.05.23.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:10:47 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 23 May 2025 17:05:14 +0000
Subject: [PATCH] dt-bindings: mmc: sdhci-omap: convert text based binding
 to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMmqMGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0NL3ZJM3eKUjORM3fzcxAJdSwPzNAsT8zRzU2MDJaCegqLUtMwKsHn
 RsbW1AF87wHdfAAAA
X-Change-ID: 20250519-ti-sdhci-omap-907f847f7530
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI OMAP SDHCI Controller binding to YAML format.
Changes during Conversion:
- Add patternProperties for pinctrl-<n>.
- Define new properties like "ti,hwmods", "ti,needs-special-reset"
  "ti,needs-special-hs-handling", "cap-mmc-dual-data-rate"
  and "pbias-supply".
- Remove "ti,hwmods", "pinctrl-names" and "pinctrl-<n>"
  from required as they are not necessary for all DTS files.
- Add missing strings like "default-rev11", "sdr12-rev11", "sdr25-rev11",
  "hs-rev11", "sdr25-rev11" and "sleep" to pinctrl-names string array.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 ------
 .../devicetree/bindings/mmc/sdhci-omap.yaml        | 155 +++++++++++++++++++++
 2 files changed, 155 insertions(+), 43 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e707837bc242b055bbc497ed893a91c9b24f2dde
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sdhci-omap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI OMAP SDHCI Controller
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description:
+  For UHS devices which require tuning, the device tree should have a
+  cpu_thermal node which maps to the appropriate thermal zone. This
+  is used to get the temperature of the zone during tuning.
+
+allOf:
+  - $ref: sdhci-common.yaml#
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
+  pinctrl-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 19
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
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      This field is used to fetch the information such as
+      address range, irq lines, dma lines, interconnect, PRCM register,
+      clock domain, input clocks associated with MMC.
+    pattern: "^mmc[0-9]+$"
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
+  pbias-supply:
+    description:
+      It is used to specify the voltage regulator that provides the bias
+      voltage for certain analog or I/O pads.
+
+  cap-mmc-dual-data-rate:
+    description:
+      A characteristic or capability associated with MultiMediaCard (MMC)
+      interfaces, specifically indicating that the MMC controller
+      supports Dual Data Rate (DDR) mode
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
+  vmmmc-supply:
+    description:
+      It is used to specify the power supply (regulator) for the MMC/SD card's
+      main operating voltage (VCC/VDD).
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      It is used to specify the frequency of a clock in Hertz (Hz). It's a
+      fundamental property for communicating hardware clocking information from
+      the Device Tree to the Linux kernel.
+
+patternProperties:
+  "^pinctrl-[0-9]+$":
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandles to pinctrl states. The numeric suffix determines the
+      state index corresponding to entries in the pinctrl-names array.
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@4809c000 {
+        compatible = "ti,omap2430-sdhci";
+        reg = <0x4809c000 0x400>;
+        interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+        ti,hwmods = "mmc1";
+        bus-width = <4>;
+        vmmc-supply = <&vmmc>; /* phandle to regulator node */
+        dmas = <&sdma 61>, <&sdma 62>;
+        dma-names = "tx", "rx";
+    };
+...

---
base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
change-id: 20250519-ti-sdhci-omap-907f847f7530

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

