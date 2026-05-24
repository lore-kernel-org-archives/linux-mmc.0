Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD830677B
	for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779621339; cv=none; b=fr8FbmTEn3Zn8CQF557Ax1Gr3MYVKVH6kq1HZ+Fk8VI6HGWb4HQB/iVvXBQLgqLo+WjXBpygpnlG4c2SHHOz9lvW9E3EmOIxH+aEoF/nMZY9s6No1E922i7d77CvsH8dz7A4w7RKqPHI7uOCPrHNhiJZ01PmE3wTmiIcmEY25s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779621339; c=relaxed/simple;
	bh=kjZPi/r0RroY+ClFqeJNnj8q1owdSDC54noh6custV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCnIZirY1DwAHXCrOrux4TxOiqrkmMGKUtgGsuQC6KpxFBr4FqGVymjhvY4YRjM9wDdPTO0owWoO3g4ZBLY7EB7Zm+ddwB2dg2dvo3gSRlYbnskWhfK7Ssf0aDshue7VvfTBT6YmTsEhoNkQqhO0KxExHSpysJqEsCeDOf1fSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLg6gxah; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLg6gxah"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2be1dd4af34so75493425ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 24 May 2026 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779621337; x=1780226137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMbYM6D21RSnrC33rDKKKRvanVXihrBst74X+roYqJU=;
        b=nLg6gxahhkHGO/5ltrZ2h+Xfx7Ml5ByVRB+Do3QcyYTJnAWGQazE7HLxkZejygfM/J
         pgdqy1qZlORzbbji8DoOq1hs51l/syppahkNzdZlITYkuSzAD3NVoAWZPgPPxOEaHZ0K
         7ooRveXlqYP6JXNt1dncHk0u4wkPgLTl7uLSGiB5qbe+b3lyad4fVk3ZRBuYsUli/AOA
         rjel5oJjH3apTtM4j8x/jTA7KRoT0RlaSjF/0MFA/XOiCst4+apog+I00J401IMbOY7I
         zqsZgQAXZF8IiVBlRMTV9ackT0PjqMTe2izVnRUr4a5AfEUT+7jThZOiTF9dEaBdwinu
         C8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779621337; x=1780226137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMbYM6D21RSnrC33rDKKKRvanVXihrBst74X+roYqJU=;
        b=SL17Sfn9WnYsISlM7g6qJKg0pqHuRApLRDug9i6Fn0PkPEBB1QyjrGUBwy0P1p4ohH
         ot0FeLltdP/qgfOtjEEco7Ia/IEReCUBdcaLQ8Py4YDMuH0fCduurcN/jFSdyLn+J6YA
         AfJf2NgQyeb3I28t4YGEKwjT5nNek6UJ7rWQQU3PHFXAWwJha4YOPe4IpTCCuf9ocJEJ
         +yQNUYUq9qYDZV16C7IjOFbNvrp4C2ovG4kF52eEFr91e+1mEm0nbhoAqe6C6OhyG6ZB
         01ubMi3KghKaSL05PoG+yp9yg6ao+6E/x2y84e8Uj0iqcYfP1/zc5fWghhdj5p4FJthV
         e6wg==
X-Gm-Message-State: AOJu0YzTT3zveu+zpcRvV93gVyArjg5p6+9H2JyeS8RsG0Agd0jb/5R9
	xv+1pHoClZW8qh9Tw1XBPpyiZ2Po0eQ+6Rmftjlqt1A5j+xvMfvXhE8/
X-Gm-Gg: Acq92OFMJ+U0Mk6Ajzoz01pHQxXlPnrzIHSKWXWwe/3ChFoJVNNaSxFE7pw1yKz8vCe
	iRORNAxKgZLcXn58fdHH0X7S1NyVnAvi/7+DAXOoRqV3F4HWsOvn5EaA9XJz8E5PXfR9pZN9Rf8
	QxmnzfrcpAHvE5bWOZZhgTLRnPNzQAt6DMrvCxJyw0is6P7wAGpBnCanQ23Gw2MxuySlZFStVE1
	cjCyMKv9jwEVK2dBvcH6FE0bSjFnZevg3a7Q9tcwK87WE7Ada+Pja0kRcoiNyp7JRGGErCyTTa4
	yWnTgu6YzGVYpnqcjVKeH0iF8WUieOtooOQJ0d29MkQ2wCQ4RnOLV0aZ3pIWEJzDupPDDTulakc
	A+rNUKWQj3SGrPGm7OGuTFUmDm164IHYVK2beDN2mAQbZ3YGGShw0YAkdOtqpiWKN2R300T7ZJA
	wTK4504l/isytjKcRDzmcx4rGAPWUJNx2gyAfZtqBqTbeLi1mcMcVch7TsmuQT9hHwUEc=
X-Received: by 2002:a17:903:388c:b0:2bc:a577:70c2 with SMTP id d9443c01a7336-2beb06292f1mr117852515ad.31.1779621337177;
        Sun, 24 May 2026 04:15:37 -0700 (PDT)
Received: from Ubuntu.. ([49.37.169.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm63738125ad.65.2026.05.24.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 04:15:36 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kblaiech@nvidia.com
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH v2] dt-bindings: mmc: mellanox,bluefield-dw-mshc: Convert DT schema
Date: Sun, 24 May 2026 11:15:28 +0000
Message-ID: <20260524111528.107251-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Mellanox BlueField SoC extensions for the Synopsys
Designware Mobile Storage Host Controller from text format
to YAML schema.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
Changes in v2:
- Fixed unit-address mismatch in the YAML example block per Sashiko bot review.

 .../bindings/mmc/bluefield-dw-mshc.txt        | 29 -----------
 .../mmc/mellanox,bluefield-dw-mshc.yaml       | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
deleted file mode 100644
index b0f0999ea1a9..000000000000
--- a/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Mellanox Bluefield SoC specific extensions to the Synopsys Designware
-  Mobile Storage Host Controller
-
-Read synopsys-dw-mshc.txt for more details
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Mellanox Bluefield SoC
-specific extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be one of the following.
-  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefield SoC
-    specific extensions.
-
-Example:
-
-	/* Mellanox Bluefield SoC MMC */
-	mmc@6008000 {
-		compatible = "mellanox,bluefield-dw-mshc";
-		reg = <0x6008000 0x400>;
-		interrupts = <32>;
-		fifo-depth = <0x100>;
-		clock-frequency = <24000000>;
-		bus-width = <8>;
-		cap-mmc-highspeed;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml
new file mode 100644
index 000000000000..a992a4a00460
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mellanox,bluefield-dw-mshc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/mellanox,bluefield-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mellanox BlueField SoC extensions for Synopsys DesignWare MSHC
+
+maintainers:
+  - Khalil Blaiech <kblaiech@nvidia.com>
+
+description:
+  The Synopsys Designware Mobile Storage Host Controller (MSHC) on Mellanox
+  BlueField SoCs is used to interface with storage media such as eMMC or
+  SD/MMC cards. This binding documents the BlueField-specific extensions
+  and the differences from the core Synopsys DW MSHC schema.
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+properties:
+  compatible:
+    const: mellanox,bluefield-dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+    /* Mellanox BlueField SoC MMC */
+    mmc@6008000 {
+        compatible = "mellanox,bluefield-dw-mshc";
+        reg = <0x6008000 0x400>;
+        interrupts = <32>;
+        fifo-depth = <0x100>;
+        clock-frequency = <24000000>;
+        bus-width = <8>;
+        cap-mmc-highspeed;
+    };
-- 
2.43.0

