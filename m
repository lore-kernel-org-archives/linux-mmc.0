From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] sunxi-mci: Move clk_enable / disable into
 host_init / exit
Date: Fri,  7 Feb 2014 15:00:40 +0100
Message-ID: <1391781641-7382-2-git-send-email-hdegoede@redhat.com>
References: <1391781641-7382-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBFOO2OLQKGQEZQCHY4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1391781641-7382-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sunxi-mci.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mci.c b/drivers/mmc/host/sunxi-mci.c
index 627d0ee..0eb59be 100644
--- a/drivers/mmc/host/sunxi-mci.c
+++ b/drivers/mmc/host/sunxi-mci.c
@@ -45,10 +45,23 @@
 
 #include "sunxi-mci.h"
 
-static void sunxi_mmc_init_host(struct mmc_host *mmc)
+static int sunxi_mmc_init_host(struct mmc_host *mmc)
 {
 	u32 rval;
 	struct sunxi_mmc_host *smc_host = mmc_priv(mmc);
+	int ret;
+
+	ret =  clk_prepare_enable(smc_host->clk_ahb);
+	if (ret) {
+		dev_err(mmc_dev(smc_host->mmc), "AHB clk err %d\n", ret);
+		return ret;
+	}
+	ret =  clk_prepare_enable(smc_host->clk_mod);
+	if (ret) {
+		dev_err(mmc_dev(smc_host->mmc), "MOD clk err %d\n", ret);
+		clk_disable_unprepare(smc_host->clk_ahb);
+		return ret;
+	}
 
 	/* reset controller */
 	rval = mci_readl(smc_host, REG_GCTRL) | SDXC_HWReset;
@@ -64,11 +77,15 @@ static void sunxi_mmc_init_host(struct mmc_host *mmc)
 	rval = mci_readl(smc_host, REG_GCTRL)|SDXC_INTEnb;
 	rval &= ~SDXC_AccessDoneDirect;
 	mci_writel(smc_host, REG_GCTRL, rval);
+
+	return 0;
 }
 
 static void sunxi_mmc_exit_host(struct sunxi_mmc_host *smc_host)
 {
 	mci_writel(smc_host, REG_GCTRL, SDXC_HWReset);
+	clk_disable_unprepare(smc_host->clk_ahb);
+	clk_disable_unprepare(smc_host->clk_mod);
 }
 
 /* /\* UHS-I Operation Modes */
@@ -515,21 +532,11 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			udelay(200);
 		}
 
-		err =  clk_prepare_enable(host->clk_ahb);
-		if (err) {
-			dev_err(mmc_dev(host->mmc), "AHB clk err %d\n", err);
-			host->ferror = 1;
-			return;
-		}
-		err =  clk_prepare_enable(host->clk_mod);
+		err = sunxi_mmc_init_host(mmc);
 		if (err) {
-			dev_err(mmc_dev(host->mmc), "MOD clk err %d\n", err);
-			clk_disable_unprepare(host->clk_ahb);
 			host->ferror = 1;
 			return;
 		}
-
-		sunxi_mmc_init_host(mmc);
 		enable_irq(host->irq);
 
 		dev_dbg(mmc_dev(host->mmc), "power on!\n");
@@ -540,8 +547,6 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		dev_dbg(mmc_dev(host->mmc), "power off!\n");
 		disable_irq(host->irq);
 		sunxi_mmc_exit_host(host);
-		clk_disable_unprepare(host->clk_ahb);
-		clk_disable_unprepare(host->clk_mod);
 		if (!IS_ERR(host->vmmc))
 			mmc_regulator_set_ocr(host->mmc, host->vmmc, 0);
 		host->ferror = 0;
-- 
1.8.4.2
