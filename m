From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [RFC PATCH] mmc: core: retry polling busy when response timeout occurs
Date: Fri, 13 Jan 2017 16:56:44 +0800
Message-ID: <CAA+hA=Q1kwi4VczjqaF96Gd6MvoG9VTetXqtFrbky-S1hGF_9A@mail.gmail.com>
References: <1484277895-94393-1-git-send-email-shawn.lin@rock-chips.com>
 <CAA+hA=S-7+gJ6Gbyr2np6419BfFs1hb2d-UAvmaCxCxuFLY-6Q@mail.gmail.com> <cdf7e04d-ee62-a620-ac22-6e4d8a689eca@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34882 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdAMI4p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 03:56:45 -0500
Received: by mail-qk0-f193.google.com with SMTP id u25so6165765qki.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 00:56:45 -0800 (PST)
In-Reply-To: <cdf7e04d-ee62-a620-ac22-6e4d8a689eca@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Jan 13, 2017 at 3:04 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Aisheng,
>
> On 2017/1/13 13:03, Dong Aisheng wrote:
>>
>> Hi Shawn,
>>
>> On Fri, Jan 13, 2017 at 11:24 AM, Shawn Lin <shawn.lin@rock-chips.com>
>> wrote:
>>>
>>> It always assumed that if the card was not ready after finishing
>>> switching the mode, we should got a CRC, namely -EILSEQ, from the
>>> hosts. But the fact is if the host is in higher speed mode but the
>>> eMMC havn't finished the switch, so the host could fail to sample
>>> the resp of CMD13 due to the mismatch timing in between. Could it is
>>> possible that response timeout was generated instaed of -EILSEQ? It's
>>> quite IP specificed.
>>
>>
>> I wonder this may not work for IMX since changing timing while card busy
>> may cause host unable to send the next CMD anymore.
>> Then SW timeout (5s or 10s)  implemented in common SDHCI driver happens.
>>
>
> (1) If the controller is able to send the next CMD, but generate
> response timeout, we should take this into account as the card is
> still in busy state, so let's retry it.
>
> (2) However, for your cases, the next CMD couldn't be sent out and SW
> timeout rountine break out the loop as the SW timeout should take much
> longer than generic_cmd6_time, which means the timeout value is expired
> immediately after getting err from host, namely SW timeout rountine
> throw out a -ETIMEDOUT, right? So it just behave the same and didn't
> improve anything.
>

Yes, it does not help for IMX.

> So I was just wanna cover the case (1). Thought?
>

Yes, it's for case (1).

A bit more thinking that as the physical spec defined in section 4.3.10.5,
The host is advised not to Issue any command during a CMD6 transaction.
It's risky operation.

Probably we could better not allow CMD13 polling during CMD6 swithc and force
controller drivers provide ops->card_busy() function to check CMD6 complete
if they not support MMC_CAP_WAIT_WHILE_BUSY.
Most controller should have such capbility.
No sure if any exception!

Regards
Dong Aisheng

>
>
>
>
>> Regards
>> Dong Aisheng
>>
>>> So I don't think we should take the risk of
>>> relying on that. In another word, we don't expect to bail out early
>>> for timeout errors bounced from hosts when polling the status, no
>>> just for explicit CRC.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> ---
>>>
>>>  drivers/mmc/core/mmc_ops.c | 14 +++++++++-----
>>>  drivers/mmc/core/mmc_ops.h |  3 ++-
>>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index db2969f..a352dea 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -451,7 +451,7 @@ int mmc_switch_status(struct mmc_card *card)
>>>  }
>>>
>>>  static int mmc_poll_for_busy(struct mmc_card *card, unsigned int
>>> timeout_ms,
>>> -                       bool send_status, bool retry_crc_err)
>>> +                       bool send_status, bool retry_crc_and_tmo_err)
>>>  {
>>>         struct mmc_host *host = card->host;
>>>         int err;
>>> @@ -486,7 +486,8 @@ static int mmc_poll_for_busy(struct mmc_card *card,
>>> unsigned int timeout_ms,
>>>                         busy = host->ops->card_busy(host);
>>>                 } else {
>>>                         err = mmc_send_status(card, &status);
>>> -                       if (retry_crc_err && err == -EILSEQ) {
>>> +                       if (retry_crc_and_tmo_err &&
>>> +                           (err == -EILSEQ || err == -ETIMEDOUT)) {
>>>                                 busy = true;
>>>                         } else if (err) {
>>>                                 return err;
>>> @@ -523,13 +524,15 @@ static int mmc_poll_for_busy(struct mmc_card *card,
>>> unsigned int timeout_ms,
>>>   *     @timing: new timing to change to
>>>   *     @use_busy_signal: use the busy signal as response type
>>>   *     @send_status: send status cmd to poll for busy
>>> - *     @retry_crc_err: retry when CRC errors when polling with CMD13 for
>>> busy
>>> + *     @retry_crc_and_tmo_err: retry when CRC errors or response timeout
>>> errors
>>> + *                             when polling with CMD13 for busy
>>>   *
>>>   *     Modifies the EXT_CSD register for selected card.
>>>   */
>>>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>                 unsigned int timeout_ms, unsigned char timing,
>>> -               bool use_busy_signal, bool send_status, bool
>>> retry_crc_err)
>>> +               bool use_busy_signal, bool send_status,
>>> +               bool retry_crc_and_tmo_err)
>>>  {
>>>         struct mmc_host *host = card->host;
>>>         int err;
>>> @@ -590,7 +593,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
>>> index, u8 value,
>>>         }
>>>
>>>         /* Let's try to poll to find out when the command is completed.
>>> */
>>> -       err = mmc_poll_for_busy(card, timeout_ms, send_status,
>>> retry_crc_err);
>>> +       err = mmc_poll_for_busy(card, timeout_ms, send_status,
>>> +                               retry_crc_and_tmo_err);
>>>
>>>  out_tim:
>>>         if (err && timing)
>>> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
>>> index abd525e..fad9963 100644
>>> --- a/drivers/mmc/core/mmc_ops.h
>>> +++ b/drivers/mmc/core/mmc_ops.h
>>> @@ -31,7 +31,8 @@
>>>  int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
>>>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>>                 unsigned int timeout_ms, unsigned char timing,
>>> -               bool use_busy_signal, bool send_status, bool
>>> retry_crc_err);
>>> +               bool use_busy_signal, bool send_status,
>>> +               bool retry_crc_and_tmo_err);
>>>
>>>  #endif
>>>
>>> --
>>> 1.9.1
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>
>
> --
> Best Regards
> Shawn Lin
>
