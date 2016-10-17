From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] mmc: sdhci-of-at91: Fix module autoload
Date: Mon, 17 Oct 2016 13:13:45 -0300
Message-ID: <1476720825-30442-2-git-send-email-javier@osg.samsung.com>
References: <1476720825-30442-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476720825-30442-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/mmc/host/sdhci-of-at91.ko | grep alias
$

After this patch:

$ modinfo drivers/mmc/host/sdhci-of-at91.ko | grep alias
alias:          of:N*T*Catmel,sama5d2-sdhciC*
alias:          of:N*T*Catmel,sama5d2-sdhci

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/mmc/host/sdhci-of-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index a9b7fc06c434..2f9ad213377a 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -100,6 +100,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
 	{ .compatible = "atmel,sama5d2-sdhci", .data = &soc_data_sama5d2 },
 	{}
 };
+MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
 
 #ifdef CONFIG_PM
 static int sdhci_at91_runtime_suspend(struct device *dev)
-- 
2.7.4
