Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774426;
	b=3DNf1RnZbJYXAXCuxLVxNcproY+/UAAQCiy6ux8gK8syXFgvVDPhxYpmvAvzVwVLiJZy
	 sVMYc+JFtmGjswX0C7Vq2fCCghBmeIeG+RPoVQv3PqNtTu9U62kP7G3aDf/89P7tY5lwP
	 TGhFNAKC0SmuVY4mblNYwyqc72sIEY06aVpY+ye15WENcE1oYpABRYJWejAnked9YJznj
	 ThSTuVC4EVDimXpag5uVWiRqIW7r93xnXIgdyAaaS2cJfHco4qSrssgFt22Q5M5+Y6vY/
	 3g1WErRMEY5sSUqrLVnWGpnypNK29u2XdxcYCenDoY8Er4jj2P61wQ56aH6nvTZGPFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774426;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L3uorpJsDuQi8hiKfbI2IIOCDoZSKWRJ97N9hJn2fYU=;
	b=mijiOsjfvcf201vgW02QSDYYLx8BMXXEdUXzmPZGZIXR7oYNERLI8dcnzBAg1afRsDv2
	 nI3NB7URWBzAf0RvQdeNsVmdwiKuggv10LWnyM9GHPRMz2m+N0eGyN0wSdD6317Odwv5S
	 g8fT7PLPkaBG4SYoNw/Yj8v6VjZ0uRQ4QsMzzPRTeDy1hoxDvaCefByzN60gbvoSF1/9p
	 kiikHknkBQIlqI/XQA6SQQlcX59FvB3p0SqIKwe/OzqPRvgFHUHgg+ZSM/mkmlIyQKfTS
	 VIGAfNsmZb1eO+gig5HUwSBydiD2LOejyXFnJ4gMHBCtrIkwSqtAOHVW5MKOUks3eOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLpmXzck;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254960A383C;
	Fri, 27 Nov 2026 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLpmXzck
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774425;
	b=H4dG7uF0jCrmuxY2elm3DTsFvHOo37hi2XfBPyCxMFdxT7e9XtrSJI0xTHUE84J5lX1U
	 7NYaxPb9I8+jpAOL2XWhQF9qEI5O9P/6/Z9bbBGanQDgjiXcqvPRqvNjoffoC2BvYlQO9
	 9NfrNXbnoLfn8berXPElC6Af2BwOxd/7Iw+iSWCQ69InrigxEo3tOT9HlR0sG6EZ7nE8T
	 iUNnf+JQfbrx2ixaTqDlTSlw5I9CZGA+isuNj3iZ9bTLBMwiGEiNEqZg1I+cHSDzoJmaV
	 p5evMIgeVWCDhwj2VEyCZVb1klfiM30jCFCD5e6LFfE+Pgi75HRbAONRQYk8wAhycEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774425;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L3uorpJsDuQi8hiKfbI2IIOCDoZSKWRJ97N9hJn2fYU=;
	b=zItJXyhjaRfIBs9ejqrv2co3vh/SQMHMa1zg/9/xyXlaZb6QA86uaRdGQoWDCgLZtkbA
	 /67oqr5Chy5WNThokKoKymAZm/+vsdVj4SvVoZ0+e/6m+ezkpFaFeQ+BGQ7CSNbbhvmPf
	 ePcN9lJI/lsCHuYtanOJ6Ia1PApnFUbwHqq7A22qSlDL3jObAK7NsaEYajwNKyVpMIGlZ
	 DH678LAVAfPMDUzHLD0GTzvr7sXmm/DaZ5Uy+xLMhPUrrhsgxqgNRpWyxqKKSbAkH9OAM
	 dBjoVilYIkv1tNpFkILNcpI4g1GYZzbcUoH3KikizmZe/ObdQgWW/traQFw5AdjB4Vg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 816361F00919;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774425;
	bh=L3uorpJsDuQi8hiKfbI2IIOCDoZSKWRJ97N9hJn2fYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bLpmXzck+8l9P8LUK+2aIeR9vwlqmJ073m5oaNcMe2Rg85sG3hoWR2yh2zDQZi+nJ
	 0rVnB8Z0YIejiP4j22fvWSq3VfiJ9W+V/lCIR1jFkqA4u1uKu9p/YO4mkXQwJXnbge
	 NRnbjpjMOz++RfPhwTJgjCn7fxtxr38fIfX2Fqk5mGq0uc2eGQyCmeCMiCGkI+dBiU
	 +z0Wz2HCA58pTiXmfrHJUr9Wc3kCceHqiN+K4cIrrAjMEaW0/kj8CGd9JI6X3oTLlX
	 jLLec0S7EOxzBRZo6qd+o27Wi35Gyn9zAvxDK4iwri4Bb+LGI8RSxpMxXX5PgyV81n
	 jXyycQ1naHoMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1035D4B6F7;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:04 +0900
Subject: [PATCH RFC v3 03/13] dt-bindings: interrupt-controller: add SiRF
 AT550 interrupt controller
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
Message-Id: <20261127-at550-rfc-v1-v3-3-f2221008912b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=2262;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=F60mi4ewot5gPQAYKYIRAeZ4rErv6ktzSFwpDWHu6xY=;
 b=TyCXSzk5Q2h/ZYk3LbPQWnuhQdFVxFL6RWlbhpnvJAc2Qrj+IAKUj744D0gvSW28eOsu2ccZL
 xNsjoxpdA13BiV6tNin18IELHG/RL245E0NaStgGdI20VD0jXpZV1Pk
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Document the Devicetree binding for the 64-source level-sensitive
interrupt controller in the SiRF AT550 SoC.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 .../interrupt-controller/sirf,at550-intc.yaml      | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
new file mode 100644
index 000000000..7effe6c9b
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
+  - Yuugo Yoneda <yogo.0917.sabu@gmail.com>
+
+description:
+  The AT550 interrupt controller routes 64 level-sensitive interrupt sources to
+  the ARM1136 IRQ and FIQ inputs. Each source has a fixed active level; the
+  single interrupt cell is the source number.
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
diff --git a/MAINTAINERS b/MAINTAINERS
index a825b3bae..e052d9dde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25851,6 +25851,7 @@ SIRF AT550 PLATFORM
 M:	Yuugo Yoneda <yogo.0917.sabu@gmail.com>
 S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>

-- 
2.56.1


