From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 27/32] mmc: sdhci: remove platform_suspend/platform_resume
 callbacks
Date: Fri, 25 Apr 2014 14:26:58 +0100
Message-ID: <E1Wdg9a-00080c-Gi@rmk-PC.arm.linux.org.uk>
References: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50687 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753677AbaDYN1C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:27:02 -0400
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

The only user (sdhci-of-esdhc) no longer uses these callbacks, so lets
remove them to discourage any further use.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 6 ------
 drivers/mmc/host/sdhci.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e5e9f2139f77..02d43765ddd5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2541,9 +2541,6 @@ EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
-	if (host->ops->platform_suspend)
-		host->ops->platform_suspend(host);
-
 	sdhci_disable_card_detection(host);
 
 	/* Disable tuning since we are suspending */
@@ -2600,9 +2597,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 	sdhci_enable_card_detection(host);
 
-	if (host->ops->platform_resume)
-		host->ops->platform_resume(host);
-
 	/* Set the re-tuning expiration flag */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER)
 		host->flags |= SDHCI_NEEDS_RETUNING;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7a35395e5f56..4a5cd5e3fa3e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -289,8 +289,6 @@ struct sdhci_ops {
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
 	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
-	void	(*platform_suspend)(struct sdhci_host *host);
-	void	(*platform_resume)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
-- 
1.8.3.1

