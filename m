Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34D2063E7
	for <linux-mmc@vger.kernel.org>; Wed, 18 Jun 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234112; cv=none; b=rWfyxXCQ5Eapz6s9wCGWufE2YsqmAl88r/d8VHSsVY8MoEdFXd4CkWD4epV1OAFEJO5jyzp1oteezTiwpn870NiC5lU/1gjfpwxC3yFB2trNotfl4hLL+UTIMZ+6VhtrkpRJu9DOChMtMdlWAsRZVpsh1OGldcThdBO7yOVoAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234112; c=relaxed/simple;
	bh=wzwQZeasVMRkHr61n+fWYE9vEQ48cjy89Q9a4nBoJmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmKOsg7dtvkdHP26XuokQvGMu9kC1WqYt6irrwN6A7aI16TXKP5zh3+YisYFDoKePjcMx4EAiL3zY0u/xbsL4I685PSxjVeXbU7b+BkR2ZARpbqH9TTQLTmjhxvIOYQ6ZIsf9oldUQ9SZRznwIj6klzw5q0ZReZv2to7KBY8u7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8DxQK_0c1JosPsYAQ--.22608S3;
	Wed, 18 Jun 2025 16:08:20 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMCx_cbtc1Jou0kfAQ--.34407S2;
	Wed, 18 Jun 2025 16:08:13 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	wanghongliang@loongson.cn,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 4/4] mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver
Date: Wed, 18 Jun 2025 16:08:03 +0800
Message-ID: <aa9cfb9707334cd2e56692397dd4f54c418262ce.1750216134.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1750216134.git.zhoubinbin@loongson.cn>
References: <cover.1750216134.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cbtc1Jou0kfAQ--.34407S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ur45Cw17Cr18JryUJrWDGFX_yoWkXw47pF
	y5A3y5KrW5tr4S9ry0qFWUu343ZrWaqryYkFZrWr15Zw1xtw18uw1DGFyfXFy5KrykGFyx
	Za1Du3yDua9rXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8EeHDUUUUU==

This patch describes the two MMC controllers of the Loongson-2K2000 SoC,
one providing an eMMC interface and the other exporting an SD/SDIO
interface.

Compared to the Loongson-2K1000's MMC controllers, their internals are
similar, except that we use an internally exclusive DMA engine instead of
an externally shared APBDMA engine.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/loongson2-mmc.c | 212 +++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index 872f5dc21b21..75144221a821 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -44,6 +44,18 @@
 #define LOONGSON2_MMC_REG_DATA		0x40 /* Data Register */
 #define LOONGSON2_MMC_REG_IEN		0x64 /* Interrupt Enable Register */
 
+/* EMMC DLL Mode Registers */
+#define LOONGSON2_MMC_REG_DLLVAL	0xf0 /* DLL Master Lock-value Register */
+#define LOONGSON2_MMC_REG_DLLCTL	0xf4 /* DLL Control Register */
+#define LOONGSON2_MMC_REG_DELAY		0xf8 /* DLL Delayed Parameter Register */
+#define LOONGSON2_MMC_REG_SEL		0xfc /* Bus Mode Selection Register */
+
+/* Exclusive DMA R/W Registers */
+#define LOONGSON2_MMC_REG_WDMA_LO	0x400
+#define LOONGSON2_MMC_REG_WDMA_HI	0x404
+#define LOONGSON2_MMC_REG_RDMA_LO	0x800
+#define LOONGSON2_MMC_REG_RDMA_HI	0x804
+
 /* Bitfields of control register */
 #define LOONGSON2_MMC_CTL_ENCLK		BIT(0)
 #define LOONGSON2_MMC_CTL_EXTCLK	BIT(1)
@@ -109,6 +121,9 @@
 #define LOONGSON2_MMC_DSTS_RESUME	BIT(15)
 #define LOONGSON2_MMC_DSTS_SUSPEND	BIT(16)
 
+/* Bitfields of FIFO Status Register */
+#define LOONGSON2_MMC_FSTS_TXFULL	BIT(11)
+
 /* Bitfields of interrupt register */
 #define LOONGSON2_MMC_INT_DFIN		BIT(0)
 #define LOONGSON2_MMC_INT_DTIMEOUT	BIT(1)
