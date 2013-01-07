From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/2] mmc: sdhci: fix dummy regulator issue
Date: Mon,  7 Jan 2013 13:38:51 +0800
Message-ID: <1357537131-8000-2-git-send-email-kliu5@marvell.com>
References: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rainer Kaluscha <rainer.kaluscha@web.de>, Rainer Kaluscha <ich@rainer-kaluscha.de>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Should consider the case that dummy regulator is used for host->vmmc
and host->vqmmc and skip the regulator voltage check.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c13415c..561d126 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2897,8 +2897,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	} else {
 		regulator_enable(host->vqmmc);
-		if (!regulator_is_supported_voltage(host->vqmmc, 1700000,
-			1950000))
+		if ((regulator_is_supported_voltage(host->vqmmc, 1700000,
+			1950000) <= 0) && !regulator_is_dummy(host->vqmmc))
 			caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
 					SDHCI_SUPPORT_SDR50 |
 					SDHCI_SUPPORT_DDR50);
@@ -2965,7 +2965,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 
 #ifdef CONFIG_REGULATOR
-	if (host->vmmc) {
+	if (host->vmmc && !regulator_is_dummy(host->vmmc)) {
 		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
 			3600000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
-- 
1.7.9.5

