From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 3/6] mmc: sdhci: add platform set_timeout hook
Date: Wed, 27 Aug 2014 15:26:29 +0800
Message-ID: <1409124392-28899-4-git-send-email-b29396@freescale.com>
References: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:19113
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752562AbaH0Hpv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Aug 2014 03:45:51 -0400
In-Reply-To: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

Currently the common code assume 0xE is the maximum timeout counter
value and use it to write into the timeout counter register.
However, it's fairly possible that some other SoCs may have different
max timeout register value. That means 0xE may be incorrect and
becomes meaningless.

It's also possible that other platforms has different timeout
calculation algorithm. To be flexible, this patch provides a .set_timeout
hook for those platforms to set the timeout on their way if they need.

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |   19 ++++++++++++++-----
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d633f288..881a7a0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -707,19 +707,28 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
-static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
+
+	if (host->ops->set_timeout) {
+		host->ops->set_timeout(host, cmd);
+	} else {
+		count = sdhci_calc_timeout(host, cmd);
+		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
+	}
+}
+
+static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+{
 	u8 ctrl;
 	struct mmc_data *data = cmd->data;
 	int ret;
 
 	WARN_ON(host->data);
 
-	if (data || (cmd->flags & MMC_RSP_BUSY)) {
-		count = sdhci_calc_timeout(host, cmd);
-		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
-	}
+	if (data || (cmd->flags & MMC_RSP_BUSY))
+		sdhci_set_timeout(host, cmd);
 
 	if (!data)
 		return;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b130509..9828ff8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -282,6 +282,8 @@ struct sdhci_ops {
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	unsigned int	(*get_max_timeout_count)(struct sdhci_host *host);
+	void		(*set_timeout)(struct sdhci_host *host,
+				       struct mmc_command *cmd);
 	void		(*set_bus_width)(struct sdhci_host *host, int width);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
-- 
1.7.8

