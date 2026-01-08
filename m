Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522112ECE9D;
	Thu,  8 Jan 2026 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894822; cv=none; b=JcGD2fstZPJySS2hh0xhwy8gZjBK8mWmIYthrhnjET+BcYfpu8JUacoPh43r1+U77NP9fGXxTXnJMDJ2hFqpbDsHHA3aQI/L1vF5HBYzlFJrhv8wB/DqqydFyOfvdKuGNVh0G9nZ1t0IOpkXkIu6/ZvT9NDCMgUHBdD3vq7jOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894822; c=relaxed/simple;
	bh=yhzVtvkMvI4BlC+wimvaT+E0X5KJhQFWtWdpmAh4oCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJtcSgjL6e9OSjgBoRdIlGddhZTJnmb/imfGx5DKqYEAjX5GXIKvuZdGejUIxUT2tKS0E9JwMmb3jpsgHWwcIDPL8WI8oMvJEqIKa9oz+5thDNbxiBv55FJmT1xz5/ooLQ3mphL9DwcLxfUo14MkPQ/gj9Uq2vpi2b8YvE7w1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrPTojfn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrPTojfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF46C2BCB9;
	Thu,  8 Jan 2026 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894822;
	bh=yhzVtvkMvI4BlC+wimvaT+E0X5KJhQFWtWdpmAh4oCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hrPTojfnbA6BUQ2nCn+Eco6pHIvwpP713P8KMcdQAkJfar0l4WyF4MARbr/5iQqFc
	 aKuwCqkfqsvL/svapSP7eDK4IYH34WFkC29YDV3Ear0mi/YzpdcGEG2JIp+nGP3MkX
	 D+Uctm+Vy1rbQ9SlYMZkNzVXI43LD2CKnTKljJusQecd5aXdGr0fT6pmV5/pWHgltY
	 SuxH2DQOZ/J4oI+3QbvagUMoWuZ/tqoQE+bBNO9jI1qAgBUmdd4VdXVxhbijuJIU8w
	 5mb7hppSdIZL0YmPFCAOQqPpMwxzVXs9cpTgji1qpdHYOe8FQc2OuTezljyQkOymQk
	 c64wOv3UdORuQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 08 Jan 2026 11:53:13 -0600
Subject: [PATCH 04/10] dt-bindings: mtd: partitions: Allow "nvmem-layout"
 in generic partition nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-dt-mtd-partitions-v1-4-124a53ce6279@kernel.org>
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

An "nvmem-layout" node can be used in any partition node, so add it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 568fac50f921..fe2f7d622e8b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -135,6 +135,9 @@ properties:
       but may differ if device has bad eraseblocks on a flash.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 if:
   not:
     required: [ reg ]

-- 
2.51.0

