From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 8/9] mmc: sdhci-esdhc-imx: set actual_clock in clock setting
Date: Fri, 13 Sep 2013 19:11:37 +0800
Message-ID: <1379070698-7344-9-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.163.24] ([207.46.163.24]:39673 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754596Ab3IMLVb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 07:21:31 -0400
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net, b29396@freescale.com

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
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fe48ec3..b9899e9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -524,8 +524,9 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
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


