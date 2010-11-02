From: Philip Rakity <prakity@marvell.com>
Subject: Re: [Patch 1/1]sdhci: verify ddr50 mode
Date: Tue, 2 Nov 2010 06:46:14 -0700
Message-ID: <2340EC70-7AF3-4002-8E69-BC701A8679C0@marvell.com>
References: <AC075E1A-DB5B-40D6-B1D1-67EC53BED256@marvell.com>
 <D2D0ECF3-178C-4572-8F7C-786F97E46F65@marvell.com>
 <AANLkTi=FjuKkWz1QSNvumgnqwyAssxzrqzRRZP9-fcyE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:59353 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752729Ab0KBNtF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Nov 2010 09:49:05 -0400
In-Reply-To: <AANLkTi=FjuKkWz1QSNvumgnqwyAssxzrqzRRZP9-fcyE@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 2, 2010, at 6:01 AM, zhangfei gao wrote:

> On Tue, Nov 2, 2010 at 7:54 AM, Philip Rakity <prakity@marvell.com> wrote:
>>
>> The DDR control code should not be sdhci.c but should be in hardware specific code like sdhci-dove or sdhci-pxa etc.
>>
>> This change requires a call back for DDR to work:  eg host->ops->set_ddr must be defined for the CAPS to be set.
>>
>> change
>>>              if ((caps & SDHCI_CAN_VDD_180) && (caps_h & SDHCI_CAN_DDR50))
>>>                              mmc->caps |= (MMC_CAP_1_8V_DDR);
>> to
>>       if (host->ops->set_ddr && (caps & SDHCI_CAN_VDD_180) && (caps_h & SDHCI_CAN_DDR50))
>>>                      mmc->caps |= (MMC_CAP_1_8V_DDR);
>>
>>
>> and call to sdhci_set_ddr() in set_ios()  would be replaced by
>>
>> if (host->ops->set_ddr)
>>    host->ops->set_ddr(host, ddr);
>>
>> The code in shdci_set_ddr() would be moved to the platform specific code section.
>
> Disagree, the common code should be implemented in sdhci.c and keep
> platform driver as simple as possible.

See below --  platform driver cannot be this simple although do agree it would be nice.

>>
>> RATIONALE:
>>
>> DDR tuning may be needed which will be host/board specific.  (I believe we have already seen this).  Auto tuning could help (if implemented) but our controllers do not support that today.
>>
>> We should allow provisions for other controllers to handle this in their own way.  The code is not performance sensitive and is executed only a few times during card setup.
>>
>>
>> On Nov 1, 2010, at 6:00 PM, Philip Rakity wrote:
>>
>>> comments below
>>>
>>>
>>>> Based on the work from Adrian and Hanumath, here is the patch to
>>>> verify ddr50 for sdhci.c on sdhci-pxa with HYNIX and toshiba eMMC.
>>>> Only support emmc DDR50 mode now.
>>>> Would you help review, thanks
>>>>
>>>> From 59072fa8fea50634f01009e51c4b5e16308ab466 Mon Sep 17 00:00:00 2001
>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>
>>>> Date: Mon, 1 Nov 2010 07:43:57 -0400
>>>> Subject: [PATCH] sdhci: support DDR50 mode
>>>>
>>>>     Verified DDR50 mode on sdhci-pxa and HYNIX and toshiba eMMC
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> ---
>>>> drivers/mmc/host/sdhci.c |   48 +++++++++++++++++++++++++++++++++++++++++++++-
>>>> drivers/mmc/host/sdhci.h |   15 ++++++++++++-
>>>> 2 files changed, 60 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 782c0ee..d9e4ab8 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -982,6 +982,44 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>>>     host->cmd = NULL;
>>>> }
>>>>
>>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
>>>> +{
>>>> +    u16 con;
>>>> +    unsigned long timeout;
>>>> +
>>>> +    if (ddr == MMC_SDR_MODE)
>>>> +            return;
>>>> +
>>>> +    if (host->ops->set_ddr)
>>>> +            host->ops->set_ddr(host, ddr);
>>>> +
>>>> +    /* Fixme, how to support 1.2v Mode */
>>>> +    if (ddr & MMC_1_8V_DDR_MODE) {
>>>> +            con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +            con |= SDHCI_CTRL2_1_8V;
>>>> +            sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>> +
>>>> +            /* Wait max 5 ms */
>>>> +            timeout = 5;
>>>> +            while (!((con = sdhci_readw(host, SDHCI_HOST_CONTROL2))
>>>> +                                    & SDHCI_CTRL2_1_8V)) {
>>>> +                    if (timeout == 0) {
>>>> +                            printk(KERN_ERR "%s: HOST CONTROL fail switch to 1.8v\n",
>>>> +                                            mmc_hostname(host->mmc));
>>>> +                            sdhci_dumpregs(host);
>>>> +                            return;
>>>> +                    }
>>>> +                    timeout--;
>>>> +                    mdelay(1);
>>>> +            }
>>>> +            con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +            con &= ~SDHCI_CTRL2_UHS_MASK;
>>>> +            /* only support DDR50 */
>>>> +            con |= SDHCI_CTRL2_DDR50;
>>>> +            sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>> +    }
>>>> +}
>>
>>>
>>> The fix me for 1.2v comment should be deleted.  SD 3.0 does not support 1.2V so there is nothing to fix.
>>>
>>> We should just try to set DDR.   If we need to check the voltage to ensure the chip is operating at 1.2v or 1.8v then the CAP should only be set once the correct voltage has been selected.  In my experience using DDR --  DDR seems to work fine even when the voltage is at a higher value.
>>>
>>> The code to program DDR can be simplified to \
>>>
>>>      if (ios->ddr) {
>>>              u16 hostctrl2;
>>>
>>>              hostctrl2 = sdhci_readw(host, HOST_CTRL_2);
>>>              hostctrl2 |= SDCTRL_2_SDH_V18_EN;
>>>              hostctrl2 &= ~SDCTRL_2_UHS_MODE_MASK;
>>>              hostctrl2 |= SDCTRL_2_UHS_MODE_SEL_DDR40;
>>>              sdhci_writew(host, hostctrl2, HOST_CTRL_2);
>>>              hostctrl2 = sdhci_readw(host, HOST_CTRL_2);
>>>      }
>>>
>>> verified with Toshiba eMMC at 50MHz.
>
> In the experiment with henix, 1.2V_DDR_MODE really could be supported
> by enable 1.8v regulator ourput, however I am still concern whether it
> is sdhci-pxa specific behavior or all controller behavior.
> SD3.0 spec says 1.8v regulator output should be stable with 5ms,
> however not find any status flag to show it is stable or not.

