From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 1/1] sdhci support emmc ddr50 mode
Date: Wed, 8 Dec 2010 20:36:51 -0800
Message-ID: <BBECB863-095E-42B9-89B0-0764164A4182@marvell.com>
References: <AANLkTiknFGMQczA-bcnDLv7K4ZpDOZgiG-iQNLDm+aNC@mail.gmail.com>
 <AANLkTikTHVORPN6U4qgEij=ig7zROERV_k+q-6RL-AYQ@mail.gmail.com>
 <E3E29FC5-7D18-4207-AF6B-6D61BD361F29@marvell.com>
 <AANLkTikVBtULWA7CZwM6GPYcQhFOudF3Fwj8bMwUimqc@mail.gmail.com>
 <AANLkTikYirB-a7i5uO9HtESA1NG2zcTb+127m672HdDd@mail.gmail.com>
 <F8976AA8-C9DB-4FA1-ADF2-290DE1E211E1@marvell.com>
 <AANLkTikkKp0od2JSjfm_PS2g2-h-76+vbKLOYjvkyQY2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36262 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750819Ab0LIEhJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Dec 2010 23:37:09 -0500
In-Reply-To: <AANLkTikkKp0od2JSjfm_PS2g2-h-76+vbKLOYjvkyQY2@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>


On Dec 8, 2010, at 6:03 PM, zhangfei gao wrote:

