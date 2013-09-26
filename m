From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/27] mmc: cb710: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:29 +0200
Message-ID: <1380207292-16968-5-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/cb710-mmc.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 9d6e2b8..1087b4c 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -667,12 +667,6 @@ static const struct mmc_host_ops cb710_mmc_host =3D=
 {
 static int cb710_mmc_suspend(struct platform_device *pdev, pm_message_=
t state)
 {
 	struct cb710_slot *slot =3D cb710_pdev_to_slot(pdev);
-	struct mmc_host *mmc =3D cb710_slot_to_mmc(slot);
-	int err;
-
-	err =3D mmc_suspend_host(mmc);
-	if (err)
-		return err;
=20
 	cb710_mmc_enable_irq(slot, 0, ~0);
 	return 0;
@@ -681,11 +675,9 @@ static int cb710_mmc_suspend(struct platform_devic=
e *pdev, pm_message_t state)
 static int cb710_mmc_resume(struct platform_device *pdev)
 {
 	struct cb710_slot *slot =3D cb710_pdev_to_slot(pdev);
-	struct mmc_host *mmc =3D cb710_slot_to_mmc(slot);
=20
 	cb710_mmc_enable_irq(slot, 0, ~0);
-
-	return mmc_resume_host(mmc);
+	return 0;
 }
=20
 #endif /* CONFIG_PM */
--=20
1.7.9.5
