From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: block: release host in case of error
Date: Thu, 24 Nov 2011 19:58:22 +0100
Message-ID: <CAFEEs1koxLhwKf2HHaO4qEWe+JzDtJqYf94HK5Z2gCVv3KCM7g@mail.gmail.com>
References: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
	<4EC4D151.1030008@intel.com>
	<4EC62BC3.30300@stericsson.com>
	<CAFEEs1kSwOF21Gn5XEL5QMrC2TWBMA+K2xAchtTALfV4STZXPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59826 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1KXS6X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2011 13:58:23 -0500
Received: by vbbfc26 with SMTP id fc26so1697571vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2011 10:58:22 -0800 (PST)
In-Reply-To: <CAFEEs1kSwOF21Gn5XEL5QMrC2TWBMA+K2xAchtTALfV4STZXPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>

On Sun, Nov 20, 2011 at 9:50 PM, Per Forlin <per.lkml@gmail.com> wrote:
> Hi Adrian,
>
> On Fri, Nov 18, 2011 at 10:56 AM, Per F=F6rlin <per.forlin@stericsson=
=2Ecom> wrote:
>> On 11/17/2011 10:18 AM, Adrian Hunter wrote:
>>> On 14/11/11 13:12, Per Forlin wrote:
>>>> Host is claimed as long as there are requests in the block queue
>>>> and all request are completed successfully. If an error occur rele=
ase
>>>> the host in case someone else needs to claim it, for instance if t=
he card
>>>> is removed during a transfer.
>>>>
>>>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>>>> ---
>>>> =A0drivers/mmc/card/block.c | =A0 37 +++++++++++++++++++++++++++++=
--------
>>>> =A01 files changed, 29 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index c80bb6d..c21fd2c 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -1158,6 +1158,28 @@ static int mmc_blk_cmd_err(struct mmc_blk_d=
ata *md, struct mmc_card *card,
>>>> =A0 =A0 =A0return ret;
>>>> =A0}
>>>>
>>>> +/*
>>>> + * This function should be called to resend a request after failu=
re.
>>>> + * Prepares and starts the request.
>>>> + */
>>>> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_car=
d *card,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_queue *mq,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_queue_req *mqrq,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 int disable_multi,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_async_req *areq)
>>>> +{
>>>> + =A0 =A0/*
>>>> + =A0 =A0 * Release host after failure in case the host is needed
>>>> + =A0 =A0 * by someone else. For instance, if the card is removed =
the
>>>> + =A0 =A0 * worker thread needs to claim the host in order to do m=
mc_rescan.
>>>> + =A0 =A0 */
>>>> + =A0 =A0mmc_release_host(card->host);
>>>> + =A0 =A0mmc_claim_host(card->host);
>>>
>>> Does this work? =A0Won't the current thread win the race
>>> to claim the host again?
>>>
>> Good question. I've tested it and I haven't seen any cases where cur=
rent has claimed the host again. Sujit has tested the patch as well.
>> But I can't say that your scenario can't happen. I will study the wa=
ke_up and wait_queue code to see if I can find the answer.
>>
>
> mmc_release_host() -> wake_up() -> schedule(). If the waking process
> has higher prio than current it will preempt current on NOSMP. If SMP=
,
> current and waking process may be on separate CPUs and in that case
> it's difficult to guarantee that the waking process will win the race=
=2E
> I'm proposing to add yield() in order to give the waking process
> better chances to win the race.
> Here's a patch:
> --------------------------------
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c21fd2c..add1c38 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1173,8 +1173,11 @@ static inline struct mmc_async_req
> *mmc_blk_resend(struct mmc_card *card,
> =A0 =A0 =A0 =A0 * by someone else. For instance, if the card is remov=
ed the
> =A0 =A0 =A0 =A0 * worker thread needs to claim the host in order to d=
o mmc_rescan.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 mmc_release_host(card->host);
> - =A0 =A0 =A0 mmc_claim_host(card->host);
> + =A0 =A0 =A0 if (mmc_card_rescan(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(card->host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 yield();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(card->host);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
> =A0 =A0 =A0 =A0return mmc_start_req(card->host, areq, NULL);
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 271efea..83f03a3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2059,6 +2059,8 @@ void mmc_rescan(struct work_struct *work)
> =A0 =A0 =A0 =A0if (host->rescan_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> + =A0 =A0 =A0 mmc_card_set_rescan(host->card);
> +
>
>
> =A0 =A0 =A0 =A0/*
> @@ -2101,6 +2103,7 @@
>
>
> =A0out:
> + =A0 =A0 =A0 mmc_card_clr_rescan(host->card);
>
>
> =A0}
> -----------------------
I'm not sure if this patch-extension is really needed, it may only
make the patch more complex. If the race condition Adrian refers to is
unlikely, there may be a few extra retries before mmc_rescan get the
chance to claim the host.
I'm in favor of skipping my proposed extension and staying with the
original v1 patch.
Adrian, what do you say?

Thanks,
Per
