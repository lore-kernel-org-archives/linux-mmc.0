From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: commit 'mmc: sdhci: add MMC_CAP_8_BIT_DATA in the host
 capabilities' breaks ricoh mmc device
Date: Thu, 4 Nov 2010 16:23:00 +0900
Message-ID: <AANLkTimvM1NrrjtT8X4yUj9y3pevqq5jebeO8QtncrOy@mail.gmail.com>
References: <1288410826.3119.5.camel@maxim-laptop>
	<20101103055735.GA21719@pengutronix.de>
	<20101103062431.GB21719@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53374 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab0KDHXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2010 03:23:01 -0400
Received: by pvb32 with SMTP id 32so482129pvb.19
        for <linux-mmc@vger.kernel.org>; Thu, 04 Nov 2010 00:23:01 -0700 (PDT)
In-Reply-To: <20101103062431.GB21719@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Chris Ball <cjb@laptop.org>, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

Hi,

I got the same problem.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..a0991ad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1849,7 +1849,7 @@ int sdhci_add_host(struct sdhci_host *host)
        mmc->caps |=3D MMC_CAP_SDIO_IRQ;

        if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-               mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+               mmc->caps |=3D MMC_CAP_4_BIT_DATA;

        if (caps & SDHCI_CAN_DO_HISPD)
                mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHS=
PEED;

In case of MMC, host->caps & MMC_CAP_8_BIT_DATA is always true. so
can't use the MMC_CAP_4_BIT_DATA.

       /*
         * Activate wide bus and DDR (if supported).
         */
        if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
            (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
                unsigned ext_csd_bit, bus_width;

                if (host->caps & MMC_CAP_8_BIT_DATA) {
                        if (ddr)
                                ext_csd_bit =3D EXT_CSD_DDR_BUS_WIDTH_8=
;
                        else
                                ext_csd_bit =3D EXT_CSD_BUS_WIDTH_8;
                        bus_width =3D MMC_BUS_WIDTH_8;
                } else {
                        if (ddr)
                                ext_csd_bit =3D EXT_CSD_DDR_BUS_WIDTH_4=
;
                        else
                                ext_csd_bit =3D EXT_CSD_BUS_WIDTH_4;
                        bus_width =3D MMC_BUS_WIDTH_4;
                }

Thank you,
Kyungmin Park

On Wed, Nov 3, 2010 at 3:24 PM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
> On Wed, Nov 03, 2010 at 06:57:35AM +0100, Wolfram Sang wrote:
>> On Sat, Oct 30, 2010 at 05:53:46AM +0200, Maxim Levitsky wrote:
>> > Hi,
>> >
>> > I just bisected and reverted this commit.
>>
>> Commit-ID would have been useful, too: b08caed8659ab27199db51c63a35c=
5ee067fc7ef
>> Also, adding the author to cc, done now.
>
> Sorry, just saw that the threading got somehow broken and the thread =
was
> continued. Sorry for the noise!
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkzRAB8ACgkQD27XaX1/VRtSHACgvSytzl8BXzNFuM31HDWryl/4
> HPoAnRGReSnUgTbjOzGYOepJbcPhprGa
> =3DoMKq
> -----END PGP SIGNATURE-----
>
>
