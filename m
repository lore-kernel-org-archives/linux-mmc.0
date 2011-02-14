From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 4/4] sdhci: sdhci-pxa.c: add callback for signaling for DDR
Date: Sun, 13 Feb 2011 23:19:05 -0800
Message-ID: <30F8ED01-C591-4D70-BAE1-B96F396E4431@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50527 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367Ab1BNHZP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:25:15 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


controller needs to have 1.8V signaling voltage bit set
even if not doing 1.8V signaling for DDR to work.

The bit does not change the i/o signaling voltage

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 3d01f94..8527ac1 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -101,8 +101,25 @@ static unsigned int get_f_max_clock(struct sdhci_host *host)
 	return pxa->pdata->max_speed;
 }
 
+static unsigned int set_signaling_voltage(struct sdhci_host *host,
+	unsigned int ddr)
+{
+	u16 con;
+
+	pr_debug("%s:%s\n", __func__, mmc_hostname(host->mmc));
+	/*
+	 * Set V18_EN -- DDR does not work without this.
+	 * does not change signaling voltage
+	 */
+	con = readw(host->ioaddr + SDHCI_HOST_CONTROL_2);
+	con |= SDCTRL_2_SDH_V18_EN;
+	writew(con, host->ioaddr + SDHCI_HOST_CONTROL_2);
+	return 0;
+}
+
 static struct sdhci_ops sdhci_pxa_ops = {
 	.platform_reset_exit = platform_reset_exit,
+	.set_signaling_voltage = set_signaling_voltage,
 	.get_f_max_clock = NULL,
 };
 
-- 
1.7.0.4


