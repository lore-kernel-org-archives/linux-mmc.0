Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774429;
	b=vybVCwMSypAtcGlmhjXv1r6eozWLwdWElVKzIFQ1P6eYy98tMUnJk/hFuv3C2jmRtfQ+
	 0ZZX3ekwDq6a6AEn4Z3sYC71/Lb++xtb9dH1505ePG3hsPCyqgnZhIRydu+MTU1vc7oqW
	 2yp7MQKIB31MMUq1trzzjxr8aEUlnZ6VvxEuiFsFkNYlb3U71xyqWO5exVDuH6XzQgz7b
	 yW79Go5F7n21by95NCSYP1YUPyMDFIIam0gz4bXkpgRWuBpGZkJTaRCYdy5knlnYBiQ2f
	 n7i61NsdBWgZN+HxynFUpqcO6LipidrIsmZJ9xDjrn9GdDSt05+60a6em7lbwiBxXfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774429;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ab+IA1pUCd9/4D6jxdIphK5teeAP67ldeGaydg5uTlo=;
	b=2ry2dwrI7gwI0bT+5DztdRMJ06+E4g2cwX/7EUEBixu3hWLNBBkbsy251RtfvtlK8IGi
	 IP8cU5CynHEY3J2JopTdtr069nJEaOev0AvPcQxX9FeLuRoDvH89mY0eW5tnDkhQcZlbu
	 bbBt+E7cXxs2hcsn+RakedBih6SZ8KuieQGuIObH3VegBYSPFjiO+4s1IVVI9bpuxpf4/
	 w6NLgwR/Hqax9zhfZ3IATiTbcVrPXMMjxNnRtUGYbBW6HANBExeK3XKCffGwiW3pyRFQL
	 Iu55An+Fr7nje0emRNskuOiGdAmRYbYSu8RWUU1HWaQpqtNsV91tbJybxbaQEY5EqVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPvW2uyy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6160A2639;
	Fri, 27 Nov 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPvW2uyy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774428;
	b=xpa/QVAagB3onw4tOTKqfSPc39xnfgPty1Q1Xx/MH/gNXdvlcRZI8SJ3WhiKLC8wlG8P
	 d4w1vgsfmrfqa+npzSUquRwCoNSVf5Hv5jldjS9ULHQLcAAEFzesE1p1zDu8uKaVmwRXW
	 8LL0f39SM/iON6KCs4I4S4+EZvJANBVSissejDt8x1MymBvL9b69dmSIqfvSjKhkbEwqL
	 DHPnTdW3LliqoTgw5hmkrJg0pmnVwx1C1hkL//7GHSyplHZ0XjDQS6SInuibqAgCb0ZId
	 er0G4vMcYMiMnDBFfQwtAfka4YZpoc83mUaKhI9y11pvQ76eLypDXUYBvbmIgJyw77Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774428;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ab+IA1pUCd9/4D6jxdIphK5teeAP67ldeGaydg5uTlo=;
	b=HU5LsahJQydteypHqaEIwlc00VU0a7KztA2BSkfhd0wh0PSAoAYfEuzRxID1sR07lz8C
	 FQpKh9z/6UvQMufaYXUhUZtoRcypjgFhiHofP/pi5omGPvbd1eKflDQy8ZU7sE3T4k/9w
	 6GocjVLcg0J+pDmHy92LjCxsWQyZIC/nHFktGjOt+uwL3Cxpdp3igKQj6JPEOuokxyQ91
	 b1QDzonLHCzv96v8EefRB9UiBZxqDcroWae9JBWak05AZdFSqRIU0Lubjogh7nmzQG4tW
	 DJ20MXc3UiEApXQfw9J9QX2iDCuFVgdMZQPPsMkcmCO84jf3h/WhfpDtBNiQ72JLz/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 172E11F00A20;
	Fri, 27 Nov 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774428;
	bh=Ab+IA1pUCd9/4D6jxdIphK5teeAP67ldeGaydg5uTlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kPvW2uyyL+SUip+h2wn2B94c5/XeaFlr0PT4J9XZBp9Px96J/8luXHAGgDhl5RI+O
	 QDSZSMlcB37Sb97OQVcWkkH1UqRfpSUnjBaaDq5ZnWTFeeNyhRCIHqRm8rpwWD057c
	 9CqsG0i+NzTmAZiRPNekP4zE8YJ0JKLvjv1e2A55Zosk38dqftOYl05gpFCiTmhCvb
	 xVbYnrclq47MOgbMuouOrr25jbJigqa/Uf8ZCDumIhfx6L4u5EE8qw53d9oktK0Nik
	 +tV3bx7lM8s3KE3kcYZMgixdJXiPwtvda0hefsMEx4fC+1YmhubxqsxpUNTYgqJSOp
	 m4vgNoJ/Ohu9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 56F834B6FF;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:06 +0900
Subject: [PATCH RFC v3 05/13] dt-bindings: timer: add SiRF AT550 system
 timer
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
Message-Id: <20261127-at550-rfc-v1-v3-5-f2221008912b@gmail.com>
References: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
In-Reply-To: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev, 
 Yuugo Yoneda <yogo.0917.sabu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=2417;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=5gGQGTX3cM+T0BMuz1s2NpjICGlgOs+GfmuaL+bCzNQ=;
 b=pRlW0u6gEj8qbdsRaY3sCiniOo9eUP3bRI12cHyfuSHotulUU6+0zHRbuN6oB6Jza2lOjtIz2
 kUg6CfHHCI8AbY3fxl67gPsRQFi4WAzW8TpoKKJHWy3BdSjFp2yE3Du
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Document the Devicetree binding for the SiRF AT550 64-bit free-running
system counter and six match channels.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 .../bindings/timer/sirf,at550-timer.yaml           | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
new file mode 100644
index 000000000..48a8895cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/sirf,at550-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 system timer
+
+maintainers:
+  - Yuugo Yoneda <yogo.0917.sabu@gmail.com>
+
+description:
+  A 64-bit free-running system counter with six 32-bit match channels and an
+  internal clock divider. Match channel 5 can also operate as a watchdog timer.
+
+properties:
+  compatible:
+    const: sirf,at550-timer
+  reg:
+    maxItems: 1
+  clocks:
+    maxItems: 1
+  interrupts:
+    minItems: 1
+    items:
+      - description: Match channel 0 interrupt
+      - description: Match channel 1 interrupt
+      - description: Match channel 2 interrupt
+      - description: Match channel 3 interrupt
+      - description: Match channel 4 interrupt
+      - description: Match channel 5 interrupt
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@90050000 {
+        compatible = "sirf,at550-timer";
+        reg = <0x90050000 0x1000>;
+        clocks = <&counter_clk>;
+        interrupt-parent = <&intc>;
+        interrupts = <0>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 354466e29..3c5a814f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25852,6 +25852,7 @@ M:	Yuugo Yoneda <yogo.0917.sabu@gmail.com>
 S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
+F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
 F:	drivers/irqchip/irq-at550.c
 
 SIS 190 ETHERNET DRIVER

-- 
2.56.1


