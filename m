Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF863B8409
	for <linux-mmc@vger.kernel.org>; Tue, 23 Jun 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207852; cv=none; b=BaRpZ965aGAwg0mSn2cPL0xYYPSGRRYj1wtbzz90wspDv2XClp+x9NsUlhvUalU0s7oWAreiQr+nxBMGIWAA0xwIaLtipTWvsbH5YXaEuu/0hlVA6ZPxDtBLdlGFMehrmcZluQJ642Y98f7QhJ17vr5chi93M8uMmV24RMrIjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207852; c=relaxed/simple;
	bh=lupoMa4bFvOB1DSqMrYrV4IvNEc7frNrCHK5DHmJHJM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oQtgyhncTbtpcx6Nrn5beaqNf2k9CCrBsTB/jvrAwiJrYQLaSz/0ACJm2AYENgcNGr/M3chRJmhez/ksYd7yHxDqZh4xIHAG6BjXiNz+cGxMJ0iEtjxAjwolzuOd0oYkxeFKKgR2+fvpEnktNhZYkvr9QcxphVpYhvSj1nfiTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agRrSgAb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agRrSgAb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so368376f8f.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jun 2026 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782207850; x=1782812650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl66SZXL4/eDYxy6oUcc3mXBNouxOkmru/WG4ypnp34=;
        b=agRrSgAbXxXN5HuDUOL7OyB8OQuRLC0zIEMC7lAuENaMqrtok+IrZ4056U58YMfEJ7
         FUdV2erSnIV1a4j2Ye1gFBHVoaRfynfbI2RwFvng3cqz4jEDia5LyQb7hT0KfNOUFx4D
         CaQl7qW428ddRclKWMFi6WxHRB1ap8IGQkyKBxwEFuHvzfKDz2aUR3bWScLItdncF0y9
         9e+aUqtnAOSHkfLurH+r1+dHWixCRHSBT9e700Rz6KfuqJTjuMoRxq3hdbLPj710QB6F
         4PFlqZ9Lr179YSlJ1T9j5ugRst/3X9beWRV9Mla7w3zRfT9sEH1s9gbaj7Pac0i18xwk
         JGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207850; x=1782812650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gl66SZXL4/eDYxy6oUcc3mXBNouxOkmru/WG4ypnp34=;
        b=FkzRN9dbf7cJcngnIyKX3u8eMwOaRUAtUERbREa4CK+G4G1iLq7NFvHCgwTH6GY8Q4
         uJ5LpJ3ht1jEqEYyfKLuMU524gzOYl6zWP+ukggFeKEJ4DaEVD5oY4k0pA3nEX9phArI
         5mArk022RUoEM1bgTY4J/wjWab6+10g928IyVD935Te4mR4QF4giNqEZrU1MdPnteWg0
         wfK5tD8k4TCUFZL8/0I1Vi+GOLwCyzxqICZ53yJxiHj2CaRAjPfa18USN0X/Wz3duEtB
         XsF3p8vD25J9M8qGfFgJz7qe5hmgWNffCwVWUheLaBsBCCxMs+vvMtEGyEG9oelJItO4
         euYg==
X-Forwarded-Encrypted: i=1; AHgh+RrORZ5nlhxJhb9P8upWdEyjYvs1TDMtUPk0YCSsmPyhSzlVMEd6t2bXEv095zwZt2+ZREwpcnRtE6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzNxw5I6scYjQYSLtyFM78WcjoYGvsHlL+ur9CPsjSdMmzU76
	jUnTgRyBeyngKorzhTTGR7ENfatsZtaxiugosF5pJeJcg545t88zVrL8
