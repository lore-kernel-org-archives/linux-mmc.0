From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/4] mmc: tmio: Add tuning support
Date: Wed, 31 Aug 2016 09:38:40 +0200
Message-ID: <CAPDyKFpHzr-emfMsKyiJ4Ow-pjCCHWw6bBCEP6kEszOz09_pmA@mail.gmail.com>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
 <1469592803-13842-3-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFq_Fs_bNx7LP-J+nC3iaNgB7gvZAvhCp--qVOh1iAh0vg@mail.gmail.com>
 <20160823135251.GA25665@verge.net.au> <CAPDyKFpbMnOag7TZtQXxffXyq4XjTfz3vYM_atks15+d64QkfQ@mail.gmail.com>
 <20160825120424.GA3385@verge.net.au> <CAPDyKFpu85h3w2JkCjyQ15P8eWfkAkYcpxR4A6bD0EpQLw9rew@mail.gmail.com>
 <20160829120533.GA8647@verge.net.au> <CAPDyKFoL1xvv1yog2tY7pF9fWoiGQ9Gew_QbrA06dSrBiFyVEQ@mail.gmail.com>
 <20160830205146.GA14623@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160830205146.GA14623@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30 August 2016 at 22:51, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 29, 2016 at 04:05:55PM +0200, Ulf Hansson wrote:
>> On 29 August 2016 at 14:05, Simon Horman <horms@verge.net.au> wrote:
>> > On Fri, Aug 26, 2016 at 10:01:35AM +0200, Ulf Hansson wrote:
>> >> On 25 August 2016 at 14:04, Simon Horman <horms@verge.net.au> wrote:
>> >> > On Tue, Aug 23, 2016 at 05:02:56PM +0200, Ulf Hansson wrote:
>> >
>> > ...
>
> ...
>
>> > @@ -1271,6 +1278,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>> >
>> >         mmc_retune_timer_stop(host->mmc);
>> >         mmc_retune_needed(host->mmc);
>> > +       host->use_saved_taps = true;
>>
>> I don't think you should trigger a re-tune here at all. Moreover you
>> don't need to keep track of whether you have valid tap values by using
>> the ->use_saved_taps variable, the mmc core deals with this for you.
>>
>> Instead, you should restore the tap values by invoking
>> host->select_tuning() from the ->runtime_resume() callback, although
>> only when host->mmc->can_retune == 1. We should probably add a helper
>> function in the mmc core for this check, instead of accessing
>> "can_retune" directly.
>
> Thanks, I was wondering what the best way to handle this is.
>
> I tried your suggestion above but it seems that host->mmc->can_retune is
> zero when ->runtime_resume() is called because of the following call paths:
>
> a) _mmc_sd_suspend()
>      -> mmc_power_off()
>         -> mmc_set_initial_state()
>            -> mmc_retune_disable
>    and
> b) mmc_sd_runtime_resume()
>      -> mmc_power_up
>         -> mmc_set_initial_state()
>            -> mmc_retune_disable
>
>> >         tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);

This is exactly what shall happen :-)

If the mmc core suspends the card, it means it will also re-initialize
the card when resuming it. In that way the regular tuning sequence
will take place as a part of re-initialization of the card, so you
definitely must not restore tap values in these case. That is why you
should be using the can_retune to know when to restore the values.

>
>
> I plan to repost this patchset without the tap restoration code.
> This is because I have a number of changes locally, in particular
> to address other parts of your review, and I would like
> them to see the light of day.
>
> I will mark the tap restoration as a TODO item which we can address
> before merging the code in question.

It shouldn't be that hard to implement this, so I rather see that we
get this right from the beginning.

As matter of fact it probably requires less code than you had in your
initial approach, especially since I don't think you need to deal with
anything tuning related in the ->runtime_suspend() callback, but only
in ->runtime_resume().

Kind regards
Uffe
