From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 4/7] msm: mmc: Remove "pio_irq" resource
Date: Mon,  2 May 2011 18:07:43 +0530
Message-ID: <1304339863-8526-1-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-4-git-send-email-stummala@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1303796066-6784-4-git-send-email-stummala@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, bryanh@codeaurora.org, dwalker@fifo99.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On some targets, MCI_IRQ_MASK1 is not routed to the MSM in which
case only "cmd_irq" must be used even for PIO. With this change,
all the targets will use only "cmd_irq" for both CMD and PIO.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 arch/arm/mach-msm/devices-msm7x00.c |   24 ------------------------
 arch/arm/mach-msm/devices-qsd8x50.c |   24 ------------------------
 drivers/mmc/host/msm_sdcc.c         |    8 ++------
 drivers/mmc/host/msm_sdcc.h         |    1 -
 4 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index 3ef38a5..a164830 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -176,12 +176,6 @@ static struct resource resources_sdc1[] = {
 		.name	= "cmd_irq",
 	},
 	{
-		.start	= INT_SDC1_1,
-		.end	= INT_SDC1_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
-	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
 	},
@@ -204,12 +198,6 @@ static struct resource resources_sdc2[] = {
 		.flags	= IORESOURCE_IRQ,
 		.name	= "cmd_irq",
 	},
-		{
-		.start	= INT_SDC2_1,
-		.end	= INT_SDC2_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
 	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
@@ -233,12 +221,6 @@ static struct resource resources_sdc3[] = {
 		.flags	= IORESOURCE_IRQ,
 		.name	= "cmd_irq",
 	},
-		{
-		.start	= INT_SDC3_1,
-		.end	= INT_SDC3_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
 	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
@@ -262,12 +244,6 @@ static struct resource resources_sdc4[] = {
 		.flags	= IORESOURCE_IRQ,
 		.name	= "cmd_irq",
 	},
-		{
-		.start	= INT_SDC4_1,
-		.end	= INT_SDC4_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
 	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index 730982f..2292883 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -140,12 +140,6 @@ static struct resource resources_sdc1[] = {
 		.name	= "cmd_irq",
 	},
 	{
-		.start	= INT_SDC1_1,
-		.end	= INT_SDC1_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
-	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
 	},
@@ -168,12 +162,6 @@ static struct resource resources_sdc2[] = {
 		.flags	= IORESOURCE_IRQ,
 		.name	= "cmd_irq",
 	},
-		{
-		.start	= INT_SDC2_1,
-		.end	= INT_SDC2_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
 	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
@@ -197,12 +185,6 @@ static struct resource resources_sdc3[] = {
 		.flags	= IORESOURCE_IRQ,
 		.name	= "cmd_irq",
 	},
-		{
-		.start	= INT_SDC3_1,
-		.end	= INT_SDC3_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
 	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
@@ -226,12 +208,6 @@ static struct resource resources_sdc4[] = {
 		.flags	= IORESOURCE_IRQ,
 		.name	= "cmd_irq",
 	},
-		{
-		.start	= INT_SDC4_1,
-		.end	= INT_SDC4_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
 	{
 		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
 		.name	= "status_irq"
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 3446cdd..be45b6a 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1150,7 +1150,6 @@ msmsdcc_probe(struct platform_device *pdev)
 	struct msmsdcc_host *host;
 	struct mmc_host *mmc;
 	struct resource *cmd_irqres = NULL;
-	struct resource *pio_irqres = NULL;
 	struct resource *stat_irqres = NULL;
 	struct resource *memres = NULL;
 	struct resource *dmares = NULL;
@@ -1175,12 +1174,10 @@ msmsdcc_probe(struct platform_device *pdev)
 	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	cmd_irqres = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
 						  "cmd_irq");
-	pio_irqres = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-						  "pio_irq");
 	stat_irqres = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
 						   "status_irq");
 
-	if (!cmd_irqres || !pio_irqres || !memres) {
+	if (!cmd_irqres || !memres) {
 		pr_err("%s: Invalid resource\n", __func__);
 		return -ENXIO;
 	}
@@ -1210,7 +1207,6 @@ msmsdcc_probe(struct platform_device *pdev)
 	}
 
 	host->cmd_irqres = cmd_irqres;
-	host->pio_irqres = pio_irqres;
 	host->memres = memres;
 	host->dmares = dmares;
 	spin_lock_init(&host->lock);
@@ -1327,7 +1323,7 @@ msmsdcc_probe(struct platform_device *pdev)
 	if (ret)
 		goto stat_irq_free;
 
-	ret = request_irq(pio_irqres->start, msmsdcc_pio_irq, IRQF_SHARED,
+	ret = request_irq(cmd_irqres->start, msmsdcc_pio_irq, IRQF_SHARED,
 			  DRIVER_NAME " (pio)", host);
 	if (ret)
 		goto cmd_irq_free;
diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
index 42d7bbc..fa626ed 100644
--- a/drivers/mmc/host/msm_sdcc.h
+++ b/drivers/mmc/host/msm_sdcc.h
@@ -202,7 +202,6 @@ struct msmsdcc_stats {
 
 struct msmsdcc_host {
 	struct resource		*cmd_irqres;
-	struct resource		*pio_irqres;
 	struct resource		*memres;
 	struct resource		*dmares;
 	void __iomem		*base;
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
