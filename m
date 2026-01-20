Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD6263C8C;
	Tue, 20 Jan 2026 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873743; cv=none; b=DoEIhtsgREFDnnxFhNG/VbyMlTycwkYdH5UGWZOR7ASvNBFe5n7FxkFePD5KKSFJ0AYVt998OX0oGN3moHafRFvbHH6p4+ehoMtOMJKYEE8C4f/jlP7yxRiyAJnz0ZX3AlC0AbOlQu4+kLbXFN+n3pYVdzNJZPOhnaATYn9cCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873743; c=relaxed/simple;
	bh=u9XogACAWuZoPpTu9SErURhp0C70hFt25CE+G1LBUM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tj9jut0nPdcx3SY9CtwhQarzRloTNYrSzZLJV+1NTktcdjcA8dKQciv5XU2bgtdbtIgGz0Zasb6Ey67RlnMuRXngAbBRZQMN1t7eTwUilvWMlkcuBl9xY5g1/8mstas+65VB0ga3n34VjUUIRYtogKjUs3KXkxX9FO8o9liUkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E44DkN3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E44DkN3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE08CC19424;
	Tue, 20 Jan 2026 01:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873743;
	bh=u9XogACAWuZoPpTu9SErURhp0C70hFt25CE+G1LBUM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E44DkN3yIfmRsob8Me4+RPJ4mYIP3bItuwYPU968H6HgpD9nEBDl/DgRRhdLlWQ+U
	 4d54RXV3BS0aiAs2pGr6jNp64q9/lFiOwhcfqSxisHGbFMG9FL6qjCcDzG4Ip+UOLI
	 16b7baH2BsV65t0IVSZawSrYrhir5ALfjri9dBhNkq4WIHSUagvSj3fiA4ImcGP6Vk
	 zlacEv68QRKbUUJ3kuK7CkmCMqNhgp7m/mQ6LcvDOmizzskg+JNoIcHuFyYzIsdV3Z
	 hbi2EjqEOFvKUjBgJRJcdFWHYaQCF4d6ecCFcRhfSfmEfTKsKYnB4r2boGqMFL7vTa
	 KtdkLSOPtT4qQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:48:27 -0600
Subject: [PATCH v2 06/10] dt-bindings: mtd: partitions: Drop
 partitions.yaml
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-dt-mtd-partitions-v2-6-77ebb958a312@kernel.org>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
In-Reply-To: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
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

The partitions.yaml schema is an unusual structure in that it includes
all possible partition types, and it disables the normal matching by
compatible strings. As partitions.yaml has nothing to match on, it is
only applied when explicitly referenced. The use of "oneOf" also results
in misleading warnings which are difficult to understand. Drop
partitions.yaml and rely on the standard compatible matching instead.

The "mmc-card" case previously allowed any partition type, but now only
allows "fixed-partitions". There aren't any users and the original
intent appeared to be only for "fixed-partitions".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 20 ++++--------
 Documentation/devicetree/bindings/mtd/mtd.yaml     |  2 +-
 .../mtd/partitions/arm,arm-firmware-suite.yaml     |  2 --
 .../mtd/partitions/brcm,bcm4908-partitions.yaml    |  2 --
 .../partitions/brcm,bcm947xx-cfe-partitions.yaml   |  2 --
 .../mtd/partitions/linksys,ns-partitions.yaml      |  2 --
 .../bindings/mtd/partitions/partitions.yaml        | 36 ----------------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   |  4 ++-
 8 files changed, 10 insertions(+), 60 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index 1d91d4272de0..a61d6c96df75 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -32,21 +32,13 @@ properties:
 
 patternProperties:
   "^partitions(-boot[12]|-gp[14])?$":
-    $ref: /schemas/mtd/partitions/partitions.yaml
+    type: object
+    additionalProperties: true
 
-    patternProperties:
-      "^partition@[0-9a-f]+$":
-        $ref: /schemas/mtd/partitions/partition.yaml
-
-        properties:
-          reg:
-            description: Must be multiple of 512 as it's converted
-              internally from bytes to SECTOR_SIZE (512 bytes)
-
-        required:
-          - reg
-
-        unevaluatedProperties: false
+    properties:
+      compatible:
+        contains:
+          const: fixed-partitions
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index bbb56216a4e2..e56dba83f00a 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -30,7 +30,7 @@ properties:
     deprecated: true
 
   partitions:
-    $ref: /schemas/mtd/partitions/partitions.yaml
+    type: object
 
     required:
       - compatible
diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
index 97618847ee35..76c88027b6d2 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
@@ -9,8 +9,6 @@ title: ARM Firmware Suite (AFS) Partitions
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
-select: false
-
 description: |
   The ARM Firmware Suite is a flash partitioning system found on the
   ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
index 94f0742b375c..159b32d12803 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -17,8 +17,6 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
-select: false
-
 properties:
   compatible:
     const: brcm,bcm4908-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
index 939e7b50db22..3484e06d6bcb 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
@@ -35,8 +35,6 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
-select: false
-
 properties:
   compatible:
     const: brcm,bcm947xx-cfe-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
index c5fa78ff7125..02ecb51fcece 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
@@ -18,8 +18,6 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
-select: false
-
 properties:
   compatible:
     const: linksys,ns-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
deleted file mode 100644
index 76199506d690..000000000000
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ /dev/null
@@ -1,36 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/mtd/partitions/partitions.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Partitions
-
-description: |
-  This binding is generic and describes the content of the partitions container
-  node. All partition parsers must be referenced here.
-
-maintainers:
-  - Miquel Raynal <miquel.raynal@bootlin.com>
-
-oneOf:
-  - $ref: arm,arm-firmware-suite.yaml
-  - $ref: brcm,bcm4908-partitions.yaml
-  - $ref: brcm,bcm947xx-cfe-partitions.yaml
-  - $ref: fixed-partitions.yaml
-  - $ref: linksys,ns-partitions.yaml
-  - $ref: qcom,smem-part.yaml
-  - $ref: redboot-fis.yaml
-  - $ref: tplink,safeloader-partitions.yaml
-
-properties:
-  compatible: true
-
-patternProperties:
-  "^partition(-.+|@[0-9a-f]+)$":
-    $ref: partition.yaml
-
-required:
-  - compatible
-
-unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
index ed24b0ea86e5..7619b19e7a04 100644
--- a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
@@ -24,7 +24,9 @@ properties:
       - description: AEMIF control registers.
 
   partitions:
-    $ref: /schemas/mtd/partitions/partitions.yaml
+    type: object
+    required:
+      - compatible
 
   ti,davinci-chipselect:
     description:

-- 
2.51.0

