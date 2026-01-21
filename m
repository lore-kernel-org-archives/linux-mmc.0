Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBE3EF0B7;
	Wed, 21 Jan 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025419; cv=none; b=rDIrHiUXtyr2NhsHSloj9hsyOWkUi+FlORO0ipV1f5OqNqXD6TlwcdS1PakUDCBJKELZx21zW7LCB0FCPAKZCS5ipfKD0dTewDzBP/0VEiah8Tu5Fanihlvyky6bjBSPcX9riSWeYRhRyP3X1tRTO5vs3ddMBkyqOsQtNYa2vPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025419; c=relaxed/simple;
	bh=q5vfvsNNHukkTxi4H/nQ+vW1T6KSyihaVNfG3gXPrN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbGgyP0JJyPnPPerq+bFCePpLfG0q0OxRYUHVtrxdiz2BfL/YKhrzVG77cDYFg1JyS/rO8LlObjeLms9l9EL+Lgaqgm33VA0EoRWyVkOstAlKIulNmnm/zx2HYL5EzGUitYdg8OzKO1tmX/WaZtKGotXdH960vO4rN6teeQEJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwNB7NoE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwNB7NoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FBBC4CEF1;
	Wed, 21 Jan 2026 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025419;
	bh=q5vfvsNNHukkTxi4H/nQ+vW1T6KSyihaVNfG3gXPrN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GwNB7NoERjnv/TWEUdI4m+Mbl66+sWj7fdEihgLCZ2hmkMR3CArfpqzDAr36xJ+/o
	 V/4Wiy6KPSWtn4MyEDQoFreDR3jephPTE7RrcYM3aSO27GrSpIkbzrS/fW67Nktf8S
	 hdkgnEkjR3KmCIW7UPX2V+cD/xjFYLWSCW75u1R6dJxtId5usgEpLyhonju6xxH7pt
	 vaMN9vBymJsXFHrId0pIAjPrvksISS8PYghA8G+i5MjkWxgQG/ewX1JIBFPUH6qjZ5
	 hCNanwtEkprVksKJ/bPgrirHDzc//CocUE3ZAefROXXFaMcago5BX4xe+72pfmQ2ED
	 IEH1WzLWsn4gQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 21 Jan 2026 13:56:36 -0600
Subject: [PATCH v3 03/10] dt-bindings: mtd: partitions: Move
 "sercomm,scpart-id" to partition.yaml
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-dt-mtd-partitions-v3-3-ec3af93c8f93@kernel.org>
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

Defining child node properties specific to the parent schema doesn't work
unless all the child node properties are known. They aren't known because
any partition can define its own properties. The solution to this is
typically something like spi-peripheral-props.yaml, but that's overkill for
this single property. Just move it to partition.yaml instead.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml   | 10 ----------
 .../devicetree/bindings/mtd/partitions/partition.yaml          |  9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 73d74c0f5cb7..b504d4376d0b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -33,16 +33,6 @@ patternProperties:
   "@[0-9a-f]+$":
     $ref: partition.yaml#
 
-    properties:
-      sercomm,scpart-id:
-        description: Partition id in Sercomm partition map. Mtd parser
-          uses this id to find a record in the partition map containing
-          offset and size of the current partition. The values from
-          partition map overrides partition offset and size defined in
-          reg property of the dts. Frequently these values are the same,
-          but may differ if device has bad eraseblocks on a flash.
-        $ref: /schemas/types.yaml#/definitions/uint32
-
 required:
   - "#address-cells"
   - "#size-cells"
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 0b989037a005..568fac50f921 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -126,6 +126,15 @@ properties:
       - xz
       - zstd
 
+  sercomm,scpart-id:
+    description: Partition id in Sercomm partition map. Mtd parser
+      uses this id to find a record in the partition map containing
+      offset and size of the current partition. The values from
+      partition map overrides partition offset and size defined in
+      reg property of the dts. Frequently these values are the same,
+      but may differ if device has bad eraseblocks on a flash.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 if:
   not:
     required: [ reg ]

-- 
2.51.0

