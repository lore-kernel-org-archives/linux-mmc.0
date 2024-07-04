Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AE1A08C9;
	Thu,  4 Jul 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075059; cv=none; b=C5+Ec3+oaao+JU7mvpmFyBnXae697omAZiU/SAKMOi2t6Hx+0pZbwUQdYbu0PE8FY3D1ijIbPpgFS6y6z/4gWuv4JSmJLQ66LmoVdXnHn3R/MUFhlEsdNBqm9GtZnmCy37l/LLKTPyNinjgXiCq+kW2nUji9d3vVIJ+l5TIZHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075059; c=relaxed/simple;
	bh=dq4foKmbLLRLnKHfXamuH6lfV24K6K/pQmj9WBAvP80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDjoIXvBaqH3OUawJdpLpdo/TydafoCH1oa+K8ufF9/P7U3MYZbE0hs1kv/vitks5ehLZ1HBguk/EeJ928g373bwkQi1+3erIaiQ2JpL4vylcAJFHd/iRdiaqvYXOuGIJVHXltp7DIrweuO4YwM/tk37FODo/r6NiNz7FVVih08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAB+WK44; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAB+WK44"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c964f5a037so234896a91.0;
        Wed, 03 Jul 2024 23:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720075057; x=1720679857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4v5t9ASBrBjbnn+yqXWOS24RZUAUYqSrgQ0RyephvE=;
        b=MAB+WK44W0KwE3rdc4hVlAOPrxIenGom00kpxjhEGfi0+ceZaYGrPm+frUlw1Yodrp
         9NtQQ11p0Gu+hs/R+QI3XwxYduef4THMK+LTBte75am4nkrhZXAWbQKpTkoUxHjr7crP
         khjJY3rNI+C2DiGKEaszpBQqJgHwIrhJLnQPKaSImdkcAzse3OsIOF7TM4XKCJWkVM53
         vxiQEhDEGm0gHjMtJlPlQ+GEdT/UHHA2BaHTS9xnaWutKEXNs2x6pyBXWgj/fZ951Zzp
         76EVVlgPk8mOJ5PDA5WHivYydXLQfm+04MWbHuOBZc73204CvcwC6YZBoj/uuaeERVxG
         h6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075057; x=1720679857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4v5t9ASBrBjbnn+yqXWOS24RZUAUYqSrgQ0RyephvE=;
        b=wZuusLY5ofjBj/yKANKp1WeDD0dcVDRVWZCAACN/kzeYhf1wpeIy+p9zL+qmMsvMYT
         v+c4QKQkhQ2vgloW3xd76RIOoQtMuyGP/3yOluvK1+V2yJebZbnwiFqEAnV1HMAMOpbM
         v4sHf8w9sOsysoQLDdRCJeDAd3ZookfjKCWvqtDkDSojsmhcXVWSwIqOiaEz3oUJhVDA
         HyGiswC4m4BqnV2rllklkCUUxH3F0J+R6jUBC0qJgt2MGOjiRbWoNo5iIUl/LdZgwc4B
         D9F4Mh0qC3QIR9cupLAtK5CuQGuj/G2lvHBB5eHx96tC1ZXSRFclT9TwLUrLlWt8D40R
         blLA==
X-Forwarded-Encrypted: i=1; AJvYcCXm4DyxNxCnjRRJB9ToBcngUvQbPQTuHkDVgm4a6rRJOLGbnd7b/jU+F2r3d8uxuvImEcLxeBH76jWR6kAUIGlu1Khp6rvn8xJCOaWSvyQGVDpErK9D8zqOuuG87HZyoCGH+dichhw4nA/Xz92gb574Gwx8+iQy8gewVGhzw3OVninJUA==
X-Gm-Message-State: AOJu0YwzZ6PLSazcNy7+oiBqrF0ERBdVXIc2JJsvM6MULIGqRzyy5dlF
	9k65hVxNeogS15bMLemodYw9sSFjhhP6VkjsHErJ5KHdEbSPfst4
X-Google-Smtp-Source: AGHT+IF1oV0nrHMmOCxoj3w1gzqAcMjuveznl6dYCSwAwcRo7Hv60N3ZzmR4sa6BYovfKo1rJZ+C0g==
X-Received: by 2002:a17:90a:eb15:b0:2c9:5c7c:815d with SMTP id 98e67ed59e1d1-2c99c57ed63mr572883a91.22.1720075056677;
        Wed, 03 Jul 2024 23:37:36 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa6fd28sm666835a91.36.2024.07.03.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:37:36 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI controller
Date: Thu,  4 Jul 2024 14:26:22 +0800
Message-Id: <20240704062623.1480062-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704062623.1480062-1-shanchun1218@gmail.com>
References: <20240704062623.1480062-1-shanchun1218@gmail.com>
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
 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
new file mode 100644
index 000000000000..fc8eab29665a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
@@ -0,0 +1,87 @@
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
+        };
+    };
--
2.25.1

