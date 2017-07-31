From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: sdhci-msm: add static to local functions
Date: Mon, 31 Jul 2017 21:00:46 +0900
Message-ID: <1501502446-13931-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Detected by sparse.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9d601dc0d646..f35db061ee4c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -611,7 +611,7 @@ static void msm_hc_select_hs400(struct sdhci_host *host)
  * HS400 - divided clock (free running MCLK/2)
  * All other modes - default (free running MCLK)
  */
-void sdhci_msm_hc_select_mode(struct sdhci_host *host)
+static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
 {
 	struct mmc_ios ios = host->mmc->ios;
 
@@ -1049,7 +1049,7 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
  * instead directly control the GCC clock as per
  * HW recommendation.
  **/
-void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
+static void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	u16 clk;
 	/*
-- 
2.7.4
