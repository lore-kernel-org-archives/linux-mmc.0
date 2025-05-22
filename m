Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBB221FB3;
	Thu, 22 May 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900456; cv=none; b=dQiqfESgoyYrCRLDemJlc1oX9fT40Rx0cOW+Atm7IqM2/AeAUd+oxH10AIf8ojKG6eZogo8hQrHvkN6cDqURVHNq0B3+HajYEldQo358ylB56KyrsOBL+y+lbiI4ybhjRza0RF3x9hstAHYM8BnpOkx00bVXcikgJbZeANRUpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900456; c=relaxed/simple;
	bh=uU8nG00Q2stbTwE2Gh2fD6nuqa9pOcbvuOaudFx+OdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gQoBCricegnD4cC9iCLGul1qdP+O4Lj4/ArbC60neD8i6JgJbEcDKI6rUq3PXtD+bnqdYW9vEf3wEvXPmsGirDTfeMX6czOcChKFvkJONQBfdvCX1u9bAO8E+XcccspLzbQPoton8a6SKxOVUjtU9ZA2ZSirfZRZ5hQOX8QKvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPxbpUmX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPxbpUmX"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c9907967so4441664b3a.1;
        Thu, 22 May 2025 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747900454; x=1748505254; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsrhGlQGDRsN50osPmG62nNMbsUeNwxrE0PRWOPkej4=;
        b=OPxbpUmXwvIkubpv72ig3HRppNPjsmfEhlDH/IFR0+y1dBsTWMJ9wn03P1OhjHpyMb
         uXcw+6v+zGVSXgMRCmqieMlOxbZDrENN0de4YdDROyY5BAmDLHauuEuJ7ck/RCIxacVR
         oFDD7T/3PxSVd9Rzj+2xin8RS0dmu5591iSzoaV1uy0LNb4DlzZgxnLo/WvivtrUWvtY
         XCA2EiCqW3puUqHY9FW221TGJ8CAgxT14jKK+51++T66dzMbwl1xFdn9Q19T1lLgQYlj
         SkYPjeGBwQY+IoR9auEADa5fDVcA491/GWK4M6XgAmpp/Dsa7C5GTLKJJADwFWHSOzlb
         eIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747900454; x=1748505254;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsrhGlQGDRsN50osPmG62nNMbsUeNwxrE0PRWOPkej4=;
        b=cYjtqn9sepbVYpFHOohBwD2l8pXSVyV/dqpelBH+SGeGJEb5tzBwQhEzd4n1Z7LJRP
         3o5I6Xfv6DbV8BGIOdr32Wr38QhT7AUAFjMkY4uxBS7AsA/mT7uJep8AV5V7UdRF03N9
         SwPa08jp3iZgM/2ei8Vm/oSgWoDXK4P3PD7kQ3irtKihEzK4D6OPw9LxF39ZxX2X/I9s
         Um+IC7GH6NZzIJGmFfrJMace8xRnP7cmETnIKsnZb6gQdqMlYAOo0yfaDxAqax4m686z
         z/SNMJpOLaB7kpyEXWEJnGwfgTaVkruSvlBdCXcIvoPIi+wvugiWKHwBUv61mEBdEpcq
         Ud6A==
X-Forwarded-Encrypted: i=1; AJvYcCV57twAv2eqDuHu7yTPKwgyTFTCcashbMD38e5hnS5TCqk3z1NCs466FmSqtdENi8g5ejZcoNHBD8ml@vger.kernel.org, AJvYcCVe3Qfx4A6I76OXTqIZem9q1P45zRDu9bxW3ylbWIugs3E+GXV3BCqRhcQn+TdldsxBss8WDErDWGK6ASZN@vger.kernel.org
X-Gm-Message-State: AOJu0YwBURsyVvwMGBThW28sxtyL01J9XvelJLreH2WRes4KqLxfusRQ
	WiD3V3Wja+zSCsV9WEMvbvmZsxmpO7Ryfz8wUXISJgIhQrCMK5WlBQ/h+wkCZA==
X-Gm-Gg: ASbGnctMY5DCJx5WbEnVZY2knQRmbQWswTE6+UpdM1gXrQlisIaP7mZfsxmKSeouOvp
	Ti4tYU+OXRgL748lD98Ijj07OCAI99CcNL8TTW3N2gxVsisguu70SNtFcw5EA+e65oUpx4xT7m/
	W7QjIyRQkuHOBj7rSysczgVrxdZ2fspBfec7nrh84GLXAY9MObtDnzYXhRWC7Xg6gXkSWXCi6vN
	t0uy9FduAb/xCg8qZpzQFJUUpUoyFvNjbYUm+7LL80bqKwUIrZHDF3LlQfJDZE8fkqMmSHNjtyP
	NSr6Y7UOFNrKb5CVlr/xWepDr2TuHdb8B1i9t8bl+ATwZDtPHusHF3dDs97T7niY/+AXsP/N
