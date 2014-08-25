From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 11/12] mmc: tmio_mmc: Fixup system PM suspend lock-up
Date: Mon, 25 Aug 2014 14:26:03 +0200
Message-ID: <1408969564-6335-12-git-send-email-ulf.hansson@linaro.org>
References: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1408969564-6335-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

At system PM suspend, the tmio core accessed the internal registers of
the controller without first moving the device into active state. This
caused a lock-up in system PM suspend phase.

The reason for the register access were masking of IRQs. Since that is
managed via the runtime PM suspend path, let's just re-use that path
for system PM suspend.

In other words force the device into runtime PM suspend state at system
PM suspend and restore it to active state at system PM resume.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 58f50ef..659028d 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -30,7 +30,7 @@ static int tmio_mmc_suspend(struct device *dev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	int ret;
 
-	ret = tmio_mmc_host_suspend(dev);
+	ret = pm_runtime_force_suspend(dev);
 
 	/* Tell MFD core it can disable us now.*/
 	if (!ret && cell->disable)
@@ -50,7 +50,7 @@ static int tmio_mmc_resume(struct device *dev)
 		ret = cell->resume(pdev);
 
 	if (!ret)
-		ret = tmio_mmc_host_resume(dev);
+		ret = pm_runtime_force_resume(dev);
 
 	return ret;
 }
-- 
1.9.1

