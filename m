From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: increase the pad I/O drive strength for DDR50 card
Date: Mon, 17 Apr 2017 19:10:02 +0800
Message-ID: <1492427402-5506-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:28320
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751894AbdDQLDp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 17 Apr 2017 07:03:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com
Cc: tharvey@gateworks.com, stable@vger.kernel.org, linux-mmc@vger.kernel.org

Currently for DDR50 card, it need tuning in default. We meet tuning fail
issue for DDR50 card and some data CRC error when DDR50 sd card works.

This is because the default pad I/O drive strength can't make sure DDR50
card work stable. So increase the pad I/O drive strength for DDR50 card,
and use pins_100mhz.

Tested-and-reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index cf666a0..abad67a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -830,6 +830,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 
 	switch (uhs) {
 	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_DDR50:
 		pinctrl = imx_data->pins_100mhz;
 		break;
 	case MMC_TIMING_UHS_SDR104:
-- 
1.9.1

