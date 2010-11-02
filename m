From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [Patch 1/1]sdhci: verify ddr50 mode
Date: Tue, 2 Nov 2010 09:01:03 -0400
Message-ID: <AANLkTi=FjuKkWz1QSNvumgnqwyAssxzrqzRRZP9-fcyE@mail.gmail.com>
References: <AC075E1A-DB5B-40D6-B1D1-67EC53BED256@marvell.com>
	<D2D0ECF3-178C-4572-8F7C-786F97E46F65@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52648 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab0KBNBQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Nov 2010 09:01:16 -0400
Received: by fxm16 with SMTP id 16so5763016fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 02 Nov 2010 06:01:15 -0700 (PDT)
In-Reply-To: <D2D0ECF3-178C-4572-8F7C-786F97E46F65@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Nov 2, 2010 at 7:54 AM, Philip Rakity <prakity@marvell.com> wro=
te:
>
> The DDR control code should not be sdhci.c but should be in hardware =
specific code like sdhci-dove or sdhci-pxa etc.
>
> This change requires a call back for DDR to work: =A0eg host->ops->se=
t_ddr must be defined for the CAPS to be set.
>
> change
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((caps & SDHCI_CAN_VDD_180) && (caps_=
h & SDHCI_CAN_DDR50))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->cap=
s |=3D (MMC_CAP_1_8V_DDR);
> to
> =A0 =A0 =A0 =A0if (host->ops->set_ddr && (caps & SDHCI_CAN_VDD_180) &=
& (caps_h & SDHCI_CAN_DDR50))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_=
1_8V_DDR);
>
>
> and call to sdhci_set_ddr() in set_ios() =A0would be replaced by
>
> if (host->ops->set_ddr)
> =A0 =A0 host->ops->set_ddr(host, ddr);
>
> The code in shdci_set_ddr() would be moved to the platform specific c=
ode section.

