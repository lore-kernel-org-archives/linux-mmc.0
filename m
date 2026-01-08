Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF372F1FDA;
	Thu,  8 Jan 2026 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894823; cv=none; b=ZKvMaIx/hnwKnaoZ5ob4/4aPe5w7vFjv/vhyU37FR0HmtUimEBzAwUpX31Q4OZ3aS+AOYwvysExq54OcJVkY5begyw81r8Ru+AbMr/1tH+ypiUaCXTeymTEHC+iGias0yhfFJcG4mTZMTfUDWc3n3iuWZ7hCfAfvP5uFwxIIsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894823; c=relaxed/simple;
	bh=NybYYQFhDpQHAUmXrGSSV36BPz67jaqMd9fSLCbvpN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsZeXIEznXuJizYV7wolv6jjiRRLdDhO0yt3WnqE8iJ6cU21oKuS8EAG7KAzsmmatVoD1Fl1XuPHiCsl+OpTApCilmejqP8Em9qnX8OrbuE4YcE6Stkx5mJz6vtFoQ+aUJdFY89XQU42fi06YzEShsChdpF42RLE3uMD2Tb5MBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei0wKvGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei0wKvGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01464C19422;
	Thu,  8 Jan 2026 17:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894823;
	bh=NybYYQFhDpQHAUmXrGSSV36BPz67jaqMd9fSLCbvpN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ei0wKvGePo3aTIWYuDO2bK2KKW2iFfn3CaBTvXVzfCr3NDQyqMkH8GzPxg31Xw+1q
	 RAUE+l8TmuvWNDwLojUwGtKynHCBp37M7siBiwLBA90LObzQGRzn5eBoYvwISLgA04
	 zqLl7YAX/6Mn6Lidm7lJhDofrU0J65a05DcMl9RPwuA/cE3Xfd/VCkmTyaK2gMq4Rv
	 43W0oopf1UuoR2G/YLFg1PL9e7g8+k5Hh83ACmQ1FFuvywAYeyPXNhLXBO6yAfbTbz
	 tplYapwuY8+d2QIuf/JKPY2cnWGoT84A0AZ4EU7YyIEwEbRvXVy8cmVIiZhWOhA6Vd
	 /NWR2wyRf6iZw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 08 Jan 2026 11:53:14 -0600
Subject: [PATCH 05/10] dt-bindings: mtd: partitions: Define
 "#{address,size}-cells" in specific schemas
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-dt-mtd-partitions-v1-5-124a53ce6279@kernel.org>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
In-Reply-To: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
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
index e3978d2bc056..dc6421150c84 100644
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

