From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: enable controller interrupt before calling
 mmc_start_host
Date: Fri, 23 Nov 2012 13:21:20 +0000
Message-ID: <50AF7850.3020203@imgtec.com>
References: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com> <CAAG0J9_ngZm7uGopaW6rdBUDQZhQWqt6gd=y1i5BifsGrZg-hg@mail.gmail.com> <50AA322A.1060604@imgtec.com> <CAKuRcOLfaX=fNML9RYdOyD3AFRdaaAipQDXo-SHapGkNVwzH2Q@mail.gmail.com> <50AB4FDF.7080602@imgtec.com> <50AC489C.7070002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56865 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab2KWNVY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Nov 2012 08:21:24 -0500
In-Reply-To: <50AC489C.7070002@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yuvaraj Kumar <yuvaraj.cd@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, "Chris Ball (laptop.org)" <cjb@laptop.org>, Will <will.newton@imgtec.com>, kgene.kim@samsung.com, "Girish K S (Linaro)" <girish.shivananjappa@linaro.org>, "Thomas Abraham (Linaro)" <thomas.abraham@linaro.org>, patches@linaro.org, Yuvaraj CD <yuvaraj.cd@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi,

I looked at the clock thing, and it appears that there's an extra divide
by two in hardware (the TRM says "Clock division is 2*n"), so those
numbers do appear to be correct.

>From some experimentation the other day, it appeared to be a race
condition which is affected by the position of the dev_info (I have a
JTAG console enabled which adds multi-millisecond delays every time
something is printed). So I think the race was always there, but is only
now showing up.