" I am still concern whether it
> is sdhci-pxa specific behavior or all controller behavior."

This is a good reason why code should be controller specific region.

There is no flag to say voltage is stable and there is not way either to recover from a failure to set 1.8v.  The card is already in DDR code from the switch statement in core/ and signaling failure may be too aggressive. The card might just work even if there is a signaling failure.


Change +            while (!((con = sdhci_readw(host, SDHCI_HOST_CONTROL2))
>>>> +                                    & SDHCI_CTRL2_1_8V)) {
>>

to

while (! sdhci_readw(host, SDHCI_HOST_CONTROL2))
>>>> +                                    & SDHCI_CTRL2_1_8V)) {

con not used.



>>>> +            while (!((con = sdhci_readw(host, SDHCI_HOST_CONTROL2))
>>>> +                                    & SDHCI_CTRL2_1_8V)) {
>>>> +                    if (timeout == 0) {
>>>> +                            printk(KERN_ERR "%s: HOST CONTROL fail switch to 1.8v\n",
>>>> +                                            mmc_hostname(host->mmc));
>>>> +                            sdhci_dumpregs(host);
>>>> +                            return;
>>>> +                    }
>>>> +                    timeout--;
>>>> +                    mdelay(1);
>>>> +            }
>>

>
>>>
>>>
>>>> +
>>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>> {
>>>>     int div;
>>>> @@ -1176,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
>>>> struct mmc_ios *ios)
>>>>     }
>>>>
>>>>     sdhci_set_clock(host, ios->clock);
>>>> +    sdhci_set_ddr(host, ios->ddr);
>>>>
>>>>     if (ios->power_mode == MMC_POWER_OFF)
>>>>             sdhci_set_power(host, -1);
>>>> @@ -1712,7 +1751,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>>> int sdhci_add_host(struct sdhci_host *host)
>>>> {
>>>>     struct mmc_host *mmc;
>>>> -    unsigned int caps;
>>>> +    unsigned int caps, caps_h;
>>>>     int ret;
>>>>
>>>>     WARN_ON(host == NULL);
>>>> @@ -1737,6 +1776,13 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>
>>>>     caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>>>>             sdhci_readl(host, SDHCI_CAPABILITIES);
>>>> +    caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_H);
>>>> +
>>>> +    if ((caps & SDHCI_CAN_VDD_180) &&
>>>> +            ((caps_h & SDHCI_CAN_SDR50) ||
>>>> +            (caps_h & SDHCI_CAN_SDR104) ||
>>>> +            (caps_h & SDHCI_CAN_DDR50)))
>>>> +            mmc->caps |= (MMC_CAP_1_8V_DDR);
>>>>
>>>
>>> SDR is Single Data Rate, I do not think we should not set DDR if DDR50 is not defined
>>>
>>> Change to
>>>              if ((caps & SDHCI_CAN_VDD_180) && (caps_h & SDHCI_CAN_DDR50))
>>>                              mmc->caps |= (MMC_CAP_1_8V_DDR);
>
> Agree, other caps may be needed to support SDR, though 1.8v also required.
>>>
>>> see comment above about if we should set CAP is voltage is not 1.8v.
>>>
>>>
>>>>     if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>>             host->flags |= SDHCI_USE_SDMA;
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index b7b8a3b..fe87c5f 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -141,7 +141,14 @@
>>>>
>>>> #define SDHCI_ACMD12_ERR     0x3C
>>>>
>>>> -/* 3E-3F reserved */
>>>> +#define SDHCI_HOST_CONTROL2 0x3E
>>>> +#define  SDHCI_CTRL2_UHS_MASK       0x07
>>>> +#define   SDHCI_CTRL2_SDR12 0x00
>>>> +#define   SDHCI_CTRL2_SDR25 0x01
>>>> +#define   SDHCI_CTRL2_SDR50 0x02
>>>> +#define   SDHCI_CTRL2_SDR104        0x03
>>>> +#define   SDHCI_CTRL2_DDR50 0x04
>>>> +#define  SDHCI_CTRL2_1_8V   0x08
>>>
>>> please add the other definitions for the register.
> Other definition has nothing to do with DDR mode.

