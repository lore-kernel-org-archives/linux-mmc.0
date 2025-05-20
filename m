Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BE19F135;
	Tue, 20 May 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746742; cv=none; b=nCBet2xHvBpn7o72O5QgzZqgpkTfCV3hCRXmN1dFT/x3vDf1OEJmk37d/BQK9a0TAG8KFatko0vkYw9I6moHcfOXPm2kIV8dNZOEU9Nc1E/vO0cgHNUNSY4l/cqvVVeBU//4VA+PFKcGURH/klmYian3e5a4QaoMmR6zlU2N1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746742; c=relaxed/simple;
	bh=mSWd+3T3kaVWyXpU6vbkPIGE9sAmeeMJHzrtO7YHLWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VHUeYGah5+dC4RnUgojBrXvOIU8TTdSUENKthMixny2+uF7T1tB7seSNzrDKFLNFfHLKZLDt6R1QF4ZLfVDmUwkT5jejrqzWHaUttBaU2YD6Zp4nMXlTkZc+qQ0dY8gPpTNzbHOMw8WAwJDQBob2EQJdZqDgBwYQWxt9OKFoIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT4qn6iY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT4qn6iY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so3746326a12.0;
        Tue, 20 May 2025 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747746738; x=1748351538; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eW89hvXQZc25oGOOzJxJK44/BxyPnPZbqF3pwcANOrE=;
        b=VT4qn6iYWx5JF+FF6j8RZq2Msn0R+np3CumHc3421NmcOH1oLlTr3zNGKxBRkV4uhS
         29S3n9a1MUMuTMDkHykahKz7QCKpokz7V2wE/6EwLWTAA6xwh/A87bmUPRRZPa2LWUfo
         sqvGg/UVmaEnVX1GZjrq89ixM9+7vBfHNJSx685P1G3UGLz32whqKThhBCL7bSPhykR8
         hQwdAB2PY0xh9X0uu6A05ilaUEyRr0ayBfFy1R5VQU+YGAaO12kb/G3nkm8hXGGoRauT
         PcYicUoPve6qD1V9s6SzZxI45MLX2cDz8wwPWcg+6+naScje865JP5mHj3o6VVy9nufo
         w1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746738; x=1748351538;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW89hvXQZc25oGOOzJxJK44/BxyPnPZbqF3pwcANOrE=;
        b=wHn+zDPZtZEom/BG9Oe+ur28w0m5x7XXHLJfEg/Nap47QPAIBKwKviSYsfBqn/115X
         iZaLYDLUBgj7mXir+r5kdEhV1JIGkOTPnmgUxjX2gsbRrori+x4tStmRro+uKQ644Z2H
         dfO9LzisixC2ZXVcLF03Li15/ptK+qhmPpAn8fea4943gV+ewBQiETwPDXsaQggv+z0f
         VJc2QhYD6iiEkYkJQFrQBg499Ligzh0sgFF3UcUD6FftQcJgKVRtczg6raWCdoZxE5H5
         Q9lDbCOP4hr+o0smWR8XQ9sEby2jRElSXVHcxBCbkLaZJhU9yTbQojRmX+m7L4A9LO1O
         OWMw==
X-Forwarded-Encrypted: i=1; AJvYcCVC/vUiTWVgCsV9NBGp3ft4PE8yhwczvzwulCsrHNhvs3mo3AVEyZTPmsBM24EFB4a/0GhF/P2FZJ+b@vger.kernel.org, AJvYcCWjPonhJ9Lx1Mz74R1JvV+XQsnrnX0AbCkHz4rS/3l16i+5ePgbQLDxlQnxKQuVz7emFrUEsFK5IOBaLeJ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzFG1t5NEH1adtk1f5HiDkcp0WbNeG/bfzR3QCGq6lDA6eNVYFb
	vv0VnM1tDXrO8FfZjORVEJX4u1BTNuB1T1carS+c/lCWtBZkjw48UCF6
X-Gm-Gg: ASbGnct5A47G2zNlPv/7WDq3m7Oj6Mp8YDTOKFNrt9a+LbU4XGYPyax4DaLjhGnIv+4
	85IZT3H5CAXY93+gCzzFOxsAGtDiM0sx8iJ0/rYIXlINvsPhl2+PTwqDvvw1KXRYe7PQwHUWhzD
	GmmSh57XsUvzRqPHhcYkNl+LckDm/sur3Tl7kAHfIG6kN6Bub7KDuUE2hgBrQQ8ksWxim3cfOmi
	uQObxGpbhZGQtazG2JBelse+Wdr/siiUFjfqP33mFgQCE0gUe+NXXZ676u/p8IaQJaRpcI7eb7b
	oyGlyb0aIvplAn77VRPGp/6XF0W1NbqPZQoABXIHg4DlqcpOx9Oncf4wbEZH/g==
X-Google-Smtp-Source: AGHT+IEgPrOh+e0Ok2pBjqx2FEU+n+NU8LQOp6kbrf99aONsnomlV5HlexSaIVKGxL9Qi4mIi6UZ3Q==
X-Received: by 2002:a17:902:d543:b0:22f:af3f:bf22 with SMTP id d9443c01a7336-231de3ba64fmr216846845ad.42.1747746737607;
        Tue, 20 May 2025 06:12:17 -0700 (PDT)
Received: from Black-Pearl. ([110.227.160.208])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-231d4edb063sm76105605ad.255.2025.05.20.06.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:12:17 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Tue, 20 May 2025 13:12:03 +0000
Subject: [PATCH v3] dt-bindings: mmc: ti-omap2420-mmc: convert text based
 binding to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-ti-omap-v3-1-aa845b301c4c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKJ/LGgC/02MwQqDMBAFf0X23JRkQ0rsqf9Rekhi1IVqJJHQI
 v57o5TW4zzezALJR/IJrtUC0WdKFMYC8lSB683YeUZNYUCOiiuObCYWBjMxgRelWlM3Vnoo7yn
 6ll576f4o3FOaQ3zv4Sy29dsQ/NfIggmmtLbcOSs0yls3GHqeXRhga2Q8evXfw+Kh4Y11XLe2d
 kdvXdcPgt2wsdYAAAA=
X-Change-ID: 20250502-ti-omap-12655fa9db3e
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI MMC host controller binding to YAML format.
Changes during Conversion:
- Add new properties 'dma', 'dma-names' under required.
- Define two separate phandles for 'dmas' in the examples.
- Include appropriate header file for interrupts and use
  it in the examples.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
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
 .../devicetree/bindings/mmc/ti,omap2420-mmc.yaml   | 66 ++++++++++++++++++++++
 Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
 2 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..61fd4244b92cb3b76db1a765933ebb2af2ccae28
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
@@ -0,0 +1,66 @@
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
+      List of hwmod names (ascii strings), that comes from the OMAP
+      HW documentation, attached to a device. Must contain at least
+      one hwmod.
+    pattern: "^msdi[0-9]+$"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
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

