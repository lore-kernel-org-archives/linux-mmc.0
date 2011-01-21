From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: support setting f_max clock via call back
Date: Fri, 21 Jan 2011 11:28:29 -0800
Message-ID: <EFB42CB6-2B1D-4A01-851D-1EE27E35D021@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49023 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752212Ab1AUTaJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:30:09 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


need ability to set f_max independent of max_clk.

We cannot use the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
since the clock is not broken and on mmp2 is fixed at 200MHz.
On some pxa platforms and changing this value
a) does not work
b) causes bad clock dividers
c) mmc errors

On other platforms defining
SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN is the right thing to do
(pxa168 and pxa910) since the clock is configured via system
registers and not known via the CAPABILITY Register.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 +++++++-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f439881..6486009 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1884,7 +1884,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-	mmc->f_max = host->max_clk;
+	if (host->ops->get_f_max_clock) {
+		mmc->f_max = host->ops->get_f_max_clock(host);
+		if (mmc->f_max > host->max_clk)
+			mmc->f_max = host->max_clk;
+	} else
+		mmc->f_max = host->max_clk;
+
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9dd7bc1..a8c43c9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -224,6 +224,7 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
+	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


