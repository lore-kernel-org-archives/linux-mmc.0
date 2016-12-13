From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 02/12] mmc: sdhci: Export
 sdhci_start_signal_voltage_switch() in sdhci.c
Date: Tue, 13 Dec 2016 18:48:31 +0100
Message-ID: <e63f9c5a962426c811955927a322c967ff822607.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Hu Ziji <huziji@marvell.com>

Export sdhci_start_signal_voltage_switch() from sdhci.c.
Thus vendor sdhci driver can implement its own signal voltage
switch routine.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ea06faf8a437..8e6e4e37e3b4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1832,8 +1832,8 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
-					     struct mmc_ios *ios)
+int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+				      struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
@@ -1925,6 +1925,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_start_signal_voltage_switch);
 
 static int sdhci_card_busy(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 37771de4cafa..cd18b6f19c3b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -689,6 +689,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
+int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+				      struct mmc_ios *ios);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.9.1
