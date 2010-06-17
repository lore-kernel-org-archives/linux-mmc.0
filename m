From: =?utf-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] mxcmmc: convert to pm_ops and enable/disable clock
Date: Thu, 17 Jun 2010 20:59:07 +0200
Message-ID: <1276801147-4103-7-git-send-email-eric@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
 <1276801147-4103-2-git-send-email-eric@eukrea.com>
 <1276801147-4103-3-git-send-email-eric@eukrea.com>
 <1276801147-4103-4-git-send-email-eric@eukrea.com>
 <1276801147-4103-5-git-send-email-eric@eukrea.com>
 <1276801147-4103-6-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:50107 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757354Ab0FQS7j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Jun 2010 14:59:39 -0400
In-Reply-To: <1276801147-4103-6-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
Cc: s.hauer@pengutronix.de
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mmc/host/mxcmmc.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index fdf33e8..350f78e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -936,43 +936,47 @@ static int mxcmci_remove(struct platform_device *=
pdev)
 }
=20
 #ifdef CONFIG_PM
-static int mxcmci_suspend(struct platform_device *dev, pm_message_t st=
ate)
+static int mxcmci_suspend(struct device *dev)
 {
-	struct mmc_host *mmc =3D platform_get_drvdata(dev);
+	struct mmc_host *mmc =3D dev_get_drvdata(dev);
+	struct mxcmci_host *host =3D mmc_priv(mmc);
 	int ret =3D 0;
=20
 	if (mmc)
 		ret =3D mmc_suspend_host(mmc);
+	clk_disable(host->clk);
=20
 	return ret;
 }
=20
-static int mxcmci_resume(struct platform_device *dev)
+static int mxcmci_resume(struct device *dev)
 {
-	struct mmc_host *mmc =3D platform_get_drvdata(dev);
-	struct mxcmci_host *host;
+	struct mmc_host *mmc =3D dev_get_drvdata(dev);
+	struct mxcmci_host *host =3D mmc_priv(mmc);
 	int ret =3D 0;
=20
-	if (mmc) {
-		host =3D mmc_priv(mmc);
+	clk_enable(host->clk);
+	if (mmc)
 		ret =3D mmc_resume_host(mmc);
-	}
=20
 	return ret;
 }
-#else
-#define mxcmci_suspend  NULL
-#define mxcmci_resume   NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops mxcmci_pm_ops =3D {
+	.suspend	=3D mxcmci_suspend,
+	.resume		=3D mxcmci_resume,
+};
+#endif
=20
 static struct platform_driver mxcmci_driver =3D {
 	.probe		=3D mxcmci_probe,
 	.remove		=3D mxcmci_remove,
-	.suspend	=3D mxcmci_suspend,
-	.resume		=3D mxcmci_resume,
 	.driver		=3D {
 		.name		=3D DRIVER_NAME,
 		.owner		=3D THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	=3D &mxcmci_pm_ops,
+#endif
 	}
 };
=20
--=20
1.6.3.3

