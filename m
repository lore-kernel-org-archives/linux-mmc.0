From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH 3/8] sdhci: Clear interrupt status register just once
Date: Wed, 14 Jul 2010 17:08:01 +0400
Message-ID: <20100714130801.GC517@oksana.dev.rtsoft.ru>
References: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Fleming <matt@console-pimps.org>, Albert Herranz <albert_herranz@yahoo.es>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <pierre@ossman.eu>
List-Id: linux-mmc@vger.kernel.org

There's no need to clear the interrupt status register bit-by-bit,
we can just clear it once. This simplifies irq handler.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/mmc/host/sdhci.c |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 748a2e3..9ec245c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1522,38 +1522,29 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		goto out;
 	}
 
+	sdhci_writel(host, intmask, SDHCI_INT_STATUS);
+
 	DBG("*** %s got interrupt: 0x%08x\n",
 		mmc_hostname(host->mmc), intmask);
 
-	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
-		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
-			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
+	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE))
 		schedule_work(&host->card_detect_work);
-	}
 
 	intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
 
-	if (intmask & SDHCI_INT_CMD_MASK) {
-		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
-			SDHCI_INT_STATUS);
+	if (intmask & SDHCI_INT_CMD_MASK)
 		sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
-	}
 
-	if (intmask & SDHCI_INT_DATA_MASK) {
-		sdhci_writel(host, intmask & SDHCI_INT_DATA_MASK,
-			SDHCI_INT_STATUS);
+	if (intmask & SDHCI_INT_DATA_MASK)
 		sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
-	}
 
 	intmask &= ~(SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK);
 
 	intmask &= ~SDHCI_INT_ERROR;
 
-	if (intmask & SDHCI_INT_BUS_POWER) {
+	if (intmask & SDHCI_INT_BUS_POWER)
 		printk(KERN_ERR "%s: Card is consuming too much power!\n",
 			mmc_hostname(host->mmc));
-		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
-	}
 
 	intmask &= ~SDHCI_INT_BUS_POWER;
 
@@ -1566,8 +1557,6 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		printk(KERN_ERR "%s: Unexpected interrupt 0x%08x.\n",
 			mmc_hostname(host->mmc), intmask);
 		sdhci_dumpregs(host);
-
-		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 	}
 
 	result = IRQ_HANDLED;
-- 
1.7.0.5
