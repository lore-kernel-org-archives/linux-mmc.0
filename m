Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D222A4E1
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953537; cv=none; b=aFQDi7aPK7Bd0btkjOBskd522q9I2ZZSGrgXu3kQQi3XbNTTtmRVHgdUKjo8/BH0BhqHvZ/9jxKFRalvwF+XFVORi2cWaOM7ErDExzD1GTkyOyrMbVvQG9dvMdmPoLug4glS6G92lLYecQjiA4Fdq3804irQYZqvKcVb0lTGWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953537; c=relaxed/simple;
	bh=88Q3XL8xvdtCjuuVOW61oEaVvabfZpKQTx9AkL1hbM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EL70uAkSh5iUsMA9W5hdCNQygxQcwTZMBtNIrFKYAXFLlSHuYvLy8c5m6OHckhmSSxJXVAMW6JKWFYinlTUzJk7K0LwFo22jQrPI3W0/HdKr9HBwXpBksC1h/9gD/rb9ki3MkjEHMoK5wvOT6j1m4PvwqEQUhnJrTkYyQ3SR+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8DxC3K66T5oKzUKAQ--.32986S3;
	Tue, 03 Jun 2025 20:25:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcW36T5ovA0HAQ--.22246S2;
	Tue, 03 Jun 2025 20:25:29 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 00/36] mmc: Cleanup mmc_alloc_host() usage
Date: Tue,  3 Jun 2025 20:25:12 +0800
Message-ID: <cover.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLcW36T5ovA0HAQ--.22246S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXry5Cw45uF1rAr17ZF15WrX_yoWrKFyDpF
	4agryavr4DJr43Wry3Gwn0ka4rXw18WayIgF1Iqw1rZFyjkF1UGrs7uFyIqF98uFy8JFZ3
	XFs8Gw1UuF1rGacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jepB-UUUUU=

Hi all:

Since the devm_mmc_alloc_host() helper was already available, I tried to
start cleaning up the use of mmc_alloc_host().

To make it easier to review the patchset, I decided to split it into two parts.
As the first part, this patchset contains cleanup for drivers other than sdhci.

Of course, the sdhci part I have ready in my repository.

Thanks.

-----
V3:
- Collect Reviewed-by and Acked-by tags.
Patch-18
  - Fix build warning by lkp:
	https://lore.kernel.org/all/202505230421.P12fqPfB-lkp@intel.com/

Link to V2:
https://lore.kernel.org/all/cover.1747877175.git.zhoubinbin@loongson.cn/

V2:
- Collect Reviewed-by and Acked-by tags.
Patch-24
  - Correct subject title: ish_mmicf -> sh_mmicf.
Patch-34
  - Fix cheap build error.

Link to V1:
https://lore.kernel.org/all/cover.1747739323.git.zhoubinbin@loongson.cn/

