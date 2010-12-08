From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V3 3/3 ] mmc: add support for H/W clock gating of SD
 controller (resend)
Date: Wed, 8 Dec 2010 02:13:54 -0500
Message-ID: <AANLkTinAR=shkVRuku+E1spF64J0hLVkwWX+EUp78AMw@mail.gmail.com>
References: <5017B261-76AC-428D-BAC2-8E1BBEB09A49@marvell.com>
	<20101208001618.GA3338@void.printf.net>
	<4024F858-A92E-4DCC-8615-528BF48939D2@marvell.com>
	<AANLkTimqaiHg6xYOquftumB=ciK+YpVkbfP877HimyHP@mail.gmail.com>
	<A48DB098-1757-456E-A506-6E935144D645@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:34056 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab0LHHN4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 02:13:56 -0500
Received: by fxm18 with SMTP id 18so751038fxm.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Dec 2010 23:13:54 -0800 (PST)
In-Reply-To: <A48DB098-1757-456E-A506-6E935144D645@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Mark Brown <markb@marvell.com>, Zhangfei Gao <zgao6@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Tue, Dec 7, 2010 at 9:50 PM, Philip Rakity <prakity@marvell.com> wro=
te:
>
> On Dec 7, 2010, at 5:49 PM, zhangfei gao wrote:
>
>> On Tue, Dec 7, 2010 at 7:20 PM, Philip Rakity <prakity@marvell.com> =
wrote:
>>>
>>> From 4f521dd851066e6f65cbf3b866502a2a308eb980 Mon Sep 17 00:00:00 2=
001
>>> From: Philip Rakity <prakity@marvell.com>
>>> Date: Tue, 7 Dec 2010 09:05:39 -0800
>>> Subject: [PATCH V2] sdhci: support H/W clock gating in Marvell PXA =
driver
>>>
>>> This code is based on sdhci-pxa in mmc-next on Dec 2, 2010.
>>>
>>> If cpu_is_mmp2() then enable MMC capability MMC_CAP_HW_CLOCK_GATING
>>>
>>> Code may need changing based on the ongoing work on sdhci-pxa but s=
ince that
>>> code is NOT in mmc-next better to have something that can work.
>>>
>>> This code tested on Marvell Linux
>>>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> Signed-off-by: Mark F. Brown <markb@marvell.com>
>>> ---
>>> =A0drivers/mmc/host/sdhci-pxa.c | =A0 33 ++++++++++++++++++++++++++=
+------
>>> =A01 files changed, 27 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-=
pxa.c
>>> index 5a61208..5cf47fd 100644
>>> --- a/drivers/mmc/host/sdhci-pxa.c
>>> +++ b/drivers/mmc/host/sdhci-pxa.c
>>> @@ -25,6 +25,7 @@
>>> =A0#include <linux/io.h>
>>> =A0#include <linux/err.h>
>>> =A0#include <plat/sdhci.h>
>>> +#include <mach/cputype.h>
>>> =A0#include "sdhci.h"
>>>
>>> =A0#define DRIVER_NAME =A0 =A0"sdhci-pxa"
>>> @@ -46,10 +47,27 @@ struct sdhci_pxa {
>>> =A0* SDHCI core callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>>> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>>> =A0\***************************************************************=
**************/
>>> +#ifdef CONFIG_MMC_CLKGATE
>>> +static void hardware_clk_gating(struct sdhci_host *host)
>>> +{
>>> + =A0 =A0 =A0 unsigned short tmp;
>>> + =A0 =A0 =A0 int enable;
>>> +
>>> + =A0 =A0 =A0 enable =3D host->mmc->clk_gated;
>>> + =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_FIFO_PARAM);
>>> +
>>> + =A0 =A0 =A0 if (enable)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~DIS_PAD_SD_CLK_GATE;
>>> + =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D DIS_PAD_SD_CLK_GATE;
>>> +
>>> + =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_FIFO_PARAM);
>>> +}
>>> +#endif
>>> +
>>> =A0static void set_clock(struct sdhci_host *host, unsigned int cloc=
k)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct sdhci_pxa *pxa =3D sdhci_priv(host);
>>> - =A0 =A0 =A0 u32 tmp =3D 0;
>>>
>>> =A0 =A0 =A0 =A0if (clock =3D=3D 0) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pxa->clk_enable) {
>>> @@ -58,11 +76,6 @@ static void set_clock(struct sdhci_host *host, u=
nsigned int clock)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (0 =3D=3D pxa->clk_enable) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->pdata->flags=
 & PXA_FLAG_DISABLE_CLOCK_GATING) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D=
 readl(host->ioaddr + SD_FIFO_PARAM);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=
