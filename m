From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 2/5] mmc: support sdhci-pxav2.c
Date: Tue, 14 Jun 2011 14:07:53 +0800
Message-ID: <BANLkTimeb-Ax99rQDYckLsVSncxhrh7amg@mail.gmail.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
	<1307526121-12059-3-git-send-email-zhangfei.gao@marvell.com>
	<0059AEB1-3536-4540-924A-A95C7F3AD21A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38745 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab1FNGHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 02:07:54 -0400
Received: by vxi39 with SMTP id 39so4195086vxi.19
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 23:07:53 -0700 (PDT)
In-Reply-To: <0059AEB1-3536-4540-924A-A95C7F3AD21A@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Qiming Wu <wuqm@marvell.com>, Jun Nie <njun@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Raymond Wu <xywu@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

>> +static void pxav2_set_private_registers(struct sdhci_host *host, u8=
 mask)
>> +{
>> + =A0 =A0 struct platform_device *pdev =3D to_platform_device(mmc_de=
v(host->mmc));
>> + =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_da=
ta;
>> +
>> + =A0 =A0 if (mask =3D=3D SDHCI_RESET_ALL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 tmp =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* tune timing of read data/command when=
 crc error happen
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* no performance impact
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->clk_delay_sel =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr=
 + SD_CLOCK_BURST_SIZE_SETUP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(SDCLK_DELAY_MAS=
K << SDCLK_DELAY_SHIFT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay=
_cycles & SDCLK_DELAY_MASK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << SDCLK_D=
ELAY_SHIFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(SDCLK_SEL_MASK =
<< SDCLK_SEL_SHIFT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (1 & SDCLK_SEL_MA=
SK) << SDCLK_SEL_SHIFT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr +=
 SD_CLOCK_BURST_SIZE_SETUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> There are 3 possible value for clk_delay_sel.
>
> 0 =A0=3D=3D do not use clk_delay_cycles
> 1 =3D=3D use programmed clk_delay_cycles value (the code above)
> all other values use the sd_clk which was used to drive the output
>
> The code about only handles 2 of the 3 cases

pxa910/920 only require two cases.
1, clk_delay_sel =3D 1 with delay value.
2, use default setting and directly use sd_clk. clk_delay_sel =3D 3.

>
> suggest
>
> =A0 =A0 =A0 =A0(if (pdata->clk_delay_sel) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->clk_delay_sel =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr=
 + SD_CLOCK_BURST_SIZE_SETUP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(SDCLK_DELAY_MAS=
K << SDCLK_DELAY_SHIFT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay=
_cycles & SDCLK_DELAY_MASK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << SDCLK_D=
ELAY_SHIFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(SDCLK_SEL_MASK =
<< SDCLK_SEL_SHIFT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D 1 << SDCLK_SEL_SH=
IFT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr +=
 SD_CLOCK_BURST_SIZE_SETUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr=
 + SD_CLOCK_BURST_SIZE_SETUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(SDCLK_SEL_MASK =
<< SDCLK_SEL_SHIFT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D 2 =A0<< SDCLK_SEL=
_SHIFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr +=
 SD_CLOCK_BURST_SIZE_SETUP);
The else is default setting on pxa910 after reset.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 }
>
> Philip and Mark
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
