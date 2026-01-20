Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937D29DB64;
	Tue, 20 Jan 2026 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873748; cv=none; b=e7kfGrcRbexvfgZfxPeJr3H6MFRr7PreiE85GNQNPgEI/9LdGqYmwgBxKCLg7RQ83RMTxKvhyiG+yvfEc6y5EkD0TgyFcyJE9s0aF6I2waeA86RLHJDt7SWqIX+686BG3+PR0BhRsIuLFIaMLuvVLl2KWHT0jhOy1iWVo8vxUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873748; c=relaxed/simple;
	bh=VzyB3Sqk9o+hcLkpFFFmVEc5a4M2ouj/OHzJ3QrwqD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=of30gu1ntw0vCt2mjE8LY2m2NHpYUNUMNWr4ZxAc+iXMhXtlE+nDDnE8oot4zlYxEUb41JWFcE+nIESfai5Pnh972gnf3idE44eSrAtOM2aI4/u83g1iUDSFUdoVqSgBQqJbJLz0gbyeWe2jScvECycF8Ze2mOrpflF7jjTEmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpBfhL9I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpBfhL9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6ABC16AAE;
	Tue, 20 Jan 2026 01:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873741;
	bh=VzyB3Sqk9o+hcLkpFFFmVEc5a4M2ouj/OHzJ3QrwqD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NpBfhL9IcyNxS5y2b8VewOF9RgOioarlWc4+wuFcd5a78+AGmvwx9gANDTEb5axHg
	 u9zmPJpqRjEWBKD+mwNca/siGGcMMblZMyO6QCbM09kO0zUpqGJPcjtswsTC+6P78P
	 FoTyAQmRdUWrLs5IaM1sh7qaJJItyyToqMX45ZmzPE/LS5CZHA+p5FoInE6WO/nReP
	 0szQwbsw9JNAYtVGnqLHs4hvj2Sa9mDn0oM24SPwEWH5nDgqTy1BokF7Jb31240sWE
	 OaELpbM6vcGKssKvAN/PQw3tD8XGiy/KnQoA32fcsBvjpYH/qZ1G3aKeJnN5WIcoKc
	 GudGW/aph/CcA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:48:26 -0600
Subject: [PATCH v2 05/10] dt-bindings: mtd: partitions: Define
 "#{address,size}-cells" in specific schemas
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-dt-mtd-partitions-v2-5-77ebb958a312@kernel.org>
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

Whether "#address-cells" and "#size-cells" are used or not depends on
the specific partition type, so drop them from partitions.yaml and
define them in the specific partition schemas as needed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml        | 6 ++++--
 Documentation/devicetree/bindings/mtd/partitions/partitions.yaml    | 6 ------
 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml   | 4 ----
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index b504d4376d0b..26bef777353d 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -25,9 +25,11 @@ properties:
           - const: sercomm,sc-partitions
           - const: fixed-partitions
 
-  "#address-cells": true
+  "#address-cells":
+    enum: [ 1, 2 ]
 
-  "#size-cells": true
+  "#size-cells":
+    enum: [ 1, 2 ]
 
 patternProperties:
   "@[0-9a-f]+$":
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..76199506d690 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -26,12 +26,6 @@ oneOf:
 properties:
   compatible: true
 
-  '#address-cells':
-    enum: [1, 2]
-
-  '#size-cells':
-    enum: [1, 2]
-
 patternProperties:
   "^partition(-.+|@[0-9a-f]+)$":
     $ref: partition.yaml
diff --git a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
index ba7445cd69e8..ba627f51840b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
@@ -28,10 +28,6 @@ properties:
       device. On a flash memory with 32KB eraseblocks, 0 means the first
       eraseblock at 0x00000000, 1 means the second eraseblock at 0x00008000 and so on.
 
-  '#address-cells': false
-
-  '#size-cells': false
-
 required:
   - compatible
   - fis-index-block

-- 
2.51.0