Disagree, the common code should be implemented in sdhci.c and keep
platform driver as simple as possible.
>
> RATIONALE:
>
> DDR tuning may be needed which will be host/board specific. =A0(I bel=
ieve we have already seen this). =A0Auto tuning could help (if implemen=
ted) but our controllers do not support that today.
>
> We should allow provisions for other controllers to handle this in th=
eir own way. =A0The code is not performance sensitive and is executed o=
nly a few times during card setup.
>
>
> On Nov 1, 2010, at 6:00 PM, Philip Rakity wrote:
>
>> comments below
>>
>>
>>> Based on the work from Adrian and Hanumath, here is the patch to
>>> verify ddr50 for sdhci.c on sdhci-pxa with HYNIX and toshiba eMMC.
>>> Only support emmc DDR50 mode now.
>>> Would you help review, thanks
>>>
>>> From 59072fa8fea50634f01009e51c4b5e16308ab466 Mon Sep 17 00:00:00 2=
001
>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>
>>> Date: Mon, 1 Nov 2010 07:43:57 -0400
>>> Subject: [PATCH] sdhci: support DDR50 mode
>>>
>>> =A0 =A0 =A0Verified DDR50 mode on sdhci-pxa and HYNIX and toshiba e=
MMC
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> ---
>>> drivers/mmc/host/sdhci.c | =A0 48 +++++++++++++++++++++++++++++++++=
++++++++++++-
>>> drivers/mmc/host/sdhci.h | =A0 15 ++++++++++++-
>>> 2 files changed, 60 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 782c0ee..d9e4ab8 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -982,6 +982,44 @@ static void sdhci_finish_command(struct sdhci_=
host *host)
>>> =A0 =A0 =A0host->cmd =3D NULL;
>>> }
>>>
>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int dd=
r)
>>> +{
>>> + =A0 =A0u16 con;
>>> + =A0 =A0unsigned long timeout;
>>> +
>>> + =A0 =A0if (ddr =3D=3D MMC_SDR_MODE)
>>> + =A0 =A0 =A0 =A0 =A0 =A0return;
>>> +
>>> + =A0 =A0if (host->ops->set_ddr)
>>> + =A0 =A0 =A0 =A0 =A0 =A0host->ops->set_ddr(host, ddr);
>>> +
>>> + =A0 =A0/* Fixme, how to support 1.2v Mode */
>>> + =A0 =A0if (ddr & MMC_1_8V_DDR_MODE) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0con =3D sdhci_readw(host, SDHCI_HOST_CONTR=
OL2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0con |=3D SDHCI_CTRL2_1_8V;
>>> + =A0 =A0 =A0 =A0 =A0 =A0sdhci_writew(host, con, SDHCI_HOST_CONTROL=
2);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0/* Wait max 5 ms */
>>> + =A0 =A0 =A0 =A0 =A0 =A0timeout =3D 5;
>>> + =A0 =A0 =A0 =A0 =A0 =A0while (!((con =3D sdhci_readw(host, SDHCI_=
HOST_CONTROL2))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0& SDHCI_CTRL2_1_8V)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (timeout =3D=3D 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KER=
N_ERR "%s: HOST CONTROL fail switch to 1.8v\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0mmc_hostname(host->mmc));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_dump=
regs(host);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mdelay(1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 =A0 =A0 =A0con =3D sdhci_readw(host, SDHCI_HOST_CONTR=
OL2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0con &=3D ~SDHCI_CTRL2_UHS_MASK;
>>> + =A0 =A0 =A0 =A0 =A0 =A0/* only support DDR50 */
>>> + =A0 =A0 =A0 =A0 =A0 =A0con |=3D SDHCI_CTRL2_DDR50;
>>> + =A0 =A0 =A0 =A0 =A0 =A0sdhci_writew(host, con, SDHCI_HOST_CONTROL=
2);
>>> + =A0 =A0}
>>> +}
>
>>
>> The fix me for 1.2v comment should be deleted. =A0SD 3.0 does not su=
pport 1.2V so there is nothing to fix.
>>
>> We should just try to set DDR. =A0 If we need to check the voltage t=
o ensure the chip is operating at 1.2v or 1.8v then the CAP should only=
 be set once the correct voltage has been selected. =A0In my experience=
 using DDR -- =A0DDR seems to work fine even when the voltage is at a h=
igher value.
>>
>> The code to program DDR can be simplified to \
>>
>> =A0 =A0 =A0 if (ios->ddr) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 hostctrl2;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hostctrl2 =3D sdhci_readw(host, HOST_CTR=
L_2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hostctrl2 |=3D SDCTRL_2_SDH_V18_EN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hostctrl2 &=3D ~SDCTRL_2_UHS_MODE_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hostctrl2 |=3D SDCTRL_2_UHS_MODE_SEL_DDR=
40;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, hostctrl2, HOST_CTRL_=
2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hostctrl2 =3D sdhci_readw(host, HOST_CTR=
L_2);
>> =A0 =A0 =A0 }
>>
>> verified with Toshiba eMMC at 50MHz.

In the experiment with henix, 1.2V_DDR_MODE really could be supported
by enable 1.8v regulator ourput, however I am still concern whether it
is sdhci-pxa specific behavior or all controller behavior.
SD3.0 spec says 1.8v regulator output should be stable with 5ms,
however not find any status flag to show it is stable or not.

>>
>>
>>> +
>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int c=
lock)
>>> {
>>> =A0 =A0 =A0int div;
>>> @@ -1176,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mm=
c,
>>> struct mmc_ios *ios)
>>> =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0sdhci_set_clock(host, ios->clock);
>>> + =A0 =A0sdhci_set_ddr(host, ios->ddr);
>>>
>>> =A0 =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
>>> @@ -1712,7 +1751,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>> int sdhci_add_host(struct sdhci_host *host)
>>> {
>>> =A0 =A0 =A0struct mmc_host *mmc;
>>> - =A0 =A0unsigned int caps;
>>> + =A0 =A0unsigned int caps, caps_h;
>>> =A0 =A0 =A0int ret;
>>>
>>> =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
>>> @@ -1737,6 +1776,13 @@ int sdhci_add_host(struct sdhci_host *host)
>>>
>>> =A0 =A0 =A0caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? hos=
t->caps :
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_CAPABILITIES);
>>> + =A0 =A0caps_h =3D sdhci_readl(host, SDHCI_CAPABILITIES_H);
>>> +
>>> + =A0 =A0if ((caps & SDHCI_CAN_VDD_180) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0((caps_h & SDHCI_CAN_SDR50) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0(caps_h & SDHCI_CAN_SDR104) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0(caps_h & SDHCI_CAN_DDR50)))
>>> + =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D (MMC_CAP_1_8V_DDR);
>>>
>>
>> SDR is Single Data Rate, I do not think we should not set DDR if DDR=
50 is not defined
>>
>> Change to
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((caps & SDHCI_CAN_VDD_180) && (caps_=
h & SDHCI_CAN_DDR50))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->cap=
s |=3D (MMC_CAP_1_8V_DDR);

Agree, other caps may be needed to support SDR, though 1.8v also requir=
ed.
>>
>> see comment above about if we should set CAP is voltage is not 1.8v.
>>
>>
>>> =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index b7b8a3b..fe87c5f 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -141,7 +141,14 @@
>>>
>>> #define SDHCI_ACMD12_ERR =A0 =A0 0x3C
>>>
>>> -/* 3E-3F reserved */
>>> +#define SDHCI_HOST_CONTROL2 0x3E
>>> +#define =A0SDHCI_CTRL2_UHS_MASK =A0 =A0 =A0 0x07
>>> +#define =A0 SDHCI_CTRL2_SDR12 0x00
>>> +#define =A0 SDHCI_CTRL2_SDR25 0x01
>>> +#define =A0 SDHCI_CTRL2_SDR50 0x02
>>> +#define =A0 SDHCI_CTRL2_SDR104 =A0 =A0 =A0 =A00x03
>>> +#define =A0 SDHCI_CTRL2_DDR50 0x04
>>> +#define =A0SDHCI_CTRL2_1_8V =A0 0x08
>>
>> please add the other definitions for the register.
Other definition has nothing to do with DDR mode.
>>
>>
>>>
>>> #define SDHCI_CAPABILITIES =A0 0x40
>>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A00x0000003F
>>> @@ -161,7 +168,10 @@
>>> #define =A0SDHCI_CAN_VDD_180 =A0 0x04000000
>>> #define =A0SDHCI_CAN_64BIT =A0 =A0 0x10000000
>>>
>>> -/* 44-47 reserved for more caps */
>>> +#define SDHCI_CAPABILITIES_H =A0 =A0 =A0 =A00x44
>>> +#define =A0SDHCI_CAN_SDR50 =A0 =A00x00000001
>>> +#define =A0SDHCI_CAN_SDR104 =A0 0x00000002
>>> +#define =A0SDHCI_CAN_DDR50 =A0 =A00x00000004
>>>
>>> #define SDHCI_MAX_CURRENT =A0 =A00x48
>>>
>>> @@ -207,6 +217,7 @@ struct sdhci_ops {
>>> #endif
>>>
>>> =A0 =A0 =A0void =A0 =A0(*set_clock)(struct sdhci_host *host, unsign=
ed int clock);
>>> + =A0 =A0void =A0 =A0(*set_ddr)(struct sdhci_host *host, unsigned i=
nt ddr);
>>>
>>> =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*enable_dma)(struct sdhci_h=
ost *host);
>>> =A0 =A0 =A0unsigned int =A0 =A0(*get_max_clock)(struct sdhci_host *=
host);
>>> --
>>> 1.7.0.4
>>>
>>>
>>> ["0001-sdhci-support-DDR50-mode.patch" (text/x-patch)]
>>>
>>>
>>> From 59072fa8fea50634f01009e51c4b5e16308ab466 Mon Sep 17 00:00:00 2=
001
>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> Date: Mon, 1 Nov 2010 07:43:57 -0400
>>> Subject: [PATCH] sdhci: support DDR50 mode
>>>
>>> =A0 =A0 =A0Verified DDR50 mode on sdhci-pxa and HYNIX and toshiba e=
MMC
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> ---
>>> drivers/mmc/host/sdhci.c | =A0 48 +++++++++++++++++++++++++++++++++=
++++++++++++-
>>> drivers/mmc/host/sdhci.h | =A0 15 ++++++++++++-
>>> 2 files changed, 60 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 782c0ee..d9e4ab8 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -982,6 +982,44 @@ static void sdhci_finish_command(struct sdhci_=
host *host)
>>> =A0 =A0 =A0host->cmd =3D NULL;
>>> }
>>>
>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int dd=
r)
>>> +{
>>> + =A0 =A0u16 con;
>>> + =A0 =A0unsigned long timeout;
>>> +
>>> + =A0 =A0if (ddr =3D=3D MMC_SDR_MODE)
>>> + =A0 =A0 =A0 =A0 =A0 =A0return;
>>> +
>>> + =A0 =A0if (host->ops->set_ddr)
>>> + =A0 =A0 =A0 =A0 =A0 =A0host->ops->set_ddr(host, ddr);
>>
>> would prefer
>>
>> =A0 =A0 =A0 if (host->ops->set_ddr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->set_ddr(host, ddr);

Set_ddr is used to tunning timming for various cards, however we could
do it in set_clock.
Want to remove this API to keep sdhci.c as simple as possible, other
controller could add this API if it is a must.

>>
>> since if private registers do need setting is not clear if the stand=
ard register set can be used. =A0Let the lower layer handle everything.
>>
>>> +
>>> + =A0 =A0/* Fixme, how to support 1.2v Mode */
>>> + =A0 =A0if (ddr & MMC_1_8V_DDR_MODE) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0con =3D sdhci_readw(host, SDHCI_HOST_CONTR=
OL2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0con |=3D SDHCI_CTRL2_1_8V;
>>> + =A0 =A0 =A0 =A0 =A0 =A0sdhci_writew(host, con, SDHCI_HOST_CONTROL=
2);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0/* Wait max 5 ms */
>>> + =A0 =A0 =A0 =A0 =A0 =A0timeout =3D 5;
>>> + =A0 =A0 =A0 =A0 =A0 =A0while (!((con =3D sdhci_readw(host, SDHCI_=
HOST_CONTROL2))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0& SDHCI_CTRL2_1_8V)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (timeout =3D=3D 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KER=
N_ERR "%s: HOST CONTROL fail switch to 1.8v\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0mmc_hostname(host->mmc));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_dump=
regs(host);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mdelay(1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 =A0 =A0 =A0con =3D sdhci_readw(host, SDHCI_HOST_CONTR=
OL2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0con &=3D ~SDHCI_CTRL2_UHS_MASK;
>>> + =A0 =A0 =A0 =A0 =A0 =A0/* only support DDR50 */
>>> + =A0 =A0 =A0 =A0 =A0 =A0con |=3D SDHCI_CTRL2_DDR50;
>>> + =A0 =A0 =A0 =A0 =A0 =A0sdhci_writew(host, con, SDHCI_HOST_CONTROL=
2);
>>> + =A0 =A0}
>>> +}
>>> +
>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int c=
lock)
>>> {
>>> =A0 =A0 =A0int div;
>>> @@ -1176,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
>>> =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0sdhci_set_clock(host, ios->clock);
>>> + =A0 =A0sdhci_set_ddr(host, ios->ddr);
>>>
>>> =A0 =A0 =A0if (ios->power_mode =3D=3D MMC_POWER_OFF)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_set_power(host, -1);
>>> @@ -1712,7 +1751,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>> int sdhci_add_host(struct sdhci_host *host)
>>> {
>>> =A0 =A0 =A0struct mmc_host *mmc;
>>> - =A0 =A0unsigned int caps;
>>> + =A0 =A0unsigned int caps, caps_h;
>>> =A0 =A0 =A0int ret;
>>>
>>> =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
>>> @@ -1737,6 +1776,13 @@ int sdhci_add_host(struct sdhci_host *host)
>>>
>>> =A0 =A0 =A0caps =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? hos=
t->caps :
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_CAPABILITIES);
>>> + =A0 =A0caps_h =3D sdhci_readl(host, SDHCI_CAPABILITIES_H);
>>> +
>>> + =A0 =A0if ((caps & SDHCI_CAN_VDD_180) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0((caps_h & SDHCI_CAN_SDR50) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0(caps_h & SDHCI_CAN_SDR104) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0(caps_h & SDHCI_CAN_DDR50)))
>>> + =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D (MMC_CAP_1_8V_DDR);
>>>
>>> =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index b7b8a3b..fe87c5f 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -141,7 +141,14 @@
>>>
>>> #define SDHCI_ACMD12_ERR =A0 =A0 0x3C
>>>
>>> -/* 3E-3F reserved */
>>> +#define SDHCI_HOST_CONTROL2 0x3E
>>> +#define =A0SDHCI_CTRL2_UHS_MASK =A0 =A0 =A0 0x07
>>> +#define =A0 SDHCI_CTRL2_SDR12 0x00
>>> +#define =A0 SDHCI_CTRL2_SDR25 0x01
>>> +#define =A0 SDHCI_CTRL2_SDR50 0x02
>>> +#define =A0 SDHCI_CTRL2_SDR104 =A0 =A0 =A0 =A00x03
>>> +#define =A0 SDHCI_CTRL2_DDR50 0x04
>>> +#define =A0SDHCI_CTRL2_1_8V =A0 0x08
>>>
>>> #define SDHCI_CAPABILITIES =A0 0x40
>>> #define =A0SDHCI_TIMEOUT_CLK_MASK =A0 =A0 =A00x0000003F
>>> @@ -161,7 +168,10 @@
>>> #define =A0SDHCI_CAN_VDD_180 =A0 0x04000000
>>> #define =A0SDHCI_CAN_64BIT =A0 =A0 0x10000000
>>>
>>> -/* 44-47 reserved for more caps */
>>> +#define SDHCI_CAPABILITIES_H =A0 =A0 =A0 =A00x44
>>> +#define =A0SDHCI_CAN_SDR50 =A0 =A00x00000001
>>> +#define =A0SDHCI_CAN_SDR104 =A0 0x00000002
>>> +#define =A0SDHCI_CAN_DDR50 =A0 =A00x00000004
>>>
>>> #define SDHCI_MAX_CURRENT =A0 =A00x48
>>>
>>> @@ -207,6 +217,7 @@ struct sdhci_ops {
>>> #endif
>>>
>>> =A0 =A0 =A0void =A0 =A0(*set_clock)(struct sdhci_host *host, unsign=
ed int clock);
>>> + =A0 =A0void =A0 =A0(*set_ddr)(struct sdhci_host *host, unsigned i=
nt ddr);


>>>
>>> =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*enable_dma)(struct sdhci_h=
ost *host);
>>> =A0 =A0 =A0unsigned int =A0 =A0(*get_max_clock)(struct sdhci_host *=
host);
>>> --
>>> 1.7.0.4
>>
>
>
