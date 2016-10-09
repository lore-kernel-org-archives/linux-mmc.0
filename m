From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 9/9] mmc: dw_mmc: remove system PM callback
Date: Sun,  9 Oct 2016 21:51:11 +0800
Message-ID: <1476021071-31477-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476020951-31292-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1476020951-31292-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Now there are no variant drivers using dw_mci_suspend
and dw_mci_resume, so let's remove it.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc.c | 44 ++++++++------------------------------------
 drivers/mmc/host/dw_mmc.h |  2 --
 2 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5ef263..46a14c5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3267,26 +3267,24 @@ EXPORT_SYMBOL(dw_mci_remove);
 
 
 #ifdef CONFIG_PM
-/*
- * TODO: we should probably disable the clock to the card in the suspend path.
- */
-int dw_mci_suspend(struct dw_mci *host)
+int dw_mci_runtime_suspend(struct dw_mci *host)
 {
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
+	clk_disable_unprepare(host->ciu_clk);
+
 	return 0;
 }
-EXPORT_SYMBOL(dw_mci_suspend);
+EXPORT_SYMBOL(dw_mci_runtime_suspend);
 
-int dw_mci_resume(struct dw_mci *host)
+int dw_mci_runtime_resume(struct dw_mci *host)
 {
-	int i, ret;
+	int i, ret = 0;
 
-	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
-		ret = -ENODEV;
+	ret = clk_prepare_enable(host->ciu_clk);
+	if (ret)
 		return ret;
-	}
 
 	if (host->use_dma && host->dma_ops->init)
 		host->dma_ops->init(host);
@@ -3323,32 +3321,6 @@ int dw_mci_resume(struct dw_mci *host)
 
 	return 0;
 }
-EXPORT_SYMBOL(dw_mci_resume);
-
-int dw_mci_runtime_suspend(struct dw_mci *host)
-{
-	int err = 0;
-
-	err = dw_mci_suspend(host);
-	if (err)
-		return err;
-
-	clk_disable_unprepare(host->ciu_clk);
-
-	return err;
-}
-EXPORT_SYMBOL(dw_mci_runtime_suspend);
-
-int dw_mci_runtime_resume(struct dw_mci *host)
-{
-	int ret = 0;
-
-	ret = clk_prepare_enable(host->ciu_clk);
-	if (ret)
-		return ret;
-
-	return dw_mci_resume(host);
-}
 EXPORT_SYMBOL(dw_mci_runtime_resume);
 #endif /* CONFIG_PM */
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index baa7261..b642dbb 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -235,8 +235,6 @@
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
 #ifdef CONFIG_PM
-extern int dw_mci_suspend(struct dw_mci *host);
-extern int dw_mci_resume(struct dw_mci *host);
 extern int dw_mci_runtime_suspend(struct dw_mci *host);
 extern int dw_mci_runtime_resume(struct dw_mci *host);
 #endif
-- 
2.3.7
