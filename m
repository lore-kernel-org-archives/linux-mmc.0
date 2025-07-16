Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748B1C68F
	for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2025 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648280; cv=none; b=HCtvGMdxPD/rkbEHXHDSYorJNey7qHNJMCWdpq0K+vPeHLUse3IDjsZ2KaVbh0c+6xrqDSxKGEOdp6NVGa2DW8adjOZcSzB4PByxh6qWlmg4j1Af3//p9X6qyGXorAFKD1fpG9ji9l8KuWnEeMPspjGMwbY8GvKN4QmFoaz/MoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648280; c=relaxed/simple;
	bh=Lhq7ACb3SRhndWgFjBbgk58SGaa9+c9+07oeIZuOPLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WhaiA/Mq0xRJ+73k0FylIow5VrGotrN0klHibb86eZoxdVW/yR2wRG6CsqUCRmeIidZL7bLLHK33O/7+GyetDuAwMff0oh4f6CfRznTsyzB6W38oKnEIiy4uLcTo6Uk3shx+c55FZ9BdLiK/WpZIqn6E5at6K5q628nJHALxFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.193])
	by gateway (Coremail) with SMTP id _____8CxG6xSSndo8v8qAQ--.48327S3;
	Wed, 16 Jul 2025 14:44:34 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.193])
	by front1 (Coremail) with SMTP id qMiowJCxocJPSndoGXEZAA--.5478S2;
	Wed, 16 Jul 2025 14:44:33 +0800 (CST)
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
Subject: [PATCH] mmc: loongson2: Unify the function prefixes for loongson2_mmc_pdata
Date: Wed, 16 Jul 2025 14:44:21 +0800
Message-ID: <20250716064421.3823418-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxocJPSndoGXEZAA--.5478S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur18JF1DXFWfWw4rWF15Awc_yoWrGFW7pF
	W7A34UKF48tr4YvF98XrWUZr15ZryaqFn7Ka17Ww1F9as8t34j9F1UtFyS9F40kry5GF17
	WF4kWa1v93WDCrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

The function prefixes for loongson2_mmc_pdata follow two naming
conventions: SoC-based and DMA-based.

First, DMA-based prefixes are the preferred choice, as they clearly
highlight differences, such as prepare_dma; however, for functions
related to SoC, such as reorder_cmd_data, it is agreed to use the
smallest SoC name as the fallback prefix, such as ls2k0500.

No functional change intended.

Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/loongson2-mmc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index ba6bb8fd5535..27499f36477c 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -594,7 +594,7 @@ static struct mmc_host_ops loongson2_mmc_ops = {
 	.ack_sdio_irq	= loongson2_mmc_ack_sdio_irq,
 };
 
-static const struct regmap_config ls2k1000_mmc_regmap_config = {
+static const struct regmap_config ls2k0500_mmc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
@@ -610,8 +610,8 @@ static int loongson2_reorder_cmd_list[] = { SD_APP_SEND_SCR, SD_APP_SEND_NUM_WR_
  * However sdio controller will send these datas in usual data format,
  * so we need to adjust these datas to a protocol consistent byte order.
  */
-static void loongson2_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
-					   struct mmc_command *cmd)
+static void ls2k0500_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
+					  struct mmc_command *cmd)
 {
 	struct scatterlist *sg;
 	u32 *data;
@@ -704,8 +704,8 @@ static int ls2k0500_mmc_set_external_dma(struct loongson2_mmc_host *host,
 }
 
 static struct loongson2_mmc_pdata ls2k0500_mmc_pdata = {
-	.regmap_config		= &ls2k1000_mmc_regmap_config,
-	.reorder_cmd_data	= loongson2_mmc_reorder_cmd_data,
+	.regmap_config		= &ls2k0500_mmc_regmap_config,
+	.reorder_cmd_data	= ls2k0500_mmc_reorder_cmd_data,
 	.setting_dma		= ls2k0500_mmc_set_external_dma,
 	.prepare_dma		= loongson2_mmc_prepare_external_dma,
 	.release_dma		= loongson2_mmc_release_external_dma,
@@ -736,8 +736,8 @@ static int ls2k1000_mmc_set_external_dma(struct loongson2_mmc_host *host,
 }
 
 static struct loongson2_mmc_pdata ls2k1000_mmc_pdata = {
-	.regmap_config		= &ls2k1000_mmc_regmap_config,
-	.reorder_cmd_data	= loongson2_mmc_reorder_cmd_data,
+	.regmap_config		= &ls2k0500_mmc_regmap_config,
+	.reorder_cmd_data	= ls2k0500_mmc_reorder_cmd_data,
 	.setting_dma		= ls2k1000_mmc_set_external_dma,
 	.prepare_dma		= loongson2_mmc_prepare_external_dma,
 	.release_dma		= loongson2_mmc_release_external_dma,
@@ -838,8 +838,8 @@ static int loongson2_mmc_prepare_internal_dma(struct loongson2_mmc_host *host,
 	return 0;
 }
 
-static int loongson2_mmc_set_internal_dma(struct loongson2_mmc_host *host,
-					  struct platform_device *pdev)
+static int ls2k2000_mmc_set_internal_dma(struct loongson2_mmc_host *host,
+					 struct platform_device *pdev)
 {
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
@@ -860,7 +860,7 @@ static struct loongson2_mmc_pdata ls2k2000_mmc_pdata = {
 	.regmap_config		= &ls2k2000_mmc_regmap_config,
 	.reorder_cmd_data	= ls2k2000_mmc_reorder_cmd_data,
 	.fix_data_timeout	= ls2k2000_mmc_fix_data_timeout,
-	.setting_dma		= loongson2_mmc_set_internal_dma,
+	.setting_dma		= ls2k2000_mmc_set_internal_dma,
 	.prepare_dma		= loongson2_mmc_prepare_internal_dma,
 	.release_dma		= loongson2_mmc_release_internal_dma,
 };

base-commit: 4ad9e44c76b301e786eb4cdab890eac8c7eebd42
-- 
2.47.3

