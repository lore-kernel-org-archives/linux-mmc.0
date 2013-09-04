From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 6/8] mmc: sdhci-esdhc: correct pre_div for imx6q
Date: Wed, 4 Sep 2013 20:54:15 +0800
Message-ID: <1378299257-2980-7-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:10624
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760087Ab3IDNBc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2013 09:01:32 -0400
In-Reply-To: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, anton@enomsg.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, b29396@freescale.com

According to spec, the pre_div for imx6q should be 1, or the biggest clock
rate we can get is a half of host clock rate.
This may cause we can not get the proper clock rate as we want.
e.g. if the desired clock is 200Mhz, however, the host clock is 200Mhz too,
then it causes the actual clock we get is 100Mhz due to pre_div is 2.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 86fcd5b..c8a773b 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -66,6 +66,9 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
 	u32 temp, val;
 
 	dev = mmc_dev(host->mmc);
+	if (of_device_is_compatible(dev->of_node, "fsl,imx6q-usdhc"))
+		pre_div = 1;
+
 	if (clock == 0) {
 		if (of_device_is_compatible(dev->of_node, "fsl,imx6q-usdhc")) {
 			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
-- 
1.7.1


