From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] mmc: mmci: constify amba_id
Date: Wed, 23 Aug 2017 22:00:49 +0530
Message-ID: <7f877ee7a2a5eada613fcb7044e761248584922d.1503505752.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d1ca2f4..f1f54a8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1904,7 +1904,7 @@ static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
-static struct amba_id mmci_ids[] = {
+static const struct amba_id mmci_ids[] = {
 	{
 		.id	= 0x00041180,
 		.mask	= 0xff0fffff,
-- 
2.7.4
