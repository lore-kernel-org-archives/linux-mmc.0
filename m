Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795264998;
	b=VPbbi/cogsbgvR8k0vweicalguLf0a0K7eKdIsUrN7vkAefjrz112JzmN3PBdtJ0xYWY
	 +pmAzdzQBAr66uAeN2bMzUWBpnZOLKS5IFSVm8yPKt8ynR/3QiKaKUt2h1GruSLRffLhu
	 cW/VDq3ZLH+b3kIR2O6kNbTSj+5x3LFS1pSYKPONVRE+pEMSyov9mVWnv5ek1SuYy2IM8
	 aVrQpmqaeiu8+vceEVTJSfmwGeYaiLUmfPLVcokA28V8/zl82YxuOnO6gGkm7q8KDaHr0
	 12YX9wixuqnxEepyj/iHQxVoVz8/k1EX7eZazQCLL+UkgC8lgxHSow+kB6pTaH9BQew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264998;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xUb80D30HN0DexKwD7t51Nu9644o2kzgN3wPWJ8IipE=;
	b=0i5cWAYer6End77XnZBaoIGAJ1ixnpJnWcR7P/I+JlvX5yy7OZ5PDhRiPvFArCei7I8o
	 aRoco+yRvW6Lr/zIQim7Ci6MewnI/QCR6LcUtdlop+tHMZASPl+cDTI+sd9SJmZdCytMo
	 h5sJU9bauEBquWVBxDkDMKv555UpWIdT33iE5+8LMrDCaLKSkF1PNKk8//6Ku7z7V1KzZ
	 FDKLEQ4TMTp3aBkPgrFb3TDUccx+pk2Do9VUfSVFv57XaJ0OfFFH3vd02IXsAOj1Jbr8z
	 it34U4F9hTUKLnkfP7sRGf3ExPEyMEl9U+KEnCyDtpJlKRtT50O99VV2s4wupXD/97A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f4ef/v33";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E260A2614;
	Sat, 21 Nov 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4ef/v33
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264998;
	b=uDDbXblnLhDx2GPfwE6ChRzQb1aNvOl2kF+wPdDtFU8mK3sMcni3iQ3jbryQsQ082S+x
	 GLCNR40TWr/pdZjWpRyfKouifyyqT5YeM9gaHmPM6Q0i6hJ5FSuaQMIwTC6UHDhnPtK55
	 p+A2p/Fe4vGFqMmnyqLtg6X1GTZ2AfV2a2D94kTGk2C2J0ipczbSYJ87Cv8RUx2UyYzHt
	 WLoK3Fn7aEOI8sW5GvDdG+8L7NKj5b6EXABSKOGGSCKAnfZvgFOBfkpdEFuFy1XWzyYqj
	 gzqd8/qumUMfrzf1I/f29Ju9htPp66CaUzdq0K7TDEbwtoe8QutrjDWffopBTgdvxGQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264998;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xUb80D30HN0DexKwD7t51Nu9644o2kzgN3wPWJ8IipE=;
	b=e08hB6PciCf4Mf7GgwNnsUXJR2ujhnGEqIGxIYazfzNLFNpRfqIAhXWV52hvUnxmapm0
	 h4N0M/adnTUtYBR5QBIWYh1WG2E9P4I9j4CFqs/Cu3AO9vxwh9TgqUdKIHfZmEtHPKNDu
	 3GY7ZW29/lVys9ykcIRMm5EwFiAwEN8KmpcU/bTH8tK5TuRoe24JcZWMg4DoJfg0Y/K6g
	 JrbJqHisNadxRobv9jnv25ZT+t4V5U4/ebf1pBG6LD8rm1XQgeq34BmdvFaK9E8C1qXzw
	 XbS0oz/dOt/yty50rZsTn9O10rqRVkhyBTHOvOPkfFDqGYAc6Ulavv2MNkOq6pF0GGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5B8C81F000E6;
	Sat, 21 Nov 2026 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264998;
	bh=xUb80D30HN0DexKwD7t51Nu9644o2kzgN3wPWJ8IipE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=f4ef/v332CSW1tGruCYNrhi1XpCPnOUKmrLXU5SvjUiC1Y8ZLpSbVLeondYmbbeIM
	 n6PbWZS+JH6enELa5YTuNQXAuxLNy5A9Byp693OSHnljZT4+XT1oryiEVctzKVPBkI
	 euWRAYSMJjHHbv4MI2HRunA46xgJ/pQuY3rHK3t4iKLmi7shvEOv4wrRkzeHg+CJfF
	 yNf94VLoa1kvaos9Aj1fPYi14h+eZYz1OQKEv78+6nz/FoayGGRvkvAjYPVt9NBcSY
	 mHDi8JDC+66ocQQ88HxqMR1jUJ842mxsQNRZXaRUyp5lWe8fCk24XXWOHaA6Q62/DO
	 KXi7MA6d1LAMg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CE02F4BC56;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:19 +0900
Subject: [PATCH RFC v2 09/13] dt-bindings: mmc: add SiRF AT550 SDHCI host
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
Message-Id: <20261121-at550-rfc-v1-v2-9-b0309d0789b2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=2242;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=Cw4PW1ium2XRqrgyq5Y/w+tMdamgHyjj6FEWVO1PTf0=;
 b=a5zpJI5EjZIlhB/FD+UmNuiUUXzSTRIjkg4sO7w1rcWzckKK7gDVBjOIO3C0eFjJNY8WwdmVc
 UhNpbbAXLIQAkJNLHm9G7C7Wsjlcl3mCu9pYSehXwFqMXqfogeooB8J
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
index 000000000..ca0c7c414
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
+  interrupts:
+    maxItems: 1
+  clocks:
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
2.56.0


