Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94D2B2D7;
	Sat,  7 Jun 2025 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749281539; cv=none; b=g98FmOaGq5CEjQZbNwVgxpXiDz/Go6PKmDTlmRzlXb49JcDQdS1sC0RS31u7ZUW3vttJDAe0uQGWx+4SjUpohcQWt0F4TrlSP6FBiSQu1rPI2eXGyF+caC2Xp/h9wQVHscPAlkUoWlbn3bngBYfdATwTMZrpqGGugQiek2moHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749281539; c=relaxed/simple;
	bh=wRDzN9iQ6/0S6lk+uKXPmqA5/+hY8ARSmqr3+8dxM2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/2LCsy5FbDKLS2nix4UJ53JFeqtWwWfTEAy+DS3gDLu4dkgVpT8cLTFIuKynFjFT5kBzRQ4fDzXEByY0BprQzFXkyDKFpfkAPdPz0s2iofhoeRisnGtHqHEt2JxsXmoU/6GXzBFecL2W0Khqj4uawtQjOfhDEB619XeRJhSsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxOGr86kNoDRUPAQ--.43912S3;
	Sat, 07 Jun 2025 15:32:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDxu8Tw6kNo4JwOAQ--.43155S2;
	Sat, 07 Jun 2025 15:32:06 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	openbmc@lists.ozlabs.org,
	Michal Simek <michal.simek@amd.com>,
	Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org,
	Aubin Constans <aubin.constans@microchip.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Yixun Lan <dlan@gentoo.org>,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Hu Ziji <huziji@marvell.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 00/35] mmc: Cleanup sdhci_pltfm_free()/sdhci_free_host() usage
Date: Sat,  7 Jun 2025 15:31:50 +0800
Message-ID: <cover.1749127796.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8Tw6kNo4JwOAQ--.43155S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw4Utr1UGF4DGFW7Gr17Jwc_yoW7Ar1rpa
	ySqrWa9r43Cr95WrZxJw1UZw15Xr4rX39Fgry5tw4FqFW3Ca4UKrsrAFy0qryDZ3yxJr48
	t3WDJw1UGr95K3XCm3ZEXasCq-sJn29KB7ZKAUJUUUjk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_GFv_Wryle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUqPrcDUUUU

Hi all:

After the first part of the cleanup[1], there are sdhci related
drivers that need further cleanup.

This patchset is the second part of the cleanup series, and since sdhci has
sdhci_alloc_host() as the general interface, our main job is to clean up
sdhci_pltfm_free() and sdhci_free_host().

[1]: https://lore.kernel.org/all/cover.1748933789.git.zhoubinbin@loongson.cn/

Thanks.

-----
V3:
- Collect Reviewed-by and Acked-by tags.
Patch-19:
  - Use dev_err_probe() to cleanup the code.
Patch-32:
  - Fix build warning by lkp:
	https://lore.kernel.org/all/202505300815.tjQRQD6z-lkp@intel.com/

Link to V2:
https://lore.kernel.org/all/cover.1748515612.git.zhoubinbin@loongson.cn/

V2:
- Collect Reviewed-by and Acked-by tags.

Patch-01:
 - Set sdhci_free_host() to empty, rather than dropping it.
Patch-07:
 - Set sdhci_pltfm_free() to empty, rather than dropping it.
Patch-22:
 - As requested by Yixun, retain the goto scheme.
Patch-35:
 - New patch;
 - Since all calls have been cleaned up, sdhci_pltfm_free()/sdhci_free_host()
   are now dropped directly;

Link to V1:
https://lore.kernel.org/all/cover.1747792905.git.zhoubinbin@loongson.cn/

Binbin Zhou (35):
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
  mmc: sdhci: Drop sdhci_free_host()/sdhci_pltfm_free() interface

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
 drivers/mmc/host/sdhci-of-at91.c    | 30 ++++++++++----------------
 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++-------
 drivers/mmc/host/sdhci-of-esdhc.c   | 11 ++--------
 drivers/mmc/host/sdhci-of-k1.c      |  1 -
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
 drivers/mmc/host/sdhci-xenon.c      | 15 +++++--------
 drivers/mmc/host/sdhci.c            |  9 +-------
 drivers/mmc/host/sdhci.h            |  1 -
 drivers/mmc/host/sdhci_am654.c      | 20 ++++++-----------
 drivers/mmc/host/sdhci_f_sdh30.c    | 13 ++++--------
 36 files changed, 135 insertions(+), 356 deletions(-)


base-commit: d2c6acff6386f43ed307822454b970c831c48f1b
-- 
2.47.1

