Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806041;
	b=S3zecLV9GYza8T53Nw6KhkLTB9MROecMH9K7Q6NAvJrja4zpZJx+P+MeprD+150CPj0U
	 wbgCRyo+ISHxxkpO6sjeTTVR4/4TPv9CcdOquG4pzRbeYyDkYjAjmRWB0f3ud8jUzancW
	 fsyIn4/Rn0f5ihJlmEj67Osjvj+ShtDwgSwS9EnSgFgZSpgtcxNc7jO4tXZLE0LCbD1uZ
	 D/pu1ALks0fvHA5vVuwz7GWl8CE64IL8bwYtcrWhJQVk2bUnDDdNAyxnvlkWPiWRIeGlI
	 jUygza0hR87r7igx715TOL4j6oYdMbc8JZRc8WX61BuRWDSTzDU1UDtHsmomM+odDkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=iq05/Yj1rzuvCwAU0PCj1CRnJwTNnmq7BvvVMNO0EdU=;
	b=2knUvRZLLQOgykox/sd+ETYZN87PLCjSt06KvxwJtJyy+lbSAId/bqkrl6QZ/Z3Iq0fb
	 aC6kw0iEOmROPT1DDaRTpHIoWo4CMGDyozK7vk43PJaP7yi9udyXr0fA0eGH322lslMxy
	 iiASwDtCDx0QsqPAGxwJ6AeDILPmRT6KFj9qULNUZzSKkYe4ls+PFbyG/Yjz8HXhMApAH
	 YE+hHOnd4FKm844/TGNcDW7WRxmNHt+AI2L4XybAx5L3SKLjxGqzBb7BMYIzOBZiHsGim
	 GFMWJOVYHcyA6021rnUOnjeurALAxxr6p/WIHf1PbfNNwXqSucyXZABX+0CBGEimzOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=CBHyxZSC;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56822606A32D
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 15:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56822606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=CBHyxZSC
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4194E240103
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 16:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793806037;
	bh=iq05/Yj1rzuvCwAU0PCj1CRnJwTNnmq7BvvVMNO0EdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=CBHyxZSCLmVhF+IEET0yBhJUYCg99wYQhD8qx1LZvJALwMUNYt6kC8+b3K74Q6eyH
	 nsV4WM/QwUAygsa/AlNQZ6I+0kHmDyBum/6t/ScjaKfZytqJ6bpzB7u0V/U9TIa2br
	 22WIZlfPGmRBJ79eTeoCgkahkJmND2m7D+FtoWLtY32ktjELXcJX+w4hvoGgEMiOMu
	 imc4hOUHQv+AiDLj2w3OZ7WQwD5ZiLaCdtnDJ800jgw6lFZseQCVhzn+efK9kTyvic
	 TCA6XPSKpFjZUcCRwCXCxxoCPT+M/OUr27ffF8X/7y7p7YDZl9fYdLP/Mk2BbakogT
	 rYcPfSh42D68g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKTnv22nLz9rxM;
	Wed,  4 Nov 2026 16:27:15 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] mmc: mmci: stm32: silent data corruption and HS200 fixes
Date: Wed, 04 Nov 2026 15:27:16 +0000
Message-ID: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eMMC of the STM32MP257F-DK in HS200 returned stale data and lost
writes without any error. Patch 1 makes data CRC errors visible to the
core again. Patches 2 and 3 are the fixes of the ST downstream kernel
for the causes seen on the DK, as Christophe pointed out. Patches 4 and
5 move the eMMC of the DK back to the sdmmc2 pins_a groups and remove
the pins_b groups I added for it in 7.4: the corruption came from the
delay block, not from the slew rate, and the slower pins avoid
overshoots on the SDMMC2 clock. Patches 1-3 are for the mmc tree, 4 and
5 for the STM32 device tree, patch 4 needs patch 3.

Tested on the STM32MP257F-DK with a v7.3-rc6 based kernel with the same
changes, each run writing 832 MiB to the eMMC and reading it back:

- SDMMC2 kernel clock 200 MHz, HS200 at 100 MHz as in mainline: without
  patch 3 the writes failed with I/O errors in all 9 runs (sdmmc2 pins_a
  or pins_b, with or without NEGEDGE), with it all 6 runs were correct
  (pins_a and pins_b).
- SDMMC2 kernel clock 150 MHz, HS200 at 150 MHz with the delay block:
  all 6 runs correct (pins_a and pins_b), the tuning picked the same
  phase in all 10 rebinds on each pin group.

Build tested on v7.4-rc1 (arm64 defconfig, W=1). Not tested on
STM32MP1x.

Changes in v2:
- Drop "mmc: mmci: stm32: do not use NEGEDGE in HS200 mode". NEGEDGE
  has no effect with CLKDIV = 0 and is valid with a divider, I misread
  RM0457 (Christophe). The writes at 100 MHz fail because of the delay
  block, not NEGEDGE.
- Replace "mmc: mmci: stm32: lock the STM32MP25 delay block again before
  tuning" with the same change from the ST downstream kernel, "mmc: mmci:
  stm32: release the delay block before enabling it" (Christophe).
- Add "mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25
  SoC" from the ST downstream kernel (Christophe), with dlyb checked
  before reading min_freq from it.
- Add "arm64: dts: st: use sdmmc2 pins_a on stm32mp257f-dk" and
  "arm64: dts: st: remove sdmmc2 pins_b from stm32mp25" (Christophe).
- Rebase on v7.4-rc1.
- Link to v1: https://lore.kernel.org/r/20261031120700.42576-1-mateusz.nowicki@posteo.net

Christophe Kerello (2):
  mmc: mmci: stm32: release the delay block before enabling it
  mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25 SoC

Mateusz Nowicki (3):
  mmc: mmci: do not count a data CRC error as a complete transfer
  arm64: dts: st: use sdmmc2 pins_a on stm32mp257f-dk
  arm64: dts: st: remove sdmmc2 pins_b from stm32mp25

 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 58 -------------------
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts     |  4 +-
 drivers/mmc/host/mmci.c                       |  5 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c           | 28 +++++++--
 4 files changed, 27 insertions(+), 68 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

