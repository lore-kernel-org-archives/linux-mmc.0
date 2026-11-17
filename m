Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794920820;
	b=JHDRGYaUNOLn0WrB5A7SmdF0M/JWKbM9upvYRWsu7EfoFtlxMzV2zpstQmJIgV40+Ium
	 SwGHPC8nmYlQJnOEFLcQjINrqkbC8uuZebhX1Cz9F0PoGWpWX6+h/uTwLLZ60fkiaoHGE
	 CpAsFJ4dyIueWcMnw5mo+fWpDwma9/Huq0E6C2NzNauXj55G71fTt8USC74ZFFPjLlE+g
	 XpA3I/mBEJXhC9e7ZhNnbAhGKV28j+HM8TaHoi24gch4yvrfUSnWCR2YY5A02XGQeS0Pr
	 DnpJDHVUmoX8S+7lPGFa4n8VbjOdUmfGphQCb+/cu+x9FbL2Fgvu7jExeQAnJfl0qkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920820;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RdzTRbCpWIMv59MYJJ2oMPglBLxs64dSWoLNVEoHROY=;
	b=qIwJljdHiFWDrQW6d12ir2UI81NZMkQW3SKY8ThwixrLE7qR0h9Ckwpz3S98Lu0yx6OD
	 o+pGiUI3RaLtsQZCmi8snwaIV57kd9AS7ooNgGdzA52UxBrhqoy9rJSngHeRIbbIBEQUx
	 x/aZdY15on5imvmYdFuOYwC/zxLv6zPk77n1B7XjLo+89h0iHpqBpW3pLQM9bP6TnBNW1
	 EHh6GyVqLjl/W1l4jUI46/Li2eUZFuaJw4gTFRwOjk3TQSQ4y/KWYh6QsAf9/A3H6CZGL
	 lHkioeng+oggsO+rT05rCWwqNEu3SZACFWOEhQk2ml3UlMNJkWZXu73YmhbOgCr4mtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpoBQTw0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A798606A338;
	Tue, 17 Nov 2026 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpoBQTw0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794920820;
	b=lbNqImIct6/BNzlqbb4PA7yKGbcKgSiq6/C5uVPFeXFSUQ4Rrsu4ZoKEn+kJ9VZqfZoB
	 SIClO53kblXOIN0i79QHVBaOD/8FOBIPzEgSzdg5Ab4MFWXS26v7LusB6gh7J7dnJUtRA
	 4ah5Mo80eiS+GRRebxqRRySfVOyiIJR3lKJHRiM6d7lgimgk5EhRr1EToYauAAB5qLPca
	 Ez4AFdDY1NimRfkqeFLH1a1ZWAQefT9Fk2IYE7rY74+CkHWfWAjXmiJeuAECW5zu4eS5v
	 4ESKrdhugtHhNPckLuM0W4peQd81FAivOrw4pqAxjZa/tRncje4nAG0ccAwUtx4gSYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920820;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RdzTRbCpWIMv59MYJJ2oMPglBLxs64dSWoLNVEoHROY=;
	b=EYvlSZy29WMKesijKDO6jXR+tzCpYyFw6hOs+LghJP700KtCb7GkXfw9HTL0zcANtbmC
	 Z8+2NHzwKajACY8vnLy8vjI1Q2D2ZGc+rEfhv0C7MA5Yfh/E+S9Z15eT6NHvhiFtE4Jvb
	 vIc49mZ+zq1uDyvoRaQvz71cSo1ebsx1UWAg8y1jjX4zh/5u9k67DH/aTpV4sJt73Ll+G
	 qsn5HSBM9o20KvM7YBvw0njtOTqjc2r7x2xrcgPqlnE8GJrYDfkNB4mhFTz1OGND6qNEX
	 NcICo+Wk7USYxXMeeBZmnEfL+lIFGHn6a1FWKJcwSHmghcUVHjSEDrGAe8jWdDjpOrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 316381F000C6;
	Tue, 17 Nov 2026 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920820;
	bh=RdzTRbCpWIMv59MYJJ2oMPglBLxs64dSWoLNVEoHROY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZpoBQTw0taBPWXPbTzglrviXyT4Z8NfmgTYcT+zpTnmjcDnf5+qUdlQ93DWy8mwkm
	 Aq8+XIjDaC1y5G7xEII58wbEV11U0KJJd4rHMzHaHyjKODgaLPlKIqejxxBnEOz1jL
	 rRxUwcXlEPLiuuhDOjUMvsCHt2Zv9O3cBpW+5rToIZvZUZvobUavcTziKmnMthip2Q
	 OxxtAJRPjAtjDg5xSNh4rLuZaRqToJiT3K77igrSa4/G4KbceOGRPc0DJGNaUi+Wlm
	 juxrEzTooLxG5Fn7U/viNo+CWmMB0//PmA/UlgIcWxLzKOAIt2SojnER3k4S3p1SVN
	 vUioOmhI6luzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF6B34A97E;
	Tue, 17 Nov 2026 13:06:58 +0000 (UTC)
