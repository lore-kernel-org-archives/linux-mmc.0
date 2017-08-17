From: Timo Alho <talho-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: tegra: suppress errors when probe is deferred
Date: Thu, 17 Aug 2017 14:52:46 +0300
Message-ID: <1502970766-23541-1-git-send-email-talho@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Timo Alho <talho-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Don't print error message when clk_get() returns -EPROBE_DEFER. On
recent Tegra chips (t186 onwards), the clocks are provided by
auxiliary microprocessor (bpmp) and until the driver for it is probed
clocks are not available.

While at it, change the real error message more meaningful.

Signed-off-by: Timo Alho <talho-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f668a6f..cdde9ff 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -501,8 +501,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
-		dev_err(mmc_dev(host->mmc), "clk err\n");
 		rc = PTR_ERR(clk);
+		if (rc != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to get controller clock: %d\n", rc);
 		goto err_clk_get;
 	}
 	clk_prepare_enable(clk);
-- 
2.7.4
