Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C22ECE9D;
	Thu,  8 Jan 2026 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894825; cv=none; b=YUnUqM8yH5lsyu24jlSeElztGW489bfAQYsXGRv2HxagUa9R3LY436Ngpyn4KVksChDDoAEuFMKjEn6yjSWKmHboQzw+u1+O31IQ9DooHhxqsYJiSYDjqaOGLk+m8ys9gDn+bnBv6NWIbazOyjpuVxyyoHmEBwKzNtCaP8bSDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894825; c=relaxed/simple;
	bh=fSFFqBjSxmW6GjXDFPoquLzIaZS4HePaiQdXXsrYlE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9u0wXxQyTZbl6IPrL9FCzg0i+14UlZsIEGiNddB3d5w81GeQ5Cg5r4P/NeWtzGyUGFyChYTMSOqu3IMwQfwHea7rX2ieXVExXy5g07D2gLzZvzGZWlMnc7iE7PWVXCqUVEbcnX1JC63fUkGLro8Vvifb5t7ae6e0HUDKZilRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGh6A2+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGh6A2+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F2EC2BCB0;
	Thu,  8 Jan 2026 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894825;
	bh=fSFFqBjSxmW6GjXDFPoquLzIaZS4HePaiQdXXsrYlE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jGh6A2+u5nsJXjQ+fzgDDdzvC9frMZdMIvyH0bUHl4Xth0CWs9n2x6YJhywVP3hLb
	 3EUNIV1rClzM28yE3yggl9KK6CaiceWaZlqIxmr4Ccib6Q/qmkief/jHriAEsahbLF
	 /SqGrRvwgnCMpQmkMx6dBx1YK8tyq0jHT9LYcMWJldWEu7Bo/FhEnhtbV6nNXl5FX6
	 Ujjz68snNWp5DpDfIko7EnXZGgKFZEW9jlvvWCbG9q8Q38RSKfxiClyqKT8FVinxVa
	 /8eLeK9SNLnio5D8Z6CXHofHDoO5l8kcfmeSViRs3g1S/DxxM28GSAdKRsqpbGhv7V
	 zi03CiNtXQNxA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 08 Jan 2026 11:53:16 -0600
Subject: [PATCH 07/10] dt-bindings: mtd: Ensure partition node properties
 are documented
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org>
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

Partition nodes without a compatible have no restrictions on additional
properties. Fix this by ensuring 'unevaluatedProperties' is set when
there's no compatible property. If there is a compatible property, then
there should be a specific schema for it which will enforce
'unevaluatedProperties'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/mtd.yaml               |  8 ++------
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml |  2 +-
 .../devicetree/bindings/mtd/partitions/partition.yaml        | 12 ++++++++++++
 .../mtd/partitions/tplink,safeloader-partitions.yaml         |  2 +-
 Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml |  2 +-
 Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml   |  2 +-
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index e56dba83f00a..5a2d06c96c0d 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -36,12 +36,8 @@ properties:
       - compatible
 
 patternProperties:
-  "@[0-9a-f]+$":
-    $ref: partitions/partition.yaml
-    deprecated: true
-
-  "^partition@[0-9a-f]+":
-    $ref: partitions/partition.yaml
+  "(^partition)?@[0-9a-f]+$":
+    $ref: /schemas/mtd/partitions/partition.yaml#/$defs/partition-node
     deprecated: true
 
   "^otp(-[0-9]+)?$":
diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 26bef777353d..4d79f786fcd5 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -33,7 +33,7 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    $ref: partition.yaml#
+    $ref: partition.yaml#/$defs/partition-node
 
 required:
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index fe2f7d622e8b..51fd48af55ec 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -149,6 +149,18 @@ then:
 # This is a generic file other binding inherit from and extend
 additionalProperties: true
 
+$defs:
+  partition-node:
+    type: object
+    if:
+      not:
+        required: [ compatible ]
+    then:
+      $ref: '#'
+      unevaluatedProperties: false
+    else:
+      $ref: '#'
+
 examples:
   - |
     partitions {
diff --git a/Documentation/devicetree/bindings/mtd/partitions/tplink,safeloader-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/tplink,safeloader-partitions.yaml
index a24bbaac3a90..40e6eaab03ce 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/tplink,safeloader-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/tplink,safeloader-partitions.yaml
@@ -38,7 +38,7 @@ properties:
 
 patternProperties:
   "^partition-.*$":
-    $ref: partition.yaml#
+    $ref: partition.yaml#/$defs/partition-node
 
 required:
   - partitions-table-offset
diff --git a/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
index 327fa872c001..d51bdcb7e585 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
@@ -29,7 +29,7 @@ properties:
 
 patternProperties:
   "^partition-.*$":
-    $ref: partition.yaml#
+    $ref: partition.yaml#/$defs/partition-node
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml
index 7d3ace4f5505..8db991dee7eb 100644
--- a/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml
@@ -36,7 +36,7 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    $ref: /schemas/mtd/partitions/partition.yaml
+    $ref: /schemas/mtd/partitions/partition.yaml#/$defs/partition-node
 
 allOf:
   - $ref: /schemas/memory-controllers/ti,gpmc-child.yaml

-- 
2.51.0

