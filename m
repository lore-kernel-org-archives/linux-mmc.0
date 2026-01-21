Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E13EDACF;
	Wed, 21 Jan 2026 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025425; cv=none; b=lJONfBm6JF7FNKEeBfKevdO/deF8RdkDUMhf+6otq6/Z6vI14aAWdRbWjQ5oct2baVmHlHfgo3xPGHEcmZHvT5hb/XfGkVSCbmPkQxy8PYS8Ag2FljwIfl3m2wkt11HYEEwEbPr2zglpGvmF62XwISLJHlDsaDIJllK1JOrd2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025425; c=relaxed/simple;
	bh=6bTsyC3swP6BR3RHzzbYpQ94rLBiUEN72oKtqXPZ8W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9RLx/BnxQO9XxECrZkO69dJdusuMUBHGlUUAuRuDC5Os721HYY8hmn48nQBz/l7x3UpE2uYdN7fhU1xQgxHOxPsNjaJue6nOE7y03ObA/vu7o5R5D4e60ZpqIvQ+6voyttRNHiuMkSvfiEBgwQ26EqI7k/tmRdyU2CHAc8f4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLKlHWEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLKlHWEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6790C19425;
	Wed, 21 Jan 2026 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025424;
	bh=6bTsyC3swP6BR3RHzzbYpQ94rLBiUEN72oKtqXPZ8W8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fLKlHWElS6KV5noT9celW8c9chnO/ITX63bCA5Jj09AvgEpCkgJNcEutmeh5Ldpie
	 X0rGMIcla8T/zuACAO353ZQieDjXEFcmpyv41BADOkB6iEqF9uowmbuZh7tHubszkW
	 UQwLAq9SiJoqNu6gj/RFoAvdYpMEKDJfVfUiGwpRqeEB373KCHleSIBs5zjMq7Yc7A
	 bmdZLFjOEK4nUe/W6RgaZxVYuAMVt9JHhAG/kmDFXrt7S3SXbA1L1vl6Aw0oy9mHjH
	 zNQIWM1ZtYDAdszswSpGteu+UNBS4sc39qvyXjhkCHTGQ9xuLiOAABmZZBX3EbjJPg
	 FZHpjLFIVNT7g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 21 Jan 2026 13:56:42 -0600
Subject: [PATCH v3 09/10] dt-bindings: mtd: partitions: Convert brcm,trx to
 DT schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-dt-mtd-partitions-v3-9-ec3af93c8f93@kernel.org>
References: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
In-Reply-To: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Kamal Dasu <kdasu.kdev@gmail.com>, 
 William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, 
 Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev

Convert the brcm,trx partition binding to DT schema format.

As the "linksys,ns-firmware" compatible also uses "brcm,trx" as a
fallback, move it to the converted binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mtd/partitions/brcm,trx.txt           | 42 --------------
 .../bindings/mtd/partitions/brcm,trx.yaml          | 65 ++++++++++++++++++++++
 .../mtd/partitions/linksys,ns-partitions.yaml      |  8 +--
 3 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,trx.txt b/Documentation/devicetree/bindings/mtd/partitions/brcm,trx.txt
deleted file mode 100644
index c2175d3c82ec..000000000000
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,trx.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Broadcom TRX Container Partition
-================================
-
-TRX is Broadcom's official firmware format for the BCM947xx boards. It's used by
-most of the vendors building devices based on Broadcom's BCM47xx SoCs and is
-supported by the CFE bootloader.
-
-Design of the TRX format is very minimalistic. Its header contains
-identification fields, CRC32 checksum and the locations of embedded partitions.
-Its purpose is to store a few partitions in a format that can be distributed as
-a standalone file and written in a flash memory.
-
-Container can hold up to 4 partitions. The first partition has to contain a
-device executable binary (e.g. a kernel) as it's what the CFE bootloader starts
-executing. Other partitions can be used for operating system purposes. This is
-useful for systems that keep kernel and rootfs separated.
-
-TRX doesn't enforce any strict partition boundaries or size limits. All
-partitions have to be less than the 4GiB max size limit.
-
-There are two existing/known TRX variants:
-1) v1 which contains 3 partitions
-2) v2 which contains 4 partitions
-
-There aren't separated compatible bindings for them as version can be trivialy
-detected by a software parsing TRX header.
-
-Required properties:
-- compatible : (required) must be "brcm,trx"
-
-Optional properties:
-
-- brcm,trx-magic: TRX magic, if it is different from the default magic
-		  0x30524448 as a u32.
-
-Example:
-
-flash@0 {
-	partitions {
-		compatible = "brcm,trx";
-	};
-};
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,trx.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,trx.yaml
new file mode 100644
index 000000000000..71458b2c05fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,trx.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/brcm,trx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom TRX Container Partition
+
+maintainers:
+  - Hauke Mehrtens <hauke@hauke-m.de>
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description: >
+  TRX is Broadcom's official firmware format for the BCM947xx boards. It's used by
+  most of the vendors building devices based on Broadcom's BCM47xx SoCs and is
+  supported by the CFE bootloader.
+
+  Design of the TRX format is very minimalistic. Its header contains
+  identification fields, CRC32 checksum and the locations of embedded partitions.
+  Its purpose is to store a few partitions in a format that can be distributed as
+  a standalone file and written in a flash memory.
+
+  Container can hold up to 4 partitions. The first partition has to contain a
+  device executable binary (e.g. a kernel) as it's what the CFE bootloader starts
+  executing. Other partitions can be used for operating system purposes. This is
+  useful for systems that keep kernel and rootfs separated.
+
+  TRX doesn't enforce any strict partition boundaries or size limits. All
+  partitions have to be less than the 4GiB max size limit.
+
+  There are two existing/known TRX variants:
+    1) v1 which contains 3 partitions
+    2) v2 which contains 4 partitions
+
+  There aren't separated compatible bindings for them as version can be trivially
+  detected by a software parsing TRX header.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: linksys,ns-firmware
+          - const: brcm,trx
+      - const: brcm,trx
+
+  brcm,trx-magic:
+    description: TRX magic, if it is different from the default magic.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0x30524448
+
+required:
+  - compatible
+
+allOf:
+  - $ref: partition.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    flash {
+        partitions {
+            compatible = "brcm,trx";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
index 02ecb51fcece..61d7e701b110 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
@@ -30,13 +30,7 @@ properties:
 
 patternProperties:
   "^partition@[0-9a-f]+$":
-    $ref: partition.yaml#
-    properties:
-      compatible:
-        items:
-          - const: linksys,ns-firmware
-          - const: brcm,trx
-    unevaluatedProperties: false
+    $ref: partition.yaml#/$defs/partition-node
 
 required:
   - "#address-cells"

-- 
2.51.0

