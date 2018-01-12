From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Subject: Re: 4.15.0-rc5 fails boot on MX53 LOCO board due to MMC (clock?) issue
Date: Fri, 12 Jan 2018 01:03:01 +0100
Message-ID: <CA+sos7_y76fz5kLEhudeS7cp2AvzcGfgpEMJjTO+PyVif3=AvA@mail.gmail.com>
References: <20180111171538.GA32086@amethyst.visucore.com> <CA+sos79yU=eQAoJnmwjiwc-h7ZEB14NhMtO8i8EMX5wO1y57xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:36314 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbeALADW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jan 2018 19:03:22 -0500
Received: by mail-ua0-f173.google.com with SMTP id a25so2923441uak.3
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jan 2018 16:03:22 -0800 (PST)
In-Reply-To: <CA+sos79yU=eQAoJnmwjiwc-h7ZEB14NhMtO8i8EMX5wO1y57xw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wladimir J. van der Laan" <laanwj@gmail.com>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Healy <cphealy@gmail.com>

On Thu, Jan 11, 2018 at 11:11 PM, Beno=C3=AEt Th=C3=A9baudeau
<benoit.thebaudeau.dev@gmail.com> wrote:
> Dear Wladimir J. van der Laan,
>
> On Thu, Jan 11, 2018 at 6:15 PM, Wladimir J. van der Laan
> <laanwj@gmail.com> wrote:
>> Hello,
>>
>> I'm experiencing issues with kernel 4.15.0-rc5 on a MX53 LOCO board.
>>
>> Setup is two 32GB Samsung microSD SDHC cards plugged in
>>
>> mmc0 plugged indirectly: contains boot and auxiliary data
>> mmc1 through SD->microSD adapter that came with the card: contains root =
fs
>>
>> Initial error is "mmcblk1: error -84 transferring data, sector 2048, nr =
8, cmd
>> response 0x900, card status 0xc00".  Then various SDHCI REGISTER DUMP fo=
llow
>> after timeouts and CRC errors. It looks like the filesystem is corruptin=
g,
>> resulting in a failed boot.
>>
>> Bisection gives me:
>>
>> 5143c953a7864c7abacf1c167c4350d641626949 is the first bad commit
>> commit 5143c953a7864c7abacf1c167c4350d641626949
>> Author: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
>> Date:   Tue May 30 11:14:10 2017 +0200
>>
>>     mmc: sdhci-esdhc-imx: Allow all supported prescaler values
>>
>>     On i.MX, SYSCTL.SDCLKFS may always be set to 0 in order to make the =
SD
>>     clock frequency prescaler divide by 1 in SDR mode, even with the eSD=
HC.
>>     The previous minimum prescaler value of 2 in SDR mode with the eSDHC=
 was
>>     a code remnant from PowerPC, which actually has this limitation on
>>     earlier revisions.
>>
>>     In DDR mode, the prescaler can divide by up to 512.
>>
>>     The maximum SD clock frequency in High Speed mode is 50 MHz. On i.MX=
25,
>>     this change makes it possible to get 48 MHz from the USB PLL
>>     (240 MHz / 5 / 1) instead of only 40 MHz from the USB PLL
>>     (240 MHz / 3 / 2) or 33.25 MHz from the AHB clock (133 MHz / 2 / 2).
>>
>>     Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
>>     Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>     Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> And indeed, after reverting this particular commit on top of 4.15.0-rc5,=
 the problem goes away.
>>
>> This could be a clock rate tolerance issue with the particular brand/typ=
e of
>> SD card, however I've not experienced any issues with them before.
>
> [...]
>
> In a few words, looking at the reference manual of the i.MX53, there
> is an exception with its eSDHCv3: it does not allow SYSCTL.SDCLKFS =3D
> 0. It seems to be fine for the eSDHCv2 instances of the i.MX53 and for
> all the other i.MXs. So your issue can be fixed by changing the
> minimum legal prescaler value if eSDHCv3 is detected on i.MX53. I will
> send something for that. This should also be fixed in U-Boot.

Can you please try the change below? If it works and everyone is fine
with it, I will send a proper patch.

Best regards,
Beno=C3=AEt

---
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -687,6 +687,20 @@ static inline void esdhc_pltfm_set_clock(struct
sdhci_host *host,
         return;
     }

+    /* For i.MX53 eSDHCv3, SYSCTL.SDCLKFS may not be set to 0. */
+    if (is_imx53_esdhc(imx_data)) {
+        /*
+         * According to the i.MX53 reference manual, if DLLCTRL[10] can
+         * be set, then the controller is eSDHCv3, else it is eSDHCv2.
+         */
+        val =3D readl(host->ioaddr + ESDHC_DLL_CTRL);
+        writel(val | BIT(10), host->ioaddr + ESDHC_DLL_CTRL);
+        temp =3D readl(host->ioaddr + ESDHC_DLL_CTRL);
+        writel(val, host->ioaddr + ESDHC_DLL_CTRL);
+        if (temp & BIT(10))
+            pre_div =3D 2;
+    }
+
     temp =3D sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
     temp &=3D ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
         | ESDHC_CLOCK_MASK);
