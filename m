From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 1/6] mmc: sdhci: add platfrom get_max_timeout_count hook
Date: Wed, 27 Aug 2014 15:26:27 +0800
Message-ID: <1409124392-28899-2-git-send-email-b29396@freescale.com>
References: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0187.outbound.protection.outlook.com ([207.46.163.187]:22937
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751187AbaH0Hpr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Aug 2014 03:45:47 -0400
In-Reply-To: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

Currently the max timeout count is hardcode to 1 << 27 for calcuate
the max_busy_timeout, however, for some platforms the max timeout
count may not be 1 << 27, e.g. i.MX uSDHC is 1 << 28.
Thus 1 << 27 is not correct for such platform.

It is also possible that other platforms may have different values.
To be flexible, we add a get_max_timeout_count hook to get the correct
maximum timeout value for these platforms.

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |   11 ++++++++---
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4cc2ff9..d633f288 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1196,8 +1196,11 @@ clock_set:
 		host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
 		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
 			host->timeout_clk = host->mmc->actual_clock / 1000;
-			host->mmc->max_busy_timeout =
-				(1 << 27) / host->timeout_clk;
+			mmc->max_busy_timeout =
+					host->ops->get_max_timeout_count ?
+					host->ops->get_max_timeout_count(host) :
+					1 << 27;
+			mmc->max_busy_timeout /= host->timeout_clk;
 		}
 	}
 
@@ -2937,7 +2940,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
 		host->timeout_clk = mmc->f_max / 1000;
 
-	mmc->max_busy_timeout = (1 << 27) / host->timeout_clk;
+	mmc->max_busy_timeout = host->ops->get_max_timeout_count ?
+			host->ops->get_max_timeout_count(host) : 1 << 27;
+	mmc->max_busy_timeout /= host->timeout_clk;
 
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4a5cd5e..b130509 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -281,6 +281,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	unsigned int	(*get_max_timeout_count)(struct sdhci_host *host);
 	void		(*set_bus_width)(struct sdhci_host *host, int width);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
-- 
1.7.8

