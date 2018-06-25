From: Mark Brown <broonie@kernel.org>
Subject: Applied "ata: pata_pxa: remove the dmaengine compat
	need" to the asoc tree
Date: Mon, 25 Jun 2018 14:15:22 +0100
Message-ID: <E1fXRL0-0008N1-GA@debutante>
References: <20180524070703.11901-10-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180524070703.11901-10-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-ide@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, netdev@vger.kernel.org, dmaengine@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Daniel Mack <daniel@zonque.org>, linux-media@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The patch

   ata: pata_pxa: remove the dmaengine compat need

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 273340e8bf86de53eef7073993352ea11c563696 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 17 Jun 2018 19:02:13 +0200
Subject: [PATCH] ata: pata_pxa: remove the dmaengine compat need

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_pxa.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index f6c46e9a4dc0..e8b6a2e464c9 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -25,7 +25,6 @@
 #include <linux/libata.h>
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
-#include <linux/dma/pxa-dma.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
@@ -180,8 +179,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct resource *irq_res;
 	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct dma_slave_config	config;
-	dma_cap_mask_t mask;
-	struct pxad_param param;
 	int ret = 0;
 
 	/*
@@ -278,10 +275,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 	ap->private_data = data;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	param.prio = PXAD_PRIO_LOWEST;
-	param.drcmr = pdata->dma_dreq;
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -294,8 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	 * Request the DMA channel
 	 */
 	data->dma_chan =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param, &pdev->dev, "data");
+		dma_request_slave_channel(&pdev->dev, "data");
 	if (!data->dma_chan)
 		return -EBUSY;
 	ret = dmaengine_slave_config(data->dma_chan, &config);
-- 
2.18.0.rc2
