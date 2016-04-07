From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH] mmc: Remove some redundant debug prints
Date: Thu, 7 Apr 2016 11:13:40 +0800
Message-ID: <CAMz4kuL_ONP0CKB80NBZVspfki2YuzR3Y6VQUWTqsA+3CYV6ig@mail.gmail.com>
References: <5cddc2f870eccf8cf50d463c72d2908dad9e1017.1459942344.git.baolin.wang@linaro.org>
	<20160406195732.67430c96@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34512 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbcDGDNl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2016 23:13:41 -0400
Received: by mail-yw0-f170.google.com with SMTP id d68so81418167ywe.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2016 20:13:41 -0700 (PDT)
In-Reply-To: <20160406195732.67430c96@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, rmk+kernel@arm.linux.org.uk, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, David Jander <david@protonic.nl>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 6 April 2016 at 19:57, Jisheng Zhang <jszhang@marvell.com> wrote:
>
>
> On Wed,  6 Apr 2016 19:38:30 +0800 Baolin Wang wrote:
>
>> This patch removes some redundant debug prints, since we have added some
>> tracepoints to help with performance analysis of MMC subsystem.
>
> I think the debug prints you removed are useful for debugging mmc err, how is
> this purpose achieved by tracepoints? From another side, why should I enable
> tracepoints to debug mmc err?

Tracepoints can show all the debugging mmc information, so I think
these debug prints are redundant. Another point you said, why you
should enable tracepoints to debug mmc? Tracepoints are lightweight
hooks and one simple way to be used for tracing and performance
accounting.

>
> Thanks
>
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/mmc/core/core.c |   52 -----------------------------------------------
>>  1 file changed, 52 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index f80b3ab..3f1362a 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -157,33 +157,6 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>
>>               led_trigger_event(host->led, LED_OFF);
>>
>> -             if (mrq->sbc) {
>> -                     pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>> -                             mmc_hostname(host), mrq->sbc->opcode,
>> -                             mrq->sbc->error,
>> -                             mrq->sbc->resp[0], mrq->sbc->resp[1],
>> -                             mrq->sbc->resp[2], mrq->sbc->resp[3]);
>> -             }
>> -
>> -             pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>> -                     mmc_hostname(host), cmd->opcode, err,
>> -                     cmd->resp[0], cmd->resp[1],
>> -                     cmd->resp[2], cmd->resp[3]);
>> -
>> -             if (mrq->data) {
>> -                     pr_debug("%s:     %d bytes transferred: %d\n",
>> -                             mmc_hostname(host),
>> -                             mrq->data->bytes_xfered, mrq->data->error);
>> -             }
>> -
>> -             if (mrq->stop) {
>> -                     pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>> -                             mmc_hostname(host), mrq->stop->opcode,
>> -                             mrq->stop->error,
>> -                             mrq->stop->resp[0], mrq->stop->resp[1],
>> -                             mrq->stop->resp[2], mrq->stop->resp[3]);
>> -             }
>> -
>>               if (mrq->done)
>>                       mrq->done(mrq);
>>       }
>> @@ -236,31 +209,6 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>       if (mmc_card_removed(host->card))
>>               return -ENOMEDIUM;
>>
>> -     if (mrq->sbc) {
>> -             pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
>> -                      mmc_hostname(host), mrq->sbc->opcode,
>> -                      mrq->sbc->arg, mrq->sbc->flags);
>> -     }
>> -
>> -     pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
>> -              mmc_hostname(host), mrq->cmd->opcode,
>> -              mrq->cmd->arg, mrq->cmd->flags);
>> -
>> -     if (mrq->data) {
>> -             pr_debug("%s:     blksz %d blocks %d flags %08x "
>> -                     "tsac %d ms nsac %d\n",
>> -                     mmc_hostname(host), mrq->data->blksz,
>> -                     mrq->data->blocks, mrq->data->flags,
>> -                     mrq->data->timeout_ns / 1000000,
>> -                     mrq->data->timeout_clks);
>> -     }
>> -
>> -     if (mrq->stop) {
>> -             pr_debug("%s:     CMD%u arg %08x flags %08x\n",
>> -                      mmc_hostname(host), mrq->stop->opcode,
>> -                      mrq->stop->arg, mrq->stop->flags);
>> -     }
>> -
>>       WARN_ON(!host->claimed);
>>
>>       mrq->cmd->error = 0;
>



-- 
Baolin.wang
Best Regards
