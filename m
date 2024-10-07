Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15ED1D54DC
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309827; cv=none; b=OujKS6RmjxZftBQAL5EUmKbYrxw5Y0dkTSSGqj2UO6SESaBq8PbrkD9S9xJlRM8Q0C8RpkL1Cb/dln43g2ajlqZkz2jb0RfgObz2vwCI9Kj8sRjxf9BqQuTJ6BYmOCt12rbBhTb3h0+n2768EzGlzVxyKXPVIxQPVLyK8G34aQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309827; c=relaxed/simple;
	bh=U5jvjVp+9NqhoxfdPMoJpOF+GmAk4YFvDw1QIqVWpzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhhTFt5DCw9OzjHUy1H1xh3KJl0TQcUSoLODQ9hBFtgGzAN6Ka+xz7+nY3UJtCck2aeXXn/bMcWEaIIiLpR0V+/HSKE4Iuiw2huL1y8/bisYFrPmIw3BmxxU5jbTq/3x15jOCCTV3R6LmR4PGLioG4zzHPisbTguGcMrzJQPzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4zXhEAM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4zXhEAM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cfa129074so3087116f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728309824; x=1728914624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqABym3N3rBidA9dDKKWzjU42l0qaxCQ6CjnRAVLGoM=;
        b=T4zXhEAMSxQ7Kd6XK8ZqUWQlLdDCgcMKeNuG1zoM/+650uQmmWiX6TI1W/+Vz32NV9
         dx7AGlLtHxWmEWcExZermUc6RbTErdYRyZKLwcx8sHkMihWLBneISRhIDMR44kikBKa8
         Q+Q2RP7iRRfCHh8pkfRAdBj9cs9h6pWlgNvq35EmWpBdpSwHGutljNoG2Ku2kI/wMcZm
         K+rHLoccrLKGn2eO+uExRQAz5DyNaWmjYjFSHzJF95WtD9nWewr4KDxACeYZWRWkXQM8
         f6oBUEi94TgpUWLq0sCNa/pV58K07PJ5AHxIH9SbnYCTleU4myGct8aYxQGSlPIBUJuv
         xQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309824; x=1728914624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqABym3N3rBidA9dDKKWzjU42l0qaxCQ6CjnRAVLGoM=;
        b=E3mHUYeNdQIpbRbMbwzSNWfodVMMk3988khFBM60BMqB/XiXeISwm8eNoyJskLMUyG
         7YUmiwV+p2ID1buHfT1PmEcr4mcRkaDHdcSSvhvtvB+Kgl40cd2FDYA2wfJO92LCxa4e
         Po1Ygym+0natOKgeH+pjGjTzH2C0m1Vkcyw7EendigckRrGMU/OEf+xEZTRoKpMn5wm6
         Vm4u0Pk/iXRGH2R86umZ4E7meTU3jcqLf/aMslTONgZIBR72Hn3fkinPqurUiiS/T88/
         rz8wryAKwTfv0XcEDnuJow7NFRwT9XWE3As1DdhncU6ZbpOCBTFVICD28mwqMsRnQyWB
         PmtQ==
X-Gm-Message-State: AOJu0YzpYV7J6dQkOUp61PTi7car3veYty9J2ShrWhAeL27728C3FNv6
	4zxfKI0iw1KpEhWC1unT2/AsB2GE6/PPMgzFYuLFaGSSI8oO+BrL80/nECONtSo=
X-Google-Smtp-Source: AGHT+IHUHRpULUeBxcXkwvM8LR1jSSl1bp1pOZe6scJTPsgFDYLeY9NgkvfL5Vg1zahAH8zAEK+EWA==
X-Received: by 2002:adf:db4b:0:b0:37c:d2ac:dd80 with SMTP id ffacd0b85a97d-37d0e8de804mr6955020f8f.42.1728309823813;
        Mon, 07 Oct 2024 07:03:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1688a486sm5857022f8f.0.2024.10.07.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:03:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Oct 2024 16:03:39 +0200
Subject: [PATCH v3 3/3] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt
 to dtschema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-3-ad4eb22c2a8d@linaro.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5039;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=U5jvjVp+9NqhoxfdPMoJpOF+GmAk4YFvDw1QIqVWpzs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA+o7jyWQFwcKbX6jGGlK1eSg5/uay9urgG7y+OT8
 lBaH9uSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPqOwAKCRB33NvayMhJ0bjlD/
 46mUauTgNR2B0KXc9D1+fJyrddo/ACZ3/QgOLjNFzowcRWudYA6fL7KdelC57/sTqaQ0BfUQolEowy
 xrhlz4D70YkWdzVc8dkem1vasMWNWvjoXqVbByhaQfufAh7aHOWhD713prKa87kKmU8sU4xK5qgDzf
 TU3oQMzDsEigKCc0B7h7jBT/sDbt8twunEmzps485mTlmW8VIozhAo/CxMGTkF0/3imOkv2ThRyEe3
 5v4aNUtiuh/vZSO72YawsWLPwqoly4IUBmY2laISJgRNIRyYJYUmVp34vcGgiUrnDNlMA1kadYfJ2m
 JvM68ERipXiY7FxkklCQUNrBUEYSgcaCif0knSN09bFID7Itq3mHMFib0c3chTF4jhtBXyBjLHrUZK
 N0Y6ThZaNDd17WI4L2yuNM39VmBaQ5Th9YWXqcu1s7wdoTPGgka73eSNOw/D7ARw+sFQbTfZuI5feY
 rNo5fB042sCg0BhTMKb+ZzjyZpnk2fGP0psUEwm6bOHMVeTDjZeld+mS1lHsF0uA8VC+A0HhtsGnRm
 3dSsC5CzX1MesSjZNUzKDh77TP9p2XEyt6ChTi0pSY5NM8SNb/rlK+ks12f0bLtze8H2Ob+Rl4WNGN
 wEgJXr+A3A8856KGaB4++nG96r6Lu0sG9U+twLHda23cNWtslVEQTsHbqx2A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 54 -------------
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 94 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 54 deletions(-)

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
index 000000000000..022682a977c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
@@ -0,0 +1,94 @@
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
+  "slot@[0-2]$":
+    $ref: mmc-slot.yaml#
+    description:
+      A node for each slot provided by the MMC controller
+
+    properties:
+      reg:
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

