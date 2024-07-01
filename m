Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2E4C69;
	Mon,  1 Jul 2024 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719794389; cv=none; b=R1f3j6P8FEE6CmVKJKMXeFWngLFNCqD/4AUZgoBDsxKLYSrOuNwlqFJp+5A2e49szaXjHejaKhIKWzVWjGW5CkvBqmmqTKETuU4TShdr7+b3WTDMOuY708I6ERL6sgoGX/mF+TYWU0IUdHFltUvS4Z29SLPlcIuuy3RiFPB0gJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719794389; c=relaxed/simple;
	bh=Vs/qlcIuOys/DBZdAlNjrBgPL42NJNU5OER9QoS34dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWF7ovBbucfOwSQtOpuRd1DOsLpsA8WVXZsKElk0K/LmMbFWWCsJMmTim8TYAOEJY+VvG5AcLVquV9Ffp7hYBsCE2BefquONg/SEAmFJ/3Ssv5cg/LyAqZdALvmaDQS09QOhYKVvHHXoYxxjcOmYljpcQM/uQNrp8Ebjtgj0ddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARC3zJV0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARC3zJV0"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d55cfebcc5so1025250b6e.2;
        Sun, 30 Jun 2024 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719794387; x=1720399187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+GuVF2kNwP7dpaSNdPfapL93zga/d4F8D+n/ifJ75U=;
        b=ARC3zJV08ne5E857ppuueFHdUre28wWyPUxFQiS1lJ9yFKb5fOJCXuJ5MDQL0dnTCe
         VhQg+lXbhlLdbfHdp2xs9+/c/x1gUVEni61Rw4QN7NXLjUK3qW2yCCKEBdoljnnD2akq
         pQ3XtxARcUUzseKrQY0ABDJTvzv9/IQhBDLMuzhD9StJaVfYcnyVStVzGSbSYSBRCuJO
         REn6/LxoAbXj3/5aZZlOyqTYmFDlEPtbBfKBlfK7sbpBneUymagRizDNBiPZHm2NwZmw
         +kDsFeLIWFuDaumbpeEOor2KNrEkpXlK+ZGkxKOTqE3pw2IOt0UYOb8uz1fBvm/uIdyY
         3oPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719794387; x=1720399187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+GuVF2kNwP7dpaSNdPfapL93zga/d4F8D+n/ifJ75U=;
        b=xSPlaL0aFm9BzAPRvroMLkeZ+weUsOqFdsLTlhDAEqLDrkxuo0HZDl8U1NuWEjt1LA
         +uy7T7XWvaQn/AADPrvDLRA/VC2jl2HNhVNk4lifu7d6gSjJfqhHflGuLSU22pijsfou
         fHdoSdGa14XzQinz+8+Hytbudl/gEURsDUffQsiyurzSVnEePZf11kPyJXqphmSYfj2L
         dZJfPnZhbPYg8x4UGmUm/1erg5AylNlN2qgcLGdXynwtLMkAI3fPuHEDQGlAi+YD747Y
         h1lwXSOuPGHH8pXVWCl95W5Wz8xV3zbhwoZDVY7AVwUFU0WFF/fYlvT862A1zglESOuD
         Z7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWsiByh+eX+hHAJNMtAvI4ZdfPwjkYZlF3dwP0/Xs64pIDN8DkbKvIygnSzXw/UVFqhOrNnciws3Bh3bO0I63rjE9U1EqLQOI2w7bRZbRd2DLKsZVrLxYRYOYlw57dwB1v6FU0naC1ESYj5WYdP/8/Sk3w/rzd/y6hpVGoSkZofH5ohXA==
X-Gm-Message-State: AOJu0YzPMxofo0nMKMx39fZjcz3eLVzuTtNO7AQxQeteVdi6b9JjXe/4
	shseoDGeVHxBbCNGLxoP8GhuSxk7gwzWB2fR4DrcoTrAIpHea0U2
X-Google-Smtp-Source: AGHT+IHEGsr50/ZkJI0Xo7HXdcXcGSsSpcDBJTs10hx01Tee6k7luqZR7xFr4n2dftPDn4jHDJhQcg==
X-Received: by 2002:a05:6808:2288:b0:3d5:47bc:14e1 with SMTP id 5614622812f47-3d6b31ebb94mr3402877b6e.23.1719794387526;
        Sun, 30 Jun 2024 17:39:47 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53b47sm5232022b3a.37.2024.06.30.17.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 17:39:47 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI controller
Date: Mon,  1 Jul 2024 08:39:12 +0800
Message-Id: <20240701003913.729428-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701003913.729428-1-shanchun1218@gmail.com>
References: <20240701003913.729428-1-shanchun1218@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Nuvoton MA35D1 SDHCI controller.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
---
 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
new file mode 100644
index 000000000000..cf08cdcb58ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
@@ -0,0 +1,88 @@
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
+allOf:
+  - $ref: sdhci-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  pinctrl-names:
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
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to access GCR (Global Control Register) registers.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - pinctrl-names
+  - pinctrl-0
+  - resets
+  - nuvoton,sys
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
+        #address-cells = <2>;
+        #size-cells = <2>;
+        mmc@40190000 {
+            compatible = "nuvoton,ma35d1-sdhci";
+            reg = <0x0 0x40190000 0x0 0x2000>;
+            interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk SDH1_GATE>;
+            pinctrl-names = "default", "state_uhs";
+            pinctrl-0 = <&pinctrl_sdhci1>;
+            pinctrl-1 = <&pinctrl_sdhci1_uhs>;
+            resets = <&sys MA35D1_RESET_SDH1>;
+            nuvoton,sys = <&sys>;
+            vqmmc-supply = <&sdhci1_vqmmc_regulator>;
+            bus-width = <8>;
+            max-frequency = <200000000>;
+            status = "disabled";
+        };
+    };
--
2.25.1

