From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] mmc: dw_mmc: exynos: remove incorrect __exit_p()
Date: Fri, 23 Jan 2015 16:33:40 -0800
Message-ID: <20150124003340.GA16286@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Kukjin Kim <kgene@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

dw_mci_pltfm_remove() is not (nor should it be) marked as __exit,
so we should not be using __exit_p() wrapper with it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 12a5eaa..fe32948 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -422,7 +422,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops = {
 
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.probe		= dw_mci_exynos_probe,
-	.remove		= __exit_p(dw_mci_pltfm_remove),
+	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_exynos",
 		.of_match_table	= dw_mci_exynos_match,
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
