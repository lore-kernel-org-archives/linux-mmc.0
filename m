From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 7/9] mmc: sdhci-esdhc-imx: correct pre_div for imx6q
Date: Fri, 13 Sep 2013 19:11:36 +0800
Message-ID: <1379070698-7344-8-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.163.27] ([207.46.163.27]:26517 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751418Ab3IMLV2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 07:21:28 -0400
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net, b29396@freescale.com

According to spec, the pre_div for imx6q should be 1, or the biggest clock
rate we can get is a half of host clock rate.
This may cause we can not get the proper clock rate as we want.
e.g. if the desired clock is 200Mhz, however, the host clock is 200Mhz too,
then it causes the actual clock we get is 100Mhz due to pre_div is 2.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ed00d6d..fe48ec3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -510,6 +510,9 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		goto out;
 	}
 
+	if (is_imx6q_usdhc(imx_data))
+		pre_div = 1;
+
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
 	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
 		| ESDHC_CLOCK_MASK);
-- 
1.7.1


