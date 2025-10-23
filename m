Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387ED2D8376
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225636; cv=none; b=NELLRSY1Ywsu2eUjz1Fx4CtzSzakPqj7dNbvdlX6AiySjMnB588S0dKwlEMs42aH1aEufhgJs4UH3jWeEa460AQAMgaWW0vitEzfibHZ+aTh1F6l/sf/TR7ahYnbKcqsxEecJKqTWxWdjEFS24RmnXwu3gfFcMtXBvHVC2ZRE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225636; c=relaxed/simple;
	bh=vuViwP/s1cMS1phQ8Gat0GObNFdBTZNa1VEQfL7iJ0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Wm4rr9vSWbzNmzKhYwlHuxQA5Yhz90hZ5EC2ZR7iy0NUpPtMi3WFfMq6E35SyqfWdew3phTXNtALNBHuGq9E3GwK03/KFTnwcdPQrkPcuF/tdlu6ZdFP45T/+juDvirrFAwPhf0tvnm/DPPa4Einm/pws5VK1SAApn6Pl1vWkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVdtvzMk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVdtvzMk"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso730156a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761225632; x=1761830432; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AF2NNx9hf0mnuYECQ9Zws6r6vEvdCmP6FSfqGkx7HaM=;
        b=GVdtvzMkc5/EhtBAKGSGGjDCiBg+3TDwlkCVofyJ4KXMp8b14zY9/1K2k3tFp6iG4d
         yNd9xllqdXUgI7QsWEAdhR402r+3JSsRit+epqTCdtzY+LBmNfet2VVEAfKXNHqrWaNi
         Ytm3BUhQjiQ4oE/4tGThXNiaP9eWznQRRS5Q/zeNzSiakAAtJ+mMOyXlDuc24app7hUK
         pLSMhG3vWDbZsDNji0Jg27jhPA25t0MDGm9OF5R2CqChyCrNIGnUxgDPBqa5RuFkznpq
         MHqG5/Lzy5I8DHeEWe3puWbwN/sbhhOBGKQAFPSPTYyho1k3lfk80Y0T9G/JbGdnw7RP
         q4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225632; x=1761830432;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AF2NNx9hf0mnuYECQ9Zws6r6vEvdCmP6FSfqGkx7HaM=;
        b=JghKJTMFNVvwVTX3OLOErA2wu5Eopn8hae+dQt2TLb02Wwdop6Y3y+zuFtp4Aux3a+
         bnNsmqENYFSH7Q106ehKcUYePDxc0ihoQ1V8v2CNXlVchQwJ3+ppM0hXyfC1IHxZnJ1E
         PmPuq55Y6g8IJaurQDgyTknjy2qzYS0wXFZqWiDod1MxlKpnPhW3E+qW+cfyF+lRfozl
         BbS+TG8gzDv6xequLqmGBYfKorlxyXAj/ZrTqVjZ2EqUQdWaAzmgtQzEzv14/yweyb1K
         o7m+hfrYjPqwSaMXX3P+FRG46iuXHpX1XzXru+tQGPxpoIasdOz4fWjyYwj6Y+th72AJ
         1mLw==
X-Gm-Message-State: AOJu0YxOskY4O4ylhiuTtUftAAoGRyzpzT321gFV5NhPRW5n0swkjONE
	9RL4XFag9595kq4WwsdJY1K63KzV5CYA04CdtYXOukuPcUgMeTlUpewmpZzQlA==
X-Gm-Gg: ASbGncsjaLV+nsr9XCTgSXAdx8Ybkv/H6q8kJnQ9hcBfjHiAtL/eLx+5/tWbkf9BneP
	SMfFglAkDRM/2xNeawp1iEx6316JDhyT0hWadFa+DQRnpQkJwr5kAbZt+VueF00+cjMDfb9IqAq
	VqmK14/o7V7ZsduM2YwPNGJ9z9V+GvUcHCuyPl/aX2JitaUhnej2FRyuRRt6Xim+yIEi2Hn1UDR
	C/n+K4BqykClx/g129Xskbw44M4bTZSPtErbC39t0RmuRopK2M5g1gri7t5VYA24JqNOWi1R3RE
	dlCMuGVbpF4fqQhCwk1GXau94u2RAxan0Tt8u9t3mD5VKkziTwsrWNb6n1BK9pXznRjJvAhc3lI
	J2JGFCqKd04d1OomiBa92/l0wVGvhIHXh0+1Ng68ZU1JIMrBs2emAIIjF2taVfv0MeuK7rM8par
	SQ5L3XJKxVmoFWPjJB32vg+WlnSV0h8aU=
X-Google-Smtp-Source: AGHT+IHgW9BWCG5ejHfW98SHJJuOnntPPezQy1Qb2Owph8LTgzKcuyURtOIXsoNG+tj9X4I70ae6wQ==
X-Received: by 2002:a05:6300:6141:b0:33c:741f:7abe with SMTP id adf61e73a8af0-33c742ec0c5mr3139528637.8.1761225632239;
        Thu, 23 Oct 2025 06:20:32 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b6cf4e2c95asm2088354a12.28.2025.10.23.06.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:20:31 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 23 Oct 2025 13:19:43 +0000
Subject: [PATCH v3] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-davinci-mmc-v3-1-5b27b9c9ecc4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG4r+mgC/22MywrCMBBFf0WyNpJkGnys/A9xEWfGdsC0kkhQS
 v/dtAtRcHnu5ZxRZU7CWR1Wo0pcJMvQV4D1SmEX+pa1UGXljPPGO9AUivQoOkbUuDVN0xgEIqO
 qcU98ledSO50rd5IfQ3ot8WLn9X+nWG01Ml9oB97RHo9tDHLb4BDV3Cnu41pj7a/rqgveUwCut
 4Nvd5qmNzmF4tLiAAAA
X-Change-ID: 20250523-davinci-mmc-c704440c3dd0
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Convert TI Highspeed MMC host controller binding to YAML format. Define
'clocks' and 'interrupts' properties to resolve errors identified by
'dt_check' and 'dtb_check'.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v3:
- Change the maintainer for the binding to "Kishon Vijay Abraham I".
- Link to v2: https://lore.kernel.org/r/20251011-davinci-mmc-v2-1-355da3e25123@gmail.com

Changes in v2:
- Modified the commit message.
- Removed 'interrupts' from required properties following the old binding.
- Changed the maintainer for the binding to "Conor Dooley".
- Link to v1: https://lore.kernel.org/r/20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com
---
 .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 ------------
 .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 61 ++++++++++++++++++++++
 2 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
deleted file mode 100644
index 516fb0143d4c..000000000000
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
index 000000000000..36b33dde086b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
@@ -0,0 +1,61 @@
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
+  - Kishon Vijay Abraham I <kishon@kernel.org>
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

