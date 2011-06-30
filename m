From: Koen Beel <koen.beel.barco@gmail.com>
Subject: [PATCH] mxs-mmc: fix clock rate setting
Date: Thu, 30 Jun 2011 12:13:34 +0200
Message-ID: <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34900 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab1F3KNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 06:13:35 -0400
Received: by wyg8 with SMTP id 8so1431459wyg.19
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jun 2011 03:13:34 -0700 (PDT)
In-Reply-To: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: shawn.guo@freescale.com, w.sang@pengutronix.de

=46ix clock rate setting on mxs-mmc driver.
Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
have been 255 instead of 0.
Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
(TIMING_CLOCK_RATE + 1) where not correctly defined.

Can easily be reproduced on mx23evk: default clock for high speed sdio
cards is 50 MHz. With a SSP_CLK of 28.8 MHz (default), this resulted in
an actual clock rate of about 56 kHz.

Signed-off-by: Koen Beel <koen.beel.barco <at> gmail.com>
---
=A0drivers/mmc/host/mxs-mmc.c | =A0 12 ++++++------
=A01 files changed, 6 insertions(+), 6 deletions(-)
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 99d39a6..3575330 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -570,22 +570,22 @@ static void mxs_mmc_set_clk_rate(struct
mxs_mmc_host *host, unsigned int rate)
=A0 =A0 ssp_rate =3D clk_get_rate(host->clk);
- =A0 for (div1 =3D 2; div1 < 254; div1 +=3D 2) {
+ =A0 for (div1 =3D 2; div1 <=3D 254; div1 +=3D 2) {
=A0 =A0 =A0 =A0 div2 =3D ssp_rate / rate / div1;
- =A0 =A0 =A0 if (div2 < 0x100)
+ =A0 =A0 =A0 if (div2 <=3D 256)
=A0 =A0 =A0 =A0 =A0 =A0 break;
=A0 =A0 }
- =A0 if (div1 >=3D 254) {
+ =A0 if (div1 > 254) {
=A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc),
=A0 =A0 =A0 =A0 =A0 =A0 "%s: cannot set clock to %d\n", __func__, rate)=
;
=A0 =A0 =A0 =A0 return;
=A0 =A0 }
=A0 =A0 if (div2 =3D=3D 0)
- =A0 =A0 =A0 bit_rate =3D ssp_rate / div1;
- =A0 else
- =A0 =A0 =A0 bit_rate =3D ssp_rate / div1 / div2;
+ =A0 =A0 =A0 div2 =3D 1;
+
+ =A0 bit_rate =3D ssp_rate / div1 / div2;
=A0 =A0 val =3D readl(host->base + HW_SSP_TIMING);
=A0 =A0 val &=3D ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RAT=
E);
--
1.7.4.1
