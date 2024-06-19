Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F561FED;
	Wed, 19 Jun 2024 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776045; cv=none; b=iylNpjoLVQCCMBLECsHvC6TSGILnCTZF1HRrsJyeIvvL5I08afbs5YQIHfb8WaDePQcjQZrKdIwW/RopJfoLWRUXl/u2a6UD1eX8qItugnOECUJsYDta4wB3d0whJq4/nGj7Z4tEyvXqMhiNALacSbrVEHyYNSCBlwrlhd+L8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776045; c=relaxed/simple;
	bh=iOGVzokJR5jZ+JjDhL70QRX0B2Z1SiCAmZwP9QMdfqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+dLd5DNAqf+KmeQN5qOQ5wXkdrEw3wEb6xi1XA7e4zfn1Mt5tkqf8IFaFMiilFh6YvZtTNFjlU34nLZePhUY6M6lRRsSv7k6OB2gcjcXAip3QqQpDgrmb20eTRstsFmJYpNPC2t0UsbhAYeyTVhtbp6S2NERel4kdWlAF46JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ+ARoWq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ+ARoWq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f44b441b08so46118075ad.0;
        Tue, 18 Jun 2024 22:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718776044; x=1719380844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwhrrlH8XQCrhM9AqgjRF8LDCPYMq6uTj0z2U7cKwhA=;
        b=mQ+ARoWqgzcwzGlsz0RjX4c725JnYobLMFURzAlC/9u+D8cSMSCiiT0DgJz9Qm2Ydx
         xoio6/7zOS5uGQtRzj2zAQW9enX+6uXt2qM5fOSjQTtOqxaH9T9Hk5My3m+tcugqjQYW
         gL1o1H9lo5fAJEBr0zFtInzjezvJPTKcKzUY06ZxzBnsQbWoGD3Nua4QNph708o0E4rc
         envJCIa2QC8PPkQSWF4VbQgENxToDDrPfoSVTtu8YHBd/4bcpOFm64s7ZOCGIp1wMNWL
         pOSjUkWwJF9aIAs2OJDcbAUCwe3oDEwMD6hJxwzwCiU/2OzlA3sig9TT7zAoio8lG9fh
         y3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776044; x=1719380844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwhrrlH8XQCrhM9AqgjRF8LDCPYMq6uTj0z2U7cKwhA=;
        b=dCTiMIRU7hSftPCeA9NWeGNQWrubFe4ohlr+SN2owQxYIXsQr0Tcxnpt1Jl14jImE1
         PKitkVJQdV/Frt5JwkDVdl/qQRNECNuU5y+i8J7HcDBlblzxbo1OhKaBL6x2ujxaNu78
         hasD1GmeXnlIvqcB/hH6ljJugWF7tJzewHO3q707THLGetrJgFXIRg4LzprLEiRXvifw
         nRwu27R6wfy2PBGE3nighN5jZaedFLDNYpFoC9OpymeRWg4nF2ao3KKGkHv2IOBFWPVj
         R43Jk2CXi8UDjm6ONkYEruJ+29yU6q2c67diXlJNIpaKiIkLm5g4dyuevjuCn2heCmYs
         vFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsdZRzjlWxlDsPE2kpf/tst3PfdCjAcc70lh30KsVar8P0y4+y4C6cK+C6IONDGBynnnjuHjsOzFn8GlvT5qUAUnb8GPkxvkWvt8DHmNGRKxaSdRlfmNzVVsKNcfOiv3ZEQDy2i5mamaUHq7I5xRZn1Y5+kEZpd78XWyO12CYT2I3Bnw==
X-Gm-Message-State: AOJu0Yx7QXP+kvZlPudIlXdWEfGN71Tz8jKuLAHvZsKVJjjbsewR+4h6
	wPgbIKyPPRqsVZAu1Xm4TwsGLunk/IuPQI/LIOf+TAJ3xDREVl1b
X-Google-Smtp-Source: AGHT+IGvAA+Cpd4oRIWGwaxBBPwcEZw+AodXI77z+3rAmXJWdZbtpV0WL0NfYV82Vs72JkvYODLNjw==
X-Received: by 2002:a17:902:c945:b0:1f4:5278:5c19 with SMTP id d9443c01a7336-1f9aa4740femr15531445ad.49.1718776043615;
        Tue, 18 Jun 2024 22:47:23 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f598bfsm107487865ad.300.2024.06.18.22.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:47:23 -0700 (PDT)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	pbrobinson@gmail.com,
	serghox@gmail.com,
	mcgrof@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	forbidden405@outlook.com,
	tmaimon77@gmail.com,
	andy.shevchenko@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Shan-Chun Hung <shanchun1218@gmail.com>
Subject: [PATCH 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI controller
Date: Wed, 19 Jun 2024 13:46:40 +0800
Message-Id: <20240619054641.277062-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619054641.277062-1-shanchun1218@gmail.com>
References: <20240619054641.277062-1-shanchun1218@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Nuvoton MA35D1 SDHCI controller.

Signed-off-by: schung <schung@nuvoton.com>
---
 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
new file mode 100644
index 000000000000..173449360dea
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/nuvoton,ma35d1-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 SD/SDIO/MMC Controller
+
+maintainers:
+  - Shan-Chun Hung <shanchun1218@gmail.com>
+
+description: |
+  This controller on Nuvoton MA35 family SoCs provides an interface for MMC, SD, and
+  SDIO types of memory cards.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nuvoton,ma35d1-sdhci
+  reg:
+    maxItems: 1
+    description: The SDHCI registers
+
+  interrupts:
+    maxItems: 1
+
+  pinctrl-names:
+    description:
+      Should at least contain default and state_uhs.
+    minItems: 1
+    items:
+      - const: default
+      - const: state_uhs
+
+  pinctrl-0:
+    description:
+      Should contain default/high speed pin ctrl.
+    maxItems: 1
+
+  pinctrl-1:
+    description:
+      Should contain uhs mode pin ctrl.
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    description: The SDHCI bus clock
+
+  resets:
+    maxItems: 1
+    description:
+      Phandle and reset specifier pair to softreset line of sdhci.
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon that configure sdhci votage stable
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - pinctrl-names
+  - pinctrl-0
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    soc {
+	#address-cells = <2>;
+	#size-cells = <2>;
+        sdhci0: sdhci@40180000 {
+            compatible = "nuvoton,ma35d1-sdhci";
+            reg = <0x0 0x40180000 0x0 0x2000>;
+            interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk SDH0_GATE>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_sdhci0>;
+            bus-width = <4>;
+            max-frequency = <100000000>;
+            no-1-8-v;
+            status = "disabled";
+        };
+
+        sdhci1: sdhci@40190000 {
+            compatible = "nuvoton,ma35d1-sdhci";
+            reg = <0x0 0x40190000 0x0 0x2000>;
+            interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk SDH1_GATE>;
+            pinctrl-names = "default", "state_uhs";
+            pinctrl-0 = <&pinctrl_sdhci1>;
+            pinctrl-1 = <&pinctrl_sdhci1_uhs>;
+            resets = <&sys MA35D1_RESET_SDH1>;
+            nuvoton,sys = <&sys>;
+            bus-width = <8>;
+            max-frequency = <200000000>;
+            status = "disabled";
+        };
+    };
--
2.25.1
