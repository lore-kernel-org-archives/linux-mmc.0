From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: mmc: sdhci stop SDCLK during asynchronous interrupt peroid
Date: Fri, 7 Jan 2011 05:29:36 -0500
Message-ID: <AANLkTi=vCFH66oVfOUd0XKYga15cLq2TG_joOo7raKFK@mail.gmail.com>
References: <AANLkTimXQMkWhJZ=nD8r-odmU+J6nf+7U+6KOHr5E1N1@mail.gmail.com>
	<CFD46C56-3B58-40E8-8B05-7FF768725B86@marvell.com>
	<AANLkTi=LW+3LpRAQ-9Q-EH5YRT2qWVCyVCjpxMn2RYLT@mail.gmail.com>
	<988ACB63-F6E4-4514-9BA8-DAF0D4CFD7E2@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49451 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1AGK3i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2011 05:29:38 -0500
Received: by fxm20 with SMTP id 20so16803491fxm.19
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jan 2011 02:29:36 -0800 (PST)
In-Reply-To: <988ACB63-F6E4-4514-9BA8-DAF0D4CFD7E2@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@stericsson.com>

On Thu, Jan 6, 2011 at 10:52 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Jan 6, 2011, at 2:44 AM, zhangfei gao wrote:
>
>> On Wed, Jan 5, 2011 at 11:30 AM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>>
>>> On Jan 5, 2011, at 1:39 AM, zhangfei gao wrote:
>>>
>>>> From 7554ead744bfdc7304a7ae9fb227212bf548161a Mon Sep 17 00:00:00 =
2001
>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> Date: Wed, 5 Jan 2011 17:21:00 -0500
>>>> Subject: [PATCH] mmc: sdhci stop SDCLK during asynchronous interru=
pt peroid
>>>>
>>>> =A0 =A0 =A0 V3 controller could stop SDCLK during asynchronous int=
errupt peroid
>>>> to save power, via set SDHCI_CTRL2_AINT bit 14 of
>>>> SDHCI_HOST_CONTROL2(0x3e)
>>>> =A0 =A0 =A0 Two conditions:
>>>> =A0 =A0 =A0 1. card support asynchronous interrupt
>>>> =A0 =A0 =A0 2. Asynchronous interrupt support is set to 1 in the c=
apabilities register.
>>>>
>>>> =A0 =A0 =A0 How to enable: mmc->caps |=3D MMC_CAP_CLOCK_GATE
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> ---
>>>> drivers/mmc/host/sdhci.c | =A0 14 ++++++++++++++
>>>> drivers/mmc/host/sdhci.h | =A0 =A02 ++
>>>> include/linux/mmc/host.h | =A0 =A02 ++
>>>> 3 files changed, 18 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index aafbb42..946b947 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1261,6 +1261,15 @@ static void sdhci_set_ios(struct mmc_host *=
mmc,
>>>> struct mmc_ios *ios)
>>>> =A0 =A0 =A0 if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_reset(host, SDHCI_RESET_CMD | SD=
HCI_RESET_DATA);
>>>>
>>>> + =A0 =A0 if (mmc->caps & MMC_CAP_CLOCK_GATE) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con =3D readw(host->ioaddr + SDHCI_HOST_=
CONTROL2);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_AINT;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 writew(con, host->ioaddr + SDHCI_HOST_CO=
NTROL2);
>>>> + =A0 =A0 }
>>>> +
>>>> +
>>>
>>>
>>> This will enable clock gating for SD/eMMC and SDIO cards. =A0This i=
s not a good idea for SDIO where
>>> there are known issues. =A0This is one reason the software clock ga=
ting code does not enable
>>> clock gating on SDIO. =A0Not all SDIO cards can work.
>>
>> It is enabled only by setting caps MMC_CAP_CLOCK_GATE, for example t=
he
>> code to verify emmc/sd in sdhci-pxa.c
>>
>> =A0 =A0 =A0 =A0if (pdata && pdata->flags & PXA_FLAG_CONTROL_CLK_GATE=
) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* v3 controller could support clock =
gating */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_CLOCK_GA=
TE;
>> =A0 =A0 =A0 =A0}
>> SDIO is not enabled since no PXA_FLAG_CONTROL_CLK_GATE in flags.
>> In the experiment, we find sdio (wifi) power does not change a lot
>> with or without clock gate, it mainly rely on wifi itself, for examp=
le
>> wifi goto deep sleep mode.
>>
>
> how do you know what card will be plugged in ? =A0this only works wor=
k hard wired cards not for cards plugged into a slot.

