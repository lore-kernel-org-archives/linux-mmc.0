From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: mmc: dw_mmc: log spamming
Date: Tue, 20 Sep 2016 14:09:23 +0200
Message-ID: <57E126F3.5070100@math.uni-bielefeld.de>
References: <CGME20160915172951epcas1p13022fec9254b5903b353dff6398cbcae@epcas1p1.samsung.com>
 <57DADA85.2000200@math.uni-bielefeld.de>
 <a36ad9ba-1758-7048-d8b8-e3d85862ff08@samsung.com>
 <57DF396E.9050503@samsung.com>
 <6dd25843-3852-b059-4c42-6c720887db38@samsung.com>
 <57DF96C3.7050706@math.uni-bielefeld.de>
 <5d370fba-e4ec-d70a-a949-a955e86d61b1@samsung.com>
 <57DFB75A.3030106@math.uni-bielefeld.de>
 <25a3a5a5-da21-dc71-45fd-d9b3f2a2b2bc@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:50063 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751539AbcITMJ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 08:09:28 -0400
In-Reply-To: <25a3a5a5-da21-dc71-45fd-d9b3f2a2b2bc@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, sw0312.kim@samsung.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hey Jaehoon,


Jaehoon Chung wrote:
> Hi Tobias,
> 
> On 09/19/2016 07:00 PM, Tobias Jakobi wrote:
>> Hey Jaehoon,
>>
>>
>> Jaehoon Chung wrote:
>>> Hi Tobias,
>>>
>>> On 09/19/2016 04:41 PM, Tobias Jakobi wrote:
>>>> Hello Jaehoon,
>>>>
>>>>
>>>> Jaehoon Chung wrote:
>>>>> Hi Tobias,
>>>>>
>>>>> CC'd mmc mailing.
>>>>>
>>>>> On 09/19/2016 10:03 AM, Seung-Woo Kim wrote:
>>>>>> Hello Jaehoon,
>>>>>>
>>>>>> On 2016년 09월 19일 09:32, Jaehoon Chung wrote:
>>>>>>> Hi Tobias,
>>>>>>>
>>>>>>> On 09/16/2016 02:29 AM, Tobias Jakobi wrote:
>>>>>>>> Hello everyone,
>>>>>>>>
>>>>>>>> I'm experiencing massive kernel log spamming by dw_mmc, the commit that
>>>>>>>> causes this is the following one.
>>>>>>>>
>>>>>>>> 65257a0deed5aee66b4e3708944f0be62a64cabc
>>>>>>>>
>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=65257a0deed5aee66b4e3708944f0be62a64cabc
>>>>>>>>
>>>>>>>> I've briefly checked the commit and I think the rationale behind
>>>>>>>> removing the check is incorrect. While MMC_CLKGATE was certainly
>>>>>>>> removed, runtime PM has "replaced" it (the commit
>>>>>>>> 9eadcc0581a8ccaf4c2378aa1c193fb164304f1d even mentions this).
>>>>>>>>
>>>>>>>> This is on an Exynos4412 board, kernel is 4.8-rc6. Nothing is connected
>>>>>>>> to the eMMC connector.
>>>>>>>
>>>>>>> Thanks for reporting this.
>>>>>>>
>>>>>>> Seung-Woo, Could you check your patch? I will also check this.
>>>>>
>>>>> Did you test after reverting this commit? or previous version is working fine?
>>>> yes, reverting the commit fixes the log spamming. I'm aware though that
>>>> the check is more of less broken (undefined behaviour because of
>>>> bit-shifting with large values), so I have also tried the following
>>>> thing: Just checking against 'div' instead of 'clock << div'. Anyway,
>>>> this also works for me.
>>>>
>>>>
>>>>> Which exynos4412 board do you use? I think it's related with "broken-cd".
>>>>> (If you can share which board and dts you are using, we can check in more detail.)
>>>> This is an Odroid-X2 board.
>>>>
>>>
>>> When i have checked on odroid-u3, it's reproduced very easy.
>> good to hear! I also worry that I'm the only one with these issues on
>> the X2. :)
>>
>> Anyway, do you seen any other message on the U3 that are related to the
>> eMMC. I'm asking because I have also experience some warning/error from
>> the regulator subsystem:
>>> Sep 15 17:19:56 chidori kernel: [    4.976690] vddf_emmc_2.85V: voltage operation not allowed
>>> Sep 15 17:19:56 chidori kernel: [    4.995417] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
>>
>> I'm sending you a patch shortly which fixes the warning, but I'm not
>> sure if this is the right approach. Maybe you can take a look?
> 
> I didn't see this..what is vddf_emmc_2.85V? I can't find this anywhere.
sorry for the confusion, I have renamed some of the regulator labels in
my private tree.

