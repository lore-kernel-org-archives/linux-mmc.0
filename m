From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: increase the pad I/O drive strength for DDR50 card
Date: Wed, 19 Apr 2017 10:53:51 +0800
Message-ID: <1492570431-5532-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, tharvey@gateworks.com
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Currently for DDR50 card, it need tuning in default. We meet tuning fail
issue for DDR50 card and some data CRC error when DDR50 sd card works.

This is because the default pad I/O drive strength can't make sure DDR50
card work stable. So increase the pad I/O drive strength for DDR50 card,
and use pins_100mhz.

This fixes DDR50 card support for IMX since DDR50 tuning was enabled from
commit 9faac7b95ea4 ("mmc: sdhci: enable tuning for DDR50")

Tested-and-reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org # v4.4+
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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
