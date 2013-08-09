From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH V2] mmc:sdhci: Wait longer for command with busy flags
Date: Fri, 9 Aug 2013 17:07:09 +0800
Message-ID: <5204B13D.8070403@freescale.com>
References: <1376006647-23073-1-git-send-email-Haijun.Zhang@freescale.com> <CAGsJ_4xjsoqwhRjt+xjqcnfDyjKejk2EXZHGWX4x7X1kvnMaSw@mail.gmail.com> <52049081.2050907@freescale.com> <CAGsJ_4zU_HeDsy6pD41H-=WyofXpXEuF=NeWMB07OrpKFVDfWw@mail.gmail.com> <5204AE16
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:49951
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964845Ab3HIJFj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 05:05:39 -0400
In-Reply-To: <5204AE16.3010203@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Barry Song <21cnbao@gmail.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, cjb@laptop.org

On 08/09/2013 04:53 PM, Jaehoon Chung wrote:
> On 08/09/2013 05:30 PM, Barry Song wrote:
>> 2013/8/9 Zhang Haijun <B42677@freescale.com>:
>>> On 08/09/2013 02:39 PM, Barry Song wrote:
>>>> 2013/8/9 Haijun Zhang <Haijun.Zhang@freescale.com>:
>>>>> When command with busy flags send and also data busy end interrupt
>>>>> will be generate, the command will be finished when data transfer
>>>>> complete or data busy state end, Sometimes this will expend more than
>>>>> 10*Hz time to finish this command, so we should wait longer to detect
>>>>> command complete timeout err.
>>>>>
>>>>> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
>>>>> ---
>>>>> changes for V2:
>>>>>           - Correct the timer
>>>>>
>>>>>    drivers/mmc/host/sdhci.c | 14 +++++++++++++-
>>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>> index a78bd4f..8888578 100644
>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>> @@ -986,6 +986,7 @@ static void sdhci_send_command(struct sdhci_host
>>>>> *host, struct mmc_command *cmd)
>>>>>           int flags;
>>>>>           u32 mask;
>>>>>           unsigned long timeout;
>>>>> +       u32 timer = 10;
>>>>>
>>>>>           WARN_ON(host->cmd);
>>>>>
>>>>> @@ -1014,7 +1015,18 @@ static void sdhci_send_command(struct sdhci_host
>>>>> *host, struct mmc_command *cmd)
>>>>>                   mdelay(1);
>>>>>           }
>>>>>
>>>>> -       mod_timer(&host->timer, jiffies + 10 * HZ);
>>>>> +       /*
>>>>> +        * When send a commmand with busy state and also the data busy
>>>>> end
>>>>> +        * interrupt can be generate, the command will be finished when
>>>>> date
>>>>> +        * transfer complete or busy state end. Sometimes this will
>>>>> expend
>>>>> +        * more than 10*HZ, In this case whe should wait longer to detect
>>>>> +        * command complete timeout err.
>>>>> +        */
>>>>> +       if ((host->cmd->flags & MMC_RSP_BUSY) &&
>>>>> +                       !(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ))
>>>>> +               timer = 1000;
>>>>> +
>>>>> +       mod_timer(&host->timer, jiffies + timer * HZ);
>>>> haojun, do you mean we need to wait for 1 minutes and 40 seconds for
>>>> timeout? it seems it is too large for a kernel.
>>> 1000 * HZ = 1000 * 1 / 250 = 4000ms, about 4s. On my platform.
>> no. pls note the unit is jiffy not ms.
> Haijun, you refer to kernel/time.c
Yes, thanks Chung and barry.
You are right. In case 4000ms = jiffies + 1000 = 4 * HZ(250).
I'll recheck on my platform.

Many thanks.
>
> Best Regards,
> Jaehoon Chung
>>>>>           host->cmd = cmd;
>>>>>
>>>>> --
>>>>> 1.8.0
>>>>>
>>>> -barry
>>>>
>>>
>>> --
>>> Thanks & Regards
>>>
>>> Haijun
>>>
>>>
>> -barry
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


-- 
Thanks & Regards

Haijun


