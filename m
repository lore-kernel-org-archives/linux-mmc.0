Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856CC21CC55
	for <linux-mmc@vger.kernel.org>; Sat, 11 Oct 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172754; cv=none; b=ZRfsz389bOvDG8KIHLPYY3T0Z+P4DrHrHeN0QWGmxuliiXgjcYLqCU2dV7K6dQpHCN249A7574Zf/pat/wHceLTLzax3Wz0v4j8JALqMx7MkJybZ1aggWmlITn9RFGXokvKyQ+oRDrqnWee9HqS+CxFUjKZILCE/sWCEv45UNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172754; c=relaxed/simple;
	bh=5NLvSnyuZikWYjbw37TkUeYgoM4N/stus6HiUzrLy9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BpKshCg3JCTSZg4G0Jo5AT83Z0d+BpylL3lIBXJpLq8J1N3SEsaPhM3vwRh1gngc0mAyaTCP9ELFjhufl8shTdkrPdP9b4QmsCv90Z4l2rcbs0cC7Zr5U8qz2BZREQ+QWiztMGlAWQ8e4aOgfumeceo1Vha8kQ6ZJtD0D3ZBrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTGoklak; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTGoklak"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b633b54d05dso1777630a12.2
        for <linux-mmc@vger.kernel.org>; Sat, 11 Oct 2025 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760172749; x=1760777549; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiLmG63RpnkdfX+sUpwnDjdHi9WgZXbqCQLxRB/gE0k=;
        b=JTGoklakaz4tu0inAECC4pENcTb12em6AIM8EAkA/ZHcNNw4cJTPzk9qfpVZjJLxX8
         yahHRTT/DuSkJttspnpWb9zi8yT6m4IYG4xTU0hJARVfJZZ4KlojK2P5NxcVtLogT/lL
         hod+PjFZUJf7JiRZgBKWRR4Wpa8uoOdLlEZ2BjH1VYYuKd3n9jHoT10Ruaq3heGs/e08
         Opeo8kTCyXWyL0eu47agcWt38nTpbt0q6olIDPDOWVFfivJrGttqyuAiUqljpk+OpBFq
         ftCe/dE9FZsCoBFDekKIFV0X6Ckk41yht0Wt2QRAmiWScxmIgfCgkEvyuC4jd1UMU71j
         7Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760172749; x=1760777549;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiLmG63RpnkdfX+sUpwnDjdHi9WgZXbqCQLxRB/gE0k=;
        b=oIKIMT5vIsn+DsWqd0bFdX0U0YQUbDKburDRVzimIFcHqO56ZP8VeYtKqqzT+RWuB2
         PoR0Xu1IxEayDI3wOjTtB1L+A0Inar1idqizHYJucW9c1PJlSllxtd6QFSGW7yZwUPgK
         D+d7ZT959tHQqIem0LQzWEuOX0ErjluGb7hAzICpFDEUatfqsh7iRyq96EOedxXUXm8G
         SSBwRhoDO8dftVhMt+Ap4awrI3MRrFWoXaxURVSTcQByeeqQPsP43AC22HkxLGCHRMd+
         vuJr+DUlXWG1nh5NdDKNt+/CJJcjJWRoiD7LEhPp/s0jtJwMePa9WU/up23TW48gW8BC
         QfGQ==
X-Gm-Message-State: AOJu0YytAOjRLJ9Yn/j+IaVmY4I4eKcniLoZW7bjU5pzArpEjpA+TLRn
	xTMaLoqsl3qNi0kgG7CnWr8ejkOx4HD+FWmRmRE2ZZgBOwiMep/EfKLh
X-Gm-Gg: ASbGncu56CTqCwwU+zvdhmiIuNS5/N3YDGy95lm3RzjiBx1WzCBKtqSyE1LZDxDeqfB
	9szqSHw9Fo9lo1KpMBXycVQt7Wqb0t+it9Cx936j/+I4O4MUrGvg2IGvf0dVsiNp2cD/dDRcwgj
	L0ReIYaG27V5bMkU+E6xmR/a090MCFyRJDxOhD8JNNGqsE6jAv5BPnlzhwgphwvAq/1owBg735S
	eyeciJ3cSKEObsg9oQqrEE6D0L6dnNmfTWiUSQXhHFgHSXrIBHaA2Hgqh5TWdVi0gRX9Vy3gmgL
	mBhaD0BGOpIZWatw61d03t4HGhQLojjA+h5NC+JHaSuH2xp0BTsnPFVjnDnb+jhlzIdcESmLKUV
	b7KnYfq4LgnJqtK9g/+O12p6+17DQxCC/+gn/mWZaC4EAanxMtj/kI6BGwCKs2/LR6dPe
X-Google-Smtp-Source: AGHT+IGrw5WjnkHFl8FT4pPAuJqjzVUuVNOVKVnaUJHLbVr1wlbjuCd2icribCshUIxZPAy3fsFyKg==
X-Received: by 2002:a17:903:1a2b:b0:268:5892:6a2e with SMTP id d9443c01a7336-290272ff539mr193038375ad.56.1760172748788;
        Sat, 11 Oct 2025 01:52:28 -0700 (PDT)
Received: from Black-Pearl.localdomain ([157.50.164.155])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29034f95bd3sm79050495ad.119.2025.10.11.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:52:28 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 11 Oct 2025 08:52:07 +0000
Subject: [PATCH v2] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-davinci-mmc-v2-1-355da3e25123@gmail.com>
X-B4-Tracking: v=1; b=H4sIALYa6mgC/23Myw7CIBCF4VdpZi2GcomXle9husBhbCcRMGCIp
 uHdxa5d/ic53wqFMlOB87BCpsqFU+yhdgPg4uJMgn1vUFJZaZUW3lWOyCIEFHiQxhiJ2nsJ/fH
 MdOf3pl2n3guXV8qfDa/jb/3v1FGMAolu/qit8ie8zMHxY48pwNRa+wKgU4mupgAAAA==
X-Change-ID: 20250523-davinci-mmc-c704440c3dd0
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI Highspeed MMC host controller binding to YAML format. Define
'clocks' and 'interrupts' properties to resolve errors identified by
'dt_check' and 'dtb_check'.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
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
index 0000000000000000000000000000000000000000..1a97c3e447fd10f14bfe0af9e22f9479304f0f26
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
+  - Conor Dooley <conor+dt@kernel.org>
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

