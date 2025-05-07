Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186621D590;
	Wed,  7 May 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602918; cv=none; b=khw4SsP8F2isSHD8twhauKh/nx/BIgFkx9HMSG4vNgIX7wicmjp8fLqep4+WTfCkyISajIb7BFUViOhtyuWBIH+QdXUtSMEVLwev5uViDZVREgphbzNQErYLZCE8sUAzMykPOyKeQbqoefugNhL6aFDOsfFjdxM7883pbNsmAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602918; c=relaxed/simple;
	bh=1Rew0YZuYxM+n14JYaOIHTvOV12a+aiXbDY3qnhh2dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRlGCgLNhpJdOQ3n5izAUfX09bYpH9jFq+iibqF/VgYrMM38iYI9MCpj1vNgxtSSxiw5LAdlxjO9l0jShQIqurAQksdWX2ULnHNYMDFzbNYpO19wIHiGBrn6YYtVwWlUL6AKAUxc2Ql2KPdy9Qp4cxNpkSpZ3BgW18n+uqLDrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8AxHHKaCxtoCeHXAA--.26331S3;
	Wed, 07 May 2025 15:28:26 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.186])
	by front1 (Coremail) with SMTP id qMiowMBxn8WVCxtoGna5AA--.12969S2;
	Wed, 07 May 2025 15:28:22 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 0/4] LoongArch: Introduce the Loongson-2K MMC host controller driver
Date: Wed,  7 May 2025 15:28:04 +0800
Message-ID: <cover.1746581751.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxn8WVCxtoGna5AA--.12969S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ury8ArWDAFWDZr4kJrykCrX_yoW8Zr1kpa
	15u343tF4UJr43CFn3Ga48Ary5urWfJ3srGanxGw1kGay3u34UX3sayFWFvay3ury8Gry7
	XFyrua1ru3WUCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jreOLU
	UUUU=

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
  dt-bindings: mmc: loongson,ls2k-mmc: Add compatible for
    Loongson-2K2000
  mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver

 .../bindings/mmc/loongson,ls2k-mmc.yaml       |  112 ++
 MAINTAINERS                                   |    7 +
 drivers/mmc/host/Kconfig                      |   13 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/loongson2-mmc.c              | 1007 +++++++++++++++++
 5 files changed, 1140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
 create mode 100644 drivers/mmc/host/loongson2-mmc.c


base-commit: 9e12816f9a6195f1f5b7c5dc2e388c2458411b97
-- 
2.47.1

