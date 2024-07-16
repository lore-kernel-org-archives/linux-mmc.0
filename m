Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B64C9F;
	Tue, 16 Jul 2024 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721090741; cv=none; b=sM8CkpU6en+zbUHJ/xygcvKbP4xiX7Drq/tYRbmpWoH81PPQFR71BjyFzclx7yYj27/v16ksQ1gy7DiK1ke3LY0NXRQqwOyYawtHDFTZwlEIVGdZ/ukUpUSW2TzuBHcaOu/h3H+zisEz/ItUGHAnd7z1STnfZwTLGdClaWc8NS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721090741; c=relaxed/simple;
	bh=Vd0wsIBAbBA7tzrd9GnsC9bwycR4Woyl1jLX3Ma8kps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+TAEsQhM3HMxdovhTP2GyjuuQnu/Zw0uAhTJSi1NGmz9NsBoraO/KAp0xYiDoUt/rit57oWm3an7XTLsDDtyvpiQYImsr84FfzH6hakb7Q9gsajEDJDpDuDa/yt7yR6vWKgaMueYEP67SV2XmFqkDEJh89WE2WcQhcXcrqTOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOu763Iu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOu763Iu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-78512d44a13so3306715a12.1;
        Mon, 15 Jul 2024 17:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721090739; x=1721695539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmRt58sujYbUWl42YDpTmjrb8UaUan/GZPrgtBml3ig=;
        b=JOu763IuWiZSqlilxzvusab7qQDWpwBs++2wZbmXhVlGVPEInk1dik02a8M7ZES22D
         7VjmSgfGXEVQQtrsAcqBieg5CfqtV903bSwJz8H77KN0mWOlxz0tbfLDGU/X73ZbiwwN
         0VPIaNflURM8l9daUN6Yjx1pYPU+Cw5fxt6K5GHq/Ryub2Sxqb8joEPTMUy6eHRBx5KB
         0xAcfiqOGOSUwZIzzS7/lbtWUC9IEZdQ40893RB6sGy8vHj6DWhoPZEuGat07YhtytR6
         JhCtQJ8D7lii9OdXUL/G3X/k5i0owzXec+IvuRl7/kXLbd26fc39jo6Ydjns+Iq0LK2v
         +kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721090739; x=1721695539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmRt58sujYbUWl42YDpTmjrb8UaUan/GZPrgtBml3ig=;
        b=IsS4/pe2zm0IvOMtZg7GKMY5ZAEUqNF8zIecQwQodx5e0CKnRWFvXJc2ONI7jIEyL+
         q/GCEwZCiF9MATLzg1VK1vQvFlAUGAY5rRyLmYzmbabdZ4H6On7eeuP+Opi5PWAg6sB6
         nF+IgC0b+RwjPyzjFIroONpJnTWgef0e5B4qEyN/zybAi+L3/Iq6AHh6+FXkYR87TkyG
         0SU2Pqgs3zPRQ8xZhYyaGqnotVNJFwgUq6rQiF4HrCMZGSLjKQxv9u4kF34MSCZM6rug
         /Di/YfI1EKmO8PtTSHgj+WiWMcsvLWjsBZG3E0TXM9nBSQ+4J0XK329HQ8AF//9qo7Ld
         YYpw==
X-Forwarded-Encrypted: i=1; AJvYcCWd4eJ4Q3tQHIVjCHtC5yAyKsYPLnJlSl10eIGXIxHp5zIw1ax9SuYtvwCUJzLUVwUgNCStHF/r8CHQgMk11B5w8e9a3YVAPvALowHAnQChta6JBXqk3oefGo+GvDemu0BHLyiYKa4coWtXOsAJ+jRiymuOnOp+QkXcXV/O5FFBIWw5vA==
X-Gm-Message-State: AOJu0YxEyXlUVc1lF8Wlmxh7Ay0HJ7jVkbzIwfnFOzJpamDmejZfCvHM
	cIxeE+InE2Cw3Z8c0BI5Rxr88f2IiNDu2hZmqEJeYQKQ7wJLPvwl
X-Google-Smtp-Source: AGHT+IExNQ8d8O1Br2OEiWhuTGusLH/+AIojQSEobbpnnMfqRPjLszj29y30WBCQjhY6/ceoTs5nZw==
X-Received: by 2002:a05:6a20:914b:b0:1be:d1bf:a371 with SMTP id adf61e73a8af0-1c3f124bf62mr782710637.33.1721090739092;
        Mon, 15 Jul 2024 17:45:39 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca758fsm5000949b3a.162.2024.07.15.17.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 17:45:38 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI controller
Date: Tue, 16 Jul 2024 08:45:26 +0800
Message-Id: <20240716004527.20378-2-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240716004527.20378-1-shanchun1218@gmail.com>
References: <20240716004527.20378-1-shanchun1218@gmail.com>
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
index 000000000000..4d787147c300
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
+  clocks:
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

