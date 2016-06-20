From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: implement reset quirks for i.MX6 DualLite/Solo
Date: Mon, 20 Jun 2016 18:16:02 +0800
Message-ID: <CAA+hA=Td=KYU54u4+=mAkvDfpsx4jWnzYZKc250DgqjRPF0CkA@mail.gmail.com>
References: <1463053968-11598-1-git-send-email-s.christ@phytec.de>
 <HE1PR0401MB1801712347A13DD827ED1880904E0@HE1PR0401MB1801.eurprd04.prod.outlook.com>
 <20160620075631.GA2377@lws-christ>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34549 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbcFTKQX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 06:16:23 -0400
Received: by mail-qk0-f195.google.com with SMTP id j2so22679498qkf.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2016 03:16:04 -0700 (PDT)
In-Reply-To: <20160620075631.GA2377@lws-christ>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Christ <s.christ@phytec.de>
Cc: Haibo Chen <haibo.chen@nxp.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "aisheng.dong@freescale.com" <aisheng.dong@freescale.com>, "festevam@gmail.com" <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>

Hi Stefan,

On Mon, Jun 20, 2016 at 3:56 PM, Stefan Christ <s.christ@phytec.de> wro=
te:
> Hi Haibo,
>
> On Mon, May 23, 2016 at 09:57:00AM +0000, Haibo Chen wrote:
>> > -----Original Message-----
>> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> > owner@vger.kernel.org] On Behalf Of Stefan Christ
>> > Sent: Thursday, May 12, 2016 7:53 PM
>> > To: adrian.hunter@intel.com; linux-mmc@vger.kernel.org
>> > Cc: aisheng.dong@freescale.com; festevam@gmail.com
>> > Subject: [PATCH] mmc: sdhci-esdhc-imx: implement reset quirks for =
i.MX6
>> > DualLite/Solo
>> >
>> > The ROM Code of i.MX6 Quad/Dual uses the MMC interfaces differentl=
y than
>> > the i.MX6 Solo/DualLite when it loads the bootloader from the inte=
rface:
>> >
>> >                 Register DLL_CTRL(0x60)  Bit 25 FBCLK_SEL (0x48)
>> >     Quad:       0x0                      0
>> >     DualLite:   0x01000021               1
>> >
>> > Since the linux kernel or bootloader driver doesn't reset all regi=
sters, the MMC
>> > interface is in an inconsistent state, which leads to boot failure=
s for some
>> > eMMC devices on the i.MX6 DualLite SoC. The errors look like:
>> >
>> >     mmcblk1: error -84 transferring data, sector 0, nr 8, cmd resp=
onse 0x900, card
>> > status 0xb00
>> >     mmcblk1: retrying using single block read
>> >     mmcblk1: error -84 transferring data, sector 2, nr 6, cmd resp=
onse 0x900, card
>> > status 0x0
>> >     blk_update_request: I/O error, dev mmcblk1, sector 2
>> >     mmcblk1: error -84 transferring data, sector 3, nr 5, cmd resp=
onse 0x900, card
>> > status 0x0
>> >     blk_update_request: I/O error, dev mmcblk1, sector 3
>> >
>> > The register DLL_CTRL is already reset. Reset also the bit FBCLK_S=
EL.
>> >
>> > Signed-off-by: Stefan Christ <s.christ@phytec.de>
>> > ---
>> > Hi,
>> >
>> > this patch is a follow up to
>> >
>> >     http://www.spinics.net/lists/linux-mmc/msg36331.html
>>
>> Hi Stefan,
>> Aisheng also take this into consideration, please refer to
>>
>>     http://www.spinics.net/lists/linux-mmc/msg36940.html
>>
>> Seems this patch still not be in Ulf's branch.
>>
>> Regards,
>> Haibo
>
> Please correct me if I'm wrong, but I don't see any activity about th=
is issue
> on the mailing list. Is it possible to pick Aisheng's and my patch wi=
thout
> waiting for the whole series to be reworked?
>

Sorry for the delay.
I'm busy with other issues and will send V2 soon this days.
Most of them already got ack from Andrian.
Suppose they will be in soon.

Regards
Dong Aisheng

> Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
>         Stefan Christ
>
>> >
>> >     mmc: sdhci-esdhci-imx: disable DLL delay line settings explici=
tly
>> >
>> >     Disable DLL delay line settings explicitly during driver initi=
alization
>> >     in case ROM/uBoot had set an invalid delay.
>> >     e.g. MX6DL ROM has set the default delay line(DLLCTRL) to 0x10=
00021,
>> >     the uSDHC clock timing will become marginal when works on DDR =
mode
>> >     due to default delay and will possibly see CRC errors in case =
the board
>> >     is not perfectly designed on the eMMC chip layout.
>> >
>> >     Signed-off-by: Dong Aisheng <aisheng.dong@xxxxxxx>
>> >
>> > It doesn't apply cleanly on Linus master branch, since the above p=
atch is missing.
>> >
>> > Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
>> >         Stefan Christ
>> > ---
>> >  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host=
/sdhci-
>> > esdhc-imx.c
>> > index 4490808..9101556 100644
>> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > @@ -1191,6 +1191,10 @@ static int sdhci_esdhc_imx_probe(struct
>> > platform_device *pdev)
>> >
>> >             /* disable DLL_CTRL delay line settings */
>> >             writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
>> > +
>> > +           /* reset bit FBCLK_SEL for i.MX6 Solo/DualLite ROM cod=
e */
>> > +           writel(readl(host->ioaddr + ESDHC_MIX_CTRL) & ~BIT(25)=
,
>> > +                   host->ioaddr + ESDHC_MIX_CTRL);
>> >     }
>> >
>> >     if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
>> > --
>> > 1.9.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in the
>> > body of a message to majordomo@vger.kernel.org More majordomo info=
 at
>> > http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
