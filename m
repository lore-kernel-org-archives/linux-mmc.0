Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32029293E;
	Fri,  9 May 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796965; cv=none; b=pIqZQIzeDt/cwaA6Ea5EKpr4ocGwAJU7dflxpaPI/BqXwzCH/4zjcX0YxsK067rlxhp7SOtCszxk79hRiBOQFM8QFDScU5o5PPPtiGKJM7vQgQ2s7FMCw0D1mnRNnOZ69EAlDTM1uFcadPwcENTMbq0jXTRrPCy+bzRw3bLBGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796965; c=relaxed/simple;
	bh=9BDdQL1tGpHM9JlvlVQB77N/+lcoo3YVzx3Z06f/FTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VIDLLiSvWP+vQ5L0qXP7w9YZ38FsmA3xeRZXSgWCYYPwXuCzN5xUBeOFJOixbRTCjS3v4d9DKcTvYFdrqigUG7ASMu80Zuad6pFBWla8ISeRBK4KPaioMDMKhp6NpYL294+HQUYOBebyiSW9QzjXHTKOKw6m/f3A2/XK6FBK3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.147.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 59FB833BE9F;
	Fri, 09 May 2025 13:22:36 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 0/2] soc: spacemit: add sdhci support to K1 SoC
Date: Fri, 09 May 2025 21:22:10 +0800
Message-Id: <20250509-20-k1-sdhci-v3-0-526c35feaa20@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIBHmgC/1WPzWrDMBAGX8XoXJXdla1IOfU9Sg76WduixGolx
 7SEvHuVhFJ8nIUZvr2KyiVxFcfuKgpvqaa8NFAvnQizWyaWKTYWBDQAIUkC+YGyxjkkedCut4C
 gIHrRjM/CY/p+1N5PjedU11x+HvEN79e/jtp1NpQgceyVJmcNhPg28bLm/JrLJO6hjf7lAXAvU
 5MVHwCG0TFZv5Nvz1mFvy7tt/W5TXhXWYZ8Pqf12IEbadSe0fdkUJnBazTBG+2i7TVHjmCsC6b
 Fbr/eqqyBMAEAAA==
X-Change-ID: 20250212-20-k1-sdhci-76a4901030db
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Alex Elder <elder@riscstar.com>, Inochi Amaoto <inochiama@gmail.com>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=9BDdQL1tGpHM9JlvlVQB77N/+lcoo3YVzx3Z06f/FTo=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoHgGS3G7h+9dQnZZHDZ8AhzN+dgX15wZmLlsnQ
 YgmuKA77tOJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaB4Bkl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277Yo+EACfSRLhS9JBZskZ/Y
 MMJgqlU0KUEOqQ0lE+hCg10IanG8UTGxMPaOGqa0syLNn1/8tFMAWsIloyFjaijQUlHOzdgDEzY
 spwXK1mO4Np3H/lQTiT5XbYKeov1nnx4L2OfJ8dBEgU/moFOq85uqH6ppZ2Islh7bfQETYoBU0M
 wn0/gNpx1cbWjQ9qwx5apuZXMvDX4B0DAB6f0n2AAffq9mZ3et8ZJolTxeu86ibRVDeFgKJzw8O
 1rnq5/IU12Z3ycS9rG39l3mvFiK/QgC5p+EABRbGx0RDqoonKt2sNeqYAeAaSV90afG0J48tq2e
 5KJYQQMZ+T5m5jI+r4JVwP/4WBjfJ1MJbt1CWWXlPjsNPTRc774SF1D5Mr9IiZrw9E47+yysSOB
 KInxNYrGzlnAZHX1YUx43cwvTPMT1TDV/Jb1XGLly5Rfe7eEQjf+a9bosuc0FjyMEinR40DVf98
 KXzRnjtzxO1qwtE6+3e3/AFDxDcThB53pZNtK9cftIzbeMpstcl/skUCyvFUZQe7sJfxfmDIuP1
 2BdSU0gMMBWAhzU4yf6auKC1MwLN05zgWg89AkmrWHfb48NurB6f+2ORDUM0MQgkbH3LgpQxWFQ
 rrYVfT6wosGciNIicpvHDPd/COQ1hfQj4urCFPO3oWY0uD+XVEHnS5iQ1MQKNcWRM+qQ==
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
Changes in v3:
- add a note to register clr/set helper() 
- drop unused struct platform_device *pdev
- drop of_match_ptr()
- Link to v2: https://lore.kernel.org/r/20250501-20-k1-sdhci-v2-0-3e7005fae29b@gentoo.org

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
 drivers/mmc/host/sdhci-of-k1.c                     | 304 +++++++++++++++++++++
 4 files changed, 372 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250212-20-k1-sdhci-76a4901030db

Best regards,
-- 
Yixun Lan

