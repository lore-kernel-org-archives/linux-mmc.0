From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 3/3] sdhci: add support for DDR to platform code
Date: Thu, 20 Jan 2011 20:29:36 -0800
Message-ID: <673349E8-F326-4620-AF2C-CCBF11645B71@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54426 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753681Ab1AUEdI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Jan 2011 23:33:08 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Mark Brown <markb@marvell.com>


set the callback for signaling voltage for Dual Data Rate.

The controller requires V18_EN be set for DDR to work.  The
bit enables DDR but does not affect any signaling voltages.
no mdelay is needed.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..8f9a04e 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -69,8 +69,23 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+static unsigned int set_signaling_voltage(struct sdhci_host *host,
+	unsigned int ddr)
+{
+	u16 con;
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
 	.set_clock = set_clock,
+	.set_signaling_voltage = set_signaling_voltage,
 };
 
 /*****************************************************************************\
-- 
1.7.0.4


