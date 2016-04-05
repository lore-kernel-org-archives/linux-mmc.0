From: David Lechner <david@lechnology.com>
Subject: [PATCH v4 2/3] mmc: davinci: prepare clock
Date: Tue,  5 Apr 2016 12:31:50 -0500
Message-ID: <1459877512-25479-3-git-send-email-david@lechnology.com>
References: <1459877512-25479-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459877512-25479-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When trying to use this driver with the common clock framework, enabling
the clock fails because it was not prepared. This fixes the problem by
calling clk_prepare and clk_enable in a single function. Ditto for
clk_disable_unprepare.

Signed-off-by: David Lechner <david@lechnology.com>
---

no change

 drivers/mmc/host/davinci_mmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 8503214..a56373c 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1245,9 +1245,9 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		ret = PTR_ERR(host->clk);
 		goto clk_get_fail;
 	}
-	ret = clk_enable(host->clk);
+	ret = clk_prepare_enable(host->clk);
 	if (ret)
-		goto clk_enable_fail;
+		goto clk_prepare_enable_fail;
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
@@ -1353,8 +1353,8 @@ mmc_add_host_fail:
 cpu_freq_fail:
 	davinci_release_dma_channels(host);
 dma_probe_defer:
-	clk_disable(host->clk);
-clk_enable_fail:
+	clk_disable_unprepare(host->clk);
+clk_prepare_enable_fail:
 clk_get_fail:
 ioremap_fail:
 	mmc_free_host(mmc);
@@ -1369,7 +1369,7 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
 	mmc_remove_host(host->mmc);
 	mmc_davinci_cpufreq_deregister(host);
 	davinci_release_dma_channels(host);
-	clk_disable(host->clk);
+	clk_disable_unprepare(host->clk);
 	mmc_free_host(host->mmc);
 
 	return 0;
-- 
1.9.1
