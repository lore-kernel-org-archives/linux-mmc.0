Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8C221D9E
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897175; cv=none; b=DoIe+qBTOccWIBeXbcgyHYPuYA49Gp/18z0DfZTg6AczNTQyTY2vcUZN2F+vC51w1gnUDCi8mHzsL8OtdyzRhlUw8bBLi3pqQSJ5HtB5mBB13g9QaKgjpe1nslkouWSLu36dZk89NVzyJe1xto9O9BS9OEDn+yx0YqVzqsO/APY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897175; c=relaxed/simple;
	bh=zoaP5k5VzqNtMBVMhSFuu7QvPh18F19GRbZ9nZROKd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZ/tdUJYIKnNadT/zbC0GEO0WQ/JLv0nzLltW/zjPq+hw0e0R/qDmgVHExbcBoIuHbPoMbzbY/k2flSU8Xm8kYkDfuYVRDoxO5vy0M7zWMIDxj6DWfvFzvX1v/03+xNSIZdzw4fB0dZBWdqIq9qyvcWeZFC0a4yul6UacTG64Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxWXFRyy5oxyH2AA--.4958S3;
	Thu, 22 May 2025 14:59:29 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3MROyy5otXHnAA--.2109S2;
	Thu, 22 May 2025 14:59:27 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 00/36] mmc: Cleanup mmc_alloc_host() usage
Date: Thu, 22 May 2025 14:59:16 +0800
Message-ID: <cover.1747877175.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3MROyy5otXHnAA--.2109S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4xCw1fur1fArW7ury5WrX_yoW7Jr4fpF
	4agryavr4DJrW3Wry3Gwn0kFyrZw18WayIgF1Iqw1rZFyjkF1UGrs7uFyIqF98CFy8JFZ3
	XF45Gw1UuF1rGacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==

Hi all:

First of all, I'm very sorry for the compilation failure issue due to my
cheap mistake in v1 patchset.

The patch series was tested by using lkp and cross compiling with different
architectures (arm/mips/x86_64 etc architectures) and enabling COMPILE_TEST=y
to ensure that each driver was compiled and tested.

Since the devm_mmc_alloc_host() helper was already available, I tried to
start cleaning up the use of mmc_alloc_host().

To make it easier to review the patchset, I decided to split it into two parts.
As the first part, this patchset contains cleanup for drivers other than sdhci.

Of course, the sdhci part I have ready in my repository.

Thanks.

-----
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
 drivers/mmc/host/omap_hsmmc.c        | 18 ++++--------
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
 39 files changed, 195 insertions(+), 442 deletions(-)


base-commit: 61bd8e76021e779f7ba3c761919b533fb3f6f584
-- 
2.47.1

