From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/5] mmc: bcm2835-sdhost: zap mmiowb() [fixup]
Date: Wed, 22 Jun 2016 13:42:16 +0200
Message-ID: <1466595738-2229-4-git-send-email-kraxel@redhat.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Arnd asked why they are needed.  Seems they are not needed at all.
Things are still working fine if I remove them.  Guess the arm{,64}
versions of writel() & friends take care already.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835-sdhost.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/mmc/host/bcm2835-sdhost.c b/drivers/mmc/host/bcm2835-sdhost.c
index cafe6ad..8a05c02 100644
--- a/drivers/mmc/host/bcm2835-sdhost.c
+++ b/drivers/mmc/host/bcm2835-sdhost.c
@@ -327,7 +327,6 @@ static void bcm2835_sdhost_reset_internal(struct bcm2835_host *host)
 	host->clock = 0;
 	bcm2835_sdhost_write(host, host->hcfg, SDHCFG);
 	bcm2835_sdhost_write(host, host->cdiv, SDCDIV);
-	mmiowb();
 }
 
 static void bcm2835_sdhost_reset(struct mmc_host *mmc)
@@ -1035,8 +1034,6 @@ static void bcm2835_sdhost_timeout(unsigned long data)
 			tasklet_schedule(&host->finish_tasklet);
 		}
 	}
-
-	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -1187,8 +1184,6 @@ static irqreturn_t bcm2835_sdhost_irq(int irq, void *dev_id)
 		result = IRQ_HANDLED;
 	}
 
-	mmiowb();
-
 	spin_unlock(&host->lock);
 
 	return result;
@@ -1303,7 +1298,6 @@ static void bcm2835_sdhost_request(struct mmc_host *mmc,
 		bcm2835_sdhost_dumpregs(host);
 		mrq->cmd->error = -EILSEQ;
 		tasklet_schedule(&host->finish_tasklet);
-		mmiowb();
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
@@ -1324,8 +1318,6 @@ static void bcm2835_sdhost_request(struct mmc_host *mmc,
 			bcm2835_sdhost_finish_command(host, &flags);
 	}
 
-	mmiowb();
-
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -1353,8 +1345,6 @@ static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	bcm2835_sdhost_write(host, host->hcfg, SDHCFG);
 
-	mmiowb();
-
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -1383,8 +1373,6 @@ static void bcm2835_sdhost_cmd_wait_work(struct work_struct *work)
 
 	bcm2835_sdhost_finish_command(host, &flags);
 
-	mmiowb();
-
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -1415,8 +1403,6 @@ static void bcm2835_sdhost_tasklet_finish(unsigned long param)
 	host->cmd = NULL;
 	host->data = NULL;
 
-	mmiowb();
-
 	host->dma_desc = NULL;
 	terminate_chan = host->dma_chan;
 	host->dma_chan = NULL;
@@ -1515,7 +1501,6 @@ int bcm2835_sdhost_add_host(struct bcm2835_host *host)
 		goto untasklet;
 	}
 
-	mmiowb();
 	mmc_add_host(mmc);
 
 	pio_limit_string[0] = '\0';
-- 
1.8.3.1
