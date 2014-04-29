From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: jz4740: don't wait for PRG_DONE after stop command
 with R1 response
Date: Tue, 29 Apr 2014 14:11:25 +0200
Message-ID: <CAPDyKFrHXbgFqxZBNxJOii0psQB4LxKWC=YqB76dLMgVfw7b5g@mail.gmail.com>
References: <1398760353-12507-1-git-send-email-alex.smith@imgtec.com>
	<CAPDyKFpAbLzhHBuzCnpTjRR9XC=H1uB71wFDkDg9drHfBMeMyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:47243 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933447AbaD2ML0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 08:11:26 -0400
Received: by mail-qg0-f50.google.com with SMTP id 63so102544qgz.9
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2014 05:11:26 -0700 (PDT)
In-Reply-To: <CAPDyKFpAbLzhHBuzCnpTjRR9XC=H1uB71wFDkDg9drHfBMeMyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Smith <alex.smith@imgtec.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Chris Ball <chris@printf.net>, James Hogan <james.hogan@imgtec.com>

On 29 April 2014 13:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 29 April 2014 10:32, Alex Smith <alex.smith@imgtec.com> wrote:
>> As of commit bcc3e1726d ("mmc: block: Use R1 responses for stop cmds for
>> read requests"), stop commands for reads do not have MMC_RSP_BUSY set.
>> In this case we should not wait for a PRG_DONE IRQ after sending the
>> stop command: it will not get raised when the busy flag is not set,
>> causing the request to fail with a timeout.
>>
>> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Chris Ball <chris@printf.net>
>> Cc: James Hogan <james.hogan@imgtec.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Alex, could you please resend a new version which has been verified
using checkpatch.

Kind regards
Ulf Hansson

>
>> ---
>>  drivers/mmc/host/jz4740_mmc.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
>> index de2139c..1c3368b 100644
>> --- a/drivers/mmc/host/jz4740_mmc.c
>> +++ b/drivers/mmc/host/jz4740_mmc.c
>> @@ -515,10 +515,12 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
>>
>>                 jz4740_mmc_send_command(host, req->stop);
>>
>> -               timeout = jz4740_mmc_poll_irq(host, JZ_MMC_IRQ_PRG_DONE);
>> -               if (timeout) {
>> -                       host->state = JZ4740_MMC_STATE_DONE;
>> -                       break;
>> +               if (mmc_resp_type(req->stop) & MMC_RSP_BUSY) {
>> +                       timeout = jz4740_mmc_poll_irq(host, JZ_MMC_IRQ_PRG_DONE);
>> +                       if (timeout) {
>> +                               host->state = JZ4740_MMC_STATE_DONE;
>> +                               break;
>> +                       }
>>                 }
>>         case JZ4740_MMC_STATE_DONE:
>>                 break;
>> --
>> 1.9.2
>>
