Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F31E487;
	Tue, 20 Jan 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873737; cv=none; b=RzDIsaUlof1oEKGBOFQpQ+LbGYA8+rvpokoPdd1azWTgodphhVP0ydwjeOjP+PjD8rY9fvcuNa1N7reCmsy8XrkVem1u+9FE8p0iFLrDcUeJfpbbIutIPHp0TaQjjJdtLIw08WB+wtnv/V+EGyzO6CKHmoEK5ld5bRxUo5snNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873737; c=relaxed/simple;
	bh=9ZjpuakurDGJy/MQHe8tjppqpyV7PRn2yRritAjgYVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i0wRAYmFbuSb2+5RaBiq6pycR7jbV2YAaPaRcDb3kLX6GBQk/04OdHs8kDtLfNXN2kiW1dTGRosk34OgZ6BkUsjNGPNIM41Y2SDpm+auivKmrwOY8H3Z+hGpU3X3wo6zQTlp0JVOmaIs9CEf0JJrbSAhj/hkQIkuagqLu2UJshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/z37+rt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/z37+rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C5BC116C6;
	Tue, 20 Jan 2026 01:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768873736;
	bh=9ZjpuakurDGJy/MQHe8tjppqpyV7PRn2yRritAjgYVE=;
	h=From:Subject:Date:To:Cc:From;
	b=N/z37+rtTvXz2v7eVPkIP373YNS7Mhsw3N8/Z3J6771p24bYGmMMt7TJx1aBzGzxH
	 rY/GBOO79P+2DYYovugGnjq8Tao6eQ0POnu2hC6a67MWsyvEqNdGs/LjiHALELKMD0
	 fBvupMHPPbTwFzU71HHI9E2cQsY6E0UQs50Jx6iSUHJKdnLlc9J6Ae9P9u/ba1M/XP
	 v82lzvVTd7FvWKk6gvD4BI7NDijTBUeoFuKq4vDAi0DQhEDXdgBZXfFfpJQ2zxrHMU
	 oxGtjNrz+SuAJyHYtIA2AR6xCutsUBW4UnsrCmq4cVVW4z/i6FLeai8sD7yJAT93Q3
	 EI9QKB1qJNmkg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v2 00/10] dt-bindings: mtd: Partition binding fixes and
 restructuring
Date: Mon, 19 Jan 2026 19:48:21 -0600
Message-Id: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOXebmkC/32NQQ6CMBBFr0Jm7Zi2CCIr72FYVDqFiQpk2hAN6
 d2tHMDl+/n//Q0CCVOAtthAaOXA85TBHAroRzsNhOwyg1GmVlo16CK+osPFSuSYywFL76qG7tZ
 5qyDvFiHP79156zKPHOIsn/1i1b/0n23VqFCbk63KnmpzvlwfJBM9j7MM0KWUvuhOAhKzAAAA
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
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Simon Glass <simon.glass@canonical.com>
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
Changes in v2:
- Rebase on mtd/next
- Link to v1: https://patch.msgid.link/20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org

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
base-commit: 779c59274d03cc5c07237a2c845dfb71cff77705
change-id: 20260108-dt-mtd-partitions-3fd58ebadfa0

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>

