Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795264997;
	b=T/HQDCKOzCGKj3X2G2LB8raqqu6UeTOwnZO84IzcRgJaX35IuNM4Q/WTQyy9JTeFL1h5
	 nRpbFTKJvZhsl33d/e70bLY4BdkGxzr1sEeNTrPz1t3y9KCYfni3p2fcVLVHdZv+b9U7v
	 9C8aUD6H6S0O6K1mf86GGzAGOc1E0JpW9CojrbOwDubjrKWVOIRGaYl9w0IX0pHg8QE8R
	 sBBhExjYjLjaIbJiwNWEnv3FpmTcYAteBnUuelf/vpQ2kIPGVTTUjz3nlElwgRg8nAF/e
	 9vFVx4XIQhiS2B3xh9J5KiqlbF7/YCENZzNKBCqKh5/NAG1mpbKUrWSkTsEkn3fep1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264997;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Qn72wdNiIoftNNgBdHUX8q0PtQP2R8owWtGGqaL4gzc=;
	b=UZUcC9mgQojiFSGJ4/7miJbk+0ck72FVITogkKp8k3sBRuOAtdAThRJduxLUa9vqjL/i
	 OUJtgFCOUmtThP6/QRdugMSr0g86uMz/tf27stuZ+h7Y5NakRa4i6yIGzY3XCQIG5YLyB
	 nmexbby9CkhOzPhxZQI2lVX+OCCfub8hOXMriMGm4+kkccXdDUpR3P3yG8ynXArIuc9Bi
	 X2akkKAEqdEskzKZQVd2n/S3qJIDlumkva0r+CKT+ATzy5c8mT1ZTlu/xcmPtXTibBwCN
	 fO2uASqNK74QlzswWIdVfouNNIHXuWmqJIPNA1KqNkH3ufpTlejT2mMvVJzkCoQhPGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0HdKJ5c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051A2606A680;
	Sat, 21 Nov 2026 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0HdKJ5c
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264996;
	b=Fo4MvA/KCO8md3jXyacXacxy8aZHORUC3IgcPRrXgAOoKzhBL8bnjVUPW2datg5L5KXY
	 wMfQYoMvKX6l3mfxEIK2SjHiqIEL4ee73kQfbdJi9RcW0xPUp5J2i9lCCVhF6k7kKCXKD
	 tlcMksdLdbvqTfCAakIK0y4gxI4bzuYX12LQ9RQs2YufUlnDbdPN7158gRdNWa4OeDvRC
	 xtgSy0lSpeM7b8t26qB7KeW4V9V6/Wi9pHPXy/xQG+VAIcdxiqogxExI9jTBHbXAi2kBQ
	 m+jgYpU4JfsexMKsxbZCas0c/b1JK8LRANsQdyfw/KOvxZIn4m8VU1FnfOQZNNZVL2A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264996;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Qn72wdNiIoftNNgBdHUX8q0PtQP2R8owWtGGqaL4gzc=;
	b=GAkbjO/5DhZ9Yl++7KrtDwDd4ZD+TAtbX1aYuhOziuwy3iVDNy1dZmi0CIyu05okVJYn
	 KyDR3sNtdbqTKQZXYJ+HZlw/w27z3b6rk4wfe3jZy4xny/XT2xRT/g+SDo/uxm7zMA+hL
	 g6Tqti+7wr1R1WGYY5i1ULHnDV2xUOD76HtizOW3htSsej8AAtUfRrkGdH43AEXMR85FK
	 TFacsRfQmZrs0u/YRH9055LyAZAg4wGPomjGBxpa+wtc+lC4TSMSFuUHl4Ctz2JAyzJFq
	 Lbvrh9v5BaXjJYkLYaL0ScVW2a93bpCYnTivQmXx6nDDTTyY2CvUVPuWvdTXhPsvUYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 39B081F000C0;
	Sat, 21 Nov 2026 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264996;
	bh=Qn72wdNiIoftNNgBdHUX8q0PtQP2R8owWtGGqaL4gzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=d0HdKJ5c7fZxpJgBN7nEWDm/hITe66PXisobYR5Xw2TTF2G7RV+4ZQgdFnXYK6d3/
	 VbM90foRWEwZ0byGfNS6O7emk9U12Z++KsVpBqly80IdbwhZV6pebIRp8cZAjYqvR3
	 2V4PwTsoMlT/9kOzMKDDUxTQNXLGU7Dj82OPigRo2jfZ52PSPunOH3q06qocRQWCE6
	 moe0Wtam/sos5iOgXMB0MJpSYGu3w5eMdlRR3yvPdicdwrHurPKawcPY2g6HES2LnD
	 1biV8YqRs9xcIl6XYAMwEFQjIhuQpdMhgrjIB77PeQGj1r6TqYvDArfRqBsdJFuO5d
	 3QclXACOWvoQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9A2034BC4E;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:17 +0900
Subject: [PATCH RFC v2 07/13] dt-bindings: input: touchscreen: add SiRF
 AT550 touchscreen
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
Message-Id: <20261121-at550-rfc-v1-v2-7-b0309d0789b2@gmail.com>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
In-Reply-To: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
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
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=2016;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=X+PTuRS+4QPJL1mA2W4q6MD3ZBh5bQ+P1z9SBc/CDqE=;
 b=oBHP9oxPhn+Aoqezc3zdN/j/eqTsmLc6YnJXISwr6zDUSGmnBCbF16KDTx8WZaBRsYFVYDp/B
 tDQfyx2hhP5DqQlHTx8oXwux26UJTKEcNgY0XP+fDkPwZh5lgaqz9JH
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Document the Devicetree binding for the SiRF AT550 resistive touchscreen
controller.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 .../bindings/input/touchscreen/sirf,at550-ts.yaml  | 40 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
new file mode 100644
index 000000000..ce081e115
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/sirf,at550-ts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 resistive touchscreen
+
+maintainers:
+  - Yuugo Yoneda <yogo.0917.sabu@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: sirf,at550-ts
+  reg:
+    maxItems: 1
+  interrupts:
+    maxItems: 1
+  clocks:
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d6ea4d946..e8e239c7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25851,6 +25851,7 @@ SIRF AT550 PLATFORM
 M:	Yuugo Yoneda <yogo.0917.sabu@gmail.com>
 S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
+F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
 F:	drivers/clocksource/timer-at550.c

-- 
2.56.0