vddf_emmc_2.85V is BUCK8, and called 'BUCK8_VDDQ_MMC4_2.8V' in the
vanilla kernel. It's the vqmmc regulator of the eMMC.


>>>>> As you mentioned, you didn't insert the eMMC card on board.
>>>>> Then it should be polling whether card is inserted/removed. (If broken-cd is set...)
>>>> I can check the callstack leading to dw_mci_setup_bus() I guess. Would
>>>> that should make it easier for you guys to understand where the issue
>>>> originates from?
>>>
>>> Not need to share the callstack. Because i understood what is problem.
>>> But checking 'div' instead of 'clock << div' should also have the unexpected behavior.
>> Why is that? If I understood the initial problem correctly, then
>> shifting with 'div' produces undefined behaviour since we don't know an
>> upper bound for it. That's not the case if we just compare old and new
>> divisor.
> 
> This problem is because of "polling" method. ("broken-cd" property in device-tree)
> If can't find the eMMC card, mmc_rescan_try_freq() is running four times.
> Because it's looping with freqs array size in mmc_rescan().
> At that time, clock and current_speed is 400KHz..and if didn't find any cards, clock is set to 0.
> After HZ, mmc_rescan is running again..and repeat above behavior.
> 
> I didn't consider about this case. (removable case and polling method.)
> 
> I think we can fix the below code..Could you check the below?
I'll try to do a test this evening. I'll let you know the results then!

And thanks for looking into this!

With best wishes,
Tobias


> I have tested with exynos4412/exynos5422 boards.
> If there is no issue, i will send the patch. Or if there is a problem, let me know, plz.
> 
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 22dacae..41306d1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1112,11 +1112,12 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> 
>                 div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
> 
> -               dev_info(&slot->mmc->class_dev,
> -                        "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
> -                        slot->id, host->bus_hz, clock,
> -                        div ? ((host->bus_hz / div) >> 1) :
> -                        host->bus_hz, div);
> +               if (clock != slot->__clk_old || force_clkinit)
> +                       dev_info(&slot->mmc->class_dev,
> +                                "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
> +                                slot->id, host->bus_hz, clock,
> +                                div ? ((host->bus_hz / div) >> 1) :
> +                                host->bus_hz, div);
> 
>                 /* disable clock */
>                 mci_writel(host, CLKENA, 0);
> @@ -1139,6 +1140,9 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> 
>                 /* inform CIU */
>                 mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> +
> +               /* keep the last clock value that requested from core */
> +               slot->__clk_old = clock;
>         }
> 
>         host->current_speed = clock;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 9e740bc..0f12e15 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -249,6 +249,8 @@ extern int dw_mci_resume(struct dw_mci *host);
>   * @queue_node: List node for placing this node in the @queue list of
>   *     &struct dw_mci.
>   * @clock: Clock rate configured by set_ios(). Protected by host->lock.
> + * @__clk_old: The last clock value that requested from core.
> + *     Keeping track of this helps us to avoid spamming the console.
>   * @flags: Random state bits associated with the slot.
>   * @id: Number of this slot.
>   * @sdio_id: Number of this slot in the SDIO interrupt registers.
> @@ -263,6 +265,7 @@ struct dw_mci_slot {
>         struct list_head        queue_node;
> 
>         unsigned int            clock;
> +       unsigned int            __clk_old;
> 
>         unsigned long           flags;
>  #define DW_MMC_CARD_PRESENT    0
> 
> 
> Best Regards,
> Jaehoon Chung
> 
>>
>>
>>> If needs to fix, i want to go ahead the correct way at this time.
>>> Anyway, thanks for reporting this!
>>
>> Also thanks, and let me know if I can test anything else.
>>
>> With best wishes,
>> Tobias
>>
>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>>
>>>>> I think it's not related with runtime PM.
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>
>>>> WIth best wishes,
>>>> Tobias
>>>>
>>>>
>>>>
>>>>
>>>>>> Ok, I will check on Exynos4412 SpC boards.
>>>>>>
>>>>>> By the way, to check no condition case, when I posted after v2[1], I
>>>>>> checked with Exynos5422 and Exynos5433 SoC boards and they didn't show
>>>>>> duplicated log, so I agreed not to check condition for logging.
>>>>>>
>>>>>> [1] https://patchwork.kernel.org/patch/9182469/
>>>>>>
>>>>>> Best Regards,
>>>>>> - Seung-Woo Kim
>>>>>>
>>>>>>>
>>>>>>> Best Regards,
>>>>>>> Jaehoon Chung
>>>>>>>
>>>>>>>>
>>>>>>>> With best wishes,
>>>>>>>> Tobias
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>
>>
>>
>>
> 

