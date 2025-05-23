Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D75FB95;
	Fri, 23 May 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007261; cv=none; b=ZEkl0qrZtdWlST95T1/fI8mAmlieylt3tvkp0jbsY0zirvjoXaTA8F1L7MvFv79kOxB7peBMJSVF9i7KymCVVOGrbwuw9SXkRYT4EUdtzph/4KkaxHXbeQ4V7m0132X0eC3UlKym33LQVlX7Tcwd+31+oJU40NlEbE71mdbl0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007261; c=relaxed/simple;
	bh=LTmwRQRobGT+9LVynrkU/vsVFP50bei2FW2/JtlF2xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n8RqCEjIIrvyGs09N3GCzRqrg5bUGdithUC9xPklnSBB2c9ohfpejxGYnB/MmWRuaNjgDitGI2NM118wIN07SSheqSu31yNVcgkzlm9vutwtQaFUd4oCKLuyK1IIvQrc5KNHAkCHGH1fmbDYKasOw1L1Rm1qqLfc2Plkzoi/Ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFM0i8wl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFM0i8wl"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30e93626065so6272151a91.1;
        Fri, 23 May 2025 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748007259; x=1748612059; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiu0KVR2fYUbvLhDI6ebtfAFwgk+5+sYMaG0Ry5Sfk4=;
        b=NFM0i8wlt7gi0XJ8PW+itAVR5+XdLfKFW4uNxY5eiGA3S9ozLNAXvZpW25OMOQdZ7k
         bEVt26dycS0BA/JMTpLT5NZMykKxPLpuWNTC4eqFxzZt9SyIgzmiT+7FZJcc8btPuZqC
         wXF0t2udYZ/UJ1l3Kwn9MPMp3bHLBjDj8aBIrM5X4sxzOefauRl9TVwLy8OT6vt3wuQ7
         rAHZ7AePI4j77ngldzKseXzXe1/WEsxXSyEAFjOXciNuALBf61z5MueK2OfiGO+wV7Qg
         Nva5r8Qo9TDnQW7NoQthAt9EsylfGz10q2Iez1r71k1DvSr7mLbb9yO4FKsdlpC/Nr02
         TYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007259; x=1748612059;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiu0KVR2fYUbvLhDI6ebtfAFwgk+5+sYMaG0Ry5Sfk4=;
        b=dnnKnPlzeanDkCQ1thz02iRNUnkbINcj+Su4c3L+SY4hjoJOpJjx5DsFNrijE3UL39
         tlH3Qke13/dnyCeeUPbTBEnlUnyIC4YheeqoI1JObDEEXUstVsE4205cW5ShowqS4Tc3
         f+K0ia4HmX5Tl5t15fCvWZcPG0xVGwqCNykilq/dXsZL15UhxnCMR9XC9KwPJE4yhe3a
         +KRaN+6mv+PDYx6YZMoamdRSkW3d7cb2jqGC7oxbQc0EUtehNm791NXbRANA9mvUQm7T
         U9pTkt5PUrwI+QZFkuxA4ODGS5PBII/RlK1LHh7D9puFoqXzX9/lAhFQRCecl7AmgINC
         oxNw==
X-Forwarded-Encrypted: i=1; AJvYcCUcdGYltxPDdtdZgf2riIERSRwBPGEF9RiVVins82ajQH+LTlDoVIJgQ3ctsh7bbMpqaRs5/besARi7O2gB@vger.kernel.org, AJvYcCVLTpJYOMRAyT+Mqhc1OjpKKsWtQKsVgpnYPituvKwdSXbKzhiVJbPWognueGAV/pHnv2uTadpFr0AU@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0Gb+gEOIQLF8sKl4A6cVeRhfL+yOS2xyszfr1aEoHDjTzt1W
	xpWxYmP54uxxthERk/v8BY7SKQlL7yNev5hsNT5yqfLDc7sTkL2VNTN0
