Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795264995;
	b=4xAhEuOfuV0OjzHGy5zz4sVfJJKnXeWcFJ5OWOR8EGogYOSz8YWYYNhtwXXJ+wyqE1Hj
	 UOpqwQrOZR1bKBBbsSdVDtwc5SBQHzVyE58sFr4EXf6UyviX2ikDJnDQJZGs0JLsNQqmL
	 whq10lmgcO4rFxC/7eeE77Wq/o4oMkT+UQbZNbZs7jRN1kqnqKai/ImDMNkw6Re2hbzki
	 T3e0wJ0te2A73HIuX9mjAufowxrUl9IH0pjqliGhiBDyiXlL6dXbrhls8p9np2vyB+pAZ
	 Kzg0PwmUuO6GePJ5v11mfb09fmafZHTerKQhwegQwLe1c4K9dAdKpufVKOt2aDlgCvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264995;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pOYSnVFZKQIm6jlB3U99AsAPBj+MjXXoDxaUN21SqZc=;
	b=OHH3Cck30ymqzNDA97DKu5/VvGBi6zuF3GAHrVrogbsVs21oRkMsAlp1cztGRGMNL7Md
	 i7m5gvIQ5NwXuQtEXSICK8J0rU6flxxjaicIRL7iarb0+a0wy+UzOc4P0lCKZWAsHriPy
	 NW93arfPzxX67AkYnVSJI9JF3cNfCld0GNcemRV3At2V2qejHwEBsvcVUIwTqvG/9TCyb
	 MwXIio+9RNwCSy3TpokA29YlyRYYWRO6YQ2PN839K6ngsbNpW2rrm2USqW/GUSXHN49Jq
	 k9Q2V4OUrimNB2v8JemzCYQI2jcmo6Qtpbee96KEVw5lBsEwO+7x5wq9qcyBbMXOIZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7em+UPR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D52606A32A;
	Sat, 21 Nov 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7em+UPR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264994;
	b=3rSiK/cRgayebHlwTM0ZGM3gIfeBIje2xZ6QqSVtSK8dWJCiS/0BCaIiK5dzTYdoKvSL
	 2c8jY0iVkB7MLyQD+7kJZ7kSGjk48eDejXVls6lcgbZWIDl4eUc+uZHWPv8yMisTqhbcm
	 E6AgEgAR4Z4ZB3Xr6Glf67KV+DW4K4VrekfLn+sQkK/qMxyOCGshgd3wgoDtdiBTfoGsA
	 9HoYODW0+iMtwjnCP8WHk8brNr/pNbq5Bl1u4yxrZGvX1wAiOhzxVcjjc5i4OCwyv7nEJ
	 oo8iSxUPH1eDR0lTAta0bRnCQyxooqlFJXmxQqMf8Hkp15R/ouYzUUrXLrbcXZPDNBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264994;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pOYSnVFZKQIm6jlB3U99AsAPBj+MjXXoDxaUN21SqZc=;
	b=ejjIuOd2vQFCUNnMlgCL1WrSA8srd40VaJx/xtSNoVJrTdg6HGCznUhAzINJcvK4B2PT
	 IdKZ/mFSuPTLvk/cAz3tLnIYbn8b54/ZO7aRTQuOc+wPo/CejwrW9pgewoBDqkT5y2jot
	 r952zuSMyjMIO7p5qINFrg1A66l5kSM124KXcvkXDnDiiDO7kUvQnvA7sf6K8e+GERj7o
	 HvNWXF5BQygmyPH8fzK177sACCO57kNd4Ts16ppEVhxIAbLzrNggcQA7TFDlXUkHraInL
	 OcXY7ay300T7UhPSbmDFkhMr9rvb3q2lj6lmOgFhVpTrMSUFI5Vc3pgmESBX/vVa7vw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8960D1F000C6;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264994;
	bh=pOYSnVFZKQIm6jlB3U99AsAPBj+MjXXoDxaUN21SqZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Z7em+UPRIxz4uxGXf31XEfb4l0ygDJTnMIiJ+pXKqcBOJFnxtK8xLzbPxuqLnUXjY
	 BfJRDE3P+4BexVQAmXNLUXZFPH4dnI3EQbgonwJwQpsnF+MUbPbcv/1z1dIiKXN4mf
	 IOWIT0PFH2NB0l+XqJBX6oP37mIvxwPt9Y5z7oF1/5uwn152l9ZVZh6pmZP5cOQCHj
	 SbLgVDYVLUwfvokWYUezCCH0fT9eSXb8rXFnZ7uUrUPSYFuNF2KkTLODzLwsFOpu8x
	 OudckUMGN736SruaycyLvgsdFMsPLgvTX4DJjX5G1wcDafIxRYIGgxbfllIXMoGk9o
	 GdKtYLCkI76Zg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1A7104BC3A;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:12 +0900
Subject: [PATCH RFC v2 02/13] dt-bindings: arm: add SiRF AT550 and Yupiteru
 YPL514si
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
Message-Id: <20261121-at550-rfc-v1-v2-2-b0309d0789b2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=1613;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=PQrX/FspDA33PekWwNtkQNVgZAR2YGwuuowr8uCQ39A=;
 b=hnIFHkpO/fOjyh207yCGUwqWuFV7rTti8wsPk3qoG+YRunLsOlNp/PFVSab7tls06HaRhzjRt
 Ty67dTXHUS3CP/JdaxriOUFj5TyhAF6X889ETQ40JFnH3O2TKbZ6Rz6
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add the Devicetree binding schema for the SiRF AT550 SoC and the
Yupiteru YPL514si board, and create the SIRF AT550 PLATFORM MAINTAINERS
entry.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 .../devicetree/bindings/arm/sirf,at550.yaml        | 22 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sirf,at550.yaml b/Documentation/devicetree/bindings/arm/sirf,at550.yaml
new file mode 100644
index 000000000..0234324e2
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
+  - Yuugo Yoneda <yogo.0917.sabu@gmail.com>
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d73899016..a825b3bae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25847,6 +25847,11 @@ F:	drivers/gpio/gpio-siox.c
 F:	drivers/siox/*
 F:	include/trace/events/siox.h
 
+SIRF AT550 PLATFORM
+M:	Yuugo Yoneda <yogo.0917.sabu@gmail.com>
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
+
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
 L:	netdev@vger.kernel.org

-- 
2.56.0


