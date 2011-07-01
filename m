From: Koen Beel <koen.beel.barco@gmail.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Fri, 1 Jul 2011 14:10:00 +0200
Message-ID: <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
	<BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
	<20110630145507.GG1997@pengutronix.de>
	<20110701091753.GE1922@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51041 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab1GAMKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 08:10:03 -0400
Received: by wyg8 with SMTP id 8so2150206wyg.19
        for <linux-mmc@vger.kernel.org>; Fri, 01 Jul 2011 05:10:01 -0700 (PDT)
In-Reply-To: <20110701091753.GE1922@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com

Hi,

Think the tabs problem was due to the gmail web ui.
Hope it's better now.


Signed-off-by: Koen Beel <koen.beel <at> barco.com>
---
 drivers/mmc/host/mxs-mmc.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 99d39a6..3575330 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -570,22 +570,22 @@ static void mxs_mmc_set_clk_rate(struct
mxs_mmc_host *host, unsigned int rate)
    ssp_rate =3D clk_get_rate(host->clk);
-   for (div1 =3D 2; div1 < 254; div1 +=3D 2) {
+   for (div1 =3D 2; div1 <=3D 254; div1 +=3D 2) {
        div2 =3D ssp_rate / rate / div1;
-       if (div2 < 0x100)
+       if (div2 <=3D 256)
            break;
    }
-   if (div1 >=3D 254) {
+   if (div1 > 254) {
        dev_err(mmc_dev(host->mmc),
            "%s: cannot set clock to %d\n", __func__, rate);
        return;
    }
    if (div2 =3D=3D 0)
-       bit_rate =3D ssp_rate / div1;
-   else
-       bit_rate =3D ssp_rate / div1 / div2;
+       div2 =3D 1;
+
+   bit_rate =3D ssp_rate / div1 / div2;
    val =3D readl(host->base + HW_SSP_TIMING);
    val &=3D ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
--
1.7.4.1

On Fri, Jul 1, 2011 at 11:17 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> On Thu, Jun 30, 2011 at 04:55:07PM +0200, Wolfram Sang wrote:
>> On Thu, Jun 30, 2011 at 12:13:34PM +0200, Koen Beel wrote:
>> > Fix clock rate setting on mxs-mmc driver.
>> > Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
>> > have been 255 instead of 0.
>> > Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
>> > (TIMING_CLOCK_RATE + 1) where not correctly defined.
>> >
>> > Can easily be reproduced on mx23evk: default clock for high speed =
sdio
>> > cards is 50 MHz. With a SSP_CLK of 28.8 MHz (default), this result=
ed in
>> > an actual clock rate of about 56 kHz.
>> >
>> > Signed-off-by: Koen Beel <koen.beel.barco <at> gmail.com>
>>
>> Looks promising, but your tabs are garbled (0xa0 0x20 here?)
>
> Can you repost a patch which applies? I'd like to test it.
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEUEARECAAYFAk4NkMEACgkQD27XaX1/VRvw0QCeP4F3oeKe1Ge3SLohJICLxZre
> LKYAmJ2sEztaKIVw4NsZMYNqCUbbwFQ=3D
> =3DC7kg
> -----END PGP SIGNATURE-----
>
>
