Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463811C700D;
	Mon, 19 May 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660385; cv=none; b=Efwy60Z67A+hRJXJs4tU8Ta2zGwX0aVNiZxJCI+POt8uBjUZ265BDt+yuartnGXCYm0EQb7FDMN84gcmCSySzmoiFPrwpvn2FeNcj6wRvWSzgoJO60zS8ZVpHyE66Z/O+mIa1dKHswJILW3eDiJeHMLGISa/YaNuMbdseMd78R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660385; c=relaxed/simple;
	bh=7dxLPoCAlKtbHQPk0Lkzcq0ABP0lz9QU215KF7CbLmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ky76bao6H2EZL4GjAxbTQ3jO9FDqD/S8YQ9Fn44+T1B8BmiSFcicziYjb1mIbd6uV5v6uSYIh5j8UqXF4Elr7ObIp0tLOSNoO5XmHI6iJKv6Vyky5ydFZKfOpGSQxTkGIb61/eEQWzXHV+RqLmxML1JoymPz1t2No4DraYrdFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIK0u/yZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIK0u/yZ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c9563fd9so1013549b3a.3;
        Mon, 19 May 2025 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747660383; x=1748265183; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x5gJoD4zZRNgLOE7Htt6PW+ZaIUwHDZndPrFpZTwTic=;
        b=eIK0u/yZtzFFI3/tdwPfLo60UyjbkWN1rkCowHBLgwln8VzURdBFc8hG3SkSL9TIM4
         lvzvm0DOTUlMzZFt7nRhe2ljvo+IdUOdZPfqIiQc5EK8s7jjcA75VfGZqcsyeEKPz0FS
         V82aVaIzW/gpCb3EQe779GlFXP1tSBbiJf4CcOYIcPh3tXe7zZqUGw9zzkmlMRw/6rtI
         VEw+OjCkAL/5NM5six+TQCM2TIJNQ9akNrE/ByZi2GLqWYw+DJ2e2ba3s3Ugobt6FVL1
         K93NwfUngtdPUAx05Dl5zPjtn3Zib6/e40Of96I6u7f3kBUvFCZQvXaLkzlKelMd64Yx
         OyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747660383; x=1748265183;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5gJoD4zZRNgLOE7Htt6PW+ZaIUwHDZndPrFpZTwTic=;
        b=M5hvn2e39lvsaL06x+5vnBaDzmOqhNLG39mlyhxF6DIo5r1WgZmnD523Pa7bRi3MJo
         zY+QViJN25nwUqpjmmchtJ6B+W7aLtWX1TTs6DKZuilx6u/XaCFibahbFfyQuPnBierT
         yOceQbU6Wi88L9tt0AoUyRaFjQczsurD0wf+h4Wc4DiIocaMKqkXcAfDF1q7GPJOx7Vy
         UgScWq3JrxofpBTQ2A6mMJe6Kr/KRTe+C22TCPXBxCk1KGsq3Y4H0TLVz85ap4Gw/jnQ
         oxPrOigwq2Yld9nZOinZN5KOqZt7bZ5+UI2ENsUsNxTLTrZ4GoRZtK8xUDrGENy7T1Fh
         Lw1g==
X-Forwarded-Encrypted: i=1; AJvYcCUeDvNoTStBcf3L5b53Mz7LIFNds+du9bATxpgCwV71cPhTiGXgMb3xrhTL2LtVEUjPl9qQHmQyyFCimAzD@vger.kernel.org, AJvYcCVBpemWOqXBMQNNTK7TZKOcL7MomJ91DfFu+u3fggE4+OiGtInhqsQ9bAgxuB0UBt/FklTaWZexWuU+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ilwx4Q4QY2sib48gglTi7CxTvsRX9Bn0D+S/j/fogtkQQu4C
	ujSquls4MtFHCOm2eZq6U8o0ltvt8fNaSE/9JHkR/zZqsxblUEZpAfH/
X-Gm-Gg: ASbGncu0HWZvpj7KrHOIZOWqlPa1dAUsxSYPM7YN+MQqJoXOx8aJRo5c51yt8FWet5g
	hCM+z70C3VM3tsvCK39Nm7ljqzlgGewvjSMDyHmGwvQLWTAkqWVk48UK9cSTcWQbg1QvIq37U8F
	mDWuI+VmW7YPo2mqTjGTYfJK7ly6JnS49qNfOljN5gCgcpsdcx3fxZy/Sudw+jDgd8891IwxL56
	CfuJUQVXyq9VjZo097CaY73hGUL8ln/agg7MV3jPkH3KJsEsfHoN+2xWjmLIT9SCCPzHutGpa6t
	o672Fy20hH/FWQwu1jDN6/EQNHk1Sbx2+FkG2NkZNUaRzeCpZbenkFDvjLHo/w==
X-Google-Smtp-Source: AGHT+IHG0I2My5OgQfajxa4X3RPOQkUO/WK8Y44LYflLkDqwdbPk7SS5kF3wIjsL7acwLynPtA2Duw==
X-Received: by 2002:a05:6a00:4642:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-742acce00ddmr14964277b3a.11.1747660383330;
        Mon, 19 May 2025 06:13:03 -0700 (PDT)
Received: from Black-Pearl. ([122.181.202.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm6245454a12.72.2025.05.19.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 06:13:02 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Mon, 19 May 2025 13:11:17 +0000
Subject: [PATCH v2] dt-bindings: mmc: ti-omap: convert text based binding
 to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPQtK2gC/z3MQQrCMBCF4auUWTuSSYlEV95DukjTtB0wTUlKU
 Erubizi8n88vh2Si+wS3JodosucOCw15KkBO5tlcshDbZBCKqGExI0xeLMiyYtSo7kOfeugvtf
 oRn4d0qOrPXPaQnwfcKbv+jNI/I1MSKi07oW1PWnZ3idv+Hm2wUNXSvkAgJonY54AAAA=
X-Change-ID: 20250502-ti-omap-12655fa9db3e
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
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
index 0000000000000000000000000000000000000000..195db77e0063b867f318ffc6b5f8811adb531515
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
+  - Rob Herring <robh@kernel.org>
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
+    maxItems: 1
+    items:
+      type: string
+      pattern: "^msdi[0-9]+$"
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

