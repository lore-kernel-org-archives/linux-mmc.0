From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 11/13] mmc: bcm2835: kill tasklet
Date: Fri, 27 Jan 2017 00:37:24 +0100
Message-ID: <1485473846-24537-12-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752741AbdAZXhn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Jan 2017 18:37:43 -0500
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835.c | 53 ++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 6a1fef3..fc2d02f 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -147,7 +147,6 @@ struct bcm2835_host {
 	u32			pio_timeout;	/* In jiffies */
 	int			clock;		/* Current clock speed */
 	unsigned int		max_clk;	/* Max possible freq */
-	struct tasklet_struct	finish_tasklet;	/* Tasklet structures */
 	struct timer_list	timer;		/* Timer for timeouts */
 	struct sg_mapping_iter	sg_miter;	/* SG state for PIO */
 	unsigned int		blocks;		/* remaining PIO blocks */
@@ -274,11 +273,12 @@ static void bcm2835_reset(struct mmc_host *mmc)
 
 	if (host->dma_chan)
 		dmaengine_terminate_sync(host->dma_chan);
-	tasklet_kill(&host->finish_tasklet);
 	bcm2835_reset_internal(host);
 }
 
+static void bcm2835_finish_data(struct bcm2835_host *host);
 static void bcm2835_finish_command(struct bcm2835_host *host);
+static void bcm2835_finish_request(struct bcm2835_host *host);
 
 static void bcm2835_wait_transfer_complete(struct bcm2835_host *host)
 {
@@ -318,8 +318,6 @@ static void bcm2835_wait_transfer_complete(struct bcm2835_host *host)
 	}
 }
 
-static void bcm2835_finish_data(struct bcm2835_host *host);
-
 static void bcm2835_dma_complete(void *param)
 {
 	struct bcm2835_host *host = param;
@@ -667,7 +665,7 @@ bool bcm2835_send_command(struct bcm2835_host *host,
 		dev_err(dev, "previous command never completed.\n");
 		bcm2835_dumpregs(host);
 		cmd->error = -EILSEQ;
-		tasklet_schedule(&host->finish_tasklet);
+		bcm2835_finish_request(host);
 		return false;
 	}
 
@@ -688,7 +686,7 @@ bool bcm2835_send_command(struct bcm2835_host *host,
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
 		dev_err(dev, "unsupported response type!\n");
 		cmd->error = -EINVAL;
-		tasklet_schedule(&host->finish_tasklet);
+		bcm2835_finish_request(host);
 		return false;
 	}
 
@@ -746,7 +744,7 @@ static void bcm2835_transfer_complete(struct bcm2835_host *host)
 		}
 	} else {
 		bcm2835_wait_transfer_complete(host);
-		tasklet_schedule(&host->finish_tasklet);
+		bcm2835_finish_request(host);
 	}
 }
 
@@ -847,7 +845,7 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 		dev_err(dev, "command never completed.\n");
 		bcm2835_dumpregs(host);
 		host->cmd->error = -EIO;
-		tasklet_schedule(&host->finish_tasklet);
+		bcm2835_finish_request(host);
 		return;
 	} else if (sdcmd & SDCMD_FAIL_FLAG) {
 		u32 sdhsts = readl(host->ioaddr + SDHSTS);
@@ -865,7 +863,7 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 				bcm2835_dumpregs(host);
 				host->cmd->error = -EILSEQ;
 			}
-			tasklet_schedule(&host->finish_tasklet);
+			bcm2835_finish_request(host);
 			return;
 		}
 	}
@@ -903,12 +901,12 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 		}
 	} else if (cmd == host->mrq->stop) {
 		/* Finished CMD12 */
-		tasklet_schedule(&host->finish_tasklet);
+		bcm2835_finish_request(host);
 	} else {
 		/* Processed actual command. */
 		host->cmd = NULL;
 		if (!host->data)
-			tasklet_schedule(&host->finish_tasklet);
+			bcm2835_finish_request(host);
 		else if (host->data_complete)
 			bcm2835_transfer_complete(host);
 	}
@@ -935,7 +933,7 @@ static void bcm2835_timeout(unsigned long data)
 				host->mrq->cmd->error = -ETIMEDOUT;
 
 			dev_dbg(dev, "timeout_timer tasklet_schedule\n");
-			tasklet_schedule(&host->finish_tasklet);
+			bcm2835_finish_request(host);
 		}
 	}
 
@@ -1244,7 +1242,7 @@ static void bcm2835_request(struct mmc_host *mmc,
 			edm);
 		bcm2835_dumpregs(host);
 		mrq->cmd->error = -EILSEQ;
-		tasklet_schedule(&host->finish_tasklet);
+		bcm2835_finish_request(host);
 		mutex_unlock(&host->mutex);
 		return;
 	}
@@ -1300,21 +1298,10 @@ static void bcm2835_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	.hw_reset = bcm2835_reset,
 };
 
-static void bcm2835_tasklet_finish(unsigned long param)
+static void bcm2835_finish_request(struct bcm2835_host *host)
 {
-	struct bcm2835_host *host = (struct bcm2835_host *)param;
-	struct mmc_request *mrq;
 	struct dma_chan *terminate_chan = NULL;
-
-	mutex_lock(&host->mutex);
-
-	/* If this tasklet gets rescheduled while running, it will
-	 * be run again afterwards but without any active request.
-	 */
-	if (!host->mrq) {
-		mutex_unlock(&host->mutex);
-		return;
-	}
+	struct mmc_request *mrq;
 
 	del_timer(&host->timer);
 
@@ -1328,8 +1315,6 @@ static void bcm2835_tasklet_finish(unsigned long param)
 	terminate_chan = host->dma_chan;
 	host->dma_chan = NULL;
 
-	mutex_unlock(&host->mutex);
-
 	if (terminate_chan) {
 		int err = dmaengine_terminate_all(terminate_chan);
 
@@ -1402,9 +1387,6 @@ int bcm2835_add_host(struct bcm2835_host *host)
 	/* report supported voltage ranges */
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-	tasklet_init(&host->finish_tasklet,
-		     bcm2835_tasklet_finish, (unsigned long)host);
-
 	setup_timer(&host->timer, bcm2835_timeout,
 		    (unsigned long)host);
 
@@ -1419,7 +1401,7 @@ int bcm2835_add_host(struct bcm2835_host *host)
 	if (ret) {
 		dev_err(dev, "failed to request IRQ %d: %d\n",
 			host->irq, ret);
-		goto untasklet;
+		return ret;
 	}
 
 	mmc_add_host(mmc);
@@ -1432,11 +1414,6 @@ int bcm2835_add_host(struct bcm2835_host *host)
 		 pio_limit_string);
 
 	return 0;
-
-untasklet:
-	tasklet_kill(&host->finish_tasklet);
-
-	return ret;
 }
 
 static int bcm2835_probe(struct platform_device *pdev)
@@ -1548,8 +1525,6 @@ static int bcm2835_remove(struct platform_device *pdev)
 
 	del_timer_sync(&host->timer);
 
-	tasklet_kill(&host->finish_tasklet);
-
 	mmc_free_host(host->mmc);
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.8.3.1

