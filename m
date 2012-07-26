From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add busmode selection support
Date: Thu, 26 Jul 2012 15:00:55 +0900
Message-ID: <5010DD17.9030508@samsung.com>
References: <1343042200-19524-1-git-send-email-girish.shivananjappa@linaro.org>
 <500E8251.906@samsung.com>
 <CAGxe1ZHA80qYj=vOhx5YYBhyVE_wG55PrK6DpLvA-KKef9g_GA@mail.gmail.com>
 <CAGxe1ZFK96HRRN=42R4nwk3i26mONrTYN86TKsVMhCx94Oug9g@mail.gmail.com>
 <CAELcNGT6CmbzmcbGB+-ZuYnjmy+vrumgb9CQxYntZYRwyJ8m6A@mail.gmail.com>
 <CAGxe1ZHntoDfm3CBxx2q=yERhqZa7jnKjDeEA0bevQ_WFpOgbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9224 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab2GZGBO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jul 2012 02:01:14 -0400
In-reply-to: <CAGxe1ZHntoDfm3CBxx2q=yERhqZa7jnKjDeEA0bevQ_WFpOgbQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, will.newton@imgtec.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi Girish,

I re-tested the your patch.
How about locating into dw_mci_setup_bus()?

And if compare the previously and current busmode,
I think host needs not to re-write at register.
For example,
if (slot->bus_mode == ios->bus_mode)
	return;

Then this patch looks good to me.

Best Regards,
Jaehoon Chung

On 07/26/2012 12:41 PM, Girish K S wrote:
> On 24 July 2012 18:37, Jae hoon Chung <jh80.chung@gmail.com> wrote:
>> Hi Girish,
>>
>> Right, it be mentioned about the open-drain mode in synopsys spec.
>> But if didn't work on other board, there is some problem.
>> We can consider the location of set_busmode() .
> Sure. Currently i am setting the bus mode after sending the command
> during the clock setting. since the bus mode has affect on the cmd
> line i will try to move the location of calling bus mode before
> setting the clock.
> you can just check whether card gets detected by moving the set mode
> function just below the switch statement of bus width.
> On my board irrespective of the set bus mode location it works fine
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> 2012/7/24 Girish K S <girish.shivananjappa@linaro.org>:
>>> On 24 July 2012 17:06, Girish K S <girish.shivananjappa@linaro.org> wrote:
>>>> On 24 July 2012 16:39, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi Girish,
>>>>>
>>>>> Well..just tested on my board.
>>>>> this patch didn't work.(eMMC card didn't initialize)
>>>>> meaning of ios->bus_mode and synosys's bus_mode is same?
>>> Yes it is same. synopsys spec says this is specific to MMC
>>> initialization. when the card core sets this mode during
>>> initialization. the host has to set this bit
>>>>> How did you test this patch?
>>>> Tested it on exynos5 board using dt patches of thomas (with some
>>>> modification to his patch)
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>>
>>>>> On 07/23/2012 08:16 PM, Girish K S wrote:
>>>>>> Synopsis Designware host controller has suppport for open
>>>>>> drain mode selection. During the mmc card initialization the
>>>>>> host controller can select the open-drain bit to allow the device
>>>>>> initialization in the open-drain mode. Once the device enters
>>>>>> the standby mode this bit can be reset to enter push-pull mode.
>>>>>>
>>>>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>>>>> ---
>>>>>>  drivers/mmc/host/dw_mmc.c |   14 ++++++++++++++
>>>>>>  drivers/mmc/host/dw_mmc.h |    1 +
>>>>>>  2 files changed, 15 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>>> index 72dc3cd..da11e5a 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>> @@ -773,6 +773,18 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>>>>       spin_unlock_bh(&host->lock);
>>>>>>  }
>>>>>>
>>>>>> +static void dw_mci_set_busmode(struct dw_mci_slot *slot)
>>>>>> +{
>>>>>> +     struct mmc_ios *ios = &slot->mmc->ios;
>>>>>> +     u32 reg;
>>>>>> +
>>>>>> +     reg = mci_readl(slot->host, CTRL);
>>>>>> +     if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
>>>>>> +             mci_writel(slot->host, CTRL, reg | SDMMC_CTRL_ENABLE_OD);
>>>>>> +     else
>>>>>> +             mci_writel(slot->host, CTRL, reg & ~SDMMC_CTRL_ENABLE_OD);
>>>>>> +}
>>>>>> +
>>>>>>  static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>>>  {
>>>>>>       struct dw_mci_slot *slot = mmc_priv(mmc);
>>>>>> @@ -818,6 +830,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>>>       default:
>>>>>>               break;
>>>>>>       }
>>>>>> +
>>>>>> +     dw_mci_set_busmode(slot);
>>>>>>  }
>>>>>>
>>>>>>  static int dw_mci_get_ro(struct mmc_host *mmc)
>>>>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>>>>> index 15c27e1..1a53fb2 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc.h
>>>>>> +++ b/drivers/mmc/host/dw_mmc.h
>>>>>> @@ -67,6 +67,7 @@
>>>>>>
>>>>>>  /* Control register defines */
>>>>>>  #define SDMMC_CTRL_USE_IDMAC         BIT(25)
>>>>>> +#define SDMMC_CTRL_ENABLE_OD         BIT(24)
>>>>>>  #define SDMMC_CTRL_CEATA_INT_EN              BIT(11)
>>>>>>  #define SDMMC_CTRL_SEND_AS_CCSD              BIT(10)
>>>>>>  #define SDMMC_CTRL_SEND_CCSD         BIT(9)
>>>>>>
>>>>>
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


