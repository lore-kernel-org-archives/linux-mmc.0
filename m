From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/10] mmc: core: Respect host's max_busy_timeout when
 sending sleep cmd
Date: Mon, 27 Jan 2014 12:46:04 +0200
Message-ID: <52E638EC.1040402@intel.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org> <1390402824-9850-7-git-send-email-ulf.hansson@linaro.org> <52E0EDAA.7040703@intel.com> <CAPDyKFqDZjyY+=mO_qMY-Bo=Kpq5Ls7mvH20E+pWmGtAw+YAXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52649 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbaA0KoV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Jan 2014 05:44:21 -0500
In-Reply-To: <CAPDyKFqDZjyY+=mO_qMY-Bo=Kpq5Ls7mvH20E+pWmGtAw+YAXA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On 23/01/14 16:26, Ulf Hansson wrote:
> On 23 January 2014 11:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 22/01/14 17:00, Ulf Hansson wrote:
>>> When sending the sleep command for host drivers supporting
>>> MMC_CAP_WAIT_WHILE_BUSY, we need to confirm that max_busy_timeout is
>>> big enough comparing to the sleep timeout specified from card's
>>> EXT_CSD. If this isn't case, we use a R1 response instead of R1B and
>>> fallback to use a delay instead.
>>>
>>> Do note that a max_busy_timeout set to zero by the host, is interpreted
>>> as it can cope with whatever timeout the mmc core provides it with.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/mmc/core/mmc.c |   19 ++++++++++++++++---
>>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 897fdd1..32e1546 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1359,6 +1359,8 @@ static int mmc_sleep(struct mmc_host *host)
>>>  {
>>>       struct mmc_command cmd = {0};
>>>       struct mmc_card *card = host->card;
>>> +     unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
>>> +     unsigned int max_busy_timeout;
>>>       int err;
>>>
>>>       if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
>>> @@ -1372,7 +1374,18 @@ static int mmc_sleep(struct mmc_host *host)
>>>       cmd.arg = card->rca << 16;
>>>       cmd.arg |= 1 << 15;
>>>
>>> -     cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>> +     /* We interpret unspecified timeouts as the host can cope with all. */
>>> +     max_busy_timeout = host->max_busy_timeout ?
>>> +                     host->max_busy_timeout : timeout_ms;
>>> +
>>> +     if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
>>> +             (timeout_ms <= max_busy_timeout)) {
>>> +             cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>> +             cmd.busy_timeout = timeout_ms;
>>> +     } else {
>>> +             cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>> +     }
>>
>> I do not see why this is related to MMC_CAP_WAIT_WHILE_BUSY.
>> Why not just:
> 
> Before I do any update, we need to decide what host->max_busy_timeout
> of zero means. Please see the response in the other patch in this
> patchset.

Unless you want to change all the host controller drivers, zero means
don't know.

> 
> I see that my patch for the mmc_switch function, maintain the R1B for
> host not supporting MMC_CAP_WAIT_WHILE_BUSY, but this one for sleep
> doesn't. :-) We should align the behaviour.
> 
> 
>>
>>         if (host->max_busy_timeout && timeout_ms > host->max_busy_timeout) {
>>                 cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>         } else {
>>                 cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>                 cmd.busy_timeout = timeout_ms;
>>         }
> 
> So here your suggestion will mean you would like to keep R1B for hosts
> not supporting MMC_CAP_WAIT_WHILE_BUSY. This opposite of what you
> proposed for the mmc_switch. :-)

I suggested:

	if (timeout_ms && host->max_busy_timeout && timeout_ms > host->max_busy_timeout)
                use_r1b_resp = false;

(without modifying timeout_ms) which wasn't related to MMC_CAP_WAIT_WHILE_BUSY
i.e. keeps R1B for hosts not supporting MMC_CAP_WAIT_WHILE_BUSY

> 
> I suggest that we only use R1B when the host are able to handle busy
> detection in hw. If you think that is bad idea, please let me know.
> 
>>
>>> +
>>>       err = mmc_wait_for_cmd(host, &cmd, 0);
>>>       if (err)
>>>               return err;
>>> @@ -1383,8 +1396,8 @@ static int mmc_sleep(struct mmc_host *host)
>>>        * SEND_STATUS command to poll the status because that command (and most
>>>        * others) is invalid while the card sleeps.
>>>        */
>>> -     if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
>>> -             mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
>>> +     if (!cmd.busy_timeout)
>>> +             mmc_delay(timeout_ms);
>>
>> And this becomes:
>>
>>         if (!cmd.busy_timeout || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
>>                 mmc_delay(timeout_ms);
>>
>>>
>>>       return err;
>>>  }
>>>
>>
> 
> Kind regards
> Uffe
> 
> 

