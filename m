From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 29/31] mmc: sdhci-of-esdhc: remove
 platform_suspend/platform_resume callbacks
Date: Tue, 18 Feb 2014 15:11:31 +0000
Message-ID: <E1WFmKZ-0006nm-JF@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40578 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754917AbaBRPLf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:11:35 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

We don't need these hooks in order to insert code in these paths, we
can just provide our own handlers and call the main sdhci handlers as
appropriate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-of-esdhc.c | 55 +++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fcaeae5f55b8..605815e52f5f 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-esdhc.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -241,20 +241,6 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	mdelay(1);
 }
 
-#ifdef CONFIG_PM
-static u32 esdhc_proctl;
-static void esdhc_of_suspend(struct sdhci_host *host)
-{
-	esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
-}
-
-static void esdhc_of_resume(struct sdhci_host *host)
-{
-	esdhc_of_enable_dma(host);
-	sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
-}
-#endif
-
 static void esdhc_of_platform_init(struct sdhci_host *host)
 {
 	u32 vvn;
@@ -302,16 +288,47 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
 	.platform_init = esdhc_of_platform_init,
-#ifdef CONFIG_PM
-	.platform_suspend = esdhc_of_suspend,
-	.platform_resume = esdhc_of_resume,
-#endif
 	.adma_workaround = esdhci_of_adma_workaround,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
=+DO NOT APPLY+=#ifdef CONFIG_PM
=+DO NOT APPLY+=
=+DO NOT APPLY+=static u32 esdhc_proctl;
=+DO NOT APPLY+=static int esdhc_of_suspend(struct device *dev)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	struct sdhci_host *host = dev_get_drvdata(dev);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	return sdhci_suspend_host(host);
=+DO NOT APPLY+=}
=+DO NOT APPLY+=
=+DO NOT APPLY+=static void esdhc_of_resume(device *dev)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	struct sdhci_host *host = dev_get_drvdata(dev);
=+DO NOT APPLY+=	int ret = sdhci_resume_host(host);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	if (ret == 0) {
=+DO NOT APPLY+=		/* Isn't this already done by sdhci_resume_host() ? --rmk */
=+DO NOT APPLY+=		esdhc_of_enable_dma(host);
=+DO NOT APPLY+=		sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
=+DO NOT APPLY+=	}
=+DO NOT APPLY+=
=+DO NOT APPLY+=	return ret;
=+DO NOT APPLY+=}
=+DO NOT APPLY+=
=+DO NOT APPLY+=static const struct dev_pm_ops esdhc_pmops = {
=+DO NOT APPLY+=	.suspend	= esdhci_of_suspend,
=+DO NOT APPLY+=	.resume		= esdhci_of_resume,
=+DO NOT APPLY+=};
=+DO NOT APPLY+=#define ESDHC_PMOPS (&esdhc_pmops)
=+DO NOT APPLY+=#else
=+DO NOT APPLY+=#define ESDHC_PMOPS NULL
=+DO NOT APPLY+=#endif
=+DO NOT APPLY+=
 static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	/*
 	 * card detection could be handled via GPIO
@@ -373,7 +390,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.name = "sdhci-esdhc",
 		.owner = THIS_MODULE,
 		.of_match_table = sdhci_esdhc_of_match,
-		.pm = SDHCI_PLTFM_PMOPS,
=+DO NOT APPLY+=		.pm = ESDHC_PMOPS,
 	},
 	.probe = sdhci_esdhc_probe,
 	.remove = sdhci_esdhc_remove,
-- 
1.8.3.1

