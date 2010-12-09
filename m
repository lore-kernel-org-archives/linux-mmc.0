From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 1/1] sdhci support emmc ddr50 mode
Date: Thu, 9 Dec 2010 00:50:50 -0500
Message-ID: <AANLkTimgG7D+qqneJbja_rnhYRFLPy39mxF047WGeRx_@mail.gmail.com>
References: <AANLkTiknFGMQczA-bcnDLv7K4ZpDOZgiG-iQNLDm+aNC@mail.gmail.com>
	<AANLkTikTHVORPN6U4qgEij=ig7zROERV_k+q-6RL-AYQ@mail.gmail.com>
	<E3E29FC5-7D18-4207-AF6B-6D61BD361F29@marvell.com>
	<AANLkTikVBtULWA7CZwM6GPYcQhFOudF3Fwj8bMwUimqc@mail.gmail.com>
	<AANLkTikYirB-a7i5uO9HtESA1NG2zcTb+127m672HdDd@mail.gmail.com>
	<F8976AA8-C9DB-4FA1-ADF2-290DE1E211E1@marvell.com>
	<AANLkTikkKp0od2JSjfm_PS2g2-h-76+vbKLOYjvkyQY2@mail.gmail.com>
	<BBECB863-095E-42B9-89B0-0764164A4182@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:48444 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab0LIFuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2010 00:50:52 -0500
Received: by fxm18 with SMTP id 18so1962995fxm.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Dec 2010 21:50:50 -0800 (PST)
In-Reply-To: <BBECB863-095E-42B9-89B0-0764164A4182@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Wed, Dec 8, 2010 at 11:36 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Dec 8, 2010, at 6:03 PM, zhangfei gao wrote:
>
>> On Wed, Dec 8, 2010 at 9:45 AM, Philip Rakity <prakity@marvell.com> =
wrote:
>>>
>>> On Dec 6, 2010, at 8:09 PM, Zhangfei Gao wrote:
>>>
>>>> On Mon, Dec 6, 2010 at 10:36 PM, zhangfei gao <zhangfei.gao@gmail.=
com> wrote:
>>>>> On Mon, Dec 6, 2010 at 10:10 PM, Philip Rakity <prakity@marvell.c=
om> wrote:
>>>>>>
>>>>>> On Dec 6, 2010, at 4:15 AM, Zhangfei Gao wrote:
>>>>>>
>>>>>>> From f2194b46c2c3ded86009d36a4a8b4eebb7d0b9eb Mon Sep 17 00:00:=
00 2001
>>>>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>>> Date: Fri, 3 Dec 2010 07:21:15 -0500
>>>>>>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>>>>>>
>>>>>>> =A0 =A0 =A0 1. spec 3.0 does not claim support 1.2v ddr mode
>>>>>>> =A0 =A0 =A0 2. Call back function set_power is added, since som=
e controller count
>>>>>>> on external pmic to provide power
>>>>>>>
>>>>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>>> ---
>>>>>>> drivers/mmc/core/core.c =A0 | =A0 =A08 ++++++++
>>>>>>> drivers/mmc/host/sdhci.c =A0| =A0 36 ++++++++++++++++++++++++++=
+++++++++-
>>>>>>> drivers/mmc/host/sdhci.h =A0| =A0 14 ++++++++++++--
>>>>>>> include/linux/mmc/mmc.h =A0 | =A0 =A01 +
>>>>>>> include/linux/mmc/sdhci.h | =A0 =A02 ++
>>>>>>> 5 files changed, 58 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>>> index 8bf542c..8f172cd 100644
>>>>>>> --- a/drivers/mmc/core/core.c
>>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>>> @@ -1573,6 +1573,14 @@ void mmc_rescan(struct work_struct *work=
)
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_op_cond(host, 0, &=
ocr);
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err) {
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ocr & MMC_CARD_1=
_8V)
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (h=
ost->ocr_avail & MMC_CARD_1_8V)) {
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* sw=
itch voltage to 1.8v */
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_p=
ower_off(host);
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host-=
>ocr =3D ocr & host->ocr_avail;
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_p=
ower_up(host);
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>>>> +
>>>>>>
>>>>>> is the 1.2v case missing ?
>>>>> ocr does not support 1.2.
>>>>>>
>>>>>> /*
>>>>>> =A0* Mask off any voltages we don't support and select
>>>>>> =A0* the lowest voltage
>>>>>> =A0*/
>>>>>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>>>>>>
>>>>>> Doesn't this code already handle the voltage correctly ?
>>>>> mmc_select_voltage can not meet the requirement, if switch voltag=
e,
>>>>> power down and power up is needed, time delay is required waiting=
 for
>>>>> voltage to be stable.
>>>>>
>>>>>>
>>>>>>
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_attach_mmc(=
host, ocr))
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc=
_power_off(host);
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.=
c
>>>>>>> index a25db42..b7ad2f6 100644
>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>> @@ -982,6 +982,22 @@ static void sdhci_finish_command(struct sd=
hci_host *host)
>>>>>>> =A0 =A0 =A0 host->cmd =3D NULL;
>>>>>>> }
>>>>>>>
>>>>>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned in=
t ddr)
>>>>>>> +{
>>>>>>> + =A0 =A0 u16 con;
>>>>>>> +
>>>>>>> + =A0 =A0 if (ddr =3D=3D MMC_SDR_MODE)
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>>> +
>>>>>>> + =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>>> + =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con &=3D ~SDHCI_CTRL2_UHS_MASK;
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_=
DDR50;
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CO=
NTROL2);
>>>>>>> + =A0 =A0 }
>>>>>>> +}
>>>>>>> +
>>>>>>
>>>>>>
>>>>>> The host controller should not enable the CAP if 1.8V is not sup=
ported. =A0DDR should not be
>>>>>> invoked if CAP is not set. =A0Thus
>>>>>
>>>>> set_ddr is called with para ddr, it would not enter here if =A0CA=
P is not set.
>>>>>>
>>>>>>> + =A0 =A0 if (con & SDHCI_CTRL2_1_8V) {
>>>>>>
>>>>>> and
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ddr & MMC_1_8V_DDR_MODE)
>>>>>>
>>>>>> are not needed.
>>>>>>
>>>>>> This code should move to driver specific function since tuning m=
ay be done on some systems and
>>>>>> some systems (not mmp2) may need to delay the 5ms for voltage to=
 be stable. =A0Would prefer a
