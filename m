From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 06/10] mmc: core: Respect host's max_busy_timeout when
 sending sleep cmd
Date: Thu, 23 Jan 2014 15:26:50 +0100
Message-ID: <CAPDyKFqDZjyY+=mO_qMY-Bo=Kpq5Ls7mvH20E+pWmGtAw+YAXA@mail.gmail.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
	<1390402824-9850-7-git-send-email-ulf.hansson@linaro.org>
	<52E0EDAA.7040703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49996 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaAWO0w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 09:26:52 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so2234855qab.33
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 06:26:51 -0800 (PST)
In-Reply-To: <52E0EDAA.7040703@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On 23 January 2014 11:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 22/01/14 17:00, Ulf Hansson wrote:
>> When sending the sleep command for host drivers supporting
>> MMC_CAP_WAIT_WHILE_BUSY, we need to confirm that max_busy_timeout is
>> big enough comparing to the sleep timeout specified from card's
>> EXT_CSD. If this isn't case, we use a R1 response instead of R1B and
>> fallback to use a delay instead.
>>
>> Do note that a max_busy_timeout set to zero by the host, is interpreted
>> as it can cope with whatever timeout the mmc core provides it with.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/mmc.c |   19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 897fdd1..32e1546 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1359,6 +1359,8 @@ static int mmc_sleep(struct mmc_host *host)
>>  {
>>       struct mmc_command cmd = {0};
>>       struct mmc_card *card = host->card;
>> +     unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
>> +     unsigned int max_busy_timeout;
>>       int err;
>>
>>       if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
>> @@ -1372,7 +1374,18 @@ static int mmc_sleep(struct mmc_host *host)
>>       cmd.arg = card->rca << 16;
>>       cmd.arg |= 1 << 15;
>>
>> -     cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>> +     /* We interpret unspecified timeouts as the host can cope with all. */
>> +     max_busy_timeout = host->max_busy_timeout ?
>> +                     host->max_busy_timeout : timeout_ms;
>> +
>> +     if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
>> +             (timeout_ms <= max_busy_timeout)) {
>> +             cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>> +             cmd.busy_timeout = timeout_ms;
>> +     } else {
>> +             cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>> +     }
>
> I do not see why this is related to MMC_CAP_WAIT_WHILE_BUSY.
> Why not just:

Before I do any update, we need to decide what host->max_busy_timeout
of zero means. Please see the response in the other patch in this
patchset.

I see that my patch for the mmc_switch function, maintain the R1B for
host not supporting MMC_CAP_WAIT_WHILE_BUSY, but this one for sleep
doesn't. :-) We should align the behaviour.


>
>         if (host->max_busy_timeout && timeout_ms > host->max_busy_timeout) {
>                 cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>         } else {
>                 cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>                 cmd.busy_timeout = timeout_ms;
>         }

So here your suggestion will mean you would like to keep R1B for hosts
not supporting MMC_CAP_WAIT_WHILE_BUSY. This opposite of what you
proposed for the mmc_switch. :-)

I suggest that we only use R1B when the host are able to handle busy
detection in hw. If you think that is bad idea, please let me know.

>
>> +
>>       err = mmc_wait_for_cmd(host, &cmd, 0);
>>       if (err)
>>               return err;
>> @@ -1383,8 +1396,8 @@ static int mmc_sleep(struct mmc_host *host)
>>        * SEND_STATUS command to poll the status because that command (and most
>>        * others) is invalid while the card sleeps.
>>        */
>> -     if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
>> -             mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
>> +     if (!cmd.busy_timeout)
>> +             mmc_delay(timeout_ms);
>
> And this becomes:
>
>         if (!cmd.busy_timeout || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
>                 mmc_delay(timeout_ms);
>
>>
>>       return err;
>>  }
>>
>

Kind regards
Uffe