=3D DIS_PAD_SD_CLK_GATE;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write=
l(tmp, host->ioaddr + SD_FIFO_PARAM);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(pxa->clk)=
;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pxa->clk_enable =3D =
1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> @@ -71,6 +84,9 @@ static void set_clock(struct sdhci_host *host, un=
signed int clock)
>>>
>>> =A0static struct sdhci_ops sdhci_pxa_ops =3D {
>>> =A0 =A0 =A0 =A0.set_clock =3D set_clock,
>>> +#ifdef CONFIG_MMC_CLKGATE
>>> + =A0 =A0 =A0 .platform_hw_clk_gate =3D =A0hardware_clk_gating,
>>> +#endif
>>> =A0};
>>>
>>> =A0/***************************************************************=
**************\
>>> @@ -145,6 +161,11 @@ static int __devinit sdhci_pxa_probe(struct pl=
atform_device *pdev)
>>> =A0 =A0 =A0 =A0if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_8_BIT_D=
ATA;
>>>
>>> +#ifdef CONFIG_MMC_CLKGATE
>>> + =A0 =A0 =A0 if (cpu_is_mmp2())
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_HW_CLOCK=
_GATING;
>>> +#endif
>>> +
>>> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
>>> =A0 =A0 =A0 =A0if (ret) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to add h=
ost\n");
>>> --
>>> 1.6.0.4
>>>
>> 1. could you pls follow the interface we discussed before in order t=
o
>> prevent the register's difference, =A0.platform_hw_clk_gate could be
>> overwrited and transfered from platform, example send before, like
>> get_ro.
>
> We are not in agreement with your proposed =A0implementation. =A0 The=
 callbacks in the
> driver specific code calling callbacks in the arch code makes the cod=
e
> difficult to follow.
>
> It would be much simpler to create 3 entries in kConfig
> one for mmp2
> one for pxa910
> one for pxa168
> then factor out the common code. =A0The could then be reused and put =
it into
> a separate file and linked =A0with the SOC specific code to provide t=
he functionality needed.
> Rather than the approach of moving
> everything into the arch directory.
>
> It is not clear to us that the approach that you are following can ha=
ndle the differences
> in silicon between the pxa168 and pxa910/mmp2.
>
>
>> 2. we have to fully verify the hardware clk gating internally before
>> sending the code.
>
> code tested under marvell 2.6.32 linux.

Thanks a lot, just wander could sdio be supported, since marvell8787
requires around 10 clock cycles after cmd53 finished.

>
>>>
>>>
>>>
>>> On Dec 7, 2010, at 4:16 PM, Chris Ball wrote:
>>>
>>>> Hi Philip,
>>>>
>>>> On Tue, Dec 07, 2010 at 02:46:25PM -0800, Philip Rakity wrote:
>>>>> 8 bit width support dependency removed. =A0Code applies directly =
to mmc-next
>>>>> Patches 2/3 and 3/3 unchanged
>>>>
>>>> The submitted patches 2/3 and 3/3 are identical -- is there a sepa=
rate
>>>> third patch that's unsent so far, or did you mean to send only two=
?
>>>>
>>>> Thanks,
>>>>
>>>> --
>>>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>>>> One Laptop Per Child
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>
>