The SDCLK is only stopped during asynchronous interrupt peroid, it has
some clks delay after synchronous mode, according to spec, 8 clks is
needed.
So mmc, sd card should meet the requirement, but sdio may not since the=
 variety.
Have test emmc/sd.

>
>>>
>>> It does not handle the case clock gating being supported in pre SD =
3.0 controllers.
>> It is true, soft clock gating also be verified in SD 2.0 controller,
>> such as pxa955.
>>
>>>
>>> See my patch on h/w clock gating -- if there are issues with the pa=
tch would appreciate comments.
>>>
>>>> out:
>>>> =A0 =A0 =A0 mmiowb();
>>>> =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
>>>> @@ -1808,6 +1817,11 @@ int sdhci_add_host(struct sdhci_host *host)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CA=
P_1_8V_DDR);
>>>> =A0 =A0 =A0 }
>>>>
>>>> + =A0 =A0 if (mmc->caps & MMC_CAP_CLOCK_GATE) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(caps & SDHCI_CAN_ASYN_INT))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps &=3D ~MMC_CAP_=
CLOCK_GATE;
>>>> + =A0 =A0 }
>>>> +
>>>> =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_USE_SDMA;
>>>> =A0 =A0 =A0 else if (!(caps & SDHCI_CAN_DO_SDMA))
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index c4bd5dd..907de87 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -153,6 +153,7 @@
>>>> #define =A0 SDHCI_CTRL2_SDR104 =A00x0003
>>>> #define =A0 SDHCI_CTRL2_DDR50 =A0 0x0004
>>>> #define =A0SDHCI_CTRL2_1_8V =A0 =A0 0x0008
>>>> +#define =A0SDHCI_CTRL2_AINT =A0 =A00x4000
>>>>
>>>> #define SDHCI_CAPABILITIES =A0 =A00x40
>>>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 0x0000003F
>>>> @@ -172,6 +173,7 @@
>>>> #define =A0SDHCI_CAN_VDD_300 =A0 =A00x02000000
>>>> #define =A0SDHCI_CAN_VDD_180 =A0 =A00x04000000
>>>> #define =A0SDHCI_CAN_64BIT =A0 =A0 =A00x10000000
>>>> +#define =A0SDHCI_CAN_ASYN_INT =A00x20000000
>>>>
>>>> #define SDHCI_CAPABILITIES_1 =A00x44
>>>> #define =A0SDHCI_CAN_SDR50 =A0 =A0 =A00x00000001
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index bcb793e..2a53a94 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -173,6 +173,8 @@ struct mmc_host {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* DDR mode at 1.2V */
>>>> #define MMC_CAP_POWER_OFF_CARD =A0 =A0 =A0 =A0(1 << 13) =A0 =A0 =A0=
 /* Can power off after boot */
>>>> #define MMC_CAP_BUS_WIDTH_TEST =A0 =A0 =A0 =A0(1 << 14) =A0 =A0 =A0=
 /* CMD14/CMD19 bus width ok */
>>>> +#define MMC_CAP_CLOCK_GATE =A0 (1 << 15) =A0 =A0 =A0 /* V3 contro=
ller */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* support clock gating */
>>>>
>>>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>>>>
>>>> --
>>>> 1.7.0.4
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>
>>>
>
>
