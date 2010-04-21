From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/8] SH: constify multiple DMA related objects and references
 to them
Date: Wed, 21 Apr 2010 17:36:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004211731440.5292@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49546 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755629Ab0DUPge (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 11:36:34 -0400
In-Reply-To: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

Lists of DMA channels and slaves are not changed, make them constant. Besides,
SH7724 channel and slave configuration of both DMA controllers is identical,
remove the extra copy of the configuration data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Just some preparatory clean up.

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    6 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   54 ++++---------------------------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |    6 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |    6 ++--
 drivers/dma/shdma.c                    |   12 ++++---
 include/linux/sh_dma.h                 |    9 +++--
 6 files changed, 28 insertions(+), 65 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index fd7e363..fe28f52 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -24,7 +24,7 @@
 #include <cpu/dma-register.h>
 #include <cpu/sh7722.h>
 
-static struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
+static const struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
 		.addr		= 0xffe0000c,
@@ -78,7 +78,7 @@ static struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
 	},
 };
 
-static struct sh_dmae_channel sh7722_dmae_channels[] = {
+static const struct sh_dmae_channel sh7722_dmae_channels[] = {
 	{
 		.offset = 0,
 		.dmars = 0,
@@ -106,7 +106,7 @@ static struct sh_dmae_channel sh7722_dmae_channels[] = {
 	}
 };
 
-static unsigned int ts_shift[] = TS_SHIFT;
+static const unsigned int ts_shift[] = TS_SHIFT;
 
 static struct sh_dmae_pdata dma_platform_data = {
 	.slave		= sh7722_dmae_slaves,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index e7fa2a9..c4572b1 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -31,7 +31,7 @@
 #include <cpu/sh7724.h>
 
 /* DMA */
-static struct sh_dmae_channel sh7724_dmae0_channels[] = {
+static const struct sh_dmae_channel sh7724_dmae_channels[] = {
 	{
 		.offset = 0,
 		.dmars = 0,
@@ -59,51 +59,11 @@ static struct sh_dmae_channel sh7724_dmae0_channels[] = {
 	}
 };
 
-static struct sh_dmae_channel sh7724_dmae1_channels[] = {
-	{
-		.offset = 0,
-		.dmars = 0,
-		.dmars_bit = 0,
-	}, {
-		.offset = 0x10,
-		.dmars = 0,
-		.dmars_bit = 8,
-	}, {
-		.offset = 0x20,
-		.dmars = 4,
-		.dmars_bit = 0,
-	}, {
-		.offset = 0x30,
-		.dmars = 4,
-		.dmars_bit = 8,
-	}, {
-		.offset = 0x50,
-		.dmars = 8,
-		.dmars_bit = 0,
-	}, {
-		.offset = 0x60,
-		.dmars = 8,
-		.dmars_bit = 8,
-	}
-};
-
-static unsigned int ts_shift[] = TS_SHIFT;
-
-static struct sh_dmae_pdata dma0_platform_data = {
-	.channel	= sh7724_dmae0_channels,
-	.channel_num	= ARRAY_SIZE(sh7724_dmae0_channels),
-	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
-	.ts_low_mask	= CHCR_TS_LOW_MASK,
-	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
-	.ts_high_mask	= CHCR_TS_HIGH_MASK,
-	.ts_shift	= ts_shift,
-	.ts_shift_num	= ARRAY_SIZE(ts_shift),
-	.dmaor_init	= DMAOR_INIT,
-};
+static const unsigned int ts_shift[] = TS_SHIFT;
 
-static struct sh_dmae_pdata dma1_platform_data = {
-	.channel	= sh7724_dmae1_channels,
-	.channel_num	= ARRAY_SIZE(sh7724_dmae1_channels),
+static struct sh_dmae_pdata dma_platform_data = {
+	.channel	= sh7724_dmae_channels,
+	.channel_num	= ARRAY_SIZE(sh7724_dmae_channels),
 	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
 	.ts_low_mask	= CHCR_TS_LOW_MASK,
 	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
@@ -187,7 +147,7 @@ static struct platform_device dma0_device = {
 	.resource	= sh7724_dmae0_resources,
 	.num_resources	= ARRAY_SIZE(sh7724_dmae0_resources),
 	.dev		= {
-		.platform_data	= &dma0_platform_data,
+		.platform_data	= &dma_platform_data,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_DMAC0,
@@ -200,7 +160,7 @@ static struct platform_device dma1_device = {
 	.resource	= sh7724_dmae1_resources,
 	.num_resources	= ARRAY_SIZE(sh7724_dmae1_resources),
 	.dev		= {
-		.platform_data	= &dma1_platform_data,
+		.platform_data	= &dma_platform_data,
 	},
 	.archdata = {
 		.hwblk_id = HWBLK_DMAC1,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 02e792c..c3fcb39 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -251,7 +251,7 @@ static struct platform_device rtc_device = {
 };
 
 /* DMA */
-static struct sh_dmae_channel sh7780_dmae0_channels[] = {
+static const struct sh_dmae_channel sh7780_dmae0_channels[] = {
 	{
 		.offset = 0,
 		.dmars = 0,
@@ -279,7 +279,7 @@ static struct sh_dmae_channel sh7780_dmae0_channels[] = {
 	}
 };
 
-static struct sh_dmae_channel sh7780_dmae1_channels[] = {
+static const struct sh_dmae_channel sh7780_dmae1_channels[] = {
 	{
 		.offset = 0,
 	}, {
@@ -295,7 +295,7 @@ static struct sh_dmae_channel sh7780_dmae1_channels[] = {
 	}
 };
 
-static unsigned int ts_shift[] = TS_SHIFT;
+static const unsigned int ts_shift[] = TS_SHIFT;
 
 static struct sh_dmae_pdata dma0_platform_data = {
 	.channel	= sh7780_dmae0_channels,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 1fcd88b..771ae76 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -299,7 +299,7 @@ static struct platform_device tmu5_device = {
 };
 
 /* DMA */
-static struct sh_dmae_channel sh7785_dmae0_channels[] = {
+static const struct sh_dmae_channel sh7785_dmae0_channels[] = {
 	{
 		.offset = 0,
 		.dmars = 0,
@@ -327,7 +327,7 @@ static struct sh_dmae_channel sh7785_dmae0_channels[] = {
 	}
 };
 
-static struct sh_dmae_channel sh7785_dmae1_channels[] = {
+static const struct sh_dmae_channel sh7785_dmae1_channels[] = {
 	{
 		.offset = 0,
 	}, {
@@ -343,7 +343,7 @@ static struct sh_dmae_channel sh7785_dmae1_channels[] = {
 	}
 };
 
-static unsigned int ts_shift[] = TS_SHIFT;
+static const unsigned int ts_shift[] = TS_SHIFT;
 
 static struct sh_dmae_pdata dma0_platform_data = {
 	.channel	= sh7785_dmae0_channels,
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 549bae9..25ddb1e 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -188,7 +188,7 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 	struct sh_dmae_device *shdev = container_of(sh_chan->common.device,
 						struct sh_dmae_device, common);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
-	struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->id];
+	const struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->id];
 	u16 __iomem *addr = shdev->dmars + chan_pdata->dmars / sizeof(u16);
 	int shift = chan_pdata->dmars_bit;
 
@@ -264,7 +264,7 @@ static struct sh_desc *sh_dmae_get_desc(struct sh_dmae_chan *sh_chan)
 	return NULL;
 }
 
-static struct sh_dmae_slave_config *sh_dmae_find_slave(
+static const struct sh_dmae_slave_config *sh_dmae_find_slave(
 	struct sh_dmae_chan *sh_chan, struct sh_dmae_slave *param)
 {
 	struct dma_device *dma_dev = sh_chan->common.device;
@@ -297,7 +297,7 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 	 * never runs concurrently with itself or free_chan_resources.
 	 */
 	if (param) {
-		struct sh_dmae_slave_config *cfg;
+		const struct sh_dmae_slave_config *cfg;
 
 		cfg = sh_dmae_find_slave(sh_chan, param);
 		if (!cfg) {
@@ -572,12 +572,14 @@ static struct dma_async_tx_descriptor *sh_dmae_prep_slave_sg(
 {
 	struct sh_dmae_slave *param;
 	struct sh_dmae_chan *sh_chan;
+	dma_addr_t slave_addr;
 
 	if (!chan)
 		return NULL;
 
 	sh_chan = to_sh_chan(chan);
 	param = chan->private;
+	slave_addr = param->config->addr;
 
 	/* Someone calling slave DMA on a public channel? */
 	if (!param || !sg_len) {
@@ -590,7 +592,7 @@ static struct dma_async_tx_descriptor *sh_dmae_prep_slave_sg(
 	 * if (param != NULL), this is a successfully requested slave channel,
 	 * therefore param->config != NULL too.
 	 */
-	return sh_dmae_prep_sg(sh_chan, sgl, sg_len, &param->config->addr,
+	return sh_dmae_prep_sg(sh_chan, sgl, sg_len, &slave_addr,
 			       direction, flags);
 }
 
@@ -871,7 +873,7 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 					int irq, unsigned long flags)
 {
 	int err;
-	struct sh_dmae_channel *chan_pdata = &shdev->pdata->channel[id];
+	const struct sh_dmae_channel *chan_pdata = &shdev->pdata->channel[id];
 	struct platform_device *pdev = to_platform_device(shdev->common.dev);
 	struct sh_dmae_chan *new_sh_chan;
 
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index cdaaff4..b08cd4e 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -17,7 +17,7 @@
 struct sh_dmae_slave {
 	unsigned int			slave_id; /* Set by the platform */
 	struct device			*dma_dev; /* Set by the platform */
-	struct sh_dmae_slave_config	*config;  /* Set by the driver */
+	const struct sh_dmae_slave_config	*config;  /* Set by the driver */
 };
 
 struct sh_dmae_regs {
@@ -36,6 +36,7 @@ struct sh_desc {
 	int chunks;
 	int mark;
 };
+
 struct sh_dmae_slave_config {
 	unsigned int			slave_id;
 	dma_addr_t			addr;
@@ -50,15 +51,15 @@ struct sh_dmae_channel {
 };
 
 struct sh_dmae_pdata {
-	struct sh_dmae_slave_config *slave;
+	const struct sh_dmae_slave_config *slave;
 	int slave_num;
-	struct sh_dmae_channel *channel;
+	const struct sh_dmae_channel *channel;
 	int channel_num;
 	unsigned int ts_low_shift;
 	unsigned int ts_low_mask;
 	unsigned int ts_high_shift;
 	unsigned int ts_high_mask;
-	unsigned int *ts_shift;
+	const unsigned int *ts_shift;
 	int ts_shift_num;
 	u16 dmaor_init;
 };
-- 
1.6.2.4

