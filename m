From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: block: release host in case of error
Date: Fri, 25 Nov 2011 14:00:07 +0100
Message-ID: <CAFEEs1nxNZD4QEcGNUFEeq3cRA2AW-cqMWOvue5FuMQE8MuVaQ@mail.gmail.com>
References: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
	<4EC4D151.1030008@intel.com>
	<4EC62BC3.30300@stericsson.com>
	<CAFEEs1kSwOF21Gn5XEL5QMrC2TWBMA+K2xAchtTALfV4STZXPw@mail.gmail.com>
	<CAFEEs1koxLhwKf2HHaO4qEWe+JzDtJqYf94HK5Z2gCVv3KCM7g@mail.gmail.com>
	<4ECF8411.4080409@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44318 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306Ab1KYNAI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2011 08:00:08 -0500
Received: by vcbfk14 with SMTP id fk14so2045537vcb.19
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2011 05:00:07 -0800 (PST)
In-Reply-To: <4ECF8411.4080409@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>

On Fri, Nov 25, 2011 at 1:03 PM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> On 24/11/11 20:58, Per Forlin wrote:
>> On Sun, Nov 20, 2011 at 9:50 PM, Per Forlin <per.lkml@gmail.com> wro=
te:
>>> Hi Adrian,
>>>
>>> On Fri, Nov 18, 2011 at 10:56 AM, Per F=F6rlin <per.forlin@stericss=
on.com> wrote:
>>>> On 11/17/2011 10:18 AM, Adrian Hunter wrote:
>>>>> On 14/11/11 13:12, Per Forlin wrote:
>>>>>> Host is claimed as long as there are requests in the block queue
>>>>>> and all request are completed successfully. If an error occur re=
lease
>>>>>> the host in case someone else needs to claim it, for instance if=
 the card
>>>>>> is removed during a transfer.
>>>>>>
>>>>>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>>>>>> ---
>>>>>> =A0drivers/mmc/card/block.c | =A0 37 +++++++++++++++++++++++++++=
++--------
>>>>>> =A01 files changed, 29 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>>> index c80bb6d..c21fd2c 100644
>>>>>> --- a/drivers/mmc/card/block.c
>>>>>> +++ b/drivers/mmc/card/block.c
>>>>>> @@ -1158,6 +1158,28 @@ static int mmc_blk_cmd_err(struct mmc_blk=
_data *md, struct mmc_card *card,
>>>>>> =A0 =A0 =A0return ret;
>>>>>> =A0}
>>>>>>
>>>>>> +/*
>>>>>> + * This function should be called to resend a request after fai=
lure.
>>>>>> + * Prepares and starts the request.
>>>>>> + */
>>>>>> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_c=
ard *card,
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_queue *mq,
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_queue_req *mqrq,
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int disable_multi,
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_async_req *areq)
>>>>>> +{
>>>>>> + =A0 =A0/*
>>>>>> + =A0 =A0 * Release host after failure in case the host is neede=
d
>>>>>> + =A0 =A0 * by someone else. For instance, if the card is remove=
d the
>>>>>> + =A0 =A0 * worker thread needs to claim the host in order to do=
 mmc_rescan.
>>>>>> + =A0 =A0 */
>>>>>> + =A0 =A0mmc_release_host(card->host);
>>>>>> + =A0 =A0mmc_claim_host(card->host);
>>>>>
>>>>> Does this work? =A0Won't the current thread win the race
>>>>> to claim the host again?
>>>>>
>>>> Good question. I've tested it and I haven't seen any cases where c=
urrent has claimed the host again. Sujit has tested the patch as well.
>>>> But I can't say that your scenario can't happen. I will study the =
wake_up and wait_queue code to see if I can find the answer.
>>>>
>>>
>>> mmc_release_host() -> wake_up() -> schedule(). If the waking proces=
s
>>> has higher prio than current it will preempt current on NOSMP. If S=
MP,
>>> current and waking process may be on separate CPUs and in that case
>>> it's difficult to guarantee that the waking process will win the ra=
ce.
>>> I'm proposing to add yield() in order to give the waking process
>>> better chances to win the race.
>>> Here's a patch:
>>> --------------------------------
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index c21fd2c..add1c38 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1173,8 +1173,11 @@ static inline struct mmc_async_req
>>> *mmc_blk_resend(struct mmc_card *card,
>>> =A0 =A0 =A0 =A0 * by someone else. For instance, if the card is rem=
oved the
>>> =A0 =A0 =A0 =A0 * worker thread needs to claim the host in order to=
 do mmc_rescan.
>>> =A0 =A0 =A0 =A0 */
>>> - =A0 =A0 =A0 mmc_release_host(card->host);
>>> - =A0 =A0 =A0 mmc_claim_host(card->host);
>>> + =A0 =A0 =A0 if (mmc_card_rescan(card)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(card->host);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 yield();
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(card->host);
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>>> =A0 =A0 =A0 =A0return mmc_start_req(card->host, areq, NULL);
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 271efea..83f03a3 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -2059,6 +2059,8 @@ void mmc_rescan(struct work_struct *work)
>>> =A0 =A0 =A0 =A0if (host->rescan_disable)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>
>>> + =A0 =A0 =A0 mmc_card_set_rescan(host->card);
>>> +
>>>
>>>
>>> =A0 =A0 =A0 =A0/*
>>> @@ -2101,6 +2103,7 @@
>>>
>>>
>>> =A0out:
>>> + =A0 =A0 =A0 mmc_card_clr_rescan(host->card);
>>>
>>>
>>> =A0}
>>> -----------------------
>> I'm not sure if this patch-extension is really needed, it may only
>> make the patch more complex. If the race condition Adrian refers to =
is
>> unlikely, there may be a few extra retries before mmc_rescan get the
>> chance to claim the host.
>> I'm in favor of skipping my proposed extension and staying with the
>> original v1 patch.
>> Adrian, what do you say?
>
> As far as I can see, if mmc block is checking / setting whether the
> card has been removed, then mmc_blk_resend would not be needed.
>
I agree. The intention of this patch is only top let mmc_rescan claim t=
he host.
=46low: card detect IRQ -> mmc_detect_change -> mmc_rescan -> mmc_claim=
_host

If doing this check in mmc block instead this patch is not needed.
Let's wait and see what comes out of the patch "mmc: Kill block
requests if card is removed".

Thanks,
Per
