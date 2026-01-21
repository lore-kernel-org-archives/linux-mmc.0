Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5940FD90;
	Wed, 21 Jan 2026 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025426; cv=none; b=aDx5G2hFkghnEwKDXo5SVJQ6ddB2BllZcsunofzcS3WN+7oH7yTeRdaW/0xcJ42aF0Q20Z11ggx5NEKo91okiqXmHyxde6YE8yY3vxR59NBDASLjsesJaXqhmt92BZxjc8ZvMOZCZy1YJgRKYZX10GNRucymwsNntz/MLzN+tzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025426; c=relaxed/simple;
	bh=n3Q69h1zMEMSvW5ZzgCOXYmarGF2KajKkMB4dfwSc78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdVV3L1bFMKOXIEdg7Eo6s9EmjHIqBGPAdtkJFtMgOFGpUkBqjutQLXTnL1Ii2hOnj04NgMjq0PJZqk/fnuh3OJJcmBxeK6TWM7dOVTqQfIRDerk8ixAxS1lNEefbY6uXO/7RZexZA6Oga3uGl4tQEFctSmGftoU1xJDo0OFXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXC2qbqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXC2qbqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB46CC19422;
	Wed, 21 Jan 2026 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025425;
	bh=n3Q69h1zMEMSvW5ZzgCOXYmarGF2KajKkMB4dfwSc78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sXC2qbqee3jiXBJd10dUAVH6Ig7P9ZfT09/8pPlRBpSPdtMO+O2UU8i/E0g8rM0eU
	 Wi5poWvJCllNCFdjIYeSI3mnmqdxn/MtG1bgaghlR7QbqCxmkAR7fK6GIAm5ZYePjo
	 cEP2Ulo9ZY5yY/T5XwREtH5ahP8MlPsOAxVwfTbX25fxck7Fd2sgSDd5etXB1dWEwR
	 wDVTK93vBJ3jSuBh1CXMtzdvWBN+lqnFQqEoMTGgMhhSnJombYNzr7Lzbrf6E69FgY
	 htbZcE4D1asYdJYzD+JDpGKMeQSdGyqOW7qSblcWOJv17QAH7YFevnuoB2aWUCxmJv
	 OQVB+M1BTIpqw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 21 Jan 2026 13:56:43 -0600
Subject: [PATCH v3 10/10] dt-bindings: mtd: partitions: Combine simple
 partition bindings
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-dt-mtd-partitions-v3-10-ec3af93c8f93@kernel.org>
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
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
X-Mailer: b4 0.15-dev

Several partition node bindings are just a compatible plus properties
defined in partition.yaml. Move all of these bindings to a single schema
file.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Add $ref to partition.yaml for brcm,bcm4908-partitions child nodes
---
 .../devicetree/bindings/mtd/partitions/binman.yaml | 53 -------------------
 .../mtd/partitions/brcm,bcm4908-partitions.yaml    |  6 +--
 .../mtd/partitions/brcm,bcm963xx-imagetag.txt      | 45 ----------------
 .../devicetree/bindings/mtd/partitions/seama.yaml  | 44 ----------------
 .../bindings/mtd/partitions/simple-partition.yaml  | 61 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 --
 6 files changed, 62 insertions(+), 152 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
