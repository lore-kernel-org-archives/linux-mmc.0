From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: [PATCH] mmc: tegra: don't enable UHS modes on Tegra210
Date: Wed, 30 Dec 2015 16:49:09 +0100
Message-ID: <1451490549-21430-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Tegra210 needs a different tuning sequence than Tegra30+. Disable
UHS modes until support for this is properly added.

Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
Ulf,
this is a follow on patch to my Tegra UHS-I series. After reading the
Tegra210 TRM I realized that the currently implemented tuning sequence will
only work on Tegra30..Tegra124.  If you don't keep your tree stable you
might want to squash this into [PATCH v2 4/5] mmc: tegra: enable UHS-I modes,
otherwise please pick this up as a fix on top.
---
 drivers/mmc/host/sdhci-tegra.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b5abbe2..83c4bf7 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -353,9 +353,6 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
-	.nvquirks = NVQUIRK_ENABLE_SDR50 |
-		    NVQUIRK_ENABLE_DDR50 |
-		    NVQUIRK_ENABLE_SDR104,
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
-- 
2.5.0
