From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH ulf.hansson-mmc] mmc: dw_mmc: exynos:
 dw_mci_exynos_prepare_hs400_tuning() can be static
Date: Thu, 5 Mar 2015 18:02:54 +0800
Message-ID: <20150305100254.GA66299@lkp-sb04.lkp.intel.com>
References: <201503051843.EsoMldBU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201503051843.EsoMldBU%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Kukjin Kim <kgene@kernel.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 dw_mmc-exynos.c |    2 +-
 dw_mmc.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0a56d766..e761eb1 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -477,7 +477,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
 	return ret;
 }
 
-int dw_mci_exynos_prepare_hs400_tuning(struct dw_mci *host,
+static int dw_mci_exynos_prepare_hs400_tuning(struct dw_mci *host,
 					struct mmc_ios *ios)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f30ef69..a99fa1b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1324,7 +1324,7 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return err;
 }
 
-int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
+static int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