X-Google-Smtp-Source: AGHT+IE6pv3MvDAHJqmt1doTPQEc7o8d+ZdNoLUOa96MB1SE5IZNE2q0Gy0vbHP6F7AbiuPNzlRZGg==
X-Received: by 2002:a05:6a00:944e:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-742a97dba4bmr37381909b3a.8.1747900454370;
        Thu, 22 May 2025 00:54:14 -0700 (PDT)
Received: from Black-Pearl. ([122.164.166.145])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-742a96def25sm10723661b3a.24.2025.05.22.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 00:54:13 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 22 May 2025 07:54:01 +0000
Subject: [PATCH v4] dt-bindings: mmc: ti-omap2420-mmc: convert text based
 binding to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-ti-omap-v4-1-5d261a661b05@gmail.com>
X-B4-Tracking: v=1; b=H4sIABjYLmgC/13N0Q6CIBTG8VdxXEc7HKRhV71H6wIQlS3FgWM15
 7uHrpV1+Z3x+zOTaIOzkZyLmQSbXHR+yKM8FMR0amgtdXXeBAEFCEA6Oep7NVKGJyEaVdWaW5J
 fj8E27rGVrre8OxcnH55bOLH1+m4w+DQSo4wKKTUYo5lEfml75e5H43uyNhLuXfV1mB0qqLUB2
 ejK/Du+c7j7j2enlCyF5sBM+eOWZXkBfuD0Tw4BAAA=
X-Change-ID: 20250502-ti-omap-12655fa9db3e
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI MMC host controller binding to YAML format. Define ti,hwmods
with $ref definition, description and a pattern under properties.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v4:
- Removed dma, dma-names from required as it is not necessary for all compatibles in DTS.
- Changed the commit message.
- Changed the description for ti,hwmods property.
- Link to v3: https://lore.kernel.org/r/20250520-ti-omap-v3-1-aa845b301c4c@gmail.com

Changes in v3:
- Changed maintainer to Tony Lindgren.
- Redefine 'ti,hwmods' with $ref under properties.
- Modify subject prefix with ti,omap2420-mmc.
- Link to v2: https://lore.kernel.org/r/20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com

Changes in v2:
- Added include statement for irq interrupt controller and
  modified the interrupts under property to use header.
- Changed maintainer to Rob Herring.
- Defined two seperate phandles for 'dmas' under examples.
- Rename the YAML file name to the compatible 'ti,omap2420-mmc'.
- Added missing type and maxItems to 'ti,hwmods' under properties.
- Link to v1: https://lore.kernel.org/r/20250510-ti-omap-v1-1-588b0ccb1823@gmail.com
---
 .../devicetree/bindings/mmc/ti,omap2420-mmc.yaml   | 64 ++++++++++++++++++++++
 Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
 2 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..705d388a1e64f64005c28b41cc27583fefeb2829
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/ti,omap2420-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI MMC host controller for OMAP1 and 2420
+
+description:
+  The MMC Host controller for TI OMAP1 and 2420 family provides
+  an interface for MMC, SD and SDIO types of memory cards.
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+properties:
+  compatible:
+    const: ti,omap2420-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+    pattern: "^msdi[0-9]+$"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mmc@4809c000 {
+        compatible = "ti,omap2420-mmc";
+        ti,hwmods = "msdi1";
+        reg = <0x4809c000 0x80>;
+        interrupts = <83 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&sdma 61>, <&sdma 62>;
+        dma-names = "tx", "rx";
+    };
+...
diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.txt b/Documentation/devicetree/bindings/mmc/ti-omap.txt
deleted file mode 100644
index 02fd31cf361d6ed893ec2f9eb8368b358ab2bae1..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/ti-omap.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* TI MMC host controller for OMAP1 and 2420
-
-The MMC Host Controller on TI OMAP1 and 2420 family provides
-an interface for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the omap mmc driver.
-
-Note that this driver will not work with omap2430 or later omaps,
-please see the omap hsmmc driver for the current omaps.
-
-Required properties:
-- compatible: Must be "ti,omap2420-mmc", for OMAP2420 controllers
-- ti,hwmods: For 2420, must be "msdi<n>", where n is controller
-  instance starting 1
-
-Examples:
-
-	msdi1: mmc@4809c000 {
-		compatible = "ti,omap2420-mmc";
-		ti,hwmods = "msdi1";
-		reg = <0x4809c000 0x80>;
-		interrupts = <83>;
-		dmas = <&sdma 61 &sdma 62>;
-		dma-names = "tx", "rx";
-	};

---
base-commit: 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
change-id: 20250502-ti-omap-12655fa9db3e

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