@@ -136,6 +151,41 @@
 #define LOONGSON2_MMC_IEN_ALL		GENMASK(9, 0)
 #define LOONGSON2_MMC_INT_CLEAR		GENMASK(9, 0)
 
+/* Bitfields of DLL master lock-value register */
+#define LOONGSON2_MMC_DLLVAL_DONE	BIT(8)
+
+/* Bitfields of DLL control register */
+#define LOONGSON2_MMC_DLLCTL_TIME	GENMASK(7, 0)
+#define LOONGSON2_MMC_DLLCTL_INCRE	GENMASK(15, 8)
+#define LOONGSON2_MMC_DLLCTL_START	GENMASK(23, 16)
+#define LOONGSON2_MMC_DLLCTL_CLK_MODE	BIT(24)
+#define LOONGSON2_MMC_DLLCTL_START_BIT	BIT(25)
+#define LOONGSON2_MMC_DLLCTL_TIME_BPASS	GENMASK(29, 26)
+
+#define LOONGSON2_MMC_DELAY_PAD		GENMASK(7, 0)
+#define LOONGSON2_MMC_DELAY_RD		GENMASK(15, 8)
+
+#define LOONGSON2_MMC_SEL_DATA		BIT(0)	/* 0: SDR, 1: DDR */
+#define LOONGSON2_MMC_SEL_BUS		BIT(0)	/* 0: EMMC, 1: SDIO */
+
+/* Internal dma controller registers */
+
+/* Bitfields of Global Configuration Register */
+#define LOONGSON2_MMC_DMA_64BIT_EN	BIT(0) /* 1: 64 bit support */
+#define LOONGSON2_MMC_DMA_UNCOHERENT_EN	BIT(1) /* 0: cache, 1: uncache */
+#define LOONGSON2_MMC_DMA_ASK_VALID	BIT(2)
+#define LOONGSON2_MMC_DMA_START		BIT(3) /* DMA start operation */
+#define LOONGSON2_MMC_DMA_STOP		BIT(4) /* DMA stop operation */
+#define LOONGSON2_MMC_DMA_CONFIG_MASK	GENMASK_ULL(4, 0) /* DMA controller config bits mask */
+
+/* Bitfields of ndesc_addr field of HW descriptor */
+#define LOONGSON2_MMC_DMA_DESC_EN	BIT(0) /*1: The next descriptor is valid */
+#define LOONGSON2_MMC_DMA_DESC_ADDR_LOW	GENMASK(31, 1)
+
+/* Bitfields of cmd field of HW descriptor */
+#define LOONGSON2_MMC_DMA_INT		BIT(1)	/* Enable DMA interrupts */
+#define LOONGSON2_MMC_DMA_DATA_DIR	BIT(12) /* 1: write to device, 0: read from device */
+
 /* Loongson-2K1000 SDIO2 DMA routing register */
 #define LS2K1000_SDIO_DMA_MASK		GENMASK(17, 15)
 #define LS2K1000_DMA0_CONF		0x0
