Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774429;
	b=yqqEP4qlegK2OGaFB89GbvLbyneUs+zVK1edXvbo62waqCfkSG5GEw1R354DZYstN+8c
	 SsfEgE/AZ41C4/c2NLtoGhH6NznK1YK3wDczSDh90Nq62pmv3oEG1E7yndH7TaM5+rPWA
	 9IxnmuB1bkkjhOi7q5y6/VpVW1hcnWxdlMqw6rxdRNPoLYJEMOMpS1seIAcE8AbTTTRIM
	 OUJsnreZvrb+v0DASMH0F09VPZcwBMbhbtLOJ1bijX4kjW3sIESrrfCLnhzZ39oUgWu0g
	 LLFDPHR/fQsQNpGbIrCCdXjjEUyzxKBuD5sarRcS/ct52lRMnLu1GfoaBKmk+3ohMIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774429;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z0uhwR2m+oo/SITZDIeOH3DIVuHEJahCSHvDrJG1SOs=;
	b=lcyrgv9sScZ1uGaT6lEwiBsYWEq6wTCJe4VP5Z+0RlUTgp+sSou71IOGXwoMK6yuqGwC
	 +6MycqLzh7YbJOqR2mznIYUygrjyzLzXwrA72t4mW1X7FL2WGmX2JIz23lasq7qcKqWYv
	 kSUrZtBy+3O7qWKRCaHEjQAATLxeJHQCsaOGNgu0MA1FCTpTH/hmRhe3M6JpfFcqzctAG
	 Cm2LI19NS0jSY3xKcEpA3SxHoptXcKyCak7kpBadD42dluQrixoZWLiURxUrvSOQ+EqZq
	 UcnbS8yLOjb866N2g9hOSF6c9VPGjd9UHk6PDlHMk7c0jd1Ed2pJ9pcnAmnLtmVCjkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJM2rJdi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25B606A6AF;
	Fri, 27 Nov 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJM2rJdi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774429;
	b=DV+SPu+5offrqEEEEPUB/om42uu8jxHiQKmj8bZysLceATl4p8WbRW3qy9DKIle8gRqn
	 Y/WZg4mj75v395nVwfDLVUtPR6F/H0RNz9lQF/yCbY94eAlR+HjTZELzBTG+jFDJVDRAs
	 mUw/YJBH+d+NH3yCwJCRwWk5mx6r4IruTk6XpT1C9eEqH02TrskZS4I8esD76ZTHh7ijL
	 ax4Au7QuJ5ClZYPDDX5wRORmSu2rtP6R1bUVA7asQSq6dEmPTeWHp3NcLTCaw8D5joC0+
	 PvhwVeLF0+IojUy8RPZsjN8/Oouge72fv3Lp28Xmd4VvQ8TMTAD1E0O5H9gCqs9fbsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774429;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z0uhwR2m+oo/SITZDIeOH3DIVuHEJahCSHvDrJG1SOs=;
	b=ZYNX+EUehHXcmACCZ4zZmVO/K3z9Egy67STDyZ8DThXI+/GPIjc3qlR5E14k4GF5P1yL
	 XvQNRfhPxETJktEstnu+fR6jkNe3Vpc5UENJZg44rDNXqvw6Apo1aPf408uOLaZVX8EcR
	 2jOvsJHqpbJdej+SiVflLP2YNxZUfhPpH14WGr9KpOoFpmQDux3pFdUecmSit8IDDzwmD
	 IiAacFhTlFDW9ByiDeG3AdZjX6NCCaLQj5JSBnM3F8FMnZNtEjFbGCTpUg2Alygqw8sql
	 HmhjLENkb8ZyiLdcssHb7pnBAicKZpH6Zpx4yNQCs21MPzovzbeZ25uEj6bJcOiE8TQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D5AB71F00A1A;
	Fri, 27 Nov 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774429;
	bh=Z0uhwR2m+oo/SITZDIeOH3DIVuHEJahCSHvDrJG1SOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XJM2rJdivwhngx96EnEPqhDqv9l2ZZ1sBxjlN98Rj7Bac+Z7b27Q79WVbyX51C6EF
	 Q/N7zcGd6v9KCHs3GkbBPo6xd/WDb+ul7hX7vWNtmzK0tBwKzVbpY91laZpM+ocuuX
	 YrXBx6ArPxR8ehpOTp+CHn12C/tML9Ho3O1gsmC/2rMpID2P6loOjJs7h8doCOU9Iu
	 IlLaqS30V2ws+f35ZTyJs80RlMM1feEqGvwjtH3NciuGEJDLIfDjyPM1t6IxH0rfA9
	 PJEZp5yrzATUxOKRmmXAhqOIyLX0Vaj85J8wnm6QHVL5wGhPYw+qIP/K5NIMtZs+1t
	 L04LbQEF1WaOQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB5ED4B70F;
	Fri, 27 Nov 2026 10:13:22 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:10 +0900
Subject: [PATCH RFC v3 09/13] dt-bindings: mmc: add SiRF AT550 SDHCI host
 controller
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
Message-Id: <20261127-at550-rfc-v1-v3-9-f2221008912b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=2242;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=IBa3lvQ65UbuemutSpp8sbPVjLxz0guLNzzgxjivMC8=;
 b=PnTIzR3KI1vTxOcikhG8kWecmATMGpKhxlMIg+96xaHeQwxOf8wPT7esiIGPWbYIN3bZiXlop
 zzoKvjMMIzJDSBUEhdGYRLOaB9jUGsG8Wwpr+0WkQZTqpbxqsJQwH4N
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Document the Devicetree binding for the SiRF AT550 SDHCI host
controller.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 .../devicetree/bindings/mmc/sirf,at550-sdhci.yaml  | 50 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
new file mode 100644
index 000000000..879285023
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sirf,at550-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRF AT550 SDHCI host controller
+
+maintainers:
+  - Yuugo Yoneda <yogo.0917.sabu@gmail.com>
+
+description:
+  SiRF AT550 SD/MMC host controller compliant with the SDHCI specification.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: sirf,at550-sdhci
+  reg:
+    maxItems: 1
+  clocks:
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
diff --git a/MAINTAINERS b/MAINTAINERS
index df3d38c6b..1164152dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25853,6 +25853,7 @@ S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
 F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
+F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
 F:	drivers/clocksource/timer-at550.c
 F:	drivers/input/touchscreen/at550-ts.c

-- 
2.56.1


