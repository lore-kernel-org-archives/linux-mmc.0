From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 1/9] mmc: sdhci: add hooks for platform specific tuning
Date: Fri, 13 Sep 2013 19:11:30 +0800
Message-ID: <1379070698-7344-2-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [65.55.88.13] ([65.55.88.13]:13852 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752118Ab3IMLVF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 07:21:05 -0400
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net, b29396@freescale.com

The tuning of some platforms may not follow the standard host control
spec v3.0, e.g. Freescale uSDHC on i.MX6Q/DL.
Add a hook here to allow execute platform specific tuning instead of
standard host controller tuning.

The hook only replaces the tuning process, so it's placed after tuning
checking and before the real tuning process.

Some notes for the tuning hook:
1) it needs handle lock itself if it wants to access host controller
according platform specific implementation.
2) do not need to handle runtime pm since it executes with runtime pm
get already.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
ChangeLog since v1:
* add more description of hook in commit message
---
 drivers/mmc/host/sdhci.c |    8 ++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a7fb4f..072d78c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1875,6 +1875,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return 0;
 	}
 
+	if (host->ops->platform_execute_tuning) {
+		spin_unlock(&host->lock);
+		enable_irq(host->irq);
+		err = host->ops->platform_execute_tuning(host, opcode);
+		sdhci_runtime_pm_put(host);
+		return err;
+	}
+
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b037f18..976c14b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -288,6 +288,7 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
+	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
-- 
1.7.1