@@ -180,6 +230,8 @@ struct loongson2_mmc_host {
 	struct resource *res;
 	struct clk *clk;
 	u64 rate;
+	void *sg_cpu;
+	dma_addr_t sg_dma;
 	int dma_complete;
 	struct dma_chan *chan;
 	int cmd_is_stop;
@@ -192,6 +244,7 @@ struct loongson2_mmc_host {
 struct loongson2_mmc_pdata {
 	const struct regmap_config *regmap_config;
 	void (*reorder_cmd_data)(struct loongson2_mmc_host *host, struct mmc_command *cmd);
+	void (*fix_data_timeout)(struct loongson2_mmc_host *host, struct mmc_command *cmd);
 	int (*setting_dma)(struct loongson2_mmc_host *host, struct platform_device *pdev);
 	int (*prepare_dma)(struct loongson2_mmc_host *host, struct mmc_data *data);
 	void (*release_dma)(struct loongson2_mmc_host *host, struct device *dev);
@@ -282,6 +335,9 @@ static void loongson2_mmc_send_request(struct mmc_host *mmc)
 		return;
 	}
 
+	if (host->pdata->fix_data_timeout)
+		host->pdata->fix_data_timeout(host, cmd);
+
 	loongson2_mmc_send_command(host, cmd);
 
 	/* Fix deselect card */
@@ -426,6 +482,36 @@ static irqreturn_t loongson2_mmc_irq(int irq, void *devid)
 	return IRQ_WAKE_THREAD;
 }
 
+static void loongson2_mmc_dll_mode_init(struct loongson2_mmc_host *host)
+{
+	u32 val, pad_delay, delay, ret;
+
+	regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_SEL,
+			   LOONGSON2_MMC_SEL_DATA, LOONGSON2_MMC_SEL_DATA);
+
+	val = FIELD_PREP(LOONGSON2_MMC_DLLCTL_TIME, 0xc8)
+	    | FIELD_PREP(LOONGSON2_MMC_DLLCTL_INCRE, 0x1)
+	    | FIELD_PREP(LOONGSON2_MMC_DLLCTL_START, 0x1)
+	    | FIELD_PREP(LOONGSON2_MMC_DLLCTL_CLK_MODE, 0x1)
+	    | FIELD_PREP(LOONGSON2_MMC_DLLCTL_START_BIT, 0x1)
+	    | FIELD_PREP(LOONGSON2_MMC_DLLCTL_TIME_BPASS, 0xf);
+
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_DLLCTL, val);
+
+	ret = regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_DLLVAL, val,
+				       (val & LOONGSON2_MMC_DLLVAL_DONE), 0, 4000);
+	if (ret < 0)
+		return;
+
+	regmap_read(host->regmap, LOONGSON2_MMC_REG_DLLVAL, &val);
+	pad_delay = FIELD_GET(GENMASK(7, 1), val);
+
+	delay = FIELD_PREP(LOONGSON2_MMC_DELAY_PAD, pad_delay)
+	      | FIELD_PREP(LOONGSON2_MMC_DELAY_RD, pad_delay + 1);
+
+	regmap_write(host->regmap, LOONGSON2_MMC_REG_DELAY, delay);
+}
+
 static void loongson2_mmc_set_clk(struct loongson2_mmc_host *host, struct mmc_ios *ios)
 {
 	u32 pre;
@@ -438,6 +524,10 @@ static void loongson2_mmc_set_clk(struct loongson2_mmc_host *host, struct mmc_io
 
 	regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
 			   LOONGSON2_MMC_CTL_ENCLK, LOONGSON2_MMC_CTL_ENCLK);
+
+	/* EMMC DLL mode setting */
+	if (ios->timing == MMC_TIMING_UHS_DDR50 || ios->timing == MMC_TIMING_MMC_DDR52)
+		loongson2_mmc_dll_mode_init(host);
 }
 
 static void loongson2_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -655,6 +745,127 @@ static struct loongson2_mmc_pdata ls2k1000_mmc_pdata = {
 	.release_dma		= loongson2_mmc_release_external_dma,
 };
 
