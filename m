From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 3/5] mmc: dw_mmc-pltfm: Remove superflous #else condition on CONFIG_PM_SLEEP
Date: Tue, 12 Aug 2014 17:14:27 +0100
Message-ID: <1407860069-12706-4-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, jarkko.lavinen@nokia.com, balajitk@ti.com, baohua@kernel.org, viresh.linux@gmail.com, ian.molton@codethink.co.uk, maxime.ripard@free-electrons.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org, michal.simek@xilinx.com, swarren@wwwdotorg.org
Cc: peter.griffin@linaro.org, patches@linaro.org, lee.jones@linaro.org
List-Id: linux-mmc@vger.kernel.org

As the code is using SIMPLE_DEV_PM_OPS helper, this compiles away to
nothing if CONFIG_PM_SLEEP is disabled. Thus we don't need to #define
the suspend/resume callbacks to NULL.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index d4a47a9..fbcb5a3 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -84,9 +84,6 @@ static int dw_mci_pltfm_resume(struct device *dev)
 
 	return dw_mci_resume(host);
 }
-#else
-#define dw_mci_pltfm_suspend	NULL
-#define dw_mci_pltfm_resume	NULL
 #endif /* CONFIG_PM_SLEEP */
 
 SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
-- 
1.9.1
