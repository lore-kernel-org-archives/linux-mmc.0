From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: allow controller private registers to be changaed on
 reset
Date: Fri, 24 Sep 2010 09:42:15 -0700
Message-ID: <772C1381-0CF0-41CD-B580-CBD090BBA1AB@marvell.com>
References: <3622567C-B5F4-40D4-A525-0AAE641E2B28@marvell.com>
 <73FAA3FF-6415-4A67-94FE-F93C3DA4A05C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44420 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933015Ab0IXQmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Sep 2010 12:42:21 -0400
In-Reply-To: <73FAA3FF-6415-4A67-94FE-F93C3DA4A05C@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

>From 9d64df0fa6874371446147f67c071e78c587c0d6 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Fri, 24 Sep 2010 05:27:11 -0700
Subject: [PATCH] sdhci: allow controller private registers to be changaed on reset

allow controllers that have private registers that are reset when
the controller is reset. They need to be reprogrammed back to their
values when the reset happens.  Provide a hook to allow this to happen.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    3 +++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..0774dad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -174,6 +174,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
+
+	if (host->ops->platform_specific_reset)
+		host->ops->platform_specific_reset(host, mask);
 }
 
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d316bc7..f68af47 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -323,6 +323,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	void	(*platform_specific_reset)(struct sdhci_host *host, u8 mask);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.0.4

