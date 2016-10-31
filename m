From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 3/10] mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
Date: Mon, 31 Oct 2016 12:09:52 +0100
Message-ID: <316397d154927e413720ca2b2ad4089eaef24551.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

From: Ziji Hu <huziji@marvell.com>

Export sdhci_execute_tuning() from sdhci.c.
Thus vendor sdhci driver can execute its own tuning process.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8e6e4e37e3b4..e971abb1368f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1950,7 +1950,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
-static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
@@ -2139,6 +2139,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	spin_unlock_irqrestore(&host->lock, flags);
 	return err;
 }
+EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
 static int sdhci_select_drive_strength(struct mmc_card *card,
 				       unsigned int max_dtr, int host_drv,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd18b6f19c3b..95beadc66849 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -691,6 +691,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.8.10
