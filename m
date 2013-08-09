From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V2] mmc:sdhci: Wait longer for command with busy flags
Date: Fri, 9 Aug 2013 16:30:37 +0800
Message-ID: <CAGsJ_4zU_HeDsy6pD41H-=WyofXpXEuF=NeWMB07OrpKFVDfWw@mail.gmail.com>
References: <1376006647-23073-1-git-send-email-Haijun.Zhang@freescale.com>
 <CAGsJ_4xjsoqwhRjt+xjqcnfDyjKejk2EXZHGWX4x7X1kvnMaSw@mail.gmail.com> <52049081.2050907@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:40470 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030522Ab3HIIa6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 04:30:58 -0400
Received: by mail-qc0-f176.google.com with SMTP id u12so2033119qcx.21
        for <linux-mmc@vger.kernel.org>; Fri, 09 Aug 2013 01:30:58 -0700 (PDT)
In-Reply-To: <52049081.2050907@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun <B42677@freescale.com>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, cjb@laptop.org

2013/8/9 Zhang Haijun <B42677@freescale.com>:
> On 08/09/2013 02:39 PM, Barry Song wrote:
>>
>> 2013/8/9 Haijun Zhang <Haijun.Zhang@freescale.com>:
>>>
>>> When command with busy flags send and also data busy end interrupt
>>> will be generate, the command will be finished when data transfer
>>> complete or data busy state end, Sometimes this will expend more than
>>> 10*Hz time to finish this command, so we should wait longer to detect
>>> command complete timeout err.
>>>
>>> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
>>> ---
>>> changes for V2:
>>>          - Correct the timer
>>>
>>>   drivers/mmc/host/sdhci.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index a78bd4f..8888578 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -986,6 +986,7 @@ static void sdhci_send_command(struct sdhci_host
>>> *host, struct mmc_command *cmd)
>>>          int flags;
>>>          u32 mask;
>>>          unsigned long timeout;
>>> +       u32 timer = 10;
>>>
>>>          WARN_ON(host->cmd);
>>>
>>> @@ -1014,7 +1015,18 @@ static void sdhci_send_command(struct sdhci_host
>>> *host, struct mmc_command *cmd)
>>>                  mdelay(1);
>>>          }
>>>
>>> -       mod_timer(&host->timer, jiffies + 10 * HZ);
>>> +       /*
>>> +        * When send a commmand with busy state and also the data busy
>>> end
>>> +        * interrupt can be generate, the command will be finished when
>>> date
>>> +        * transfer complete or busy state end. Sometimes this will
>>> expend
>>> +        * more than 10*HZ, In this case whe should wait longer to detect
>>> +        * command complete timeout err.
>>> +        */
>>> +       if ((host->cmd->flags & MMC_RSP_BUSY) &&
>>> +                       !(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ))
>>> +               timer = 1000;
>>> +
>>> +       mod_timer(&host->timer, jiffies + timer * HZ);
>>
>> haojun, do you mean we need to wait for 1 minutes and 40 seconds for
>> timeout? it seems it is too large for a kernel.
>
> 1000 * HZ = 1000 * 1 / 250 = 4000ms, about 4s. On my platform.

no. pls note the unit is jiffy not ms.

>
>>
>>>          host->cmd = cmd;
>>>
>>> --
>>> 1.8.0
>>>
>> -barry
>>
>
>
> --
> Thanks & Regards
>
> Haijun
>
>
-barry
