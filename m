From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/10] mmc: sdhci: Export sdhci_set_ios() from sdhci.c
Date: Fri,  7 Oct 2016 17:22:47 +0200
Message-ID: <cdd78a886ed9fba1f6adba9061e6c91cf7e15bf3.1475853198.git-series.gregory.clement@free-electrons.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Jack(SH) Zhu" <jmzhu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xueping Liu <xpliu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hilbert Zhang <zzhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Export sdhci_set_ios() in sdhci.c.
Thus vendor sdhci driver can implement its own set_ios() routine.

Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 48055666c655..d4bb818c52d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1562,7 +1562,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
 
-static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
@@ -1719,6 +1719,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_ios);
 
 static int sdhci_get_cd(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c722cd23205c..21dc80b8ae3d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -686,6 +686,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.8.10
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
