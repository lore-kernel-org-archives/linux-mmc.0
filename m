Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB11E5B6F;
	Thu,  1 May 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746089455; cv=none; b=plYysp2ye5leb6/TRTF/iE8Fmdc26AFkSEdcwTUIsfO54c2RpmWVJwArGM0jYKhAMicxznpPO0OHwG5I7LQDGCK661Ja9rs8urFjerAf0XA0f5kpbp4fhG1YeDr858yl6Hu81yRk9CU4OrjZtyX0IJ33Fa0wX/pe70fNiuV/Z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746089455; c=relaxed/simple;
	bh=7iG3g5Fpkpmnaw2P8DKAL0enzyTifLCknRgh9KOA600=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j6qnzNC1gJPBplpHiggpZ8li0fFsF7XnnywdkOIpEZIPAxdJtVBuckyhgAlfAFs5yUZnWdz6gZBRD1GmSoqD1oz6qFGb0tL0KRBG/y+T65dynI+Y0CEHsuYuuonNfFuP23zS7AXK1S27aPup3ybCgT1qPArmTdIucV47ZuA4roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BC823340C39;
	Thu, 01 May 2025 08:50:49 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 0/2] soc: spacemit: add sdhci support to K1 SoC
Date: Thu, 01 May 2025 16:50:20 +0800
Message-Id: <20250501-20-k1-sdhci-v2-0-3e7005fae29b@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMw1E2gC/1XOTQrCMBCG4auUrI3MTGtMu/Ie4iI/0zaIjSa1K
 OLdjYoLl+8H8zAPkTkFzqKrHiLxEnKIUwlaVcKNZhpYBl9aENAGCEkSyCPK7EcX5FaZpgWEGrw
 V5eKcuA+3j7Y/lB5DnmO6f/AF3+vPqf+cBSVI7JtakWk1OL8beJpjXMc0iMPzKye+XMt785cX1
 mSWLp5OYe4qMD31yjLahjTWemMVame1Mr5tFHv2oFvjdMGeL5sILsPzAAAA
X-Change-ID: 20250212-20-k1-sdhci-76a4901030db
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Alex Elder <elder@riscstar.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=7iG3g5Fpkpmnaw2P8DKAL0enzyTifLCknRgh9KOA600=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoEzXfTy59n2gtVx6jPw4KiofG2dRFcY72qANKR
 0UNuoigwqSJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaBM1318UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277T4qD/9J9QVJfXVytcWb2J
 DpCJg4p11unIBM6rffhwQjI2fJVI4bnrKBDphYWMw06VX3LVWKy6vPvwUaBcfGQ6x6wgSDCZyYi
 ppdBww4//bTNtHc78DTZaYTxztm3oxNl9mI1XOO0NlsYRHvpobE1eTwjOpMR4Eay6FEQuoNTtB6
 2JxHw5vpEyZIWCt4aKbsJJ5hQZZXWFG4FXac9aTupmdJEiUSIYVSOPmQ3++YVmy+gIyEm4qPoha
 7xYJ+t6RYVzw91Bcl4GDcjYLZp1RtdebwXDm8Gvkw5zAvKtU+Yy4kyzbzARtqCKD/8yTabcwqMe
 rHodvBTMMfFFHne8sVfSgvhlRP56q+VmUSWp3xJBo2wnUFewY2X09YsPzR8EcPMLqdRdyL+N44I
 xae4jgBEUHFlueZbM8tqhh8INlhK3isYJYGsslc5uuGlwHGlK3WAInZJDUokink9yfCrTWcPvmD
 njUClyQraISF4XG/iOna4+9FuCdLw07qCKq6gv3HOGE8X70EZHcPllfy8UcYlk1fjHnMdJw8w/t
 5icbJUWtW/4slKhlNNW4VB18tnsP9DS0hprNm6f53jbncyVxTSJ//t24WXacA6sbBR119f73QmX
 pPX//ggMKyh/Q1/kV9ni/LW4GaTiyE2/R7fDVPezGveDIeXCQ/YK7ek8gpwyUn9KHM2g==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add support for the SD/eMMC Host Controller found in SpacemiT K1 SoC,
The controller supports data transmission of MMC, SDIO, and SD protocol.

The SD/eMMC Host Controller has the following features:
- MMC/eMMC 5.1 specification compliant
- Supports PIO mode and SDMA mode data transfer
- Supports ADMA1 and ADMA 2 (64-bit addressing) data transfer
- Supports 1-bit/4-bit SD memory and SDIO
- Supports 1-bit/8-bit MMC and CE-ATA cards
- SPI mode supported for eMMC card
Full docs can be found at SpacemiT's developer web, chapter 10.4 SD/eMMC [1]

In this patch series, only MMC part has been implemented and tested.
This driver also requires clock support which now is ready for v6.16 [2].

There is a WIP branch at SpacemiT's repo for people who interested [3].

Link: https://developer.spacemit.com/documentation?token=WZNvwFDkYinYx0k9jzPcMK5WnIe [1]
Link: https://lore.kernel.org/all/20250430012941-GYA288294@gentoo [2]
Link: https://github.com/spacemit-com/linux/tree/k1/wip-sdhci [3]

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Changes in v2:
- rebase to v6.15-rc1
- collect review tags
- drop RFC as clock driver is ready
- drop spacemit_sdhci_remove(), favor sdhci_pltfm_remove()
- update register definition using GENMASK(), FIELD_PREP()
- Link to v1: https://lore.kernel.org/r/20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org

---
Yixun Lan (2):
      dt-bindings: mmc: spacemit,sdhci: add support for K1 SoC
      mmc: sdhci-of-k1: add support for SpacemiT K1 SoC

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  53 ++++
 drivers/mmc/host/Kconfig                           |  14 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-of-k1.c                     | 306 +++++++++++++++++++++
 4 files changed, 374 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250212-20-k1-sdhci-76a4901030db

Best regards,
-- 
Yixun Lan

