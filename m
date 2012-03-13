From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/3] mmc: sdhci: check interrupt flags in ISR again
Date: Tue, 13 Mar 2012 18:16:41 +0100
Message-ID: <1331659002-13743-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: linux-mmc@vger.kernel.org

When using MSI it is possible that a new MSI is sent while an earlier
MSI is currently handled. In this case SDHCI_INT_STATUS only contains
SDHCI_INT_RESPONSE and the ISR would not be called again. But at the end
of the ISR SDHCI_INT_DATA_END is now also pending which would be ignored.

Fix this by rereading the interrupt flags in the ISR until no interrupt
we care is pending.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/mmc/host/sdhci.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..654ab32 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2268,6 +2268,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	irqreturn_t result;
 	struct sdhci_host *host = dev_id;
 	u32 intmask;
+	u32 intmask_unhandled;
 	int cardint = 0;
 
 	spin_lock(&host->lock);
@@ -2286,6 +2287,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		goto out;
 	}
 
+again:
 	DBG("*** %s got interrupt: 0x%08x\n",
 		mmc_hostname(host->mmc), intmask);
 
@@ -2336,6 +2338,14 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
 	}
 
+	intmask_unhandled = intmask;
+
+	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+
+	/* Do interrupt handling again if we got new flags */
+	if (intmask & ~intmask_unhandled)
+		goto again;
+
 	intmask &= ~SDHCI_INT_BUS_POWER;
 
 	if (intmask & SDHCI_INT_CARD_INT)
-- 
1.7.3.4
