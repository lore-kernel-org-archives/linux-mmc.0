From: Xiang Wang <wangxfdu@gmail.com>
Subject: [PATCH] mmc: sdhci-pxav3: fix error handling of sdhci_add_host
Date: Wed, 16 Jul 2014 15:50:09 +0800
Message-ID: <1405497009-20338-1-git-send-email-wangxfdu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Marcin Wojtas <mw@semihalf.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Xiang Wang <wangx@marvell.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chao Xie <cxie4@marvell.com>, Xiang Wang <wangxfdu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Xiang Wang <wangx@marvell.com>

Commit 0dcaa2499b7d111bd70da5b0976c34210c850fb3 improved error
handling of sdhci_add_host. However, "err_of_parse" and "err_cd_req"
should be placed after "pm_runtime_disable(&pdev->dev)".

Signed-off-by: Xiang Wang <wangx@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 2fd73b3..0644655 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -380,11 +380,11 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_of_parse:
-err_cd_req:
 err_add_host:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+err_of_parse:
+err_cd_req:
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 err_clk_get:
-- 
1.7.5.4
