From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 08/10] mmc: card: Use R1 response for the stop cmd at
 recovery path
Date: Thu, 23 Jan 2014 14:21:34 +0100
Message-ID: <CAPDyKFpB4CUqzLsDE1NyGuWX4nMLRL7HwtPpcKp82vP1VGhJmg@mail.gmail.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
	<1390402824-9850-9-git-send-email-ulf.hansson@linaro.org>
	<52E0EA70.9010308@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46450 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbaAWNVe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 08:21:34 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so2087662qab.5
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 05:21:34 -0800 (PST)
In-Reply-To: <52E0EA70.9010308@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On 23 January 2014 11:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 22/01/14 17:00, Ulf Hansson wrote:
>> Hosts supporting MMC_CAP_WAIT_WHILE_BUSY shall not be waiting for busy
>> detection completion in the recovery path, which were the case when
>> using R1B response.
>>
>> Start using R1 as response instead to align behavior, no matter if
>> MMC_CAP_WAIT_WHILE_BUSY is supported or not.
>
> This does not make sense to me.  If you are sending a STOP command you
> should use the correct response type.  R1B should be OK here because the
> card should release the busy signal in any case except failure.

For those hosts not supporting MMC_CAP_WAIT_WHILE_BUSY a R1B is
assumed to be treated same as an R1, which means there are no busy
detection handled in the host.

mmc_blk_cmd_recovery() is the only caller of the send_stop() function.
Additionally it does not care about to handle busy detection with
CDM13 polling.

Now, since most hosts don't support MMC_CAP_WAIT_WHILE_BUSY which
means there no busy detection done, I wanted to align to this
behaviour - no matter if the host can do HW busy detection or not.

I am not saying this is how it must be done, just trying to provide
you with some more reasons to why I wanted to change.

If we instead decide keep the R1B for send_stop(), we should implement
CMD 13 polling to meet the same behaviour for hosts not supporting
MMC_CAP_WAIT_WHILE_BUSY. In this scenario, we need to set a select a
busy timeout, do you have any suggestion of what would be a reasonable
value for it?

Kind regards
Ulf Hansson

>
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/card/block.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 87cd2b0..74169fa 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -728,7 +728,7 @@ static int send_stop(struct mmc_card *card, u32 *status)
>>       int err;
>>
>>       cmd.opcode = MMC_STOP_TRANSMISSION;
>> -     cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> +     cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>>       err = mmc_wait_for_cmd(card->host, &cmd, 5);
>>       if (err == 0)
>>               *status = cmd.resp[0];
>>
>