>>>>>> host->ops callback.
>>>>> 5ms is considered in power up, that's the reason not put in set_i=
os
>>>>> with call back.
>>>>>>
>>>>>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned i=
nt clock)
>>>>>>> {
>>>>>>> =A0 =A0 =A0 int div;
>>>>>>> @@ -1080,6 +1096,17 @@ static void sdhci_set_power(struct sdhci=
_host
>>>>>>> *host, unsigned short power)
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>>> =A0 =A0 =A0 }
>>>>>>>
>>>>>>> + =A0 =A0 if (pwr =3D=3D SDHCI_POWER_180) {
>>>>
>>>> Could add one more condition here
>>>> if ((host->mmc->caps & MMC_CAP_1_8V_DDR) &&
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pwr =3D=3D SDHCI_POWER_180)) {
>>>>
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 con;
>>>>>>> +
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con =3D sdhci_readw(host, SDHCI_HOST_=
CONTROL2);
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 con |=3D SDHCI_CTRL2_1_8V;
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, con, SDHCI_HOST_CO=
NTROL2);
>>>>>>> +
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ops->set_power)
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_power(=
host, pwr);
>>>>>>> + =A0 =A0 }
>>>>>>> +
>>>>>>
>>>>>> This code should be moved to sdhci_set_ddr (aboe). =A0Not needed=
 if voltage is 1.8v and card