+static const struct regmap_config ls2k2000_mmc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = LOONGSON2_MMC_REG_RDMA_HI,
+};
+
+static void ls2k2000_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
+					  struct mmc_command *cmd)
+{
+	struct scatterlist *sg;
+	u32 *data;
+	int i, j;
+
+	if (cmd->opcode != SD_SWITCH || mmc_cmd_type(cmd) != MMC_CMD_ADTC)
+		return;
+
+	for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
+		data = sg_virt(&sg[i]);
+		for (j = 0; j < (sg_dma_len(&sg[i]) / 4); j++)
+			data[j] = bitrev8x4(data[j]);
+	}
+}
+
+/*
+ * This is a controller hardware defect. Single/multiple block write commands
+ * must be sent after the TX FULL flag is set, otherwise a data timeout interrupt
+ * will occur.
+ */
+static void ls2k2000_mmc_fix_data_timeout(struct loongson2_mmc_host *host,
+					  struct mmc_command *cmd)
+{
+	int val;
+
+	if (cmd->opcode != MMC_WRITE_BLOCK && cmd->opcode != MMC_WRITE_MULTIPLE_BLOCK)
+		return;
+
+	regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_FSTS, val,
+				 (val & LOONGSON2_MMC_FSTS_TXFULL), 0, 500);
+}
+
+static int loongson2_mmc_prepare_internal_dma(struct loongson2_mmc_host *host,
+					      struct mmc_data *data)
+{
+	struct loongson2_dma_desc *pdes = (struct loongson2_dma_desc *)host->sg_cpu;
+	struct mmc_host *mmc = mmc_from_priv(host);
+	dma_addr_t next_desc = host->sg_dma;
+	struct scatterlist *sg;
+	int reg_lo, reg_hi;
+	u64 dma_order;
+	int i, ret;
+
+	ret = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
+			 mmc_get_dma_dir(data));
+	if (!ret)
+		return -ENOMEM;
+
+	for_each_sg(data->sg, sg, data->sg_len, i) {
+		pdes[i].len = sg_dma_len(&sg[i]) / 4;
+		pdes[i].step_len = 0;
+		pdes[i].step_times = 1;
+		pdes[i].mem_addr = lower_32_bits(sg_dma_address(&sg[i]));
+		pdes[i].high_mem_addr = upper_32_bits(sg_dma_address(&sg[i]));
+		pdes[i].apb_addr = host->res->start + LOONGSON2_MMC_REG_DATA;
+		pdes[i].cmd = LOONGSON2_MMC_DMA_INT;
+
+		if (data->flags & MMC_DATA_READ) {
+			reg_lo = LOONGSON2_MMC_REG_RDMA_LO;
+			reg_hi = LOONGSON2_MMC_REG_RDMA_HI;
+		} else {
+			pdes[i].cmd |= LOONGSON2_MMC_DMA_DATA_DIR;
+			reg_lo = LOONGSON2_MMC_REG_WDMA_LO;
+			reg_hi = LOONGSON2_MMC_REG_WDMA_HI;
+		}
+
+		next_desc += sizeof(struct loongson2_dma_desc);
+		pdes[i].ndesc_addr = lower_32_bits(next_desc) |
+				     LOONGSON2_MMC_DMA_DESC_EN;
+		pdes[i].high_ndesc_addr = upper_32_bits(next_desc);
+	}
+
+	/* Setting the last descriptor enable bit */
+	pdes[i - 1].ndesc_addr &= ~LOONGSON2_MMC_DMA_DESC_EN;
+
+	dma_order = (host->sg_dma & ~LOONGSON2_MMC_DMA_CONFIG_MASK) |
+		    LOONGSON2_MMC_DMA_64BIT_EN |
+		    LOONGSON2_MMC_DMA_START;
+
+	regmap_write(host->regmap, reg_hi, upper_32_bits(dma_order));
+	regmap_write(host->regmap, reg_lo, lower_32_bits(dma_order));
+
+	return 0;
+}
+
+static int loongson2_mmc_set_internal_dma(struct loongson2_mmc_host *host,
+					  struct platform_device *pdev)
+{
+	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
+					  &host->sg_dma, GFP_KERNEL);
+	if (!host->sg_cpu)
+		return -ENOMEM;
+
+	memset(host->sg_cpu, 0, PAGE_SIZE);
+	return 0;
+}
+
+static void loongson2_mmc_release_internal_dma(struct loongson2_mmc_host *host,
+					       struct device *dev)
+{
+	dma_free_coherent(dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+}
+
+static struct loongson2_mmc_pdata ls2k2000_mmc_pdata = {
+	.regmap_config		= &ls2k2000_mmc_regmap_config,
+	.reorder_cmd_data	= ls2k2000_mmc_reorder_cmd_data,
+	.fix_data_timeout	= ls2k2000_mmc_fix_data_timeout,
+	.setting_dma		= loongson2_mmc_set_internal_dma,
+	.prepare_dma		= loongson2_mmc_prepare_internal_dma,
+	.release_dma		= loongson2_mmc_release_internal_dma,
+};
+
 static int loongson2_mmc_resource_request(struct platform_device *pdev,
 					  struct loongson2_mmc_host *host)
 {
@@ -777,6 +988,7 @@ static void loongson2_mmc_remove(struct platform_device *pdev)
 static const struct of_device_id loongson2_mmc_of_ids[] = {
 	{ .compatible = "loongson,ls2k0500-mmc", .data = &ls2k0500_mmc_pdata },
 	{ .compatible = "loongson,ls2k1000-mmc", .data = &ls2k1000_mmc_pdata },
+	{ .compatible = "loongson,ls2k2000-mmc", .data = &ls2k2000_mmc_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, loongson2_mmc_of_ids);
-- 
2.47.1