deleted file mode 100644
index bb4b08546184..000000000000
--- a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
+++ /dev/null
@@ -1,53 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Binman entries
-
-description: |
-  This corresponds to a binman 'entry'. It is a single partition which holds
-  data of a defined type.
-
-  Binman uses the type to indicate what data file / type to place in the
-  partition. There are quite a number of binman-specific entry types, such as
-  section, fill and files, to be added later.
-
-maintainers:
-  - Simon Glass <sjg@chromium.org>
-
-allOf:
-  - $ref: /schemas/mtd/partitions/partition.yaml#
-
-properties:
-  compatible:
-    enum:
-      - u-boot       # u-boot.bin from U-Boot project
-      - tfa-bl31     # bl31.bin or bl31.elf from TF-A project
-
-required:
-  - compatible
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    partitions {
-        compatible = "fixed-partitions";
-        #address-cells = <1>;
-        #size-cells = <1>;
-
-        partition@100000 {
-            compatible = "u-boot";
-            reg = <0x100000 0xf00000>;
-            align-size = <0x1000>;
-            align-end = <0x10000>;
-        };
-
-        partition@200000 {
-            compatible = "tfa-bl31";
-            reg = <0x200000 0x100000>;
-            align = <0x4000>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
index 159b32d12803..d9fefb46d2fa 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -29,11 +29,7 @@ properties:
 
 patternProperties:
   "^partition@[0-9a-f]+$":
-    $ref: partition.yaml#
-    properties:
-      compatible:
-        const: brcm,bcm4908-firmware
-    unevaluatedProperties: false
+    $ref: partition.yaml#/$defs/partition-node
 
 required:
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm963xx-imagetag.txt b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm963xx-imagetag.txt
deleted file mode 100644
index f8b7418ed817..000000000000
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm963xx-imagetag.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Broadcom BCM963XX ImageTag Partition Container
-==============================================
-
-Some Broadcom BCM63XX SoC based devices contain additional, non discoverable
-partitions or non standard bootloader partition sizes. For these a mixed layout
-needs to be used with an explicit firmware partition.
-
-The BCM963XX ImageTag is a simple firmware header describing the offsets and
-sizes of the rootfs and kernel parts contained in the firmware.
-
-Required properties:
-- compatible : must be "brcm,bcm963xx-imagetag"
-
-Example:
-
-flash@1e000000 {
-	compatible = "cfi-flash";
-	reg = <0x1e000000 0x2000000>;
-	bank-width = <2>;
-
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		cfe@0 {
-			reg = <0x0 0x10000>;
-			read-only;
-		};
-
-		firmware@10000 {
-			reg = <0x10000 0x7d0000>;
-			compatible = "brcm,bcm963xx-imagetag";
-		};
-
-		caldata@7e0000 {
-			reg = <0x7e0000 0x10000>;
-			read-only;
-		};
-
-		nvram@7f0000 {
-			reg = <0x7f0000 0x10000>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mtd/partitions/seama.yaml b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
deleted file mode 100644
index 4c1cbf43e81a..000000000000
--- a/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/mtd/partitions/seama.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Seattle Image Partitions
-
-description: The SEAttle iMAge (SEAMA) partition is a type of partition
-  used for NAND flash devices. This type of flash image is found in some
-  D-Link routers such as DIR-645, DIR-842, DIR-859, DIR-860L, DIR-885L,
-  DIR890L and DCH-M225, as well as in WD and NEC routers on the ath79
-  (MIPS), Broadcom BCM53xx, and RAMIPS platforms. This partition type
-  does not have children defined in the device tree, they need to be
-  detected by software.
-
-allOf:
-  - $ref: partition.yaml#
-
-maintainers:
-  - Linus Walleij <linus.walleij@linaro.org>
-
-properties:
-  compatible:
-    const: seama
-
-required:
-  - compatible
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    partitions {
-        compatible = "fixed-partitions";
-        #address-cells = <1>;
-        #size-cells = <1>;
-
-        partition@0 {
-            compatible = "seama";
-            reg = <0x0 0x800000>;
-            label = "firmware";
-        };
-    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/simple-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/simple-partition.yaml
new file mode 100644
index 000000000000..14f5006c54a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/simple-partition.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/simple-partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple partition types
+
+description:
+  Simple partition types which only define a "compatible" value and no custom
+  properties.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+  - Simon Glass <sjg@chromium.org>
+
+allOf:
+  - $ref: partition.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: brcm,bcm4908-firmware
+        description:
+          Broadcom BCM4908 CFE bootloader firmware partition
+
+      - const: brcm,bcm963xx-imagetag
+        description:
+          The BCM963XX ImageTag is a simple firmware header describing the
+          offsets and sizes of the rootfs and kernel parts contained in the
+          firmware.
+
+      - const: seama
+        description:
+          The SEAttle iMAge (SEAMA) partition is a type of partition used for
+          NAND flash devices. This type of flash image is found in some D-Link
+          routers such as DIR-645, DIR-842, DIR-859, DIR-860L, DIR-885L, DIR890L
+          and DCH-M225, as well as in WD and NEC routers on the ath79 (MIPS),
+          Broadcom BCM53xx, and RAMIPS platforms. This partition type does not
+          have children defined in the device tree, they need to be detected by
+          software.
+
+      - const: u-boot
+        description: >
+          u-boot.bin from U-Boot project.
+
+          This corresponds to a binman 'entry'. It is a single partition which holds
+          data of a defined type.
+
+          Binman uses the type to indicate what data file / type to place in the
+          partition. There are quite a number of binman-specific entry types, such as
+          section, fill and files, to be added later.
+
+      - const: tfa-bl31
+        description: >
+          bl31.bin or bl31.elf from TF-A project
+
+          This corresponds to a binman 'entry'. It is a single partition which holds
+          data of a defined type.
+
+unevaluatedProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index c856aed83bb0..c3087c282ee3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4403,11 +4403,6 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
-BINMAN
-M:	Simon Glass <sjg@chromium.org>
-S:	Supported
-F:	Documentation/devicetree/bindings/mtd/partitions/binman*
-
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>

-- 
2.51.0

