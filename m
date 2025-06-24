Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062802376E1;
	Tue, 24 Jun 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766314; cv=none; b=kymxA8UNCP8I3bMSMjC/d7Mk+iXAsFrDTOD9hHeLll/SlUkGn3Q7a18BhZY6GmGz6IVpFK9CgLV37RkkA0DUhf/eeOgROzinUT/kKCaEgtf99tMNSW2UVIm0ofhwxBRwMwskEEVyL7Gm/CC30+4NXrqAjp7Tq8eN6kPq/hYtVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766314; c=relaxed/simple;
	bh=rGp24HhF+1pOwu85qNC5bnROKkUUy/fG4sK7Cs5MWX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFshVBhy4Vb3LTlsbHqNLcojXYpTqcLqvqdZn47ZwFb2TCvR8ajvwu1x0xryNF1JC92s96aggqWhey438a/1/5O3mE5XwLbumPptutssLLWARsK3xD+Bnl4MHMFrqx1QBCdL2lWNsO53SJYo02kXE/km5EmWDYuSaBQ3JJd/Ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8AxQK3jklpoNDocAQ--.46349S3;
	Tue, 24 Jun 2025 19:58:27 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMDxu8TcklpohsAoAQ--.53899S2;
	Tue, 24 Jun 2025 19:58:24 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	wanghongliang@loongson.cn,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 0/4] LoongArch: Introduce the Loongson-2K MMC host controller driver
Date: Tue, 24 Jun 2025 19:58:09 +0800
Message-ID: <cover.1750765495.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8TcklpohsAoAQ--.53899S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF13WF4kXFWxJF15uw18Xrc_yoW5AF1kpa
	98u343Gr4UKr45Ars3Gay8Cr15u345Xr9rGFsxGw18Wa98u34UZ3sYkFWY9FW3urW8Wry7
	Zr95ua1F9a4UCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==

Hi all:

This patchset introduce the MMC host controller on Loongson-2K series
CPUs.

They are similar, except for the interface characteristics and the use of
DMA engine, specifically, the Loongson-2K0500/Loongson-2K1000 use an
externally shared APBDMA engine, while the Loongson-2K2000 uses an
internally exclusive DMA.

Based on this, I'm splitting the driver into two patches.

List of the patchset:
Patch1: bindings for Loongson-2K0500/Loongson-2K1000;
Patch2: driver for MMC controller using externally shared APBDMA engine;
Patch3: bindings for Loongson-2K2000;
Patch4: driver for MMC controller using internally exclusive DMA.

Thanks.

-------
V4:
patch(2/4):
 - Code formatting;
 - Fix lkp error
    https://lore.kernel.org/all/202506202031.TNchn822-lkp@intel.com/
patch(4/4):
 - Rename function names:
	ls2k1000_mmc_regmap_config -> ls2k0500_mmc_regmap_config
	loongson2_mmc_reorder_cmd_data -> ls2k0500_mmc_reorder_cmd_data
	loongson2_mmc_set_internal_dma -> ls2k2000_mmc_set_internal_dma
 - Use macro definitions for magic numbers.

Link to V3:
https://lore.kernel.org/all/cover.1750216134.git.zhoubinbin@loongson.cn/

V3:
patch(1/4):
 - Rename dt-binding file as loongson,ls2k0500-mmc.yaml.
patch(2/4):
 - Fix lkp error;
    https://lore.kernel.org/all/202505130918.uanOGxju-lkp@intel.com/
 - Add regulators support for ios ops;
 - Add ack_sdio_irq() callback;
 - Add MMC_CAP2_SDIO_IRQ_NOTHREAD flag;
patch(3/4):
 - Add Ack-by tag.
patch(4/4):
 - Update commit for fix_data_timeout().

Link to V2:
https://lore.kernel.org/all/cover.1746581751.git.zhoubinbin@loongson.cn/

V2:
patch(1/4):
 - Add reg define for each reg entry.

patch(2/4):
 - Put all code in the c-file;
 - Use mmc_from_priv() instead of host->mmc;
 - Use sdio_signal_irq() instead of mmc_signal_sdio_irq();
 - Use devm_mmc_alloc_host() instead of mmc_alloc_host();
 - Use mmc_regulator_get_supply();

patch(4/4):
 - Add fix_cmd_interrupt function which is needed by Loongson-2K2000.

Link to V1:
https://lore.kernel.org/linux-mmc/cover.1744273956.git.zhoubinbin@loongson.cn/

Binbin Zhou (4):
  dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
  mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
  dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for
    Loongson-2K2000
  mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver

 .../bindings/mmc/loongson,ls2k0500-mmc.yaml   |  112 ++
 MAINTAINERS                                   |    7 +
 drivers/mmc/host/Kconfig                      |   13 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/loongson2-mmc.c              | 1029 +++++++++++++++++
 5 files changed, 1162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
 create mode 100644 drivers/mmc/host/loongson2-mmc.c


base-commit: f5c755ef810009b85350884c483705bd04365370
-- 
2.47.1