> On Wed, Dec 8, 2010 at 9:45 AM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> On Dec 6, 2010, at 8:09 PM, Zhangfei Gao wrote:
>> 
>>> On Mon, Dec 6, 2010 at 10:36 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>>>> On Mon, Dec 6, 2010 at 10:10 PM, Philip Rakity <prakity@marvell.com> wrote:
>>>>> 
>>>>> On Dec 6, 2010, at 4:15 AM, Zhangfei Gao wrote:
>>>>> 
>>>>>> From f2194b46c2c3ded86009d36a4a8b4eebb7d0b9eb Mon Sep 17 00:00:00 2001
>>>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>> Date: Fri, 3 Dec 2010 07:21:15 -0500
>>>>>> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
>>>>>> 
>>>>>>       1. spec 3.0 does not claim support 1.2v ddr mode
>>>>>>       2. Call back function set_power is added, since some controller count
>>>>>> on external pmic to provide power
>>>>>> 
>>>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>>>> ---
>>>>>> drivers/mmc/core/core.c   |    8 ++++++++
>>>>>> drivers/mmc/host/sdhci.c  |   36 +++++++++++++++++++++++++++++++++++-
>>>>>> drivers/mmc/host/sdhci.h  |   14 ++++++++++++--
>>>>>> include/linux/mmc/mmc.h   |    1 +
>>>>>> include/linux/mmc/sdhci.h |    2 ++
>>>>>> 5 files changed, 58 insertions(+), 3 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>> index 8bf542c..8f172cd 100644
>>>>>> --- a/drivers/mmc/core/core.c
>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>> @@ -1573,6 +1573,14 @@ void mmc_rescan(struct work_struct *work)
>>>>>>                */
>>>>>>               err = mmc_send_op_cond(host, 0, &ocr);
>>>>>>               if (!err) {
>>>>>> +                     if ((ocr & MMC_CARD_1_8V)
>>>>>> +                             && (host->ocr_avail & MMC_CARD_1_8V)) {
>>>>>> +                             /* switch voltage to 1.8v */
>>>>>> +                             mmc_power_off(host);
>>>>>> +                             host->ocr = ocr & host->ocr_avail;
>>>>>> +                             mmc_power_up(host);
>>>>>> +                     }
>>>>>> +
>>>>> 
>>>>> is the 1.2v case missing ?
>>>> ocr does not support 1.2.
>>>>> 
>>>>> /*
>>>>>  * Mask off any voltages we don't support and select
>>>>>  * the lowest voltage
>>>>>  */
>>>>> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>>>>> 
>>>>> Doesn't this code already handle the voltage correctly ?
>>>> mmc_select_voltage can not meet the requirement, if switch voltage,
>>>> power down and power up is needed, time delay is required waiting for
>>>> voltage to be stable.
>>>> 
>>>>> 
>>>>> 
>>>>>>                       if (mmc_attach_mmc(host, ocr))
>>>>>>                               mmc_power_off(host);
>>>>>>                       goto out;
>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>> index a25db42..b7ad2f6 100644
>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>> @@ -982,6 +982,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>>>>>       host->cmd = NULL;
>>>>>> }
>>>>>> 
>>>>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
>>>>>> +{
>>>>>> +     u16 con;
>>>>>> +
>>>>>> +     if (ddr == MMC_SDR_MODE)
>>>>>> +             return;
>>>>>> +
>>>>>> +     con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>> +     if (con & SDHCI_CTRL2_1_8V) {
>>>>>> +             con &= ~SDHCI_CTRL2_UHS_MASK;
>>>>>> +             if (ddr & MMC_1_8V_DDR_MODE)
>>>>>> +                     con |= SDHCI_CTRL2_DDR50;
>>>>>> +             sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>>>> +     }
>>>>>> +}
>>>>>> +
>>>>> 
>>>>> 
>>>>> The host controller should not enable the CAP if 1.8V is not supported.  DDR should not be
>>>>> invoked if CAP is not set.  Thus
>>>> 
>>>> set_ddr is called with para ddr, it would not enter here if  CAP is not set.
>>>>> 
>>>>>> +     if (con & SDHCI_CTRL2_1_8V) {
>>>>> 
>>>>> and
>>>>>> +             if (ddr & MMC_1_8V_DDR_MODE)
>>>>> 
>>>>> are not needed.
>>>>> 
>>>>> This code should move to driver specific function since tuning may be done on some systems and
>>>>> some systems (not mmp2) may need to delay the 5ms for voltage to be stable.  Would prefer a
>>>>> host->ops callback.
>>>> 5ms is considered in power up, that's the reason not put in set_ios
>>>> with call back.
>>>>> 
>>>>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>>>> {
>>>>>>       int div;
>>>>>> @@ -1080,6 +1096,17 @@ static void sdhci_set_power(struct sdhci_host
>>>>>> *host, unsigned short power)
>>>>>>               return;
>>>>>>       }
>>>>>> 
>>>>>> +     if (pwr == SDHCI_POWER_180) {
>>> 
>>> Could add one more condition here
>>> if ((host->mmc->caps & MMC_CAP_1_8V_DDR) &&
>>>               (pwr == SDHCI_POWER_180)) {
>>> 
>>>>>> +             u16 con;
>>>>>> +
>>>>>> +             con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>> +             con |= SDHCI_CTRL2_1_8V;
>>>>>> +             sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
>>>>>> +
>>>>>> +             if (host->ops->set_power)
>>>>>> +                     host->ops->set_power(host, pwr);
>>>>>> +     }
>>>>>> +
>>>>> 
>>>>> This code should be moved to sdhci_set_ddr (aboe).  Not needed if voltage is 1.8v and card
>>>>> is not running ddr.
>>>> No defect to set SDHCI_CTRL2_1_8V if choose 1.8v.
>>>> 
>>>>> 
>>>>>>       /*
>>>>>>        * Spec says that we should clear the power reg before setting
>>>>>>        * a new value. Some controllers don't seem to like this though.
>>>>>> @@ -1176,6 +1203,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
>>>>>> struct mmc_ios *ios)
>>>>>>       }
>>>>>> 
>>>>>>       sdhci_set_clock(host, ios->clock);
>>>>>> +     sdhci_set_ddr(host, ios->ddr);
>>>>>> 
>>>>>>       if (ios->power_mode == MMC_POWER_OFF)
>>>>>>               sdhci_set_power(host, -1);
>>>>>> @@ -1736,7 +1764,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>>>>> int sdhci_add_host(struct sdhci_host *host)
>>>>>> {
>>>>>>       struct mmc_host *mmc;
>>>>>> -     unsigned int caps;
>>>>>> +     unsigned int caps, caps_h;
>>>>>>       int ret;
>>>>>> 
>>>>>>       WARN_ON(host == NULL);
>>>>>> @@ -1761,6 +1789,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>>> 
>>>>>>       caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>>>>>>               sdhci_readl(host, SDHCI_CAPABILITIES);
>>>>>> +     caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_H);
>>>>>> +
>>>>>> +     if (caps & SDHCI_CAN_VDD_180) {
>>>>>> +             if (caps_h & SDHCI_CAN_SDR50)
>>>>>> +                     mmc->caps |= (MMC_CAP_1_8V_DDR);
>>>>>> +     }
>>>>>> 
>>>>>>       if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>>>>               host->flags |= SDHCI_USE_SDMA;
>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>>> index b689cc6..28c460a 100644
>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>> @@ -144,7 +144,14 @@
>>>>>> 
>>>>>> #define SDHCI_ACMD12_ERR      0x3C
>>>>>> 
>>>>>> -/* 3E-3F reserved */
>>>>>> +#define SDHCI_HOST_CONTROL2  0x3E
>>>>>> +#define  SDHCI_CTRL2_UHS_MASK        0x0007
>>>>>> +#define   SDHCI_CTRL2_SDR12  0x0000
>>>>>> +#define   SDHCI_CTRL2_SDR25  0x0001
>>>>>> +#define   SDHCI_CTRL2_SDR50  0x0002
>>>>>> +#define   SDHCI_CTRL2_SDR104 0x0003
>>>>>> +#define   SDHCI_CTRL2_DDR50  0x0004
>>>>>> +#define  SDHCI_CTRL2_1_8V    0x0008
>>>>>> 
>>>>>> #define SDHCI_CAPABILITIES    0x40
>>>>>> #define  SDHCI_TIMEOUT_CLK_MASK       0x0000003F
>>>>>> @@ -165,7 +172,10 @@
>>>>>> #define  SDHCI_CAN_VDD_180    0x04000000
>>>>>> #define  SDHCI_CAN_64BIT      0x10000000
>>>>>> 
>>>>>> -/* 44-47 reserved for more caps */
>>>>>> +#define SDHCI_CAPABILITIES_H 0x44
>>>>>> +#define  SDHCI_CAN_SDR50     0x00000001
>>>>>> +#define  SDHCI_CAN_SDR104    0x00000002
>>>>>> +#define  SDHCI_CAN_DDR50     0x00000004
>>>>>> 
>>>>>> #define SDHCI_MAX_CURRENT     0x48
>>>>>> 
>>>>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>>>>> index 956fbd8..bd09b19 100644
>>>>>> --- a/include/linux/mmc/mmc.h
>>>>>> +++ b/include/linux/mmc/mmc.h
>>>>>> @@ -202,6 +202,7 @@ struct _mmc_csd {
>>>>>>  * OCR bits are mostly in host.h
>>>>>>  */
>>>>>> #define MMC_CARD_BUSY 0x80000000      /* Card Power up status bit */
>>>>>> +#define MMC_CARD_1_8V        0x00000080      /* Card 1.70-1.95V support bit */
>>>>>> 
>>>>>> /*
>>>>>>  * Card Command Classes (CCC)
>>>>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>>>>>> index 86e8380..57bcda9 100644
>>>>>> --- a/include/linux/mmc/sdhci.h
>>>>>> +++ b/include/linux/mmc/sdhci.h
>>>>>> @@ -163,6 +163,8 @@ struct sdhci_ops {
>>>>>>       void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>>>>>                                            u8 power_mode);
>>>>>>       unsigned int    (*get_ro)(struct sdhci_host *host);
>>>>>> +     unsigned int    (*set_power)(struct sdhci_host *host,
>>>>>> +                             unsigned short power);
>>>>>> };
>>>>>> 
>>>>>> 
>>>>>> --
>>>>>> 1.7.0.4
>>>>>> 
>>>>>> Update the condition of voltage switch.
>>>>>> +                     if ((ocr & MMC_CARD_1_8V)
>>>>>> +                             && (host->ocr_avail & MMC_CARD_1_8V)) {
>>>>>> +                             /* switch voltage to 1.8v */
>>>>>> 
>>>>>> Any comments are welcome.
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> 
>>>>> 
>>>> 
>> 
>> 
>> 
>> NAK
>> 
>> There are two voltages -- the voltage to the card and the voltage used for signaling.
>> The voltage of the card is programmed using mmc_set_voltage.  It can be 3.3, 1.8v etc
>> this voltage is controlled via the host control register 0x28.
>> 
>> the voltage used for signaling is controlled via the host control register 2 (0x3e).  moving
>> to ddr requires that this voltage be signaled to the card (CMD11) and and changed via
>> host control register 2.  The flowchart figure 3.10 -- page 104 shows the sequence that
>> is needed.
>> 
>> What is missing in core/ is
>> a) support for CMD11
>> b) correct implementation for changing  the signaling voltage for uhs modes
>> 
>> 
> CMD11 only used for sd3.0 card, not mmc card, mmc does not require any
> cmd, just change voltage and wait for voltage stable, thanks

This may work but is not sd host controller compliant.   My testing indicates that
we can supply 2.8v to the card and NOT support 1.8v signaling and the eMMC
chip that is being used will be recognized as supporting DDR and work.

A compliant card can support 3.3 volts to the card and allow 1.8v signaling.
Thus lowering the voltage to the card can stop the card from working.   (The
card does not have to support 1.8v to work using DDR)

The host controller spec says (Page 72: Host Control 2 Register:

 Bit 3 RW  1.8V Signaling Enable
--------------------------------------------
This bit controls voltage regulator for I/O cell.  3.3V is supplied to the card
regardless of signaling voltage.
Setting this bit from 0 to1 starts changing signaling voltage from 3.3v to 1.8v.
1.8v regulator output shall be stable with 5ms.  Host controller clears this bit
if switching to1.8v signaling fails.



>> 
>> 
>> 

