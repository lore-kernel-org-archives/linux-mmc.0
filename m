From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 04/10] mmc: core: Fixup busy detection for mmc switch
 operations
Date: Mon, 27 Jan 2014 12:40:26 +0200
Message-ID: <52E6379A.7070107@intel.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org> <1390402824-9850-5-git-send-email-ulf.hansson@linaro.org> <52E0EA96.4030702@intel.com> <CAPDyKFqKSEPPTnXo=TA3LrW_BCHYma8BvAaYd+Ovgg_QsnV-Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4573 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbaA0Kin (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Jan 2014 05:38:43 -0500
In-Reply-To: <CAPDyKFqKSEPPTnXo=TA3LrW_BCHYma8BvAaYd+Ovgg_QsnV-Xg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On 23/01/14 16:11, Ulf Hansson wrote:
> On 23 January 2014 11:10, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 22/01/14 17:00, Ulf Hansson wrote:
>>> If the host controller supports busy detection in HW, we expect the
>>> MMC_CAP_WAIT_WHILE_BUSY to be set. Likewise the corresponding
>>> host->max_busy_timeout shall reflect the maximum busy detection timeout
>>> supported by the host. A timeout set to zero, is interpreted as the
>>> host supports whatever timeout the mmc core provides it with.
>>>
>>> Previously we expected a host that supported MMC_CAP_WAIT_WHILE_BUSY to
>>> cope with any timeout, which just isn't feasible due to HW limitations.
>>>
>>> For most switch operations, R1B responses are expected and thus we need
>>> to check for busy detection completion. To cope with cases where the
>>> requested busy detection timeout is greater than what the host are able
>>> to support, we fallback to use a R1 response instead. This will prevent
>>> the host from doing HW busy detection.
>>>
>>> In those cases busy detection completion is handled by polling the for
>>> the card's status using CMD13, which is the same mechanism used when
>>> the host doesn't support MMC_CAP_WAIT_WHILE_BUSY.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/mmc/core/mmc_ops.c |   53 ++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 36 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index 5e1a2cb..2e0cccb 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -413,13 +413,31 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>               unsigned int timeout_ms, bool use_busy_signal, bool send_status,
>>>               bool ignore_crc)
>>>  {
>>> +     struct mmc_host *host;
>>
>> It would be nicer if the addition of 'host' was a separate patch.  You
>> should remove the unnecessary BUG_ONs (it will oops anyway) at the same
>> time and then just do:
>>
>>         struct mmc_host *host = card->host;
> 
> Sure, make sense!
> 
>>
>>>       int err;
>>>       struct mmc_command cmd = {0};
>>>       unsigned long timeout;
>>> +     unsigned int max_busy_timeout;
>>>       u32 status = 0;
>>> +     bool use_r1b_resp = true;
>>
>> This is a little confusing.  Why not:
>>
>>         bool use_r1b_resp = use_busy_signal;
>>
>> Although 'use_busy_signal' actually means 'wait_while_busy'.
> 
> Right, that should simplify code a bit. I will update in a v2.
> 
>>
>>>
>>>       BUG_ON(!card);
>>>       BUG_ON(!card->host);
>>> +     host = card->host;
>>> +
>>> +     /* Once all callers provides a timeout, remove this fallback. */
>>> +     if (!timeout_ms)
>>> +             timeout_ms = MMC_OPS_TIMEOUT_MS;
>>
>> A timeout of zero does not mean a very long timeout.  It means an unknown timeout.
> 
> I guess this is a matter of definition.

JEDEC did not define GENERIC_CMD6_TIME until v4.5 so before that the timeout
is unknown.  It is reasonable for the host controller drivers to select a
value that suits them rather than constrain them to some arbitrarily large
timeout.

> 
> For those hosts that don't have a hw timeout, but maybe implements a
> software timeout, I thought this was more convenient. We likely then
> also need to define a "MAX_BUSY_TIMEOUT", which host drivers could
> use.
> 
> Additionally, since as of today only sdhci specifies the
> max_discard_to (renamed to max_busy_timeout), I thought it make sense
> to not force other hosts to specify the timeout to keep the existing
> behaviour.

Yes max_busy_timeout of zero again means unknown.

> 
>>
>>> +
>>> +     /* We interpret unspecified timeouts as the host can cope with all. */
>>> +     max_busy_timeout = host->max_busy_timeout ?
>>> +                     host->max_busy_timeout : timeout_ms;
>>> +
>>> +     if (use_busy_signal && (host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
>>> +             (timeout_ms > max_busy_timeout))
>>> +                     use_r1b_resp = false;
>>> +     else if (!use_busy_signal)
>>> +             use_r1b_resp = false;
>>
>> Why not just check what you know:
>>
>>         if (timeout_ms && host->max_busy_timeout && timeout_ms > host->max_busy_timeout)
>>                 use_r1b_resp = false;
>>
> 
> I wanted to maintain the R1B response for hosts that don't support
> MMC_CAP_WAIT_WHILE_BUSY. With your proposal this will not be done.
> 
> Given this a second thought. I think it would make sense to adapt to
> your proposal. I will update in v2.
> 
>>>
>>>       cmd.opcode = MMC_SWITCH;
>>>       cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>>> @@ -427,17 +445,25 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>                 (value << 8) |
>>>                 set;
>>>       cmd.flags = MMC_CMD_AC;
>>> -     if (use_busy_signal)
>>> +     if (use_r1b_resp)
>>>               cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
>>>       else
>>>               cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
>>>
>>> +     if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp) {
>>> +             /* Tell the host what busy detection timeout to use. */
>>> +             cmd.busy_timeout = timeout_ms;
>>> +             /*
>>> +              * CRC errors shall only be ignored in cases were CMD13 is used
>>> +              * to poll to detect busy completion.
>>> +              */
>>> +             ignore_crc = false;
>>> +     }
>>>
>>> -     cmd.busy_timeout = timeout_ms;
>>
>> The busy_timeout should be provided for R1B i.e. this should be:
>>
>>         if (use_r1b_resp)
>>                 cmd.busy_timeout = timeout_ms;
>>
> 
> Will fix in v2, given you still think this is good approach according
> to my comment just above.
> 
>>>       if (index == EXT_CSD_SANITIZE_START)
>>>               cmd.sanitize_busy = true;
>>>
>>> -     err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>>> +     err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>>>       if (err)
>>>               return err;
>>>
>>> @@ -445,24 +471,17 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>       if (!use_busy_signal)
>>>               return 0;
>>>
>>> -     /*
>>> -      * CRC errors shall only be ignored in cases were CMD13 is used to poll
>>> -      * to detect busy completion.
>>> -      */
>>> -     if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
>>> -             ignore_crc = false;
>>> -
>>>       /* Must check status to be sure of no errors. */
>>> -     timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
>>
>> This is the place to set the default timeout for the loop.
>>
>>         if (!timeout_ms)
>>                 timeout_ms = MMC_OPS_TIMEOUT_MS
>>
>>> +     timeout = jiffies + msecs_to_jiffies(timeout_ms);
>>>       do {
>>>               if (send_status) {
>>>                       err = __mmc_send_status(card, &status, ignore_crc);
>>>                       if (err)
>>>                               return err;
>>>               }
>>> -             if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
>>> +             if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
>>>                       break;
>>> -             if (mmc_host_is_spi(card->host))
>>> +             if (mmc_host_is_spi(host))
>>>                       break;
>>>
>>>               /*
>>> @@ -478,18 +497,18 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>               /* Timeout if the device never leaves the program state. */
>>>               if (time_after(jiffies, timeout)) {
>>>                       pr_err("%s: Card stuck in programming state! %s\n",
>>> -                             mmc_hostname(card->host), __func__);
>>> +                             mmc_hostname(host), __func__);
>>>                       return -ETIMEDOUT;
>>>               }
>>>       } while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
>>>
>>> -     if (mmc_host_is_spi(card->host)) {
>>> +     if (mmc_host_is_spi(host)) {
>>>               if (status & R1_SPI_ILLEGAL_COMMAND)
>>>                       return -EBADMSG;
>>>       } else {
>>>               if (status & 0xFDFFA000)
>>> -                     pr_warning("%s: unexpected status %#x after "
>>> -                            "switch", mmc_hostname(card->host), status);
>>> +                     pr_warn("%s: unexpected status %#x after switch\n",
>>> +                             mmc_hostname(host), status);
>>>               if (status & R1_SWITCH_ERROR)
>>>                       return -EBADMSG;
>>>       }
>>>
>>
> 
> Adrian, thanks for reviewing!
> 
> Kind regards
> Uffe
> 
> 

