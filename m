Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC603EF0A4;
	Wed, 21 Jan 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025421; cv=none; b=FVVnNeM5Uhr0oiEEuQwGN8XjdcUAJ4gae0QsGlDPuYJ8Y2dlyeFBk419yiEAmM+m9QRY83f3BtN/Pj6NQMr2AQXFGVcJF0dgp1peNyiooMvC9kicN9lh4/suPetV2VdaaZ/7diTxdNoTa0j91vX7qoBizXW4cYZqI0H1FnfRtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025421; c=relaxed/simple;
	bh=lNztnI4QcVHyFig2NE9Jca79n6y7e/q4hG9Afn4a2J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edRb46M+SPFOGzr3WeMkooD9bApX8W15OcY/sFYNbi5jXzJ5K3ILvJT+v7GehS7zUm/pr9E67NGh9qbus2CM788pMP8W74yPydu/98cVHv+2b8eMu3lx0jBrRez0JVEFwBdTqdlXKRCOCA0MxnFn8E1T82ww2i9fqxA4xauRhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2c7upRn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2c7upRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A5EC19424;
	Wed, 21 Jan 2026 19:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025421;
	bh=lNztnI4QcVHyFig2NE9Jca79n6y7e/q4hG9Afn4a2J8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c2c7upRnt8HsVzca0u4hvucw45+nRTSBGjjsZDsvurEJ2eVuXjB02zP0M2Q22KLAv
	 wTabPm4JWD8j2Y2i1uH2EGoOdvkrZFlFg8MFgD04SwWt5QeCSvtrHZrOSDvOAaBtmk
	 VsnZwUQekO+4dpbHUvaGV2XrMFG1BUyeM3S9haVpjtgIV4W6rXuErAbhcn6MNuKAWG
	 g+UggfSlaq4WURxyVBUWwrcrhizLzdQwc0O8rkQj9vyH+B3tPy8jQjNcWyQsY9ns4P
	 pDGCElumR75VnrbbMeE5fi5K6L3qTEn2fuFBAtjS3BLKSnMxjuOHbrktzlBYt1iEMp
	 EOcXhMPxauSIQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 21 Jan 2026 13:56:38 -0600
Subject: [PATCH v3 05/10] dt-bindings: mtd: partitions: Define
 "#{address,size}-cells" in specific schemas
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-dt-mtd-partitions-v3-5-ec3af93c8f93@kernel.org>
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

Whether "#address-cells" and "#size-cells" are used or not depends on
the specific partition type, so drop them from partitions.yaml and
define them in the specific partition schemas as needed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