agree but
since you are adding definitions for the register -- just do them all to keep the naming conventions.

>>>
>>>
>>>>
>>>> #define SDHCI_CAPABILITIES   0x40
>>>> #define  SDHCI_TIMEOUT_CLK_MASK      0x0000003F
>>>> @@ -161,7 +168,10 @@
>>>> #define  SDHCI_CAN_VDD_180   0x04000000
>>>> #define  SDHCI_CAN_64BIT     0x10000000
>>>>
>>>> -/* 44-47 reserved for more caps */
>>>> +#define SDHCI_CAPABILITIES_H        0x44
>>>> +#define  SDHCI_CAN_SDR50    0x00000001
>>>> +#define  SDHCI_CAN_SDR104   0x00000002
>>>> +#define  SDHCI_CAN_DDR50    0x00000004
>>>>
>>>> #define SDHCI_MAX_CURRENT    0x48
>>>>
>>>> @@ -207,6 +217,7 @@ struct sdhci_ops {
>>>> #endif
>>>>
>>>>     void    (*set_clock)(struct sdhci_host *host, unsigned int clock);
>>>> +    void    (*set_ddr)(struct sdhci_host *host, unsigned int ddr);
>>>>
>>>>     int             (*enable_dma)(struct sdhci_host *host);
>>>>     unsigned int    (*get_max_clock)(struct sdhci_host *host);
>>>> --
>>>> 1.7.0.4
>>>>
>>>>
>>>> ["0001-sdhci-support-DDR50-mode.patch" (text/x-patch)]
>>>>
>>>>
>>>> From 59072fa8fea50634f01009e51c4b5e16308ab466 Mon Sep 17 00:00:00 2001
>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> Date: Mon, 1 Nov 2010 07:43:57 -0400
>>>> Subject: [PATCH] sdhci: support DDR50 mode
>>>>
>>>>     Verified DDR50 mode on sdhci-pxa and HYNIX and toshiba eMMC
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> ---
>>>> drivers/mmc/host/sdhci.c |   48 +++++++++++++++++++++++++++++++++++++++++++++-
>>>> drivers/mmc/host/sdhci.h |   15 ++++++++++++-
>>>> 2 files changed, 60 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 782c0ee..d9e4ab8 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -982,6 +982,44 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>>>     host->cmd = NULL;
>>>> }
>>>>
>>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
>>>> +{
>>>> +    u16 con;
>>>> +    unsigned long timeout;
>>>> +
>>>> +    if (ddr == MMC_SDR_MODE)
>>>> +            return;
>>>> +
>>>> +    if (host->ops->set_ddr)
>>>> +            host->ops->set_ddr(host, ddr);
>>>
>>> would prefer
>>>
>>>      if (host->ops->set_ddr)
>>>              return host->ops->set_ddr(host, ddr);
>
> Set_ddr is used to tunning timming for various cards, however we could
> do it in set_clock.
> Want to remove this API to keep sdhci.c as simple as possible, other
> controller could add this API if it is a must.

 Set clock is not right place for this but until we have experience with a controller that does tuning let leave this discussion for another time.

Since tuning IS board specific the host->ops mechanism is the safest way.

>
>>>
>>> since if private registers do need setting is not clear if the standard register set can be used.  Let the lower layer handle everything.
>>>
>>>> +
>>>> +    /* Fixme, how to support 1.2v Mode */
>>>> +    if (ddr & MMC_1_8V_DDR_MODE) {
>>>> +            con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +            con |= SDHCI_CTRL2_1_8V;
>>>> +            sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>> +
>>>> +            /* Wait max 5 ms */
>>>> +            timeout = 5;
>>>> +            while (!((con = sdhci_readw(host, SDHCI_HOST_CONTROL2))
>>>> +                                    & SDHCI_CTRL2_1_8V)) {
>>>> +                    if (timeout == 0) {
>>>> +                            printk(KERN_ERR "%s: HOST CONTROL fail switch to 1.8v\n",
>>>> +                                            mmc_hostname(host->mmc));
>>>> +                            sdhci_dumpregs(host);
>>>> +                            return;
>>>> +                    }
>>>> +                    timeout--;
>>>> +                    mdelay(1);
>>>> +            }
>>>> +            con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> +            con &= ~SDHCI_CTRL2_UHS_MASK;
>>>> +            /* only support DDR50 */
>>>> +            con |= SDHCI_CTRL2_DDR50;
>>>> +            sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>> +    }
>>>> +}
>>>> +
>>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>> {
>>>>     int div;
>>>> @@ -1176,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>     }
>>>>
>>>>     sdhci_set_clock(host, ios->clock);
>>>> +    sdhci_set_ddr(host, ios->ddr);
>>>>
>>>>     if (ios->power_mode == MMC_POWER_OFF)
>>>>             sdhci_set_power(host, -1);
>>>> @@ -1712,7 +1751,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>>> int sdhci_add_host(struct sdhci_host *host)
>>>> {
>>>>     struct mmc_host *mmc;
>>>> -    unsigned int caps;
>>>> +    unsigned int caps, caps_h;
>>>>     int ret;
>>>>
>>>>     WARN_ON(host == NULL);
>>>> @@ -1737,6 +1776,13 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>
>>>>     caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>>>>             sdhci_readl(host, SDHCI_CAPABILITIES);
>>>> +    caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_H);
>>>> +
>>>> +    if ((caps & SDHCI_CAN_VDD_180) &&
>>>> +            ((caps_h & SDHCI_CAN_SDR50) ||
>>>> +            (caps_h & SDHCI_CAN_SDR104) ||
>>>> +            (caps_h & SDHCI_CAN_DDR50)))
>>>> +            mmc->caps |= (MMC_CAP_1_8V_DDR);
>>>>
>>>>     if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>>             host->flags |= SDHCI_USE_SDMA;
>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>> index b7b8a3b..fe87c5f 100644
>>>> --- a/drivers/mmc/host/sdhci.h
>>>> +++ b/drivers/mmc/host/sdhci.h
>>>> @@ -141,7 +141,14 @@
>>>>
>>>> #define SDHCI_ACMD12_ERR     0x3C
>>>>
>>>> -/* 3E-3F reserved */
>>>> +#define SDHCI_HOST_CONTROL2 0x3E
>>>> +#define  SDHCI_CTRL2_UHS_MASK       0x07
>>>> +#define   SDHCI_CTRL2_SDR12 0x00
>>>> +#define   SDHCI_CTRL2_SDR25 0x01
>>>> +#define   SDHCI_CTRL2_SDR50 0x02
>>>> +#define   SDHCI_CTRL2_SDR104        0x03
>>>> +#define   SDHCI_CTRL2_DDR50 0x04
>>>> +#define  SDHCI_CTRL2_1_8V   0x08
>>>>
>>>> #define SDHCI_CAPABILITIES   0x40
>>>> #define  SDHCI_TIMEOUT_CLK_MASK      0x0000003F
>>>> @@ -161,7 +168,10 @@
>>>> #define  SDHCI_CAN_VDD_180   0x04000000
>>>> #define  SDHCI_CAN_64BIT     0x10000000
>>>>
>>>> -/* 44-47 reserved for more caps */
>>>> +#define SDHCI_CAPABILITIES_H        0x44
>>>> +#define  SDHCI_CAN_SDR50    0x00000001
>>>> +#define  SDHCI_CAN_SDR104   0x00000002
>>>> +#define  SDHCI_CAN_DDR50    0x00000004
>>>>
>>>> #define SDHCI_MAX_CURRENT    0x48
>>>>
>>>> @@ -207,6 +217,7 @@ struct sdhci_ops {
>>>> #endif
>>>>
>>>>     void    (*set_clock)(struct sdhci_host *host, unsigned int clock);
>>>> +    void    (*set_ddr)(struct sdhci_host *host, unsigned int ddr);
>
>
>>>>
>>>>     int             (*enable_dma)(struct sdhci_host *host);
>>>>     unsigned int    (*get_max_clock)(struct sdhci_host *host);
>>>> --
>>>> 1.7.0.4
>>>
>>
>>

