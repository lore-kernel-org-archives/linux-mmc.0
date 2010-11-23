From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [RFC] sdhci: 8 bit bus width changes
Date: Mon, 22 Nov 2010 21:45:19 -0500
Message-ID: <AANLkTinKkg5UdgAY+Uo3-bW8_GDxCtkPmp8r5zMNQgLX@mail.gmail.com>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com>
	<20101119214002.GA19272@void.printf.net>
	<20101119215333.GB19272@void.printf.net>
	<20101120123553.GA11936@pengutronix.de>
	<20101120182423.GA31030@void.printf.net>
	<06A44983-1A70-4715-86AF-66C08DD381C0@marvell.com>
	<AANLkTimP8oRK_ALTbEXzL7Pp2VtJFef7eKGEA00Ers-7@mail.gmail.com>
	<C1554C82-70D9-4CE6-BFC3-469CF037B8D3@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63837 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0KWCpX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 21:45:23 -0500
Received: by fxm13 with SMTP id 13so3379771fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2010 18:45:21 -0800 (PST)
In-Reply-To: <C1554C82-70D9-4CE6-BFC3-469CF037B8D3@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Nov 22, 2010 at 11:13 AM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> On Nov 22, 2010, at 2:36 AM, zhangfei gao wrote:
>
>> On Mon, Nov 22, 2010 at 3:17 AM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>> From d52213a33a71142134555793583b726501827827 Mon Sep 17 00:00:00 2=
001
>>> From: Philip Rakity <prakity@marvell.com>
>>> Date: Sun, 21 Nov 2010 11:08:21 -0800
>>> Subject: [PATCH] [PATCH] sdhci: resubmit 8 bit support based on fee=
dback from list
>>>
>>> a) QUIRK removed for 8 bit support since platform issue - not quirk
>>> b) platform Flag defined for sdhci-pxa.c and plat-pxa
>>> c) comments added to sdhci.c on usage
>>>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>>
>>> comments from previous submission
>>>
>>> We now:
>>> * check for a v3 controller before setting 8-bit bus width
>>> * offer a callback for platform code to switch to 8-bit mode, which
>>> =A0allows non-v3 controllers to support it
>>> * introduce a quirk to specify that the board designers have indeed
>>> =A0brought out all the pins for 8-bit to the slot.
>>>
>>> We were previously relying only on whether the controller supported
>>> 8-bit, which doesn't tell us anything about the pin configuration i=
n
>>> the board design.
>>>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> Tested-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>>> Signed-off-by: Chris Ball <cjb@laptop.org>
>>> ---
>>> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 =A03 ++
>>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++
>>> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 49 ++=
++++++++++++++++++++++--------
>>> =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 =
++-
>>> =A04 files changed, 47 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat=
-pxa/include/plat/sdhci.h
>>> index e49c5b6..e85b58f 100644
>>> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
>>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>>> @@ -17,6 +17,9 @@
>>> =A0/* Require clock free running */
>>> =A0#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
>>>
>>> +/* board design supports 8 bit data on SD/SDIO BUS */
>>> +#define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
>>> +
>>> =A0/*
>>> =A0* struct pxa_sdhci_platdata() - Platform device data for PXA SDH=
CI
>>> =A0* @max_speed: the maximum speed supported
>>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-=
pxa.c
>>> index fc406ac..f609f4a 100644
>>> --- a/drivers/mmc/host/sdhci-pxa.c
>>> +++ b/drivers/mmc/host/sdhci-pxa.c
>>> @@ -141,6 +141,10 @@ static int __devinit sdhci_pxa_probe(struct pl=
atform_device *pdev)
>>> =A0 =A0 =A0 =A0if (pdata->quirks)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D pdata->quirks;
>>>
>>> + =A0 =A0 =A0 /* if slot design supports 8 bit data - indicate this=
 */
>>> + =A0 =A0 =A0 if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_8_BIT_DA=
TA;
>>> +
>>> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
>>
>> how about
>> =A0 =A0 =A0/* if BOARD NOT support 8 BIT */
>> =A0 =A0 =A0 if (pdata->flags & PXA_FLAG_SD_CANT_8_BIT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps &=3D ~MMC_CAP_8_BIT_DATA=
;
>
>
> A number of folks have found that enabling 8 bit by default breaks ex=
isting drivers.
> Having it enabled by default is not a good idea. =A0New features shou=
ld enabled by the
> platform code and not enabled by default.
>
>>
>>
>>> =A0 =A0 =A0 =A0if (ret) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to add h=
ost\n");
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 154cbf8..03c801b 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1185,17 +1185,31 @@ static void sdhci_set_ios(struct mmc_host *=
mmc, struct mmc_ios *ios)
>>> =A0 =A0 =A0 =A0if (host->ops->platform_send_init_74_clocks)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops->platform_send_init_74_clo=
cks(host, ios->power_mode);
>>>
>>> - =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
>>> -
>>> - =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_8)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_8BITBUS;
>>> - =A0 =A0 =A0 else
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_8BITBUS;
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* If your platform has 8-bit width support but is =
not a v3 controller,
>>> + =A0 =A0 =A0 =A0* or if it requires special setup code, you should=
 implement that in
>>> + =A0 =A0 =A0 =A0* platform_8bit_width().
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (host->ops->platform_8bit_width)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->platform_8bit_width(host, =
ios->bus_width);
>>> + =A0 =A0 =A0 else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST=
_CONTROL);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WID=
TH_8) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL=
_4BITBUS;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->version >=3D=
 SDHCI_SPEC_300)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =
|=3D SDHCI_CTRL_8BITBUS;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->version >=3D=
 SDHCI_SPEC_300)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =
