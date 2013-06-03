From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH V2] mmc: host: use platform_{get,set}_drvdata()
Date: Mon, 03 Jun 2013 13:41:03 +0900
Message-ID: <001d01ce6014$8d8f8a50$a8ae9ef0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28855 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3FCElE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2013 00:41:04 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNS001NCVNJE5I0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Jun 2013 13:41:03 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, =?iso-8859-2?Q?'_Micha=B3_Miros=B3aw_'?= <mirq-linux@rere.qmqm.pl>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->de=
v,
so we can directly pass a struct platform_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
---
Changes since v1:
- Fixed the missed counterpart - cb710_slot_to_mmc() in cb710-mmc.h.

 drivers/mmc/host/cb710-mmc.c      |    2 +-
 drivers/mmc/host/cb710-mmc.h      |    2 +-
 drivers/mmc/host/sh_mobile_sdhi.c |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 777ca20..9d6e2b8 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -703,7 +703,7 @@ static int cb710_mmc_init(struct platform_device *p=
dev)
 	if (!mmc)
 		return -ENOMEM;
=20
-	dev_set_drvdata(&pdev->dev, mmc);
+	platform_set_drvdata(pdev, mmc);
=20
 	/* harmless (maybe) magic */
 	pci_read_config_dword(chip->pdev, 0x48, &val);
diff --git a/drivers/mmc/host/cb710-mmc.h b/drivers/mmc/host/cb710-mmc.=
h
index e845c77..8984ec8 100644
--- a/drivers/mmc/host/cb710-mmc.h
+++ b/drivers/mmc/host/cb710-mmc.h
@@ -24,7 +24,7 @@ struct cb710_mmc_reader {
=20
 static inline struct mmc_host *cb710_slot_to_mmc(struct cb710_slot *sl=
ot)
 {
-	return dev_get_drvdata(&slot->pdev.dev);
+	return platform_get_drvdata(&slot->pdev);
 }
=20
 static inline struct cb710_slot *cb710_mmc_to_slot(struct mmc_host *mm=
c)
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mo=
bile_sdhi.c
index cc4c872..6a5d90e 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -51,7 +51,7 @@ struct sh_mobile_sdhi {
=20
 static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, uns=
igned int *f)
 {
-	struct mmc_host *mmc =3D dev_get_drvdata(&pdev->dev);
+	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host =3D mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv =3D container_of(host->pdata, struct sh_m=
obile_sdhi, mmc_data);
 	int ret =3D clk_enable(priv->clk);
@@ -64,7 +64,7 @@ static int sh_mobile_sdhi_clk_enable(struct platform_=
device *pdev, unsigned int
=20
 static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
 {
-	struct mmc_host *mmc =3D dev_get_drvdata(&pdev->dev);
+	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host =3D mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv =3D container_of(host->pdata, struct sh_m=
obile_sdhi, mmc_data);
 	clk_disable(priv->clk);
@@ -119,7 +119,7 @@ static int sh_mobile_sdhi_write16_hook(struct tmio_=
mmc_host *host, int addr)
=20
 static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pde=
v)
 {
-	mmc_detect_change(dev_get_drvdata(&pdev->dev), msecs_to_jiffies(100))=
;
+	mmc_detect_change(platform_get_drvdata(pdev), msecs_to_jiffies(100));
 }
=20
 static const struct sh_mobile_sdhi_ops sdhi_ops =3D {
--=20
1.7.10.4


