Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2762BE035;
	Wed, 21 Jan 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025420; cv=none; b=Ojk/W2KE1ZKyiboBt1TXI5/C8EkRuiiZ74K/DIXbXoZ9oh6Aje73V55Y1cgQ6SgFvc+x7H9qXhr5l90S7L49SqEhMaQMrcI5S17xTRb7/IjyZ/bxVc9Q3iPTa/jVh1GrChkhZ7x6XVrUmSbmECfXQ4WRQVDF2grm1iM2gV5fb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025420; c=relaxed/simple;
	bh=OsjbooI0PzsSGUgngyI7clHgsjttkcXNF84NTeIQn64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECB3WPXMc97Xc1hsJ5+WRbLBSwGupOuRDTBw7y4jE+6Om0dmI0XTVV7kLQVvMpFauEnQb3BGgb44Q13YZnGXxi5ZJ5f249WZXusDWee2DZhailsPvZijCnwu3dIBmY4KBjr5siQNVMiwerEnpVHmjNhl5Y0KoLbwVHbNS1FCJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAMgMGsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAMgMGsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D362DC4CEF1;
	Wed, 21 Jan 2026 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025420;
	bh=OsjbooI0PzsSGUgngyI7clHgsjttkcXNF84NTeIQn64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nAMgMGsAlFypN4Ya2goe99Kc/ynhx11xJAcCtHPXg+DD1DaBZeFLBLUzVUtT0zcn3
	 B7oWBBg71kLI6delh0CBhqJHStvuws/Eba2MC08DMRf7TwoZbBK1+CWCyQYph8Lw9I
	 /t938+stLXCjaERmVrW5MuO6I2xzCRNiuUF6YY4RRuirkjUNtprI0WpqrU87ZS2cZ/
	 Cn6d5o3sk6RjxS7AVcvEM1EF+vn9NiNUBDqjMkvKcSTepD1PSwSFrR0Qfe/6iwRZm3
	 rI1CUk/IFLnuBmfzEwdQdWRISU4xBiXWInmijLXz0NthsliZR7vNRhYHRdeD0xx2KV
	 R+G9i3bAYdoFA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 21 Jan 2026 13:56:37 -0600
Subject: [PATCH v3 04/10] dt-bindings: mtd: partitions: Allow
 "nvmem-layout" in generic partition nodes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-dt-mtd-partitions-v3-4-ec3af93c8f93@kernel.org>
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

An "nvmem-layout" node can be used in any partition node, so add it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