X-Gm-Gg: ASbGncs/MxlktQcdN6v/4thw5aa278IXVExDprI88LQVOoF47fyFBkdOdCgZ6VBNp02
	m5uUMUyHeyvDGT/47+ttEvT874rl+PaA4bvYLfoXgOC03pvzpLszMGeGt8LqwMT+5hqf5O2RTJG
	eji0mCdvrpHVv3gse/9N34EE2s6qJ7qGb9zZe+eya9sX9gU/l6V8n8GWxzpBeEpW2xBeKu1U05e
	2X2TXW6UUGY6MfR2Jplv3PoUBAAZMykz8BwOKvnaglALOvM4wpysZyWFFDYsdBaIoiT5gN1/tSu
	CWgpOxusmdhoHSJR60MAaeByZT/xqBKRLDU0/YzHSAJB3ppA7jHHtEZ6wx07
X-Google-Smtp-Source: AGHT+IHjuVJdklfm00XeHF7SLPfR034qveSgInfgmtI/zpDkIT4kFLFov3QvtDBYaVmztMcqpo8UqA==
X-Received: by 2002:a17:90b:52c8:b0:30e:382f:8b86 with SMTP id 98e67ed59e1d1-30e8312dc73mr48552905a91.15.1748007258531;
        Fri, 23 May 2025 06:34:18 -0700 (PDT)
Received: from Black-Pearl. ([223.230.93.129])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-30f36513bb7sm7324625a91.46.2025.05.23.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:34:18 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 23 May 2025 13:34:10 +0000
Subject: [PATCH] dt-bindings: mmc: ti,da830-mmc: convert text based binding
 to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFF5MGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyNj3ZTEssy85Ezd3Nxk3WRzAxMTE4Nk45QUAyWgjoKi1LTMCrBp0bG
 1tQB8zgDsXQAAAA==
X-Change-ID: 20250523-davinci-mmc-c704440c3dd0
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI Highspeed MMC host controller binding to YAML format. Add
'clocks' property to resolve errors identified by 'dtb_check'.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 -----------
 .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
deleted file mode 100644
index 516fb0143d4c21d1c8e44a8846d55ea5458d7b74..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* TI Highspeed MMC host controller for DaVinci
-
-The Highspeed MMC Host Controller on TI DaVinci family
-provides an interface for MMC, SD and SDIO types of memory cards.
-
-This file documents the properties used by the davinci_mmc driver.
-
-Required properties:
-- compatible:
- Should be "ti,da830-mmc": for da830, da850, dm365
- Should be "ti,dm355-mmc": for dm355, dm644x
-
-Optional properties:
-- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
-- max-frequency: Maximum operating clock frequency, default 25MHz.
-- dmas: List of DMA specifiers with the controller specific format
-	as described in the generic DMA client binding. A tx and rx
-	specifier is required.
-- dma-names: RX and TX  DMA request names. These strings correspond
-	1:1 with the DMA specifiers listed in dmas.
-
-Example:
-mmc0: mmc@1c40000 {
-	compatible = "ti,da830-mmc",
-	reg = <0x40000 0x1000>;
-	interrupts = <16>;
-	bus-width = <4>;
-	max-frequency = <50000000>;
-	dmas = <&edma 16
-		&edma 17>;
-	dma-names = "rx", "tx";
-};
diff --git a/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2be2ad0bdd14693208c2d6b94cc9257ab3209635
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/ti,da830-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Highspeed MMC host controller for DaVinci
+
+description:
+  The Highspeed MMC Host Controller on TI DaVinci family
+  provides an interface for MMC, SD and SDIO types of memory cards.
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - ti,da830-mmc
+      - ti,dm355-mmc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mmc@1c40000 {
+        compatible = "ti,da830-mmc";
+        reg = <0x40000 0x1000>;
+        interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+                     <17 IRQ_TYPE_LEVEL_HIGH>;
+        bus-width = <4>;
+        max-frequency = <50000000>;
+        dmas = <&edma 16>, <&edma 17>;
+        dma-names = "rx", "tx";
+    };
+...

---
base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
change-id: 20250523-davinci-mmc-c704440c3dd0

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

