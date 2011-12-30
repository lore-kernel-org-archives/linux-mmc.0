From: NeilBrown <neilb@suse.de>
Subject: [PATCH] omap_hsmmc - use threaded irq handler for card-detect.
Date: Fri, 30 Dec 2011 12:35:13 +1100
Message-ID: <20111230123513.6a843526@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/RArZZEY8frjVL5viKLgm3lm"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

--Sig_/RArZZEY8frjVL5viKLgm3lm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



As the card-detect irq handler just schedules work to be done by
a thread, we can use request_threaded_irq to do much of the work for
us.  This means that interrupts which arrive by handle_nested_irq
actually work.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d5fe43d..56f6cfc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -24,7 +24,6 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <linux/workqueue.h>
 #include <linux/timer.h>
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
@@ -163,7 +162,6 @@ struct omap_hsmmc_host {
 	 */
 	struct	regulator	*vcc;
 	struct	regulator	*vcc_aux;
-	struct	work_struct	mmc_carddetect_work;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
@@ -1280,17 +1278,16 @@ static void omap_hsmmc_protect_card(struct omap_hsm=
mc_host *host)
 }
=20
 /*
- * Work Item to notify the core about card insertion/removal
+ * irq handler to notify the core about card insertion/removal
  */
-static void omap_hsmmc_detect(struct work_struct *work)
+static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 {
-	struct omap_hsmmc_host *host =3D
-		container_of(work, struct omap_hsmmc_host, mmc_carddetect_work);
+	struct omap_hsmmc_host *host =3D dev_id;
 	struct omap_mmc_slot_data *slot =3D &mmc_slot(host);
 	int carddetect;
=20
 	if (host->suspended)
-		return;
+		return IRQ_HANDLED;
=20
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
=20
@@ -1305,19 +1302,6 @@ static void omap_hsmmc_detect(struct work_struct *wo=
rk)
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	else
 		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
-}
-
-/*
- * ISR for handling card insertion and removal
- */
-static irqreturn_t omap_hsmmc_cd_handler(int irq, void *dev_id)
-{
-	struct omap_hsmmc_host *host =3D (struct omap_hsmmc_host *)dev_id;
-
-	if (host->suspended)
-		return IRQ_HANDLED;
-	schedule_work(&host->mmc_carddetect_work);
-
 	return IRQ_HANDLED;
 }
=20
@@ -1919,7 +1903,6 @@ static int __init omap_hsmmc_probe(struct platform_de=
vice *pdev)
 	host->next_data.cookie =3D 1;
=20
 	platform_set_drvdata(pdev, host);
-	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
=20
 	mmc->ops	=3D &omap_hsmmc_ops;
=20
@@ -2047,10 +2030,11 @@ static int __init omap_hsmmc_probe(struct platform_=
device *pdev)
=20
 	/* Request IRQ for card detect */
 	if ((mmc_slot(host).card_detect_irq)) {
-		ret =3D request_irq(mmc_slot(host).card_detect_irq,
-				  omap_hsmmc_cd_handler,
-				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				  mmc_hostname(mmc), host);
+		ret =3D request_threaded_irq(mmc_slot(host).card_detect_irq,
+					   NULL,
+					   omap_hsmmc_detect,
+					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					   mmc_hostname(mmc), host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
 				"Unable to grab MMC CD IRQ\n");
@@ -2129,7 +2113,6 @@ static int omap_hsmmc_remove(struct platform_device *=
pdev)
 		free_irq(host->irq, host);
 		if (mmc_slot(host).card_detect_irq)
 			free_irq(mmc_slot(host).card_detect_irq, host);
-		flush_work_sync(&host->mmc_carddetect_work);
=20
 		pm_runtime_put_sync(host->dev);
 		pm_runtime_disable(host->dev);
@@ -2176,7 +2159,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 				return ret;
 			}
 		}
-		cancel_work_sync(&host->mmc_carddetect_work);
 		ret =3D mmc_suspend_host(host->mmc);
=20
 		if (ret =3D=3D 0) {

--Sig_/RArZZEY8frjVL5viKLgm3lm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTv0VUTnsnt1WYoG5AQIoRw//TuWbRjM8YZUxhLe7D0bDH5jRzxlMHHQn
FTwwtXNjYCsf4ApCzNpytWiysz+4HS7oj+0SMRFe7Ass1luuoWjmUvHyNuSi0QuI
/5ubBiQV4KiXajLI8q+oLzIdgEVxCKkzOfBkmRRUAe2WwvWvKHF86d30RSs9uzbl
DN+06uXlPA9HaTqfZI0XON/CArytyNzfsvpTmZmbPOhhW2D920NHYUdWBrwUAANb
P/QpSw+QOSj6qemb/pVoGFfEMxI2Qx7wJPKhVxcn+R5lJ21w1ctoTF+ePGp9csUF
1NCdZgCqbQaXxwH+xdHtrFEk1TURQGNrbImCREuo2Jp3/9aUFahdUZs3Td8zHWDS
x2VSiRYebxfMO6a8/pP88dwtjxIG86d+2h9j2fxNdp54TsFz+Vmxccf2RMayZb57
LcV6ZbytQxgDxaM5GyCxo2q6lr8B68ks8V4C7Zywbr7s1OHH9q4d9EOmjC2rZ1qr
m2CE+V1neTHlaRRed+cFa34hZ5W96z2X3zL+uYdeC3rfDXmDRAZ4TI5HQWUu6ToG
eWFXkxwDRsZgLi+dqGBE/O3umJ5FOXcchL/f9uvS06HwnoZDwAy0OGaFBq/DMYOf
kt0Hvo6tl/TGi8ESFqMdb0au0sgcWjmM8Eel9FgaYWsLB3xOwo7Boeibo92q1QWH
uBsaWvUKp5g=
=DQzd
-----END PGP SIGNATURE-----

--Sig_/RArZZEY8frjVL5viKLgm3lm--
