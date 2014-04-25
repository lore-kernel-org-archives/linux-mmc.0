From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 28/32] mmc: sdhci-tegra: get rid of special PRESENT_STATE
 register handling
Date: Fri, 25 Apr 2014 14:27:03 +0100
Message-ID: <E1Wdg9f-00080g-KE@rmk-PC.arm.linux.org.uk>
References: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50693 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751311AbaDYN1H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:27:07 -0400
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org

sdhci-tegra provides a get_ro method, which overrides the checking
of the write protect bit in the PRESENT_STATE register in sdhci.c:

        if (host->flags & SDHCI_DEVICE_DEAD)
                is_readonly = 0;
        else if (host->ops->get_ro)
                is_readonly = host->ops->get_ro(host);
        else
                is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
                                & SDHCI_WRITE_PROTECT);

This means it's pointless detecting accesses to this register and
manually setting the SDHCI_WRITE_PROTECT as it has no effect.

This means that the whole of tegra_sdhci_readl() can be removed and
we can use the builtin sdhci readl functionality here.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-tegra.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index d06b6ff60432..985247649f46 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -48,19 +48,6 @@ struct sdhci_tegra {
 	int power_gpio;
 };
 
-static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
-{
-	u32 val;
-
-	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
-		/* Use wp_gpio here instead? */
-		val = readl(host->ioaddr + reg);
-		return val | SDHCI_WRITE_PROTECT;
-	}
-
-	return readl(host->ioaddr + reg);
-}
-
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -150,7 +137,6 @@ static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
 
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
-	.read_l     = tegra_sdhci_readl,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = sdhci_set_clock,
-- 
1.8.3.1

