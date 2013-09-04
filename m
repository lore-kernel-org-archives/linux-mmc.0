From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 7/8] mmc: sdhci-esdhc: set actual_clock in clock setting
Date: Wed, 4 Sep 2013 20:54:16 +0800
Message-ID: <1378299257-2980-8-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:29212
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932491Ab3IDNBm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2013 09:01:42 -0400
In-Reply-To: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, anton@enomsg.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, b29396@freescale.com

This enables access the actual_clock via sys.
root@imx6qsabreauto:~# cat /sys/kernel/debug/mmc0/ios
clock:          198000000 Hz
actual clock:   198000000 Hz
vdd:            17 (2.9 ~ 3.0 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 0 (1.80 V)

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c8a773b..eb22e5f 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -89,8 +89,9 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
 	while (host_clock / pre_div / div > clock && div < 16)
 		div++;
 
+	host->mmc->actual_clock = host_clock / pre_div / div;
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
-		clock, host_clock / pre_div / div);
+		clock, host->mmc->actual_clock);
 
 	pre_div >>= 1;
 	div--;
-- 
1.7.1


