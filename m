Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFF30ACEE
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318693; cv=none; b=Kx+xJ5OULhEgPujbiWu6kCnYG4Q5eSVHwk8csD1NjFT5hPbRx5X+2ukQWU/rjEoJaMvLsv8Ouabc7EpHwPat/qpVnH8eKbemULVqGuutEFz5DgCV8SpNT6zRzuWaB1phgtGa+p6P3ehchY8wl2tjegL5LQvJwlqYjWmuhEWW/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318693; c=relaxed/simple;
	bh=NGaOrLTsFDY23HN6mLsw7AAbdGveOKYGWEzmFMEvhZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W7sj+hH/bUpzlni8l8njcAaoQk3odaJansrlwPb251TZPUA930GXBj1vpG7zxrKg8rZQNpn57tsecTC98Tet0ijx8hZoyp8hNsFN2YUgnVPX1DT8PuAtBFTePrp32+iBAqqajZm1mh/grcqCloOrlMfKDQQl76C9p6drR7vYSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVY/EPk3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVY/EPk3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4924593f45dso14306795e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782318689; x=1782923489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CfY+fA8aRPdoLbeY5/hh263ftDsGPqED+585kkEVz4=;
        b=gVY/EPk3V5yDkVgeDPBfpGS5dLVm2NSSQliEi5m8YKcKQfnDi5FFdxBYweJBLHACiR
         yTR1b41jyghhr97nF0W2tZAkNDjHLTPODgNma/FwqPqv4JKX/RKCwbNUPnSixVuOtk4M
         iX+iQPY7QliuUY/KuFv9AhY1bgRExcl/qUwpkGYgPyzcRdGIpROiGvzluE3vEhpz+KSB
         0Tt47aQ8RLaHx0fyJKm8QdqrGKxrho3CHvBvWMWzmq9IzMBbMJ94A8YdPSLWBDYxKL1a
         ycyRbmbs2S2xwAhUYbEZAelAhmUHQTBt79dgjtAcU8nxYwues8YwVOv51+CQmV3VzeFU
         /J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782318689; x=1782923489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CfY+fA8aRPdoLbeY5/hh263ftDsGPqED+585kkEVz4=;
        b=U597IAsd63YqBGcVH11cszz7LW6Fbbja64YcOZSdQPf9MVrh4rR0MnxNIX8GpE1P+U
         3B+GVMJlj4r4vJVU0pRQkiSYn22p4oRJZK3iWLfjafn/9131OVC1QwcRyXTPzvTV+izT
         w2E9ZiHLRYf7Jir3iL/EEMSEpq0cSZ+SrD0I/G0hzsZMRl1QOtBH7d0IeOQFNwU+vvCt
         1HvDtPa1lVsY47XktZG95nrlRtjE4l/6ILu9ra4lWPo8hLwnjC8NXk/zqg9emeuBo84m
         m3zH+Vl/RcLRxbJKiTtYKstIyCuh9Z5l53Qv87kVLBaLQh6vNMYF7+Fl2K8QgC0V0Hnx
         zrXA==
X-Forwarded-Encrypted: i=1; AFNElJ8mAHw9mrXUoSlZmzPfIeDBLNzghzheLEj8TcheL5R5+VrdD1QgOwx79VPHOgQoR0AH5UbgeCV81KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvp2OMTuHYdW1JWoWOG6EZ4xSHATR+TpLmNpOsooIaOhh6pwWc
	kmI6uXtjn2U9OKidF6CpVQIkFR86dKmdl+0yKzXcgwmNdLEzx5hXlsdP
X-Gm-Gg: AfdE7ckCwNUY7YSdGlrsZXXqMceSWgDYtu+KtMezcSYZlLC+rtCjp9elxnhajnzp9ta
	UOF6OQB0By8Tc+MzZPyINchQisCMbZMd0VBldqA26M0UTvKv6moa7GnwfQDgJcclFfTtEMBZg0c
	sCPPftnsZycJld6LQxeMquDN8jHclk9gDc8MI5k6kLzeQVI92NCV1YLsYDCgO9lo/y11Ig4Q1HL
	WFnLj7GrVIHtaagkFM5Ggr4U55jYNJ5WwwaXi/KBrzoxwCdwKobUjUOROIdXp83XmdltKmyZ7/M
	E2Rk57XHp32Q7YCLQg+6EeH/DDEWS12YoLN8LT61D78pIO4QdyvDFGsUGam+U7Y3eHACrqPqe5I
	MsmgDWDqQOthOh39MhDQoCoc2aW3zGjExFVB2eB4P1jl6nCFvTvSdpTLwPQvrAgt3IfK5oV2xSU
	8R3GNRA38Rg1Sq2XGBMRMUHRylFy8cRD62YARjbSeOFEoZOPqNiZzccw==
X-Received: by 2002:a05:600c:4f56:b0:490:d354:bcf4 with SMTP id 5b1f17b1804b1-49260875aa9mr58753125e9.27.1782318688828;
        Wed, 24 Jun 2026 09:31:28 -0700 (PDT)
Received: from localhost.localdomain ([82.77.79.113])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4926401a21asm3739235e9.1.2026.06.24.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 09:31:28 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com,
	egbostina@gmail.com,
	Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: Convert TI OMAP2420 MMC to DT schema
Date: Wed, 24 Jun 2026 16:31:11 +0000
Message-ID: <20260624163112.535237-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments MMC host controller bindings
to DT schema.

Note that the OMAP2420 driver will not work with OMAP2430 or later omaps.
Please see the OMAP HSMMC driver for current OMAPs.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
Changes in v2:
  - Changed ti,hwmods type reference from string-array to string
  - Updated ti,hwmods regex pattern to "^msdi([1-9]|[1-9][0-9]+)$"
---
 .../bindings/mmc/ti,omap2420-mmc.yaml         | 60 +++++++++++++++++++
 .../devicetree/bindings/mmc/ti-omap.txt       | 26 --------
 2 files changed, 60 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/ti-omap.txt

diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
new file mode 100644
index 000000000000..794d5ec0b58e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/ti,omap2420-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments MMC host controller for OMAP1 and 2420
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description: |
+  The MMC Host Controller on TI OMAP1 and 2420 family provides
+  an interface for MMC, SD, and SDIO types of memory cards.
+
+allOf:
+  - $ref: /schemas/mmc/mmc-controller.yaml#
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
+  ti,hwmods:
+    description: |
+      Name of the hwmod associated to the MMC controller. Must be
+      "msdi<n>" where n is the controller instance starting from 1.
+    $ref: /schemas/types.yaml#/definitions/string
+    pattern: "^msdi([1-9]|[1-9][0-9]+)$"
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
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
+    mmc@4809c000 {
+        compatible = "ti,omap2420-mmc";
+        ti,hwmods = "msdi1";
+        reg = <0x4809c000 0x80>;
+        interrupts = <83>;
+        dmas = <&sdma 61 &sdma 62>;
+        dma-names = "tx", "rx";
+    };
diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.txt b/Documentation/devicetree/bindings/mmc/ti-omap.txt
deleted file mode 100644
index 02fd31cf361d..000000000000
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
-- 
2.43.0

