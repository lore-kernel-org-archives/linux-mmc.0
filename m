Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24881624C5
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239550; cv=none; b=d1w5smitaDt6a2OxRYGFxW2jt1e5FuFBTyEOZRQTqamWu/1T9EPIHcVoW/hl8giMq1xJA5b3GmvIeFu95mYJt7Tq9wVOvpTnMqfR6qpuIvnOoep6ldQt4u1hb63qJR3ZI+3mWdNogNBBLHPgR/pTgKlIIy+bnnoMeLj4ZuEq9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239550; c=relaxed/simple;
	bh=rcQ0NpORCaM2RDDXj97wNirHqNxjdQP06vJy5T8fs1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pijDD71n1VCVMy00R9aHQmuB7M6pqywb0J2J5c6N7lxqmsQJ+dCMwAeusaB03KIOFaSCbNXZzMCjl4bjj4/Pk5b0v2fEJIZoXZk01zE2QBAB9YRVoGsIlSWyZpJxzhdaJgBeO+3NNMltpnR+ZbnBk5D98054RSMY+CGhovw7n4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxzOK4BDRoEoX8AA--.13789S3;
	Mon, 26 May 2025 14:05:44 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxb8e1BDRo2APyAA--.30366S2;
	Mon, 26 May 2025 14:05:42 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 00/34] mmc: Cleanup sdhci_pltfm_free()/sdhci_free_host() usage
Date: Mon, 26 May 2025 14:05:29 +0800
Message-ID: <cover.1747792905.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxb8e1BDRo2APyAA--.30366S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1ftryxuFyfWF1Uuw4rWFX_yoWrZw1xpa
	ySqrWa9r43Cr95WrZxJw1UZw15Xr1rWa9Fgry5tw4FqrW3Ca4UKrsrAFy0qryDX3yxJF48
	t3Z8Jw1UGr95K3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Hi all:

After the first part of the cleanup[1], there are sdhci related
drivers that need further cleanup.

This patchset is the second part of the cleanup series, and since sdhci has
sdhci_alloc_host() as the general interface, our main job is to clean up
sdhci_pltfm_free() and sdhci_free_host().

[1]:https://lore.kernel.org/all/cover.1747877175.git.zhoubinbin@loongson.cn/

Thanks.

Binbin Zhou (34):
  mmc: sdhci: Use devm_mmc_alloc_host() helper
  mmc: sdhci-acpi: Drop the use of sdhci_free_host()
  mmc: sdhci-milbeaut: Drop the use of sdhci_free_host()
  mmc: sdhci-pci: Drop the use of sdhci_free_host()
  mmc: sdhci-s3c: Drop the use of sdhci_free_host()
  mmc: sdhci-spear: Drop the use of sdhci_free_host()
  mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-bcm-kona: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-brcmstb: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-cadence: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-dove: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-esdhc-imx: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-esdhc-mcf: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-iproc: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-msm: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-npcm: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-arasan: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-aspeed: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-at91: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-esdhc: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-k1: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-ma35d1: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-of-sparx5: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-omap: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-pic32: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-pxav2: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-pxav3: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-sprd: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-st: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-tegra: Drop the use of sdhci_pltfm_free()
  mmc: sdhci-xenon: Drop the use of sdhci_pltfm_free()
  mmc: sdhci_am654: Drop the use of sdhci_pltfm_free()
  mmc: sdhci_f_sdh30: Drop the use of sdhci_pltfm_free()

 drivers/mmc/host/sdhci-acpi.c       |  3 ---
 drivers/mmc/host/sdhci-bcm-kona.c   |  2 --
 drivers/mmc/host/sdhci-brcmstb.c    |  1 -
 drivers/mmc/host/sdhci-cadence.c    | 21 ++++++------------
 drivers/mmc/host/sdhci-dove.c       | 12 ++---------
 drivers/mmc/host/sdhci-esdhc-imx.c  |  3 ---
 drivers/mmc/host/sdhci-esdhc-mcf.c  | 25 ++++++----------------
 drivers/mmc/host/sdhci-iproc.c      | 18 ++++------------
 drivers/mmc/host/sdhci-milbeaut.c   | 19 ++++++-----------
 drivers/mmc/host/sdhci-msm.c        | 11 ++++------
 drivers/mmc/host/sdhci-npcm.c       | 15 +++----------
 drivers/mmc/host/sdhci-of-arasan.c  | 26 +++++++----------------
 drivers/mmc/host/sdhci-of-aspeed.c  | 10 ++-------
 drivers/mmc/host/sdhci-of-at91.c    | 23 +++++++-------------
 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++-------
 drivers/mmc/host/sdhci-of-esdhc.c   | 11 ++--------
 drivers/mmc/host/sdhci-of-k1.c      | 15 ++++---------
 drivers/mmc/host/sdhci-of-ma35d1.c  | 23 +++++++-------------
 drivers/mmc/host/sdhci-of-sparx5.c  | 24 +++++++--------------
 drivers/mmc/host/sdhci-omap.c       | 21 ++++++------------
 drivers/mmc/host/sdhci-pci-core.c   |  9 ++------
 drivers/mmc/host/sdhci-pic32.c      |  9 +++-----
 drivers/mmc/host/sdhci-pltfm.c      | 16 +-------------
 drivers/mmc/host/sdhci-pltfm.h      |  1 -
 drivers/mmc/host/sdhci-pxav2.c      | 26 ++++++-----------------
 drivers/mmc/host/sdhci-pxav3.c      |  7 +-----
 drivers/mmc/host/sdhci-s3c.c        | 16 ++++----------
 drivers/mmc/host/sdhci-spear.c      | 11 ++++------
 drivers/mmc/host/sdhci-sprd.c       | 33 +++++++++--------------------
 drivers/mmc/host/sdhci-st.c         |  6 ++----
 drivers/mmc/host/sdhci-tegra.c      |  9 +++-----
 drivers/mmc/host/sdhci-xenon.c      |  9 ++------
 drivers/mmc/host/sdhci.c            |  9 +-------
 drivers/mmc/host/sdhci.h            |  1 -
 drivers/mmc/host/sdhci_am654.c      | 20 ++++++-----------
 drivers/mmc/host/sdhci_f_sdh30.c    | 13 ++++--------
 36 files changed, 133 insertions(+), 359 deletions(-)


base-commit: aee11c5ac9a0949e1af7534e30dda4ffa122eb97
-- 
2.47.1

