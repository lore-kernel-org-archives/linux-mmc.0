From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V2] mmc: sdhci add explicit callback to set f_max
Date: Fri, 29 Apr 2011 13:21:29 -0700
Message-ID: <343135FB-1668-463C-A155-359004845845@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34826 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061Ab1D2UYn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Apr 2011 16:24:43 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


We currently have callbacks for max_clk, f_min but
are missing the callback for f_max.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    9 ++++++---
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1709f8b..7a444f7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2364,9 +2364,12 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	mmc->ops = &sdhci_ops;
 	mmc->f_max = host->max_clk;
-	if (host->ops->get_min_clock)
-		mmc->f_min = host->ops->get_min_clock(host);
-	else if (host->version >= SDHCI_SPEC_300) {
+	if (host->ops->get_min_clock || host->ops->get_f_max_clock) {
+		if (host->ops->get_min_clock)
+			mmc->f_min = host->ops->get_min_clock(host);
+		if (host->ops->get_f_max_clock)
+			mmc->f_max = host->ops->get_f_max_clock(host);
+	} else if (host->version >= SDHCI_SPEC_300) {
 		if (host->clk_mul) {
 			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
 			mmc->f_max = host->max_clk * host->clk_mul;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 15cb026..7295c2a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -264,6 +264,7 @@ struct sdhci_ops {
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	int 	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
+	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
 
 };
 
-- 
1.7.0.4

