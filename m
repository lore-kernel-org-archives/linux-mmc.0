Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D82EB5AF;
	Thu,  8 Jan 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894820; cv=none; b=AvhkNCphsZjmmu1H7o+g+vmD2+drDnsu2LTmhywZ6bidesqR8LLW5tap5UpsWtVqgQsd84K3/KQGL74q1bu4r+bymHFMvbXbQ8ECBAMcD8DoqK8Ld4iAo0QpAPVgXwPO+0YZY3GtDJgQy5cdNO6UBjs+N6rG6TItzu4h1+YzsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894820; c=relaxed/simple;
	bh=ugA+9bTKP7viQx4bvjNE6uPV3wSRpbGlQ6T4noR20Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEysV/NKUqDBTDYD8BOq/nkvL+2wKzVVFU9CNL4lkBp4/ZMCZpPNeps9QQuBB10A24eD8Ih49oBj24xQz3PEYGf2H2IaQccU6KnRC8rb39Sop+DNTUsdt5XjTB2PR9SGAmHMmPFF86D8niswPlorVC1/0tzdWOl7fZYYDmLmxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZdTvL7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZdTvL7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F058FC16AAE;
	Thu,  8 Jan 2026 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894820;
	bh=ugA+9bTKP7viQx4bvjNE6uPV3wSRpbGlQ6T4noR20Pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aZdTvL7kKt6kaEBFVE5qpZEXckuIMzXmmjZVHjh2YN8Ovk7zMcsbWzWAizzJK6Nc7
	 mRKKIHQbU2UqRgANA3dCGZKBHaRVIRFmbDtHt93OOmCmGYyOS3OuI20gGNskRZ0/YF
	 9kvdcKarMVGz1Pd2qTjIFp0/SRJSRsWM+zN2p4hS8GXcGc4B4bz7wxildWrdsUPCuo
	 C36LYtmX4x8QQ5+7xPabHDCQGCEUDxsOw0j54HpD4ulTfElA62+iC1T38XK0iLfvch
	 ESs2dqw/rfLYCKySMhZqWaedoFRz9QPq203BATdvxt3TvjBHTCv7UGuP6TsEobBVEu
	 1vv+DkcImao0g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 08 Jan 2026 11:53:11 -0600
Subject: [PATCH 02/10] dt-bindings: mtd: fixed-partitions: Move
 "compression" to partition node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-dt-mtd-partitions-v1-2-124a53ce6279@kernel.org>
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

The "compression" property is defined in the wrong place as it applies
to individual partitions nodes, not all nodes.

Fixes: 8baba8d52ff5 ("dt-bindings: mtd: fixed-partitions: Add compression property")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mtd/partitions/fixed-partitions.yaml      | 18 ------------------
 .../devicetree/bindings/mtd/partitions/partition.yaml  | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 62086366837c..73d74c0f5cb7 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -29,24 +29,6 @@ properties:
 
   "#size-cells": true
 
-  compression:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: |
-      Compression algorithm used to store the data in this partition, chosen
-      from a list of well-known algorithms.
-
-      The contents are compressed using this algorithm.
-
-    enum:
-      - none
-      - bzip2
-      - gzip
-      - lzop
-      - lz4
-      - lzma
-      - xz
-      - zstd
-
 patternProperties:
   "@[0-9a-f]+$":
     $ref: partition.yaml#
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 80d0452a2a33..0b989037a005 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -108,6 +108,24 @@ properties:
       with the padding bytes, so may grow. If ‘align-end’ is not provided,
       no alignment is performed.
 
+  compression:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Compression algorithm used to store the data in this partition, chosen
+      from a list of well-known algorithms.
+
+      The contents are compressed using this algorithm.
+
+    enum:
+      - none
+      - bzip2
+      - gzip
+      - lzop
+      - lz4
+      - lzma
+      - xz
+      - zstd
+
 if:
   not:
     required: [ reg ]

-- 
2.51.0

