Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950B1386D8
	for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821494; cv=none; b=pU2nG1691uRq+1JGWTcvt0sE4w/War4ZomJ93qHOP73FLq3PoXLvj2OXfp7hhFqwUaRdJqakHTaAwbbHQz5o1lOJSpiZxsHEpqiH3kDct0r8J7DJVSGUbm99G3Bqe+6WzyqKFPWeY6cDqtuxs0W1ouhdbfO8gZasL74EA6iI4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821494; c=relaxed/simple;
	bh=7CJFNsK+RYsiPatWJUwXv7bSU3rHGoSDbNBW/V45qdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UShjqHbNOudaLUPKNifrUirZefdp+4dxlEGu9dUJIo3JlWJDp7WXhaecUEwDQW7BSQd39sfAZ4wCcWejqqFB3nRjiO1Zp+rJ19UUUJNzBJnggKI2DFjGZiMmJiRPDYTEJgW2sfuopNuu1aGSifL2dWB9gkqiGI6KmJc0TvZOuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=chhwzM0s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chhwzM0s"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so21473245e9.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726821491; x=1727426291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M26p8HJUGVrSTve7LtSl4MnedM6VlYwh3DdAdGmuv7c=;
        b=chhwzM0sMxRHQRobSnwUarGwHfhuDFKDdbUa7Su86ODuA/4rNWg3PyLCjhcpR1u1n1
         Aq+gToIAC1vKIbYtJHYrfmHELfBpo0CUMXAdOLujJ/4Z4ihZaNS6izTu4Yv3Xcnx1hZy
         XvULAcM8qgvCAbxotV4+qnc/catiOZlq2gycMUdJ3xHziVfAPOPytWcL2kE+OXrq27mB
         4F0DG09niNX9oJsmPYDnC1b/F9VcBse8gSq3KMvnsNTOqRCRCPr7rrdq1DXGx7M7HuLs
         x85cRLSx2H7Ts9D7bjmiNmdfoqjbErdlg5e5mQ0407RWGyQ3ZgeSA+cMuG3Y2cwZk8UH
         z1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726821491; x=1727426291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M26p8HJUGVrSTve7LtSl4MnedM6VlYwh3DdAdGmuv7c=;
        b=LDdK9mnnDZXKv5ww9lZOuvh10KpVgCceIlz7TDh7khqwKVirbj62eC5hvzNOI0fIml
         KZg404ToAGnhxxZECu0CVwpS3b8bRRbLeoRYObrtjmOrrOyZgr79yX40AC1rEuZHn5nR
         +YEDHvT3mBupbrYqu/MvH5jYON7M+uNq9+306BAR4QqXiOcH/8u2u22Chaw0KHCc35ji
         ayA8dJj7NvWZgbCoyJgAlvbCT2QWguFIzl3qnwuJgq1WU779wgoPR232Zx7p6t3gHDmr
         amNFRywwaaHLh8tmghtNqqVHuc9hYByg9H2b1FavEnTPxYPvrZo2KQ12Qzyie7w3NeQA
         71HA==
X-Gm-Message-State: AOJu0Yx5vwqiat2Jr0gdChj3SwGVL6Py0rSati/BKVZanKkrBD9wj6Pl
	GrOm5jlw5yo5C6NPs9qWB4jgeESIl4fDhJftp2yUu0F8qxVE6dSCKQU8jesj8G8=
X-Google-Smtp-Source: AGHT+IGu0mJn0TEAtjrxCTFxsE8k5t1vGcbdWZEZvHC/A/1yKOwaWCwpTcH4rvcoPgrQPnL4UVJgQw==
X-Received: by 2002:a05:600c:314c:b0:42c:bb58:a077 with SMTP id 5b1f17b1804b1-42e7ac30863mr19117735e9.14.1726821491058;
        Fri, 20 Sep 2024 01:38:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e2c1sm43099165e9.2.2024.09.20.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:38:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:38:05 +0200
