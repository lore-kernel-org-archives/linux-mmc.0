From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 22/38] mmc: sdhci: set_uhs_signaling() need not return a value
Date: Wed, 23 Apr 2014 20:08:02 +0100
Message-ID: <E1Wd2WY-0003vk-OJ@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46464 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932312AbaDWTIG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:08:06 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

The set_uhs_signaling() method gives the impression that it can fail,
but anything returned from the method is entirely ignored by the sdhci
driver.  So returning failure has no effect.

So, kill the idea that it's possible for this to return an error by
removing the returned value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 drivers/mmc/host/sdhci-pxav3.c     | 4 +---
 drivers/mmc/host/sdhci.h           | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index dfed2c37ab3f..72e0581e564f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -841,7 +841,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
 }
 
-static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
@@ -879,7 +879,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		break;
 	}
 
-	return esdhc_change_pinstate(host, uhs);
+	esdhc_change_pinstate(host, uhs);
 }
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 8a40e079a57e..05574104a254 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -186,7 +186,7 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 	pxa->power_mode = power_mode;
 }
 
-static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	u16 ctrl_2;
 
@@ -220,8 +220,6 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	dev_dbg(mmc_dev(host->mmc),
 		"%s uhs = %d, ctrl_2 = %04X\n",
 		__func__, uhs, ctrl_2);
-
-	return 0;
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ac20195f667b..3179a8053019 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -287,7 +287,7 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void		(*reset)(struct sdhci_host *host, u8 mask);
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
-	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
+	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
-- 
1.8.3.1

