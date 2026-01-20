Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BB263C8C;
	Tue, 20 Jan 2026 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873739; cv=none; b=D9YYzB+yWCMM6JwWDXW7RiHjGW8XXeQr01MOegIJtN+gQ4J/eEi3QEC87ulwSiD/lzjnJ4H/LFXAjNQBxxM2YkdfCrrLT4M0fvAUsxgv1vzJdWl0L3vOyDI2XfDWvS5tYG7IT1yO8VjmdN13IFBCgfIzsmWncrivdd85Eq/d2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873739; c=relaxed/simple;
	bh=g/uMQusRPTzXLgyH55SF2Z0Ew27f2Lx3R56DScAIcKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lihcEzKmI6+JQHJBDL0wmcR9X2WAi8dcIMeBja92qZ+vp9aq0JCsTyW1tjD117CImJ+OFTOyIc340xkL3dq66WCfHxUlLrF0664G9tdRcWgAPeon3VPGdM74LpnhT0UdYgENnF1IYXjhmhEjspRNvBf1HjR9tzorwXX0zqsiadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ncyo4giv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ncyo4giv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09D0C116C6;
	Tue, 20 Jan 2026 01:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873738;
	bh=g/uMQusRPTzXLgyH55SF2Z0Ew27f2Lx3R56DScAIcKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ncyo4giv2phgkfri7JiliRauLyWNGyPHeJ7eBayc+j+tixYyhVmHowa/m4lPQ1UH1
	 5LpZkYZ/yBich6u93+kfAo9UaIPDemKL4XZX4mlpbf2NfCFeKBdRn/B3aLX0/ptu8c
	 k0rviGH3w/irU75dZ1gyGKjIMQiv9SeWr1oyQLgvjs9MnfjsZ79a5YE5XWZdGGCgid
	 QC9Fy4buIEv5Aw+XF7ZZUy+OXXBpkvm10vpB5eHf0SVE3uxpe2qLONpFFeb2bKZxG7
	 mm4dyEo2nU94gC8AXqsWaqPIStNQIPoN3BCJuW5Q85oUxzyFLvXfgFvImwhAER7nUm
	 xOD7dw562bH2g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:48:23 -0600
Subject: [PATCH v2 02/10] dt-bindings: mtd: fixed-partitions: Move
 "compression" to partition node
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-dt-mtd-partitions-v2-2-77ebb958a312@kernel.org>
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
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 Simon Glass <simon.glass@canonical.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev

The "compression" property is defined in the wrong place as it applies
to individual partitions nodes, not all nodes.

Fixes: 8baba8d52ff5 ("dt-bindings: mtd: fixed-partitions: Add compression property")
Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