&=3D ~SDHCI_CTRL_8BITBUS;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ios->bus_width =3D=
=3D MMC_BUS_WIDTH_4)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =
|=3D SDHCI_CTRL_4BITBUS;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =
&=3D ~SDHCI_CTRL_4BITBUS;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_C=
ONTROL);
>>> + =A0 =A0 =A0 }
>>>
>>> - =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_4BITBUS;
>>> - =A0 =A0 =A0 else
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBUS;
>>> + =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
>>>
>>> =A0 =A0 =A0 =A0if ((ios->timing =3D=3D MMC_TIMING_SD_HS ||
>>> =A0 =A0 =A0 =A0 =A0 =A0 ios->timing =3D=3D MMC_TIMING_MMC_HS)
>>> @@ -1855,11 +1869,22 @@ int sdhci_add_host(struct sdhci_host *host)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->f_min =3D host->max_clk / SDHCI=
_MAX_DIV_SPEC_300;
>>> =A0 =A0 =A0 =A0else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->f_min =3D host->max_clk / SDHCI=
_MAX_DIV_SPEC_200;
>>> +
>>> =A0 =A0 =A0 =A0mmc->f_max =3D host->max_clk;
>>> =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>>>
>>> - =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA | M=
MC_CAP_8_BIT_DATA;
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* A controller may support 8-bit width, but the bo=
ard itself
>>> + =A0 =A0 =A0 =A0* might not have the pins brought out. =A0So, boar=
ds that support
>>> + =A0 =A0 =A0 =A0* 8-bit width should set the MMC_CAP_8_BIT_DATA an=
d we won't assume
>>> + =A0 =A0 =A0 =A0* that devices without the quirk can use 8-bit wid=
th.
>>> + =A0 =A0 =A0 =A0*
>>> + =A0 =A0 =A0 =A0* set mmc->caps |=3D MMC_CAP_8_BIT_DATA in platfro=
m code
>>> + =A0 =A0 =A0 =A0* before call for_add_host to enable 8 bit support
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>>> + =A0 =A0 =A0 }
>>
>> i am afraid this will impact all platform supporting 8 bit emmc, if
>> this logic is correct, why assume board could support 4-bit width.
>> i think sdhci.c should describe controller behavior, instead of boar=
d
>> specific behavior.
>
>
> Concur about 4 bit support and said this on the mailing list earlier.=
 =A0The original code by Pierre
> assumes 4 bit bus width is always available.
>
> sdhci.c should only assume 1 bit mode works and the platform code sho=
uld enable 4 and 8 bit support.

Disagree, i think there is no assumption.
sdhci.c describe the capability of the controller aligning to sdh
standard, instead of board limitation.
 if (caps & SDHCI_CAN_DO_8BIT)
       mmc->caps |=3D SDHCI_CAN_DO_8BIT;

While platfrom specific driver add platfrom limitation, including
specific controller limitation and board limitation.
Though counting on platfrom driver add "mmc->caps |=3D
MMC_CAP_8_BIT_DATA;" is also workable.

> Did not want to change the original assumptions as it impacts lots of=
 platform code. =A0If the list thinks this
> is a good idea I am open to preparing the patch to do this.
>
> 8 bit support is new -- I have not seen the impact that you are refer=
ring too.
>
>
>>
>>>
>>> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_DO_HISPD)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED =
| MMC_CAP_MMC_HIGHSPEED;
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index d52a716..ff18eaa 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -76,7 +76,7 @@
>>> =A0#define =A0 SDHCI_CTRL_ADMA1 =A0 =A0 0x08
>>> =A0#define =A0 SDHCI_CTRL_ADMA32 =A0 =A00x10
>>> =A0#define =A0 SDHCI_CTRL_ADMA64 =A0 =A00x18
>>> -#define =A0SDHCI_CTRL_8BITBUS =A0 =A00x20
>>> +#define =A0 SDHCI_CTRL_8BITBUS =A0 0x20
>>>
>>> =A0#define SDHCI_POWER_CONTROL =A0 =A00x29
>>> =A0#define =A0SDHCI_POWER_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
>>> @@ -215,6 +215,8 @@ struct sdhci_ops {
>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_max_clock)(struct sdhci_ho=
st *host);
>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_min_clock)(struct sdhci_ho=
st *host);
>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_timeout_clock)(struct sdhc=
i_host *host);
>>> + =A0 =A0 =A0 int =A0 =A0 (*platform_8bit_width)(struct sdhci_host =
*host,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int w=
idth);
>>> =A0 =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_ho=
st *host,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u8 power_mode);
>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *hos=
t);
>>> --
>>> 1.6.0.4
>>>
>>> On Nov 20, 2010, at 10:24 AM, Chris Ball wrote:
>>>
>>>> Hi,
>>>>
>>>> On Sat, Nov 20, 2010 at 01:35:53PM +0100, Wolfram Sang wrote:
>>>>> I know it's too late, but...
>>>>
>>>> It's late, but it's not too late. =A0I'd like to send a fix for MM=
C cards
>>>> to Linus within the next week. =A0If we decide to make some small =
changes
>>>> here and can do it quickly, that should be fine.
>>>>
>>>>> What does the platform_-prefix of the callback indicate?
>>>>
>>>> That it's a hook for code (whether that's a -pltfm driver or an SD=
HCI
>>>> driver) that knows more about the board-level setup to implement.
>>>>
>>>>>> * introduce a quirk to specify that the board designers have ind=
eed
>>>>>> =A0 brought out all the pins for 8-bit to the slot.
>>>>>
>>>>> This is not a quirk, this is platform_data, no?
>>>>
>>>> Yes, I agree that platform code would be more correct than the qui=
rk.
>>>>
>>>> Thanks,
>>>>
>>>> --
>>>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>>>> One Laptop Per Child
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
