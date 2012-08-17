From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: tegra: convert to device tree support only
Date: Fri, 17 Aug 2012 15:04:31 +0800
Message-ID: <1345187071-6619-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

When compiling a kernel that supports only Tegra30 and not Tegra20,
the SDHCI driver will fail to compile since the of_match_device() failure
fallback code unconditinally references soc_data_tegra20, which is only
compiled in when Tegra20 support is enabled.

In Kernel 3.7, both Tegra20 and Tegra30 will only support booting using
device tree, Hence, there is never a need to fall back to using
soc_data_tegra20 if of_mach_device() fails. Instead, make this case an
error. This removes the reference to soc_data_tegra20, and hence solves
the compile failure.

Signed-off-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0810ccc..436186c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -257,10 +257,9 @@ static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
 	int rc;
 
 	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
-	if (match)
-		soc_data = match->data;
-	else
-		soc_data = &soc_data_tegra20;
+	if (!match)
+		return -EINVAL;
+	soc_data = match->data;
 
 	host = sdhci_pltfm_init(pdev, soc_data->pdata);
 	if (IS_ERR(host))
-- 
1.7.0.4
