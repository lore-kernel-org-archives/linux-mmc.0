From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 30/31] mmc: sdhci: remove platform_suspend/platform_resume
 callbacks
Date: Tue, 18 Feb 2014 15:11:36 +0000
Message-ID: <E1WFmKe-0006nr-Mr@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40582 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756282AbaBRPLi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:11:38 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

The only user (sdhci-of-esdhc) no longer uses these callbacks, so lets
remove them to discourage any further use.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c | 6 ------
 drivers/mmc/host/sdhci.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 224ca833410c..2ed89c4aa176 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -2533,9 +2533,6 @@ EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
-	if (host->ops->platform_suspend)
-		host->ops->platform_suspend(host);
-
 	sdhci_disable_card_detection(host);
 
 	/* Disable tuning since we are suspending */
@@ -2592,9 +2589,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 	sdhci_enable_card_detection(host);
 
-	if (host->ops->platform_resume)
-		host->ops->platform_resume(host);
-
 	/* Set the re-tuning expiration flag */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER)
 		host->flags |= SDHCI_NEEDS_RETUNING;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7a35395e5f56..4a5cd5e3fa3e 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.h
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

