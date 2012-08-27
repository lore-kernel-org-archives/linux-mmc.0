From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 07/10] mmc: omap_hsmmc: consolidate flush posted writes
 for HSMMC IRQs
Date: Mon, 27 Aug 2012 16:32:00 +0530
Message-ID: <CANfBPZ-V9a1pjb-bZSvED8qsx8D7vPwiwY+wL9zfA-iHaWk2kQ@mail.gmail.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
 <1345229550-8672-8-git-send-email-svenkatr@ti.com> <CANrkHUZLHO4nPvd37AaO43F37uCKB1LnsRxBOia5R3osF1ONvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46826 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752028Ab2H0LCW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 07:02:22 -0400
Received: by pbbro12 with SMTP id ro12so7989155pbb.14
        for <linux-mmc@vger.kernel.org>; Mon, 27 Aug 2012 04:02:20 -0700 (PDT)
In-Reply-To: <CANrkHUZLHO4nPvd37AaO43F37uCKB1LnsRxBOia5R3osF1ONvw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, vishp@ti.com

On Tue, Aug 21, 2012 at 8:51 PM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:
> On Sat, Aug 18, 2012 at 12:22 AM, Venkatraman S <svenkatr@ti.com> wrote:
>> Flushing spurious IRQs from HSMMC IP is done twice in
>> omap_hsmmc_irq and omap_hsmmc_do_irq.
>
> spurious IRQ is flushed in start of omap_hsmmc_do_irq
> and irq acked at the end of omap_hsmmc_do_irq
>
>> Consolidate them to one location.
>
> if you wanted to consolidated ...
>
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c | 17 ++++-------------
>>  1 file changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 4bc55ac..20453c8 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -969,15 +969,6 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>>         struct mmc_data *data;
>>         int end_cmd = 0, end_trans = 0;
>>
>> -       if (!host->req_in_progress) {
>
> just do a return from here

I think it's still better to filter out the validation to the outer
function and let do_irq to just 'do' it.

>
>> -               do {
>> -                       OMAP_HSMMC_WRITE(host->base, STAT, status);
>> -                       /* Flush posted write */
>> -                       status = OMAP_HSMMC_READ(host->base, STAT);
>> -               } while (status & INT_EN_MASK);
>> -               return;
>> -       }
>> -
>>         data = host->data;
>>         dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>>
>> @@ -1028,8 +1019,6 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>>                 }
>>         }
>>
>> -       OMAP_HSMMC_WRITE(host->base, STAT, status);
>> -
>>         if (end_cmd || ((status & CC) && host->cmd))
>>                 omap_hsmmc_cmd_done(host, host->cmd);
>>         if ((end_trans || (status & TC)) && host->mrq)
>> @@ -1045,11 +1034,13 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>>         int status;
>>
>>         status = OMAP_HSMMC_READ(host->base, STAT);
>> -       do {
>> +       while (status & INT_EN_MASK && host->req_in_progress) {
>
> and remove the check for host->req_in_progress
> I think do while loop can be retained as it will get executed once anyway.

It's a minor issue, and the consolidation of the check for
req_in_progress makes sure that it might
sometimes be not executed at all..


>
>>                 omap_hsmmc_do_irq(host, status);
>> +
>
>>                 /* Flush posted write */
>
> comment is misplaced
>
Ok. I'll remove.

>> +               OMAP_HSMMC_WRITE(host->base, STAT, status);
>>                 status = OMAP_HSMMC_READ(host->base, STAT);
>> -       } while (status & INT_EN_MASK);
>> +       }
>>
>>         return IRQ_HANDLED;
>>  }
>> --
>> 1.7.11.1.25.g0e18bef
>>
