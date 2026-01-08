Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B262FC86C;
	Thu,  8 Jan 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894826; cv=none; b=iikUELyaFzSJYaFwRDALJAsJie23q/KJw18Eewf5yZ4ZPcRshX1c7feVDCTcTVGzXI4tavV6FILCf8aUOGSxJybMdaYeJZQxzWkDnqWlk1uSk2GrEKjEKl6My8cR3pBb/lsj1MJ8FkxVdaZuSn559B0Y+evovB7/F3BLpDp8Lvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894826; c=relaxed/simple;
	bh=/xLQMDY+Z5c201pwV6drsWJD9hut61CKQg2Ohei6ByU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbXsM7/OBrQxfVo4Q8VrYLP8JEhfZv3nor8kz0pX95VrsSm1mRDKF7PPA/ZkmK0Av6Pjh7BM3VBoE4Zuu3vl3WcBL15PnbbIyoE8W9+k+UQ8nvGKM6TT5y9x/gOXtbkwCfr27IDcU+8hJwu7jC9hp8lskEK1Gbs0KUGryMjNX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le3Uy+re; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le3Uy+re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ED7C116D0;
	Thu,  8 Jan 2026 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894826;
	bh=/xLQMDY+Z5c201pwV6drsWJD9hut61CKQg2Ohei6ByU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Le3Uy+re5r+KiKpy56t2y4K9CEu4ZDEzyHjguCdB/ACk9BBEVX52msmhek+a1JC8i
	 +Dxg2XGl/sHOd3TvvDyaSTjg5T6Gu8s9L6C31IX5yjnvOSTSxPzhIJVsnkeSVm0XqS
	 DebMcdMrbbPoKwjOah/UB6smg0xrtgu+xxIPG8zKO7QYRCkEdQDz8yYfn7fLtHEKLX
	 tMaB8Q0lHTLzYd37UOXD/fT0cfB+TsaRjGI+qwJ43+qRLkq7QZHISsKomp+2Qx4GF/
	 tYFtGEqjl0AG8x9POlueSHN/4+ZfkVHxSJtN578ANldkC0NE/X6TcHZhQHiIPkUNJP
	 R2tB/uFOrqwMA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 08 Jan 2026 11:53:17 -0600
Subject: [PATCH 08/10] dt-bindings: mtd: fixed-partitions: Restrict
 undefined properties
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-dt-mtd-partitions-v1-8-124a53ce6279@kernel.org>
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

The fixed-partitions schema allowed undefined properties in order to
avoid warnings when there are nested fixed-partitions.

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

