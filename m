Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774429;
	b=EXllbAQKdRrCHJZAN0TBK+Bi13rbmuvSkQpBw92/v1nE7Uny47QF6vNCbfIcanfjpxAF
	 8Aag7xwDCB4JNtu/zOo+JsEOQFY6uw1fnFa35R6glSGkkEOsQdHzVc1UI7Xstt3DtOT1k
	 ZvJcGHKny3BBHlE0mqeXqkKJGiEj8g8tkB/rJXFuVB0MWJciPtOxOIxE+HQlM4GTaZao5
	 uxavtDBogOV7Orq/MIV871H4QkRKknOU/PySYoIVFR/pm2k44LPZ4PvBFsJjOl/+xjpW+
	 vImHSHPQYx2wFBxHMNucLatUfA2t3SeHUa4wPtS4gIkw7ZLG3Z2c3uE1WjFPE5mgByQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774429;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YULJ69UgB1AzAeC8n0qnr6OGMirEd2PzUnNarHgu9cQ=;
	b=Vj2lRel26d6W6tecVYDWcixhey4gDjuK2OxoeCU7PsMK1+5lpMKu/EvUQ1DT6vy3ZiEK
	 DFVfxR2PohldEAmRu3BGgsvhnnSceHDpYa0fXwXFc8LXrKimgt8WR/6Cvq07bUbPlfk5h
	 7O3Tjm05+NRhgkA26fgkrEkmbaQj+XvAdBnx+P+ONW34/xan2D0fWZasJYY5s6XnE3njW
	 fLaKs1Ls8U18ag4BpmhG1FVPutSaZ/QJ25r8rzs1LzzOAfRAbdo9EIIKsaS8yFSWAZ0bi
	 NM+Vqno30LZhRrjauZRIMfedzHdoNWQM/VUjzKJchA5UjHjDaDwBNuWJaL/ADL8Yuiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua0vyRCe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AC60A5BD3;
	Fri, 27 Nov 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua0vyRCe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774429;
	b=UqOf+Z1libajZn1L2lgIhZJZ7Z0NWCMIK7/rfoD6RHErLTTLhaFjAQX6f6wPS1Q3PgVN
	 E/Pt2GRGiM9pyX37eRYxnw3uTAxTb0IjjRnPVoLvLUORP1ABsl0F0T3muTwzQsePZw5Nc
	 g9845EOnAHXi5RiWzEQYv06+4g+jQkLfudFcAQpqdYaoVGkSfmbQ7wEyAbfRYBB3sUjZ3
	 o1fjERiUg8i3cZjztK68MDmm4NY+X9+v1eiWfa8Er15fJ4F+CecfWwadTgUsvMlFGolJK
	 z1YZwh55UOCFnEjWLnbf5o3Rv6PYjBpjIERuvwjJvK3VDIu/HeQJJBSJOTZPoGpwX4g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774429;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YULJ69UgB1AzAeC8n0qnr6OGMirEd2PzUnNarHgu9cQ=;
	b=An9M3vQ8ipFWLevbILCsSFhOLalbCeaLXS0PHrde+/kwG25glGGxKLs1rUzHup4yLlLd
	 OyUZvTuj4l/6iqjCRHyq77Rs8lTspZA+lXxg0Usafn6HuruyIwIfrc29ZTMmEWeaHMQGh
	 MdEcS/k/GahqaxLUMXV43sitRQsNhUCVKpmdMZ+BhY63nQ55g7DLb8tAR0/1FWIjmGzj+
	 Xt/fXj75YUXvDpQ1t8EhGmJEZ51lZ7etLsAbrrAdmtF6fJLo7jFwykSVlvLTYsDG9h9WF
	 TB2wTUeDnWh4qflE8wlJEgat9z7xazS/aThKfPxKXoGboG9TAbJdan+SEzU7gTGB2cg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 88CC81F00932;
	Fri, 27 Nov 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774429;
	bh=YULJ69UgB1AzAeC8n0qnr6OGMirEd2PzUnNarHgu9cQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ua0vyRCeECKpmNCDtRK7aGc0rqn6RT437hrkq5lE6MeHJxLS3f+8R0UAPV7GdLQuo
	 P9NWhGcspymGmNoxMFOJXtr3Fmg5NE/wkynki65hvh4vD53way5Q/q9bwQu0qqNmLw
	 PSMDAoh3aFQAqIgmTF41viFf+VRxyN3LAORtONlcZI9G9ScHlk5rqXP3tHWsBh+5l+
	 hS2WTtOoHDnJQWtQLmmuV/TYq9+8iHv35N3QMMee/zXc/UOhNQ7FE6v6coWHi+YSuf
	 fyp3IWMkq23ucOeYsEusfkQ5GsGaEzhWrgYGWik8UfTumyQGIGcOvWdoGlQ3I0OStK
	 M/cim+/D6OGSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 99DF54B707;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:08 +0900
Subject: [PATCH RFC v3 07/13] dt-bindings: input: touchscreen: add SiRF
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
Message-Id: <20261127-at550-rfc-v1-v3-7-f2221008912b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=2016;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=4WegJ7GDBstjIhoBrc38EpMdTe1TOQiXiQmdRaYl0pM=;
 b=Bn4YPNDO1uPfagG5kMFTmqie8C77tfv0VRs+DT/W32oYLnCzfHCM+LBKkSPtYnIYwKXdmwKr1
 qeSa2GfvV7oDNCIUD8gxvzF3cX2xkpcFwb3hBV2gLqEd2i0kVC+GBfi
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
index 000000000..6edb03afd
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
+  clocks:
+    maxItems: 1
+  interrupts:
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
2.56.1


