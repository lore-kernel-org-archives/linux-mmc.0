From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: use mmc_of_parse and remove the card_tasklet
Date: Mon, 26 May 2014 13:58:28 +0900
Message-ID: <1401080308-19974-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21194 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaEZE6g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 00:58:36 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N66000Z20HMWW80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 May 2014 13:58:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

=46ix the compile error.
(Removed the card_tasklet at "mmc: sdhci: push card_tasklet into treade=
d irq handler")

drivers/mmc/host/sdhci-s3c.c: In function =E2=80=98sdhci_s3c_notify_cha=
nge=E2=80=99:
drivers/mmc/host/sdhci-s3c.c:402:25: error: =E2=80=98struct sdhci_host=E2=
=80=99 has no member named =E2=80=98card_tasklet=E2=80=99

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   99 ++--------------------------------=
--------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.=
c
index 781b8a9..fa5954a 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -374,82 +374,12 @@ static struct sdhci_ops sdhci_s3c_ops =3D {
 	.set_uhs_signaling	=3D sdhci_set_uhs_signaling,
 };
=20
-static void sdhci_s3c_notify_change(struct platform_device *dev, int s=
tate)
-{
-	struct sdhci_host *host =3D platform_get_drvdata(dev);
-#ifdef CONFIG_PM_RUNTIME
-	struct sdhci_s3c *sc =3D sdhci_priv(host);
-#endif
-	unsigned long flags;
-
-	if (host) {
-		spin_lock_irqsave(&host->lock, flags);
-		if (state) {
-			dev_dbg(&dev->dev, "card inserted.\n");
-#ifdef CONFIG_PM_RUNTIME
-			clk_prepare_enable(sc->clk_io);
-#endif
-			host->flags &=3D ~SDHCI_DEVICE_DEAD;
-			host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-		} else {
-			dev_dbg(&dev->dev, "card removed.\n");
-			host->flags |=3D SDHCI_DEVICE_DEAD;
-			host->quirks &=3D ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-#ifdef CONFIG_PM_RUNTIME
-			clk_disable_unprepare(sc->clk_io);
-#endif
-		}
-		tasklet_schedule(&host->card_tasklet);
-		spin_unlock_irqrestore(&host->lock, flags);
-	}
-}
-
-static irqreturn_t sdhci_s3c_gpio_card_detect_thread(int irq, void *de=
v_id)
-{
-	struct sdhci_s3c *sc =3D dev_id;
-	int status =3D gpio_get_value(sc->ext_cd_gpio);
-	if (sc->pdata->ext_cd_gpio_invert)
-		status =3D !status;
-	sdhci_s3c_notify_change(sc->pdev, status);
-	return IRQ_HANDLED;
-}
-
-static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
-{
-	struct s3c_sdhci_platdata *pdata =3D sc->pdata;
-	struct device *dev =3D &sc->pdev->dev;
-
-	if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT CD") =3D=3D=
 0) {
-		sc->ext_cd_gpio =3D pdata->ext_cd_gpio;
-		sc->ext_cd_irq =3D gpio_to_irq(pdata->ext_cd_gpio);
-		if (sc->ext_cd_irq &&
-		    request_threaded_irq(sc->ext_cd_irq, NULL,
-					 sdhci_s3c_gpio_card_detect_thread,
-					 IRQF_TRIGGER_RISING |
-					 IRQF_TRIGGER_FALLING |
-					 IRQF_ONESHOT,
-					 dev_name(dev), sc) =3D=3D 0) {
-			int status =3D gpio_get_value(sc->ext_cd_gpio);
-			if (pdata->ext_cd_gpio_invert)
-				status =3D !status;
-			sdhci_s3c_notify_change(sc->pdev, status);
-		} else {
-			dev_warn(dev, "cannot request irq for card detect\n");
-			sc->ext_cd_irq =3D 0;
-		}
-	} else {
-		dev_err(dev, "cannot request gpio for card detect\n");
-	}
-}
-
 #ifdef CONFIG_OF
 static int sdhci_s3c_parse_dt(struct device *dev,
 		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
 {
 	struct device_node *node =3D dev->of_node;
-	struct sdhci_s3c *ourhost =3D to_s3c(host);
 	u32 max_width;
-	int gpio;
=20
 	/* if the bus-width property is not specified, assume width as 1 */
 	if (of_property_read_u32(node, "bus-width", &max_width))
@@ -467,18 +397,8 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 		return 0;
 	}
=20
-	gpio =3D of_get_named_gpio(node, "cd-gpios", 0);
-	if (gpio_is_valid(gpio)) {
-		pdata->cd_type =3D S3C_SDHCI_CD_GPIO;
-		pdata->ext_cd_gpio =3D gpio;
-		ourhost->ext_cd_gpio =3D -1;
-		if (of_get_property(node, "cd-inverted", NULL))
-			pdata->ext_cd_gpio_invert =3D 1;
+	if (of_get_named_gpio(node, "cd-gpios", 0))
 		return 0;
-	} else if (gpio !=3D -ENOENT) {
-		dev_err(dev, "invalid card detect gpio specified\n");
-		return -EINVAL;
-	}
=20
 	/* assuming internal card detect that will be configured by pinctrl *=
/
 	pdata->cd_type =3D S3C_SDHCI_CD_INTERNAL;
@@ -681,6 +601,8 @@ static int sdhci_s3c_probe(struct platform_device *=
pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_suspend_ignore_children(&pdev->dev, 1);
=20
+	mmc_of_parse(host->mmc);
+
 	ret =3D sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
@@ -689,15 +611,6 @@ static int sdhci_s3c_probe(struct platform_device =
*pdev)
 		goto err_req_regs;
 	}
=20
-	/* The following two methods of card detection might call
-	   sdhci_s3c_notify_change() immediately, so they can be called
-	   only after sdhci_add_host(). Setup errors are ignored. */
-	if (pdata->cd_type =3D=3D S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init=
)
-		pdata->ext_cd_init(&sdhci_s3c_notify_change);
-	if (pdata->cd_type =3D=3D S3C_SDHCI_CD_GPIO &&
-	    gpio_is_valid(pdata->ext_cd_gpio))
-		sdhci_s3c_setup_card_detect_gpio(sc);
-
 #ifdef CONFIG_PM_RUNTIME
 	if (pdata->cd_type !=3D S3C_SDHCI_CD_INTERNAL)
 		clk_disable_unprepare(sc->clk_io);
@@ -718,16 +631,12 @@ static int sdhci_s3c_remove(struct platform_devic=
e *pdev)
 {
 	struct sdhci_host *host =3D  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc =3D sdhci_priv(host);
-	struct s3c_sdhci_platdata *pdata =3D sc->pdata;
-
-	if (pdata->cd_type =3D=3D S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_clea=
nup)
-		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
=20
 	if (sc->ext_cd_irq)
 		free_irq(sc->ext_cd_irq, sc);
=20
 #ifdef CONFIG_PM_RUNTIME
-	if (pdata->cd_type !=3D S3C_SDHCI_CD_INTERNAL)
+	if (sc->pdata->cd_type !=3D S3C_SDHCI_CD_INTERNAL)
 		clk_prepare_enable(sc->clk_io);
 #endif
 	sdhci_remove_host(host, 1);
--=20
1.7.9.5

