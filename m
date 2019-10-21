From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
Date: Mon, 21 Oct 2019 15:13:22 -0700
Message-ID: <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191017135739.1315-3-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 17, 2019 at 6:58 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> It have turned out that it's not a good idea to try to power cycle and to
> re-initialize the SDIO card, via mmc_hw_reset. This because there may be
> multiple SDIO funcs attached to the same SDIO card.
>
> To solve this problem, we would need to inform each of the SDIO func in
> some way when mmc_sdio_hw_reset() gets called, but that isn't an entirely
> trivial operation. Therefore, let's instead take the easy way out, by
> triggering a card removal and force a new rescan of the SDIO card.
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mmc/core/core.c |  3 +--
>  drivers/mmc/core/core.h |  2 ++
>  drivers/mmc/core/sdio.c | 11 +++++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6f8342702c73..39c4567e39d8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>         mmc_bus_put(host);
>  }
>
> -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> -                               bool cd_irq)
> +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>  {
>         /*
>          * If the device is configured as wakeup, we prevent a new sleep for
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 328c78dbee66..575ac0257af2 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -70,6 +70,8 @@ void mmc_rescan(struct work_struct *work);
>  void mmc_start_host(struct mmc_host *host);
>  void mmc_stop_host(struct mmc_host *host);
>
> +void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> +                       bool cd_irq);
>  int _mmc_detect_card_removed(struct mmc_host *host);
>  int mmc_detect_card_removed(struct mmc_host *host);
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 26cabd53ddc5..5d7462c223c3 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1050,8 +1050,15 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
>
>  static int mmc_sdio_hw_reset(struct mmc_host *host)
>  {
> -       mmc_power_cycle(host, host->card->ocr);
> -       return mmc_sdio_reinit_card(host);
> +       /*
> +        * We may have more multiple SDIO funcs. Rather than to inform them all,
> +        * let's trigger a removal and force a new rescan of the card.
> +        */
> +       host->rescan_entered = 0;
> +       mmc_card_set_removed(host->card);
> +       _mmc_detect_change(host, 0, false);
> +
> +       return 0;
>  }

The problem I see here is that callers of this reset function aren't
expecting it to work this way.  Look specifically at
mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
things like shutdown / reinit.  Now it's true that the old
mwifiex_sdio_card_reset_work() was pretty broken on any systems that
also had SDIO bluetooth, but presumably it worked OK on systems
without SDIO Bluetooth.  I don't think it'll work so well now.

Testing shows that indeed your patch breaks mwifiex reset worse than
it was before (AKA WiFi totally fails instead of it just killing
Bluetooth).

I think it may be better to add a new API call rather than trying to
co-opt the old one.  Maybe put a WARN_ON() for the old API call to
make people move away from it, or something?


...but on the bright side, your patch does seem to work.  If I add my
patch from <https://lkml.kernel.org/r/20190722193939.125578-3-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
and change "sdio_trigger_replug(func)" to
"mmc_hw_reset(func->card->host)" then I can pass reboot tests.  I made
it through about 300 cycles of my old test before stopping the test to
work on other things.


In terms of the implementation, I will freely admit that I'm always
confused by the SD/MMC state machines, but as far as I can tell your
patch accomplishes the same thing as mine but in a bit simpler way.
;-)  I even confirmed that with your patch mmc_power_off() /
mmc_power_up are still called...

Thanks!

-Doug
