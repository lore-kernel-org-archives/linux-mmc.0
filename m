Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2C1917CD;
	Tue, 20 Jan 2026 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873742; cv=none; b=qBa3gyV5PmP1hAymNQKiEbul0yFiADXBh1SZ9jr/jf685AdFedPRXobjYmT7DZUjL2cO4wU6uFlhaLi6WQnoaxDy0nD/+aY5IiOpv60R8UBesqmKtQ+wb2rVdJoH7024gUJK0qcyUxNtoP2HC5uCkG0EyW07vqDsIH7vR3Uwo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873742; c=relaxed/simple;
	bh=q5vfvsNNHukkTxi4H/nQ+vW1T6KSyihaVNfG3gXPrN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzS6N4fvNyr5cTEU5OrqZO2J4Lwc+kEBS6wyTY2WDhKec3uIPpQ20RqMvTQYXS5d3OVnQ/agAQJFYXaARDHC1ioU1lSZc2aqrIMyqZ834j/kp7k3yShD9D4cezC3c3/qhbJ/x2zPWQ0aqIoPp2iiYkVE8OvPKMjKj8hDgSOLkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I45RNspJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I45RNspJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38FDC19424;
	Tue, 20 Jan 2026 01:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873739;
	bh=q5vfvsNNHukkTxi4H/nQ+vW1T6KSyihaVNfG3gXPrN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I45RNspJXWYKEUnxcSO2lXzj/5Dpg58vxrK9SloidKD84/a91jUkJthgia9PzoW6P
	 1dL6PyCAAYSjVM1I6qSDE+A2crfQRVV7rhOJpnNobv4r8xWVmAI/0RvAoo9LoVHz4s
	 GsQDli82LH6Ag7uP7sZ0QI4UK2PxcFxXoYDW533wXG7PO+Vqc0VAT+tdWcIRNZSWkR
	 bMWRQ7vJdWU8+nlD/RPMgQDYZvBDiiOgXygh+HNGvuPEyqAP5RR05WMw1Sj9SQsYtm
	 lUQym+h0eJzPW6Mlgbr8WPnrURXoYwz2Pyqi/xOdObN8vLhLCGv1ubosh+lkRchRaN
	 7k+m504I1UEVA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Mon, 19 Jan 2026 19:48:24 -0600
Subject: [PATCH v2 03/10] dt-bindings: mtd: partitions: Move
 "sercomm,scpart-id" to partition.yaml
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-dt-mtd-partitions-v2-3-77ebb958a312@kernel.org>
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

