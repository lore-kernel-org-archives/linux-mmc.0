Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B842135D0;
	Thu, 13 Feb 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444357; cv=none; b=K92Qz2HKDHDxGrrnePYUB559zODr30M+1nrbQfIpWroEb3bPug0R9Fwtuy4s+ZpNVrc9jX4gjrsKM6+STjKcS2u97lfX4OhN7gVUk9S8GXlrUEmwIQqAqjChd4bF5aBXdxZrRSrRTGZF82XESU+8oTprI4eu0wUlTtPMpF9eEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444357; c=relaxed/simple;
	bh=KUjOvF9P/vuDVqGQh2F5bKA4gVmwZUblVLO61U/+eqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FNmVDY2dT05lS9X6Wy+lfHEXMLm1EPwlspHxRwnxfvTgVUEDQWgK2+2kl5bjji13CqFDwrjU2XbRty9yHHQRvHVCXNSp40vOLxEdhKAHNLI1oFTWSAcFksY7QsuBarSk700MyteXQapkLVAwH8SscCsU/KI50tLHTNS241/su8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [180.172.76.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 49D01343097;
	Thu, 13 Feb 2025 10:59:11 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH RFC 0/2] soc: spacemit: add sdhci support to K1 SoC
Date: Thu, 13 Feb 2025 18:58:23 +0800
Message-Id: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/QrWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MjXSMD3WxD3eKUjORMXXOzRBNLA0MDY4OUJCWgjoKi1LTMCrBp0Up
 Bbs5KsbW1ALI1TyViAAAA
X-Change-ID: 20250212-20-k1-sdhci-76a4901030db
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=KUjOvF9P/vuDVqGQh2F5bKA4gVmwZUblVLO61U/+eqQ=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBnrdB1HCsrUFt90NBRwSRSbpxoBCyz7HLpYIHgp
 ywEzaSCdv+JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZ63QdV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277aGGD/98joLcC6mB9wphN+
 FXiPW/KOgj6Tf00aKYHoPjaaDB2/lOISt9IA++IxeyP5ICmLODeULPpdN6a/T0mT23+w5M0opUa
 /WM2YjeovA+SdeUBRyTytBrmZETt7HM6N2vH64FWHEj8hlraPpa1QMSBoJRMBYNtcHJe0WO8cgU
 2kY3dwBhceVUqYS9Ppo+Jg8oV3v0LL/4kw+s/1l6VYibVjM2Lbk6sQzlKGbltnBYVdfvZ1kkMm9
 0KTtpoLTyjBsrrxS5z43VViJ+8Kzqnq4re0N7NM3T6Auf9KqlmEJbTVfIQrRQy8fhzgd62lq0oB
 3FKdCQfV6NIKbwkC1vX6VeykjrkmsOpoMaIQ2XOO0fp2OUdyuQO+/l6wf9sksDRjUmYc7S1Cehn
 5IcTl5lfz+i7NUbQVC5+LeF/JG3MjkAl6g8MJlzDFQ+dIxiRP2rhBRdNNOOpNGt3MCNPKWiJXiW
 P37fHYyzlT1R4o+xOnXr7ZnCuiKH88eHbY/XNzQBccKa6c3cCf8+la0Jv7TM8OoSsGM2iwf0c9f
 AIr/sMpJS9qk7VUlWveL7K1lHF87Lnkg3doko3WUibdHgbSmgvFynz6ebVGbvQlDIZpyBXdMlwK
 bkiPT4r4tUtdBEmBnA/T6GdHH4AEJgQgiQ64vBX9UehvW+W0JzkN9Wvh35mNjo3Hpcgw==
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
This driver also requires clock support which currently isn't in mainline [2].

There is a WIP branch at SpacemiT's repo for people who interested [3].

I've marked this patch series as RFC, due to incomplete clock and SD/SDIO support.

Link: https://developer.spacemit.com/documentation?token=WZNvwFDkYinYx0k9jzPcMK5WnIe [1]
Link: https://lore.kernel.org/all/20250103215636.19967-2-heylenay@4d2.org/ [2]
Link: https://github.com/spacemit-com/linux/tree/k1/wip-sdhci [3]

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Yixun Lan (2):
      dt-bindings: mmc: spacemit,sdhci: add support for K1 SoC
      mmc: sdhci-of-k1: add support for SpacemiT K1 SoC

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  53 ++++
 drivers/mmc/host/Kconfig                           |  14 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-of-k1.c                     | 320 +++++++++++++++++++++
 4 files changed, 388 insertions(+)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250212-20-k1-sdhci-76a4901030db

Best regards,
-- 
Yixun Lan

