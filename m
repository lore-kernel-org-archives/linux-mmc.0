From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3 sd controller
Date: Mon, 8 Nov 2010 06:48:32 -0500
Message-ID: <AANLkTi=9omu=yDXEk_=QhGsz6xy3VVxn39T4DF7UvHjR@mail.gmail.com>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
	<20101107220411.GB5376@pengutronix.de>
	<BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
	<20101108091754.GA8638@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab0KHLsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 06:48:33 -0500
Received: by fxm16 with SMTP id 16so3908962fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2010 03:48:32 -0800 (PST)
In-Reply-To: <20101108091754.GA8638@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Nov 8, 2010 at 4:17 AM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
>> > This isn't a quirk, this is platform_data, no?
>>
>> Never sure of the difference between a quirk and platform data.
>> example: =A0Broken card detect is a quirk but maybe some slots on th=
e board work and some do not
>
> A quirk is something which needs to be handled in a special case beca=
use
> some controllers do not adhere to the SDHC standard. An 8 bit bus see=
ms
> to be in the 3.0 standard, so it is not a quirk :) Does the standard =
say
> anything about how the actual bus width should be handled?
>
> That said, you are right that quirks have been abused to cover board
> issues. Another reason to clean them up ;)
>
> Regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkzXwEIACgkQD27XaX1/VRuQ8QCeN1ueDODn5jbt9MS49MCJcQXS
> BccAn0VnBmmBbLRFvBf/wo4zStAXUGV0
> =3DVwO1
> -----END PGP SIGNATURE-----
>
>

Highly concern of abuse of QUIRK, currently the highest bit is
(1<<29), while the quirks is u32.
Could we remove some quirk, such as SDHCI_QUIRK_FORCE_1_BIT_DATA,
which only used to transfer info to caps.
We could simply update mmc->caps after sdhci_add_host.


 arch/arm/plat-pxa/include/plat/sdhci.h |    2 ++
 drivers/mmc/host/sdhci-pxa.c           |    5 +++++
 drivers/mmc/host/sdhci.c               |    3 ---
 include/linux/mmc/sdhci.h              |    2 --
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
index e49c5b6..661dc48 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -16,6 +16,8 @@
 /* pxa specific flag */
 /* Require clock free running */
 #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
+#define PXA_FLAG_FORCE_1_BIT_DATA (1<<2)
+#define PXA_FLAG_CAN_DO_8_BIT_DATA (1<<3)

 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.=
c
index fc406ac..3d63a37 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -147,6 +147,11 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 		goto out;
 	}

+	if (pxa->pdata->flags & PXA_FLAG_FORCE_1_BIT_DATA)
+		host->mmc->caps &=3D ~(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
+	if (pxa->pdata->flags & PXA_FLAG_CAN_DO_8_BIT_DATA)
+		host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
+
 	if (pxa->pdata->max_speed)
 		host->mmc->f_max =3D pxa->pdata->max_speed;

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 154cbf8..2628ec2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1858,9 +1858,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->f_max =3D host->max_clk;
 	mmc->caps |=3D MMC_CAP_SDIO_IRQ;

-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-		mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;

diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..ede02a4 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -67,8 +67,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
 /* Controller cannot do multi-block transfers */
 #define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
-/* Controller can only handle 1-bit data transfers */
-#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
 /* Controller needs 10ms delay between applying power and clock */
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
--=20
1.7.0.4
