From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] mmc: add functions to enable/disable aggressive clock gating
Date: Wed, 17 Aug 2011 09:51:31 +0200
Message-ID: <CACRpkdZ5oCmRupNn9HjZj534zXJQWD8OpycpMxG4Jhgsvk=kEQ@mail.gmail.com>
References: <e13e177c732ee8ad2d6fe389c9bac21877f60c59.1313400777.git.mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34170 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1HQHvc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2011 03:51:32 -0400
In-Reply-To: <e13e177c732ee8ad2d6fe389c9bac21877f60c59.1313400777.git.mika.westerberg@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org

On Mon, Aug 15, 2011 at 12:03 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> There are few places where we want to make sure that no clock gating =
takes
> place. For example when we are updating several related fields in ios
> structure and we don't want to accidentally pass the partially filled=
 ios
> to the host driver.
>
> To solve this we add two functions to enable/disable the aggressive c=
lock
> gating where this is needed.

OK I realize the problem.

There is a terminologty problem here: "disable" is a word used
in the clock framework clk.h and can be very cofusing, since it
means "turn off the clock" or "decrease refcount on clock by one",
whereas here the meaning is the exact opposite.

Please use some other word like "gate inhibit" or so.

> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b29d3e8..ee52246 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -178,7 +178,7 @@ void mmc_host_clk_gate(struct mmc_host *host)
> =A0 =A0 =A0 =A0spin_lock_irqsave(&host->clk_lock, flags);
> =A0 =A0 =A0 =A0host->clk_requests--;
> =A0 =A0 =A0 =A0if (mmc_host_may_gate_card(host->card) &&
> - =A0 =A0 =A0 =A0 =A0 !host->clk_requests)
> + =A0 =A0 =A0 =A0 =A0 !host->clk_requests && !host->clk_disabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule_work(&host->clk_gate_work);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->clk_lock, flags);
> =A0}
> @@ -204,6 +204,42 @@ unsigned int mmc_host_clk_rate(struct mmc_host *=
host)
> =A0}
>
> =A0/**
> + * =A0 =A0 mmc_host_clk_gate_disable - temporarily disable clock gat=
ing
> + * =A0 =A0 @host: host to disable clock gating
> + *
> + * =A0 =A0 Function temporarily disables aggressive clock gating. Th=
is is to
> + * =A0 =A0 prevent clock gating worker to kick in for example in a m=
iddle of
> + * =A0 =A0 ios structure update.
> + *
> + * =A0 =A0 After this function returns, it is guaranteed that no clo=
ck gating
> + * =A0 =A0 takes place until it is re-enabled again.
> + */
> +void mmc_host_clk_gate_disable(struct mmc_host *host)

So rename "mmc_host_clk_gate_inhibit() or so.

> +{
> + =A0 =A0 =A0 spin_lock_irq(&host->clk_lock);
> + =A0 =A0 =A0 WARN_ON(host->clk_disabled);
> + =A0 =A0 =A0 host->clk_disabled =3D true;
> + =A0 =A0 =A0 spin_unlock_irq(&host->clk_lock);
> +
> + =A0 =A0 =A0 cancel_work_sync(&host->clk_gate_work);
> +}

To inhibit clock gating it should be enough to increase
the refcount on the requests:

spin_lock_*(&host->clk_lock);
host->clk_requests++;
spin_unlock_*(&host->clk_lock);

But if you look closer at mmc_host_clk_gate() that is
exactly what that function does.

> +/**
> + * =A0 =A0 mmc_host_clk_gate_enable - re-enables clock gating
> + * =A0 =A0 @host: host to re-enable clock gating
> + *
> + * =A0 =A0 Allows aggressive clock gating framework to continue gati=
ng the
> + * =A0 =A0 host clock.
> + */
> +void mmc_host_clk_gate_enable(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 spin_lock_irq(&host->clk_lock);
> + =A0 =A0 =A0 WARN_ON(!host->clk_disabled);
> + =A0 =A0 =A0 host->clk_disabled =3D false;
> + =A0 =A0 =A0 spin_unlock_irq(&host->clk_lock);
> +}

spin_lock_*(&host->clk_lock);
host->clk_requests--;
spin_unlock_*(&host->clk_lock);

But this is equivalent to mmc_host_clk_gate().

> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index de199f9..7148b24 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -19,6 +19,8 @@ void mmc_unregister_host_class(void);
> =A0void mmc_host_clk_ungate(struct mmc_host *host);
> =A0void mmc_host_clk_gate(struct mmc_host *host);
> =A0unsigned int mmc_host_clk_rate(struct mmc_host *host);
> +void mmc_host_clk_gate_disable(struct mmc_host *host);
> +void mmc_host_clk_gate_enable(struct mmc_host *host);
>
> =A0#else
> =A0static inline void mmc_host_clk_ungate(struct mmc_host *host)
> @@ -33,6 +35,15 @@ static inline unsigned int mmc_host_clk_rate(struc=
t mmc_host *host)
> =A0{
> =A0 =A0 =A0 =A0return host->ios.clock;
> =A0}
> +
> +static inline void mmc_host_clk_gate_disable(struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_host_clk_gate_enable(struct mmc_host *host)
> +{
> +}
> +
> =A0#endif
>
> =A0void mmc_host_deeper_disable(struct work_struct *work);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1d09562..dea6350 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -240,6 +240,7 @@ struct mmc_host {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_old; =A0 =A0 =A0=
 =A0/* old clock value cache */
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_lock; =A0 =A0=
 =A0 /* lock for clk fields */
> =A0 =A0 =A0 =A0struct mutex =A0 =A0 =A0 =A0 =A0 =A0clk_gate_mutex; /*=
 mutex for clock gating */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable=
d; =A0 /* gating is temporarily disabled */

This name does not work. Please call it "gating_inhibited" or
something similar if you use this approach.

I would suggest that in all patches using these functions, try
to replace:

mmc_host_clk_disable() -> mmc_host_clk_ungate()
mmc_host_clk_enable() -> mmc_host_clk_gate()

Please tell us if this works!

I understand that the names can be a bit confusing by but
I think you can convince yourself that what this will do is
simply increase the refcount host->clk_requests so the
clock is not gated across these sections.

If you think the names of the functions are confusing then
you may rename them, say like this:

mmc_host_clk_ungate() -> mmc_host_clk_hold()
mmc_host_clk_gate() -> mmc_host_clk_release()

Which would make the usecases more clear, I'd be happy
to ACK a patch for this.

Thanks,
Linus Walleij