>>>>>> is not running ddr.
>>>>> No defect to set SDHCI_CTRL2_1_8V if choose 1.8v.
>>>>>
>>>>>>
>>>>>>> =A0 =A0 =A0 /*
>>>>>>> =A0 =A0 =A0 =A0* Spec says that we should clear the power reg b=
efore setting
>>>>>>> =A0 =A0 =A0 =A0* a new value. Some controllers don't seem to li=
ke this though.
>>>>>>> @@ -1176,6 +1203,7 @@ static void sdhci_set_ios(struct mmc_host=
 *mmc,
>>>>>>> struct mmc_ios *ios)
>>>>>>> =A0 =A0 =A0 }
>>>>>>>
>>>>>>> =A0 =A0 =A0 sdhci_set_clock(host, ios->clock);
>>>>>>> + =A0 =A0 sdhci_set_ddr(host, ios->ddr);
>>>>>>>
>>>>>>> =A0 =A0 =A0 if (ios->power_mode =3D=3D MMC_POWER_OFF)
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_power(host, -1);
>>>>>>> @@ -1736,7 +1764,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>>>>>> int sdhci_add_host(struct sdhci_host *host)
>>>>>>> {
>>>>>>> =A0 =A0 =A0 struct mmc_host *mmc;
>>>>>>> - =A0 =A0 unsigned int caps;
>>>>>>> + =A0 =A0 unsigned int caps, caps_h;
>>>>>>> =A0 =A0 =A0 int ret;
>>>>>>>
>>>>>>> =A0 =A0 =A0 WARN_ON(host =3D=3D NULL);
>>>>>>> @@ -1761,6 +1789,12 @@ int sdhci_add_host(struct sdhci_host *ho=
st)
>>>>>>>
>>>>>>> =A0 =A0 =A0 caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) =
? host->caps :
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIE=
S);
>>>>>>> + =A0 =A0 caps_h =3D sdhci_readl(host, SDHCI_CAPABILITIES_H);
>>>>>>> +
>>>>>>> + =A0 =A0 if (caps & SDHCI_CAN_VDD_180) {
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (caps_h & SDHCI_CAN_SDR50)
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_C=
AP_1_8V_DDR);
>>>>>>> + =A0 =A0 }
>>>>>>>
>>>>>>> =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_USE_SDMA;
>>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.=
h
>>>>>>> index b689cc6..28c460a 100644
>>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>>> @@ -144,7 +144,14 @@
>>>>>>>
>>>>>>> #define SDHCI_ACMD12_ERR =A0 =A0 =A00x3C
>>>>>>>
>>>>>>> -/* 3E-3F reserved */
>>>>>>> +#define SDHCI_HOST_CONTROL2 =A00x3E
>>>>>>> +#define =A0SDHCI_CTRL2_UHS_MASK =A0 =A0 =A0 =A00x0007
>>>>>>> +#define =A0 SDHCI_CTRL2_SDR12 =A00x0000
>>>>>>> +#define =A0 SDHCI_CTRL2_SDR25 =A00x0001
>>>>>>> +#define =A0 SDHCI_CTRL2_SDR50 =A00x0002
>>>>>>> +#define =A0 SDHCI_CTRL2_SDR104 0x0003
>>>>>>> +#define =A0 SDHCI_CTRL2_DDR50 =A00x0004
>>>>>>> +#define =A0SDHCI_CTRL2_1_8V =A0 =A00x0008
>>>>>>>
>>>>>>> #define SDHCI_CAPABILITIES =A0 =A00x40
>>>>>>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A0 0x0000003F
>>>>>>> @@ -165,7 +172,10 @@
>>>>>>> #define =A0SDHCI_CAN_VDD_180 =A0 =A00x04000000
>>>>>>> #define =A0SDHCI_CAN_64BIT =A0 =A0 =A00x10000000
>>>>>>>
>>>>>>> -/* 44-47 reserved for more caps */
>>>>>>> +#define SDHCI_CAPABILITIES_H 0x44
>>>>>>> +#define =A0SDHCI_CAN_SDR50 =A0 =A0 0x00000001
>>>>>>> +#define =A0SDHCI_CAN_SDR104 =A0 =A00x00000002
>>>>>>> +#define =A0SDHCI_CAN_DDR50 =A0 =A0 0x00000004
>>>>>>>
>>>>>>> #define SDHCI_MAX_CURRENT =A0 =A0 0x48
>>>>>>>
>>>>>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>>>>>> index 956fbd8..bd09b19 100644
>>>>>>> --- a/include/linux/mmc/mmc.h
>>>>>>> +++ b/include/linux/mmc/mmc.h
>>>>>>> @@ -202,6 +202,7 @@ struct _mmc_csd {
>>>>>>> =A0* OCR bits are mostly in host.h
>>>>>>> =A0*/
>>>>>>> #define MMC_CARD_BUSY 0x80000000 =A0 =A0 =A0/* Card Power up st=
atus bit */
>>>>>>> +#define MMC_CARD_1_8V =A0 =A0 =A0 =A00x00000080 =A0 =A0 =A0/* =
Card 1.70-1.95V support bit */
>>>>>>>
>>>>>>> /*
>>>>>>> =A0* Card Command Classes (CCC)
>>>>>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhc=
i.h
>>>>>>> index 86e8380..57bcda9 100644
>>>>>>> --- a/include/linux/mmc/sdhci.h
>>>>>>> +++ b/include/linux/mmc/sdhci.h
>>>>>>> @@ -163,6 +163,8 @@ struct sdhci_ops {
>>>>>>> =A0 =A0 =A0 void (*platform_send_init_74_clocks)(struct sdhci_h=
ost *host,
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0u8 power_mode);
>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0(*get_ro)(struct sdhci_host *ho=
st);
>>>>>>> + =A0 =A0 unsigned int =A0 =A0(*set_power)(struct sdhci_host *h=
ost,
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned short power);
>>>>>>> };
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> 1.7.0.4
>>>>>>>
>>>>>>> Update the condition of voltage switch.
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ocr & MMC_CARD_1=
_8V)
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (h=
ost->ocr_avail & MMC_CARD_1_8V)) {
>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* sw=
itch voltage to 1.8v */
>>>>>>>
>>>>>>> Any comments are welcome.
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-mmc" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>
>>>>>>
>>>>>
>>>
>>>
>>>
>>> NAK
>>>
>>> There are two voltages -- the voltage to the card and the voltage u=
sed for signaling.
>>> The voltage of the card is programmed using mmc_set_voltage. =A0It =
can be 3.3, 1.8v etc
>>> this voltage is controlled via the host control register 0x28.
>>>
>>> the voltage used for signaling is controlled via the host control r=
egister 2 (0x3e). =A0moving
>>> to ddr requires that this voltage be signaled to the card (CMD11) a=
nd and changed via
>>> host control register 2. =A0The flowchart figure 3.10 -- page 104 s=
hows the sequence that
>>> is needed.
>>>
>>> What is missing in core/ is
>>> a) support for CMD11
>>> b) correct implementation for changing =A0the signaling voltage for=
 uhs modes