More information:
* it usually alternates between working and not working (works on first
boot), I'm just hard resetting rather than shutting down cleanly.
* unplugging the SD card between boots prevents it going wrong (I don't
believe our board has power control over SD card).
* using old kernel first and then new kernel, failure can still happen,
so the card could always get into the funny state, but it's only now
causing problems.
* forcing a GPIO bitbanging reset on probe to unlock the card stops it
failing (usually this sequence is only initiated if the card is locked
up - i.e. busy. It's our own quirk to the driver).

I'll have another look at it sometime and report back if I find the root
cause.

Thanks
James


On 21/11/12 03:21, Jaehoon Chung wrote:
> Hi All,
> 
> Well, i didn't find the James's error message.
> But i confused about the clock value.
> 
> Bus speed : 99840000Hz
> request   : 200000Hz
> Div : 250
> 
> If bus_speed is divided with div, then actual value should be 399360Hz.
> But this log is produced 199680Hz. What's wrong?
> 
> I think this message can be confused to debug.
> 
> Best Regards,
> Jaehoon Chung
> 
> On 11/20/2012 06:39 PM, James Hogan wrote:
>> Hi Yuvaraj,
>>
>> On 20/11/12 05:35, Yuvaraj Kumar wrote:
>>> Its not sufficient.In my case, sdio_reset command was submitted to
>>> dw_mmc controller before interrupts are enabled.
>>> By looking at your log,it seems something wrong with frequency set by
>>> your U-boot.
>>
>> I'm not using U-boot, I'm booting with JTAG. In any case it works if I
>> revert your patch so I think the clocks are fine. I'll continue
>> debugging it and see if I can figure out what's happening.
>>
>> Cheers
>> James
>>
>>>
>>> Best Regards
>>> Yuvaraj
>>>
>>> On Mon, Nov 19, 2012 at 6:50 PM, James Hogan <james.hogan@imgtec.com> wrote:
>>>> On 19/11/12 13:01, Yuvaraj CD wrote:
>>>>> As mmc_start_host is getting called before enabling the dw_mmc controller
>>>>> interrupt, there is a problem of missing the SDMMC_INT_CMD_DONE for the
>>>>> very first command sent by the sdio_reset.
>>>>> This problem occurs only when we disable MMC debugging i.e, MMC_DEBUG [=n].
>>>>> Hence this patch enables the dw_mmc controller interrupt before mmc_start_host.
>>>>>
>>>>> Signed-off-by: Yuvaraj CD <yuvaraj.cd@samsung.com>
>>>>
>>>> Hi Yuvaraj,
>>>>
>>>> I get the following errors after this patch is applied
>>>> (2da1d7f2948900cd50d38643db39f790edb3cc96, merged in v3.7-rc5) and the
>>>> driver doesn't work as a result. Reverting it fixes the problem.
>>>>
>>>> mmc0: error -110 whilst initialising SD card
>>>> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 300000Hz, actual 298922HZ div = 167)
>>>> mmc0: error -110 whilst initialising SD card
>>>> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 200000Hz, actual 199680HZ div = 250)
>>>> mmc0: error -110 whilst initialising SD card
>>>> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 195765Hz, actual 195764HZ div = 255)
>>>> mmc0: error -110 whilst initialising SD card
>>>> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 400000Hz, actual 399360HZ div = 125)
>>>> mmc0: error -110 whilst initialising SD card
>>>> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 300000Hz, actual 298922HZ div = 167)
>>>> mmc0: error -110 whilst initialising SD card
>>>> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 200000Hz, actual 199680HZ div = 250)
>>>> mmc0: error -110 whilst initialising SD card
>>>> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 195765Hz, actual 195764HZ div = 255)
>>>> mmc0: error -110 whilst initialising SD card
>>>>
>>>> The interrupts are already cleared and disabled at the beginning of the
>>>> probe function, so is the following sufficient (after reverting your
>>>> patch) to fix the problem you've been observing?
>>>>
>>>> Thanks
>>>> James
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index ec9b5a8..2be9899 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -2266,7 +2266,6 @@ int dw_mci_probe(struct dw_mci *host)
>>>>          * Enable interrupts for command done, data over, data empty, card det,
>>>>          * receive ready and error such as transmit, receive timeout, crc error
>>>>          */
>>>> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>>         mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>>>>                    SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>>>>                    DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
>>>>
>>>>
>>>>> ---
>>>>>  drivers/mmc/host/dw_mmc.c |   29 +++++++++++++++--------------
>>>>>  1 file changed, 15 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>> index a23af77..729c031 100644
>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>> @@ -2233,6 +2233,21 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>         else
>>>>>                 host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
>>>>>
>>>>> +       /*
>>>>> +        * Enable interrupts for command done, data over, data empty, card det,
>>>>> +        * receive ready and error such as transmit, receive timeout, crc error
>>>>> +        */
>>>>> +       mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>>> +       mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>>>>> +                  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>>>>> +                  DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
>>>>> +       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci
>>>>> interrupt */
>>>>> +
>>>>> +       dev_info(host->dev, "DW MMC controller at irq %d, "
>>>>> +                "%d bit host data width, "
>>>>> +                "%u deep fifo\n",
>>>>> +                host->irq, width, fifo_size);
>>>>> +
>>>>>         /* We need at least one slot to succeed */
>>>>>         for (i = 0; i < host->num_slots; i++) {
>>>>>                 ret = dw_mci_init_slot(host, i);
>>>>> @@ -2262,20 +2277,6 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>         else
>>>>>                 host->data_offset = DATA_240A_OFFSET;
>>>>>
>>>>> -       /*
>>>>> -        * Enable interrupts for command done, data over, data empty, card det,
>>>>> -        * receive ready and error such as transmit, receive timeout, crc error
>>>>> -        */
>>>>> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>>> -       mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>>>>> -                  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>>>>> -                  DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
>>>>> -       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci
>>>>> interrupt */
>>>>> -
>>>>> -       dev_info(host->dev, "DW MMC controller at irq %d, "
>>>>> -                "%d bit host data width, "
>>>>> -                "%u deep fifo\n",
>>>>> -                host->irq, width, fifo_size);
>>>>>         if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>>>>>                 dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
>>>>>
>>>>> --
>>>>> 1.7.9.5
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>> --
>>>>> James Hogan
>>>>>
>>>>
>>
>>
> 

