Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C193F075E;
	Wed, 21 Jan 2026 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025425; cv=none; b=o/3SZvpg6A9Vv3Y8CZonyAVQONAWglkdQ1g1/xECK+jwZqOQu3cVeKRFFngCjtbCgf/6Psaw9lSRXjHpOAL17s+P9s6lnutiDmC+w3P3FfXvFWvAOgoGMevVRmzWoQkyFV7PZhK+sgUCi61WkcQCf4AZ6CRgy9zpIeidl3vrF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025425; c=relaxed/simple;
	bh=hqmmibdeyEIA8HNBIkJ+3aEvL37E5fI2EktVUAcmCS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbWqlXd28PDEV3CGBFMFqJ6zyDXHeNoILgDXa5hQNXXKLOjGMEOpHOiddBZ9rkryVqBsbti6A1TUi8pQ8l0LGLznSBIyYunZ0/JBI04q+wiCjWF4b+Dq0x2Fj9/unP6EEv5LC9bLJg+PpXYdmIYrgMCn6duD4ZtYQJw4HR3MXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsPbwjxS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsPbwjxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C94C19422;
	Wed, 21 Jan 2026 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025423;
	bh=hqmmibdeyEIA8HNBIkJ+3aEvL37E5fI2EktVUAcmCS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IsPbwjxSd8RkF1rK+DN5NR3Dxc/glKA9poYj4V9fJePMCs72ej85Qz6wuvWWxYf3A
	 PWspl3Y9vXmkrv3hBB3/ZylxG60kOzFb69XezwvGygIOr2K6vQyejy299ovegD0OLf
	 mFCUwl3f9ANqvonrsuW0DsI3ZU4sRwxW4qPCnL5SEHDFjW573AHeg0EGwwPDFst5TF
	 /JsrDZ8MIjBloxT8ZAjbDfkIMuX+0hJCpJsIu/KCYN6ebheMyeXTEJhVb0sTkM+r73
	 Ok71EmZTy95s2V9kD9bYTqNpwh2AN2NNYEbXBO0jj6iFChMtdVqTCe9YTHDK5MbSw0
	 bSdp2Ton2B20g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 21 Jan 2026 13:56:41 -0600
Subject: [PATCH v3 08/10] dt-bindings: mtd: fixed-partitions: Restrict
 undefined properties
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-dt-mtd-partitions-v3-8-ec3af93c8f93@kernel.org>
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

The fixed-partitions schema allowed undefined properties in order to
avoid warnings when there are nested fixed-partitions.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml       | 7 +++++--
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml    | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 4d79f786fcd5..984823108f9c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -39,7 +39,11 @@ required:
   - "#address-cells"
   - "#size-cells"
 
-additionalProperties: true
+# fixed-partitions can be nested
+allOf:
+  - $ref: partition.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -115,7 +119,6 @@ examples:
             compatible = "fixed-partitions";
             label = "calibration";
             reg = <0xf00000 0x100000>;
-            ranges = <0 0xf00000 0x100000>;
             #address-cells = <1>;
             #size-cells = <1>;
 
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 51fd48af55ec..2397d97ecac5 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -144,7 +144,7 @@ if:
 then:
   properties:
     $nodename:
-      pattern: '^partition-.*$'
+      pattern: '^partitions?(-.+)?$'
 
 # This is a generic file other binding inherit from and extend
 additionalProperties: true

-- 
2.51.0