Binbin Zhou (36):
  mmc: alcor: Use devm_mmc_alloc_host() helper
  mmc: atmel: Use devm_mmc_alloc_host() helper
  mmc: au1xmmc: Use devm_mmc_alloc_host() helper
  mmc: bcm2835: Use devm_mmc_alloc_host() helper
  mmc: cavium: Use devm_mmc_alloc_host() helper
  mmc: cb710: Use devm_mmc_alloc_host() helper
  mmc: davinci_mmc: Use devm_mmc_alloc_host() helper
  mmc: dw_mmc: Use devm_mmc_alloc_host() helper
  mmc: jz4740: Use devm_mmc_alloc_host() helper
  mmc: litex_mmc: Use devm_mmc_alloc_host() helper
  mmc: meson-mx-sdhc: Use devm_mmc_alloc_host() helper
  mmc: mmci: Use devm_mmc_alloc_host() helper
  mmc: moxart-mmc: Use devm_mmc_alloc_host() helper
  mmc: mvsdio: Use devm_mmc_alloc_host() helper
  mmc: mxcmmc: Use devm_mmc_alloc_host() helper
  mmc: mxs-mmc: Use devm_mmc_alloc_host() helper
  mmc: omap: Use devm_mmc_alloc_host() helper
  mmc: omap_hsmmc: Use devm_mmc_alloc_host() helper
  mmc: owl-mmc: Use devm_mmc_alloc_host() helper
  mmc: pxamci: Use devm_mmc_alloc_host() helper
  mmc: rtsx_pci: Use devm_mmc_alloc_host() helper
  mmc: rtsx_usb_sdmmc: Use devm_mmc_alloc_host() helper
  mmc: sdricoh_cs: Use devm_mmc_alloc_host() helper
  mmc: sh_mmicf: Use devm_mmc_alloc_host() helper
  mmc: tifm_sd: Use devm_mmc_alloc_host() helper
  mmc: toshsd: Use devm_mmc_alloc_host() helper
  mmc: usdhi6ro10: Use devm_mmc_alloc_host() helper
  mmc: ushc: Use devm_mmc_alloc_host() helper
  mmc: via-sdmmc: Use devm_mmc_alloc_host() helper
  mmc: vub300: Use devm_mmc_alloc_host() helper
  mmc: wbsd: Use devm_mmc_alloc_host() helper
  mmc: wmt-sdmmc: Use devm_mmc_alloc_host() helper
  mmc: tmio: Use devm_mmc_alloc_host() helper
  mmc: sunxi: Use devm_mmc_alloc_host() helper
  mmc: mmc_spi: Use devm_mmc_alloc_host() helper
  mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper

 drivers/mmc/host/alcor.c             | 20 ++++---------
 drivers/mmc/host/atmel-mci.c         |  7 ++---
 drivers/mmc/host/au1xmmc.c           | 14 +++-------
 drivers/mmc/host/bcm2835.c           |  5 +---
 drivers/mmc/host/cavium.c            | 10 ++-----
 drivers/mmc/host/cb710-mmc.c         |  5 +---
 drivers/mmc/host/davinci_mmc.c       | 22 +++++----------
 drivers/mmc/host/dw_mmc.c            | 15 ++++------
 drivers/mmc/host/jz4740_mmc.c        | 40 +++++++++-----------------
 drivers/mmc/host/litex_mmc.c         | 12 +-------
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 13 +--------
 drivers/mmc/host/meson-mx-sdio.c     | 20 ++++++-------
 drivers/mmc/host/mmc_spi.c           |  4 +--
 drivers/mmc/host/mmci.c              | 31 ++++++++------------
 drivers/mmc/host/moxart-mmc.c        | 40 ++++++++++----------------
 drivers/mmc/host/mvsdio.c            | 24 +++++-----------
 drivers/mmc/host/mxcmmc.c            | 31 +++++++-------------
 drivers/mmc/host/mxs-mmc.c           | 31 ++++++++------------
 drivers/mmc/host/omap.c              | 25 ++++++-----------
 drivers/mmc/host/omap_hsmmc.c        | 17 ++++-------
 drivers/mmc/host/owl-mmc.c           | 37 +++++++++---------------
 drivers/mmc/host/pxamci.c            | 42 ++++++++++------------------
 drivers/mmc/host/renesas_sdhi_core.c |  6 +---
 drivers/mmc/host/rtsx_pci_sdmmc.c    |  5 +---
 drivers/mmc/host/rtsx_usb_sdmmc.c    |  4 +--
 drivers/mmc/host/sdricoh_cs.c        | 10 ++-----
 drivers/mmc/host/sh_mmcif.c          | 17 ++++-------
 drivers/mmc/host/sunxi-mmc.c         | 22 ++++++---------
 drivers/mmc/host/tifm_sd.c           |  7 +----
 drivers/mmc/host/tmio_mmc.h          |  1 -
 drivers/mmc/host/tmio_mmc_core.c     | 18 ++----------
 drivers/mmc/host/toshsd.c            |  4 +--
 drivers/mmc/host/uniphier-sd.c       |  8 ++----
 drivers/mmc/host/usdhi6rol0.c        | 30 +++++++-------------
 drivers/mmc/host/ushc.c              |  4 +--
 drivers/mmc/host/via-sdmmc.c         |  7 ++---
 drivers/mmc/host/vub300.c            | 16 ++++-------
 drivers/mmc/host/wbsd.c              |  4 +--
 drivers/mmc/host/wmt-sdmmc.c         |  8 ++----
 39 files changed, 195 insertions(+), 441 deletions(-)


base-commit: d2c6acff6386f43ed307822454b970c831c48f1b
-- 
2.47.1