Subject: [PATCH v2 3/3] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt
 to dtschema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-3-5aa8bdfe01af@linaro.org>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5098;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7CJFNsK+RYsiPatWJUwXv7bSU3rHGoSDbNBW/V45qdo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7TRuyUKbSWggrLcYL3U67aC98p+hgvoXseunmRTZ
 QSonzOGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu00bgAKCRB33NvayMhJ0SxZEA
 DD/tHmAUJB6hYWVHojaA5NrWqA/Nhi/mZY7G4EnGnwGWzTLVeD3recvdof38Itt1vty9fYc9qrP3na
 gsszZfV0hOSwZcvJA5SERhRfc4yljd7GjhRuSRBh2C0wzumWXqJm7xcZLxkR+4f/jXGcPaem46tfc0
 CSNZ9meAoaRHWFSzCTnQx3F2NPI1SXnyfLkRNJHZMtli0FNwoXbtd4sfW/IUG47YrfjaWvUcG1+yws
 IqE+8jNZx72J1mCfktuUNB3jC3e9mf2tMAvvGt3AFH5DogngSiZSN6oL3Lh+GNNYmmjENyvota1ryH
 kOZlHb2J+deIdbL3YbmTmMKpnzVw+FmT1wt81kB1avqCMxEFs1XtpSc+wDyEi5vTrrXSD/GXnMtaFt
 9Vc1aFOcxRfQCQl70a98MiR3j/rkFW2+4teKte7lEQ7339p0N4Gz1WkVNiVmK6elb2RqwJ7cfd/tIO
 mnzJ72REGtGtAhgOSZvUc3pJAIKerQ1U+bFABnqUtu1geaTzNw8zTXg0E+l2PGGRRip1plVIQrrdJt
 I7QIT2ikwZwuqGYOC3Gu4rVcdmugVx28ghj+5VjM8Cs6EnIfglsavmD3vZdal4C4bem+M6VTpU7+I2
 HAo+g5zS5Be191z30RM9QCH/mjcBEvG7BptWhtHO3tJnCumJY1VQuSMNZtjg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 54 ------------
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 96 ++++++++++++++++++++++
 2 files changed, 96 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
deleted file mode 100644
index 8765c605e6bc..000000000000
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
-
-The highspeed MMC host controller on Amlogic SoCs provides an interface
-for MMC, SD, SDIO and SDHC types of memory cards.
-
-Supported maximum speeds are the ones of the eMMC standard 4.41 as well
-as the speed of SD standard 2.0.
-
-The hardware provides an internal "mux" which allows up to three slots
-to be controlled. Only one slot can be accessed at a time.
-
-Required properties:
- - compatible : must be one of
-	- "amlogic,meson8-sdio"
-	- "amlogic,meson8b-sdio"
-	along with the generic "amlogic,meson-mx-sdio"
- - reg : mmc controller base registers
- - interrupts : mmc controller interrupt
- - #address-cells : must be 1
- - size-cells : must be 0
- - clocks : phandle to clock providers
- - clock-names : must contain "core" and "clkin"
-
-Required child nodes:
-A node for each slot provided by the MMC controller is required.
-NOTE: due to a driver limitation currently only one slot (= child node)
-      is supported!
-
-Required properties on each child node (= slot):
- - compatible : must be "mmc-slot" (see mmc.txt within this directory)
- - reg : the slot (or "port") ID
-
-Optional properties on each child node (= slot):
- - bus-width : must be 1 or 4 (8-bit bus is not supported)
- - for cd and all other additional generic mmc parameters
-   please refer to mmc.txt within this directory
-
-Examples:
-	mmc@c1108c20 {
-		compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
-		reg = <0xc1108c20 0x20>;
-		interrupts = <0 28 1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
-		clock-names = "core", "clkin";
-
-		slot@1 {
-			compatible = "mmc-slot";
-			reg = <1>;
-
-			bus-width = <4>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
new file mode 100644
index 000000000000..3b665396169d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
+
+description: |
+  The highspeed MMC host controller on Amlogic SoCs provides an interface
+  for MMC, SD, SDIO and SDHC types of memory cards.
+
+  Supported maximum speeds are the ones of the eMMC standard 4.41 as well
+  as the speed of SD standard 2.0.
+
+  The hardware provides an internal "mux" which allows up to three slots
+  to be controlled. Only one slot can be accessed at a time.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amlogic,meson8-sdio
+          - amlogic,meson8b-sdio
+      - const: amlogic,meson-mx-sdio
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
+      - const: core
+      - const: clkin
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "slot@[0-2]+$":
+    $ref: mmc-slot.yaml#
+    description:
+      A node for each slot provided by the MMC controller
+
+    properties:
+      reg:
+        description:
+          the slot (or "port") ID
+        enum: [0, 1, 2]
+
+      bus-width:
+        enum: [1, 4]
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@c1108c20 {
+        compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
+        reg = <0xc1108c20 0x20>;
+        interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clk_core>, <&clk_in>;
+        clock-names = "core", "clkin";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        slot@1 {
+            compatible = "mmc-slot";
+            reg = <1>;
+            bus-width = <4>;
+        };
+    };

-- 
2.34.1