>>>
>>>
>> CMD11 only used for sd3.0 card, not mmc card, mmc does not require a=
ny
>> cmd, just change voltage and wait for voltage stable, thanks
>
> This may work but is not sd host controller compliant. =A0 My testing=
 indicates that
> we can supply 2.8v to the card and NOT support 1.8v signaling and the=
 eMMC
> chip that is being used will be recognized as supporting DDR and work=
=2E

The emmc ddr50 mode could work at either 1.8v or 3v,  while sd UHS
mode must work at 1.8v.
UHS mode, including emmc ddr50, only effective when 1.8v Singlaing
Enable is set to 1, it does not matter what the real voltage.
So if 1.8v Singlaing Enable bit is clear to 1 after 5ms, the emmc
ddr50 mode can not work.
Though dual data rate card does not equal to dual voltage card, still
not find dual data rate card does not have capacity of dual voltage.

>
> A compliant card can support 3.3 volts to the card and allow 1.8v sig=
naling.
> Thus lowering the voltage to the card can stop the card from working.=
 =A0 (The
> card does not have to support 1.8v to work using DDR)
>
> The host controller spec says (Page 72: Host Control 2 Register:
>
> =A0Bit 3 RW =A01.8V Signaling Enable
> --------------------------------------------
> This bit controls voltage regulator for I/O cell. =A03.3V is supplied=
 to the card
> regardless of signaling voltage.
> Setting this bit from 0 to1 starts changing signaling voltage from 3.=
3v to 1.8v.
> 1.8v regulator output shall be stable with 5ms. =A0Host controller cl=
ears this bit
> if switching to1.8v signaling fails.
>
>
>
>>>
>>>
>>>
>
>