From: yy-Local-LLM via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 22:06:51 +0900
Subject: [PATCH RFC 1/6] dt-bindings: add SiRF AT550 and Yupiteru YPL514si
 descriptions
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-at550-rfc-v1-v1-1-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
In-Reply-To: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Ulf Hansson <ulfh@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794920817; l=8505;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=PPMFmty+X1fB4x1sTCUWuwl5IruxK1aahzVZzgQU0DI=;
 b=/M56w7i6wjjKb7hkQhlFL4AB7O0JGYb32FY8M87pw5hDp1BHmErXvZVs4yqdXAIaIoI0HuWL3
 x7h42a21k0HBJ0HskfUmHsNgeVwKeAgdVZzsePenB1Nq51EwaHtImmM
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: yy-Local-LLM <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: yy-Local-LLM <yogo.0917.sabu@gmail.com>

Describe the 64-source interrupt controller, counter/match timer,
resistive touch input and PIO SD host, together with the YPL514si board
compatible. The counter clock is supplied by boot firmware after its
configured divider. The initial platform inherits firmware clock and pin
setup.

Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>
---
 .../devicetree/bindings/arm/sirf,at550.yaml        | 22 ++++++++++
 .../bindings/input/touchscreen/sirf,at550-ts.yaml  | 36 +++++++++++++++
 .../interrupt-controller/sirf,at550-intc.yaml      | 46 +++++++++++++++++++
 .../devicetree/bindings/mmc/sirf,at550-sdhci.yaml  | 51 ++++++++++++++++++++++
 .../bindings/timer/sirf,at550-timer.yaml           | 47 ++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
 MAINTAINERS                                        |  9 ++++
 7 files changed, 213 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sirf,at550.yaml b/Documentation/devicetree/bindings/arm/sirf,at550.yaml
new file mode 100644
index 000000000..f538f7ccc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sirf,at550.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sirf,at550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 platforms
+
+maintainers:
+  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - const: yupiteru,ypl514si
+      - const: sirf,at550
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
new file mode 100644
index 000000000..0458db241
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/sirf,at550-ts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 resistive touchscreen
+
+maintainers:
+  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: sirf,at550-ts
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    touchscreen@80120000 {
+        compatible = "sirf,at550-ts";
+        reg = <0x80120000 0x1000>;
+        touchscreen-size-x = <4096>;
+        touchscreen-size-y = <4096>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
new file mode 100644
index 000000000..ec68afa80
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sirf,at550-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 interrupt controller
+
+maintainers:
+  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
+
+description:
+  The AT550 controller routes 64 level-sensitive interrupt sources to the
+  ARM1136 IRQ input. Each source has a fixed active level; the single interrupt
+  cell is the source number. Firmware FIQ routes are not exposed by this driver.
+
+properties:
+  compatible:
+    const: sirf,at550-intc
+  reg:
+    maxItems: 1
+  interrupt-controller: true
+  '#interrupt-cells':
+    const: 1
+  '#address-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@90020000 {
+        compatible = "sirf,at550-intc";
+        reg = <0x90020000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        #address-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
new file mode 100644
index 000000000..7129aaeec
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sirf,at550-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 SDHCI host controller
+
+maintainers:
+  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
+
+description:
+  AT550 removable SD controller. Initial support uses programmed I/O and
+  firmware-configured clocks and pin multiplexing. DMA address translation
+  and 1.8 V operation are not described by this binding.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: sirf,at550-sdhci
+  reg:
+    maxItems: 1
+  interrupts:
+    maxItems: 1
+  bus-width:
+    enum: [1, 4]
+  no-1-8-v: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - no-1-8-v
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@56000000 {
+        compatible = "sirf,at550-sdhci";
+        reg = <0x56000000 0x1000>;
+        interrupt-parent = <&intc>;
+        interrupts = <36>;
+        bus-width = <4>;
+        max-frequency = <25000000>;
+        no-1-8-v;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
new file mode 100644
index 000000000..d1465d438
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/sirf,at550-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 system timer
+
+maintainers:
+  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
+
+description:
+  A free-running counter with six match channels. The Linux driver uses the
+  low 32 counter bits and match channel zero. Firmware configures the divider
+  before boot and supplies the resulting counter clock. A running watchdog
+  must be disabled by firmware before this block is handed to Linux.
+
+properties:
+  compatible:
+    const: sirf,at550-timer
+  reg:
+    maxItems: 1
+  interrupts:
+    maxItems: 1
+  clocks:
+    items:
+      - description: Counter clock after the firmware-configured divider
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@90050000 {
+        compatible = "sirf,at550-timer";
+        reg = <0x90050000 0x1000>;
+        interrupt-parent = <&intc>;
+        interrupts = <0>;
+        clocks = <&counter_clk>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f9..a8927fea3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1985,6 +1985,8 @@ patternProperties:
     description: Shenzhen Yashi Changhua Intelligent Technology Co., Ltd.
   "^ysoft,.*":
     description: Y Soft Corporation a.s.
+  "^yupiteru,.*":
+    description: Yupiteru
   "^yuridenki,.*":
     description: Yuridenki-Shokai Co. Ltd.
   "^yuzukihd,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index d73899016..6c3702cd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25847,6 +25847,15 @@ F:	drivers/gpio/gpio-siox.c
 F:	drivers/siox/*
 F:	include/trace/events/siox.h
 
+SIRF AT550 PLATFORM
+M:	yy-Local-LLM <yogo.0917.sabu@gmail.com>
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
+F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
+F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
+F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
+
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
 L:	netdev@vger.kernel.org

-- 
2.56.0


