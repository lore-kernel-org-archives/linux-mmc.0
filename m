Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1A20B207;
	Thu, 10 Apr 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274464; cv=none; b=JNscuxeS0SnmozWvOHTNAAnyPkmafNdPXXyLX6vgO4FW4mpeUCtlyrQaFZ5cgrleV4AboRT6OfCjIu9D4VDuYS0WLiUEfLM/KxtSX4KiryfhWGVKX2Km0eToiMAfxzT+w5CSjp3VN2+v7rAEvKQjdmVlUaY3sMOVux5aJfGSPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274464; c=relaxed/simple;
	bh=t2+OBeJgd6vIgnkDPi51zU+djJ+sYytL4w9vvY7Gjv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jug1J51YBxCysipayqRSNYwLfvOhlrCcjksOQ9WEkBYmrWmeqF3UMlZDu5PrVZSJU5OOMjNvYf07kc7nG0w0TuLNuv6M1N2rM78miFEO/JAhSSg03mqVEq68czZ0yMshAM61t0c2tTvDffQ9jMAD7u+HOXudOjvF0pHWmiPoTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8CxeXEZhPdnn7i2AA--.41468S3;
	Thu, 10 Apr 2025 16:40:57 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowMDxH+UQhPdnGrJ3AA--.30039S2;
	Thu, 10 Apr 2025 16:40:51 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v1 0/4] LoongArch: Introduce the Loongson-2K MMC host controller driver
Date: Thu, 10 Apr 2025 16:40:34 +0800
Message-ID: <cover.1744273956.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxH+UQhPdnGrJ3AA--.30039S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ury8ArWDAFWDZr4kJrykCrX_yoW8Xw1Upa
	13u3y3Kr4UCr43uF93Ga48Cry5u34fJ39rGanxJwn5Wa93u34UWryIkayYvrZxury8Jryx
	ZFyrua18u3Z8GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

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

Binbin Zhou (4):
  dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
  mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
  dt-bindings: mmc: loongson,ls2k-mmc: Add compatible for
    Loongson-2K2000
  mmc: loongson2: Add Loongson-2K2000 SD/SDIO controller driver

 .../bindings/mmc/loongson,ls2k-mmc.yaml       | 110 +++
 MAINTAINERS                                   |   8 +
 drivers/mmc/host/Kconfig                      |  13 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/loongson2-mmc.c              | 781 ++++++++++++++++++
 drivers/mmc/host/loongson2-mmc.h              | 224 +++++
 6 files changed, 1137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
 create mode 100644 drivers/mmc/host/loongson2-mmc.c
 create mode 100644 drivers/mmc/host/loongson2-mmc.h


base-commit: 6b8dba9a7fdba6d669e4119e390a071e44383934
-- 
2.47.1

