From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Subject: Re: 4.15.0-rc5 fails boot on MX53 LOCO board due to MMC (clock?) issue
Date: Thu, 11 Jan 2018 23:11:15 +0100
Message-ID: <CA+sos79yU=eQAoJnmwjiwc-h7ZEB14NhMtO8i8EMX5wO1y57xw@mail.gmail.com>
References: <20180111171538.GA32086@amethyst.visucore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:40261 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933009AbeAKWLg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jan 2018 17:11:36 -0500
Received: by mail-vk0-f44.google.com with SMTP id w75so2493079vkd.7
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jan 2018 14:11:36 -0800 (PST)
In-Reply-To: <20180111171538.GA32086@amethyst.visucore.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wladimir J. van der Laan" <laanwj@gmail.com>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Healy <cphealy@gmail.com>

Dear Wladimir J. van der Laan,

On Thu, Jan 11, 2018 at 6:15 PM, Wladimir J. van der Laan
<laanwj@gmail.com> wrote:
> Hello,
>
> I'm experiencing issues with kernel 4.15.0-rc5 on a MX53 LOCO board.
>
> Setup is two 32GB Samsung microSD SDHC cards plugged in
>
> mmc0 plugged indirectly: contains boot and auxiliary data
> mmc1 through SD->microSD adapter that came with the card: contains root f=
s
>
> Initial error is "mmcblk1: error -84 transferring data, sector 2048, nr 8=
, cmd
> response 0x900, card status 0xc00".  Then various SDHCI REGISTER DUMP fol=
low
> after timeouts and CRC errors. It looks like the filesystem is corrupting=
,
> resulting in a failed boot.
>
> Bisection gives me:
>
> 5143c953a7864c7abacf1c167c4350d641626949 is the first bad commit
> commit 5143c953a7864c7abacf1c167c4350d641626949
> Author: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
> Date:   Tue May 30 11:14:10 2017 +0200
>
>     mmc: sdhci-esdhc-imx: Allow all supported prescaler values
>
>     On i.MX, SYSCTL.SDCLKFS may always be set to 0 in order to make the S=
D
>     clock frequency prescaler divide by 1 in SDR mode, even with the eSDH=
C.
>     The previous minimum prescaler value of 2 in SDR mode with the eSDHC =
was
>     a code remnant from PowerPC, which actually has this limitation on
>     earlier revisions.
>
>     In DDR mode, the prescaler can divide by up to 512.
>
>     The maximum SD clock frequency in High Speed mode is 50 MHz. On i.MX2=
5,
>     this change makes it possible to get 48 MHz from the USB PLL
>     (240 MHz / 5 / 1) instead of only 40 MHz from the USB PLL
>     (240 MHz / 3 / 2) or 33.25 MHz from the AHB clock (133 MHz / 2 / 2).
>
>     Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
>     Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>     Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> And indeed, after reverting this particular commit on top of 4.15.0-rc5, =
the problem goes away.
>
> This could be a clock rate tolerance issue with the particular brand/type=
 of
> SD card, however I've not experienced any issues with them before.

[...]

In a few words, looking at the reference manual of the i.MX53, there
is an exception with its eSDHCv3: it does not allow SYSCTL.SDCLKFS =3D
0. It seems to be fine for the eSDHCv2 instances of the i.MX53 and for
all the other i.MXs. So your issue can be fixed by changing the
minimum legal prescaler value if eSDHCv3 is detected on i.MX53. I will
send something for that. This should also be fixed in U-Boot.

Best regards,
Beno=C3=AEt
