From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 24/31] mmc: sdhci: set_uhs_signaling() need not return a
 value
Date: Tue, 18 Feb 2014 15:11:06 +0000
Message-ID: <E1WFmKA-0006nS-0z@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40548 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756233AbaBRPLI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:11:08 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

The set_uhs_signaling() method gives the impression that it can fail,
but anything returned from the method is entirely ignored by the sdhci
driver.  So returning failure has no effect.

So, kill the idea that it's possible for this to return an error by
removing the returned value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 drivers/mmc/host/sdhci-pxav3.c     | 4 +---
 drivers/mmc/host/sdhci.h           | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5ad4883155a5..ae346d60adb7 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -839,7 +839,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
 }
 
-static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
=+DO NOT APPLY+=static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
@@ -877,7 +877,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		break;
 	}
 
-	return esdhc_change_pinstate(host, uhs);
=+DO NOT APPLY+=	esdhc_change_pinstate(host, uhs);
 }
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3d6b574528ea..13f8552ed0b3 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pxav3.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pxav3.c
@@ -131,7 +131,7 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 	pxa->power_mode = power_mode;
 }
 
-static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
=+DO NOT APPLY+=static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	u16 ctrl_2;
 
@@ -165,8 +165,6 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	dev_dbg(mmc_dev(host->mmc),
 		"%s uhs = %d, ctrl_2 = %04X\n",
 		__func__, uhs, ctrl_2);
-
-	return 0;
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ac20195f667b..3179a8053019 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.h
@@ -287,7 +287,7 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void		(*reset)(struct sdhci_host *host, u8 mask);
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
-	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
=+DO NOT APPLY+=	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
-- 
1.8.3.1

