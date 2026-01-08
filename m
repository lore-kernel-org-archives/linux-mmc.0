Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3142DC32A;
	Thu,  8 Jan 2026 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894818; cv=none; b=ZBjlpHdp0Bkf+8FAGgi1FBUzy+LTRhXeOr8imYya/PaZd6t0/7p5LG6/IHTIp57Wwf/cLLq0nLZRXFkc0OP5UnMu75AFJJcb5Ow9RHdqxQmsq7bbqRzig3CelHz4/RaAyAfAisCRrZejJBjN9I63UetUkIkoCfmlTBL9Ory7Gy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894818; c=relaxed/simple;
	bh=EpeLs1hupKlkC3f4T5WsMQDKzIOTZY86hves7++2JUI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e8vX/PNqvvmjDmUROJ06cqhJSsZ38jekGfWxqsvZD7rrEDXvjsxdQdOL2ulNU3qXUvmi3kVplKKrWnwQejR2TW2BYE9O48cuC8T9oU/iKxSsCxEmvBS+9bdfbxgECWl2F5mJaCfbhSTCQJRydcmyoTdgq+AzLOurUkeUuPui8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivZc6EBs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivZc6EBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6F4C116C6;
	Thu,  8 Jan 2026 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894817;
	bh=EpeLs1hupKlkC3f4T5WsMQDKzIOTZY86hves7++2JUI=;
	h=From:Subject:Date:To:Cc:From;
	b=ivZc6EBsyPMVfPTYjQEWagwN/pirjUKfWJl4cth6wdp/9zCMNe2USua3VRpIAYRCM
	 qcBc2Ov76Qh5DCdon9LxjVFN3u3xtw7rLEc0fQhr25C8RYGvjQokk568fJW8bnBQRb
	 itChIgO5q8agWgYonj28sO2QyjBXfOUqvgyAkKUbCtXsc3+qhnXINg2gWqHyEf/bq2
	 q/TYKBa8ktpF+aLQ5sPnsa2ZqOE6lC8xnNqY/VTLhgf6dOrlr2IP5ojjTXwgato2+q
	 0GCx1IcUbP8E/PxUHtTzdvbX4pRd0MjPXAp9nu6mQGJmRwjIGyNVQwrluUSGS7IU5p
	 dmXH1wTb3Absg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 00/10] dt-bindings: mtd: Partition binding fixes and
 restructuring
Date: Thu, 08 Jan 2026 11:53:09 -0600
Message-Id: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbvX2kC/x2MQQqAIBAAvxJ7bkGLQvpKdLB2rT1kohKB9Pek4
 8DMFEgchRNMTYHItyS5fAXdNrAd1u+MQpWhU92otDJIGc9MGGzMkqucsHc0GF4tOaugdiGyk+d
 /zsv7fqvmAHRjAAAA
X-Change-ID: 20260108-dt-mtd-partitions-3fd58ebadfa0
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

The partition bindings fail to restrict undefined properties. This is 
primarily on fixed-partitions which can be nested and partition nodes 
without a compatible string. This series fixes those issues and then 
several problems exposed by restricting undefined properties. As part of 
this, the schema structure is reworked to follow more conventional 
structure of applying schemas by compatible and a schema only checks 1 
level of nodes (unless possible child nodes are fixed).

In theory, we could have all sorts of combinations of different 
partition types nesting, and those may or may not work. No attempt is 
made to support them here. Only the known cases are supported.

Rob

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (10):
      dt-bindings: mtd: brcm,brcmnand: Drop "brcm,brcmnand" compatible for iProc
      dt-bindings: mtd: fixed-partitions: Move "compression" to partition node
      dt-bindings: mtd: partitions: Move "sercomm,scpart-id" to partition.yaml
      dt-bindings: mtd: partitions: Allow "nvmem-layout" in generic partition nodes
      dt-bindings: mtd: partitions: Define "#{address,size}-cells" in specific schemas
      dt-bindings: mtd: partitions: Drop partitions.yaml
      dt-bindings: mtd: Ensure partition node properties are documented
      dt-bindings: mtd: fixed-partitions: Restrict undefined properties
      dt-bindings: mtd: partitions: Convert brcm,trx to DT schema
      dt-bindings: mtd: partitions: Combine simple partition bindings

 .../devicetree/bindings/mmc/mmc-card.yaml          | 20 ++-----
 .../devicetree/bindings/mtd/brcm,brcmnand.yaml     |  1 -
 Documentation/devicetree/bindings/mtd/mtd.yaml     | 10 +---
 .../mtd/partitions/arm,arm-firmware-suite.yaml     |  2 -
 .../devicetree/bindings/mtd/partitions/binman.yaml | 53 ------------------
 .../mtd/partitions/brcm,bcm4908-partitions.yaml    |  8 +--
 .../partitions/brcm,bcm947xx-cfe-partitions.yaml   |  2 -
 .../mtd/partitions/brcm,bcm963xx-imagetag.txt      | 45 ---------------
 .../bindings/mtd/partitions/brcm,trx.txt           | 42 --------------
 .../bindings/mtd/partitions/brcm,trx.yaml          | 65 ++++++++++++++++++++++
 .../bindings/mtd/partitions/fixed-partitions.yaml  | 43 ++++----------
 .../mtd/partitions/linksys,ns-partitions.yaml      | 10 +---
 .../bindings/mtd/partitions/partition.yaml         | 44 ++++++++++++++-
 .../bindings/mtd/partitions/partitions.yaml        | 42 --------------
 .../bindings/mtd/partitions/redboot-fis.yaml       |  4 --
 .../devicetree/bindings/mtd/partitions/seama.yaml  | 44 ---------------
 .../bindings/mtd/partitions/simple-partition.yaml  | 61 ++++++++++++++++++++
 .../partitions/tplink,safeloader-partitions.yaml   |  2 +-
 .../devicetree/bindings/mtd/partitions/u-boot.yaml |  2 +-
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   |  4 +-
 .../devicetree/bindings/mtd/ti,gpmc-onenand.yaml   |  2 +-
 MAINTAINERS                                        |  5 --
 22 files changed, 196 insertions(+), 315 deletions(-)
---
base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
change-id: 20260108-dt-mtd-partitions-3fd58ebadfa0

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>