X-Gm-Gg: AfdE7cnS4v2BJxF2gNQCniIF8Lk0uPhl7ogZhQVjRUtRuwo1VT2EjYu5z4mQx7Z5M5g
	ntt20NHcvyOKIRjydLHJG6TKzFVKlLqJFh/a4DFy+8CHC/blf7sYQsXyDQjttVYpI2LWejOyU+h
	Zfwrt++mSsK/TUJT3u6v4SxowdMneox9tKV2KeTb1LjDH/xWvHiAM+r2+B+FbVYlZnADDd1uRGL
	lP3JQy8Me1d58R5lsSq+gneXnHOSbh0yaRSE9KOl2wOVCTIjYT3sc2h7wnq2hCuO0kWyKCUBcMr
	nzlKsjhSi90Z2FWYXwBxPDkHTzgj8l8VDuYu85UJk3XJw3ocU3XKQ0PBdc0VJ+qpovLr29nDOWv
	H4GhjShbUEAiZxImxFw91j/uCkInPPsTHLXFKoJtalkqKfNKcYLn5fxEAv9lK2Vvlr3zS1KqZ2W
	vFIe6IJ3aN/apIRW7Wwa3ZDTAP01RVOMSVw/NFC6Npi3Q4wB0IsNpNYQ==
X-Received: by 2002:a05:6000:250a:b0:463:3184:6310 with SMTP id ffacd0b85a97d-46a80f5c67amr4790653f8f.28.1782207849607;
        Tue, 23 Jun 2026 02:44:09 -0700 (PDT)
Received: from localhost.localdomain ([82.77.79.113])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46666c579dfsm34379097f8f.31.2026.06.23.02.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:44:09 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com,
	egbostina@gmail.com,
	Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Convert TI OMAP2420 MMC to DT schema
Date: Tue, 23 Jun 2026 09:43:35 +0000
Message-ID: <20260623094336.4172741-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments MMC host controller bindings
to DT schema.

Note that the OMAP2420 driver will not work with OMAP2430 or later omaps.
Please see the OMAP HSMMC driver for current OMAPs.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/mmc/ti,omap2420-mmc.yaml         | 61 +++++++++++++++++++
 .../devicetree/bindings/mmc/ti-omap.txt       | 26 --------
 2 files changed, 61 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/ti-omap.txt

diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
new file mode 100644
index 000000000..31a73c130
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/ti,omap2420-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments MMC host controller for OMAP1 and 2420
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description: |
+  The MMC Host Controller on TI OMAP1 and 2420 family provides
+  an interface for MMC, SD, and SDIO types of memory cards.
+
+allOf:
+  - $ref: /schemas/mmc/mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,omap2420-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    description: |
+      Name of the hwmod associated to the MMC controller. Must be
+      "msdi<n>" where n is the controller instance starting from 1.
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      - pattern: "^msdi[0-9]+$"
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
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
+    mmc@4809c000 {
+        compatible = "ti,omap2420-mmc";
+        ti,hwmods = "msdi1";
+        reg = <0x4809c000 0x80>;
+        interrupts = <83>;
+        dmas = <&sdma 61 &sdma 62>;
+        dma-names = "tx", "rx";
+    };
diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.txt b/Documentation/devicetree/bindings/mmc/ti-omap.txt
deleted file mode 100644
index 02fd31cf3..000000000
--- a/Documentation/devicetree/bindings/mmc/ti-omap.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* TI MMC host controller for OMAP1 and 2420
-
-The MMC Host Controller on TI OMAP1 and 2420 family provides
-an interface for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the omap mmc driver.
-
-Note that this driver will not work with omap2430 or later omaps,
-please see the omap hsmmc driver for the current omaps.
-
-Required properties:
-- compatible: Must be "ti,omap2420-mmc", for OMAP2420 controllers
-- ti,hwmods: For 2420, must be "msdi<n>", where n is controller
-  instance starting 1
-
-Examples:
-
-	msdi1: mmc@4809c000 {
-		compatible = "ti,omap2420-mmc";
-		ti,hwmods = "msdi1";
-		reg = <0x4809c000 0x80>;
-		interrupts = <83>;
-		dmas = <&sdma 61 &sdma 62>;
-		dma-names = "tx", "rx";
-	};
-- 
2.43.0

