From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/12] mmc: tmio_mmc: Enable runtime PM support
Date: Mon, 25 Aug 2014 14:26:01 +0200
Message-ID: <1408969564-6335-10-git-send-email-ulf.hansson@linaro.org>
References: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

To take advantage of the clock gating support, use the runtime PM
callbacks provided by the tmio core.

Additionally, we make use of the SET_PM_RUNTIME_PM_OPS, which is a
preparation needed to simplify system PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index cfad844..58f50ef 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -135,6 +135,9 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tmio_mmc_suspend, tmio_mmc_resume)
+	SET_PM_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+			tmio_mmc_host_runtime_resume,
+			NULL)
 };
 
 static struct platform_driver tmio_mmc_driver = {
-- 
1.9.1
