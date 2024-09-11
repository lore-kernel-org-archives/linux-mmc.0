Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF71AB6DD
	for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068053; cv=none; b=fVpXNwcUPZPok9yUsPxpj1YMxVdzQxZFIfFo7gIbwb7/YNFOxUutS0O7tDQbSSOT4vxV0ili23kdOH7IQ/ICZjBgXJbhzC3G5+ZZEIE4xqduouNFVp5t2DClrllN1oY8g2rc4HZp89J7hz2cOpG4kRJVpSsfoNp+9rSoe4mUihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068053; c=relaxed/simple;
	bh=vIrwLFn0Lj1NqOwB9QQ9/zFKyKXRywCPsQ36/qGl6Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W92id7+8sfFsR/0gy34uR55+gCG75JokwxWkmjbfOelYQzVXUVBHurlp+uLzSylMyecjEvDXL3yeql97kdBsX5HCIKRGd0LOv3BrsWOnFft7tQIG41d9cg7SCvmwgPYy2+CT6dXjXtTJhIPIOJy6Hp5n/LTF+Q2PypGpeQjknk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUb+Vgi+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUb+Vgi+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so6890195e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2024 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726068050; x=1726672850; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpwVKYxub2BR6rBdSQr/mUsVWo46XLcAlWmWzYZ00ME=;
        b=iUb+Vgi+HVRQuYtSEfA4PmWCWa6yLPfYV9YYhYF3e//5lvonJoT1t/N8HC+Gpluy2V
         eXeZdn57W/Q+YZzJZHdiATiKy9JrE4uKEXmV248l4MCnb+v/H3NoHVWo+bG9ukS4QTJc
         XX+qH0HnAntntGM9SPNi7nY1gVVC33Vd1UCY8w/CK+XzoXLT4LjvCG9bPpnpeZe2GE5C
         xkpaKSIpn1yGmK3I8jn7YgYO/OV4krmAnt7mtHc9eAZ6Yl94wRtwXa4KYOMpptkTyen3
         h1ts4BKu8Ke99yQ9VnCbcN/PjkcgmTYeOjxVTc0TTG2Na60DoMHxWOeSF1qzQC6Hr6C1
         JEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726068050; x=1726672850;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpwVKYxub2BR6rBdSQr/mUsVWo46XLcAlWmWzYZ00ME=;
        b=hOp4i3SEHih+wUJwQreV4EBA42aVsnDOnlS6mG1diAbAWmEWjD4Tmo9ldKiLLNhZBP
         XF63eRK6JQ7BKdxuJtvevgWnTyObCh0UNWgB8DI/nXaOo7D9fTatFgmd1C3RgwqusX1g
         BY21ydrg91dXN4LX8x+8b1Xj56lwLFiEYjuimzZr3HQrRaSgj08NY2HTF9LoJhgiRFI0
         bimsPhtsRKShrvKdbAZBVTd0UgGBQdilBQ94NYH0b6rwMrFN2yqv24DusWxQsPejcBqS
         7rOFAI7MS7QpRSyTqo7yD/hG+GmXTK9zqo1I4lgLQ6X8mOW7r6XbVAtW4wCgXw7xMnnY
         iJZQ==
X-Gm-Message-State: AOJu0YyB+eElK1NO4u8AS1f3rVT8zXfx94EQcqghgMYnS55GtwA/ra0E
	icw7UEm1+e74StPtp5r4f5tsOAFjIzleAIFUQjchtFpJT7isrONtgYvOmNAiF7Q=
X-Google-Smtp-Source: AGHT+IGGHpq+zYMTZocGCaMvv+5XJ+vHhPUzGJxZgnG3MkplItlhUXqG56ppM3UlODyWrOknNfFn6A==
X-Received: by 2002:a05:600c:1ca7:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42cbddb8169mr41928635e9.4.1726068049344;
        Wed, 11 Sep 2024 08:20:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb45c81sm146751395e9.28.2024.09.11.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:20:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 17:20:47 +0200
Subject: [PATCH] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to
 dtschema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE614WYC/x2NywrCMBAAf6Xk7EISa338SvGQxzYumAfZWAql/
 270NAwMzC4YKyGLx7CLiisx5dRFnQbhXiYFBPLdhZZ6lHeloOVCDkx85/BjjWcNn8KtoolgKXl
 KgWGhDRlcTivWBhE5J4gbsKcM02Ku8jJOaO1N9E+p+M/7Zn4exxc2NRjlkwAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5413;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vIrwLFn0Lj1NqOwB9QQ9/zFKyKXRywCPsQ36/qGl6Zo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4bVQ6s636OA1QDaFeqg/34xI/mWJKr6MuE3M7Zhi
 v87vz1qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuG1UAAKCRB33NvayMhJ0UAlD/
 wLOjPu8CVqo/B/qHbOv2nTEdvk/O9OJpRlcXMqjxlX2GXOHUCSUwNl63rFacIetDsizjCcQBzQut/B
 u7KheQKIuLlwDf1NP3x43crtnKg4OK/yfLZZWkcIBzWKU5NCszYo0BVPGLidw2fvac1TkcqdWiEZrg
 LN9urOmmo3l6cfrpoIjDLcdMocfWoDeita3l+YvCeGsLRnye7kYTxvoWpx58V+PukMLWlKtnRSrqVn
 z1TShFUGbFE9UGfJK+Qle3B9zVrcdAdQaCyIg3qzERfn9lDfo5XAnfil1H0rUmTUtseOx0e9E5Vt2Q
 FmBFOWlA/EvTuzvYwYk8X9i6mvjrX7DO6D3bdM+cQfsJ7kU3Y+fupdmLegcqw1bKwXZWNbLYqWix4I
 NdYogZY+vZFRVb/kruoCRVYRbXFGlFXolQBVoWcYPH229+GOZjZ4mXsrlVJeLhJVwmT5kMGbkv63Cw
 uFWL9IwGMkoE3OzVGxjgdI/Rls3YR7SluHXdsI/I7aCY6Km1mfwvpF0EpKXeQ8etXWAuQXX1V0FA9p
 Anq7FfQb7ZPEJ4SUKkuftTfMBGN5020hwyvI7xeKloLS5V6wxtfG85ClzKcLC5ubFoISLxCd22wWPo
 dbRzJpSNqVcsgwS/BwdOwYC2w6hIJ8n+inJOaYe3pxVosaadIdeocSrJXiEw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 -----------
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 101 +++++++++++++++++++++
 2 files changed, 101 insertions(+), 54 deletions(-)

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
index 000000000000..4d1142d2ff02
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
+
+description:
+  The highspeed MMC host controller on Amlogic SoCs provides an interface
+  for MMC, SD, SDIO and SDHC types of memory cards.
+  Supported maximum speeds are the ones of the eMMC standard 4.41 as well
+  as the speed of SD standard 2.0.
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
+
+patternProperties:
+  "slot@[a-f0-9]+$":
+    $ref: mmc-controller.yaml#
+    description:
+      A node for each slot provided by the MMC controller
+    properties:
+      compatible:
+        const: mmc-slot
+
+      reg:
+        description:
+          the slot (or "port") ID
+        maxItems: 1
+
+      bus-width:
+        enum: [1, 4]
+
+    required:
+      - compatible
+      - reg
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

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-6fa70546ebb8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

