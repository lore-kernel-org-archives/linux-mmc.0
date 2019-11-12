From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
Date: Mon, 11 Nov 2019 16:33:45 -0800
Message-ID: <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <20191109103046.26445-2-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191109103046.26445-2-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
> when the SDIO card is shared with another SDIO func driver. This is the
> case when the Bluetooth btmrvl driver is being used in combination with
> mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
> the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
> point, the btmrvl driver will fail to communicate with the SDIO card.
>
> This is a generic problem for SDIO func drivers sharing an SDIO card, which
> are about to be addressed in subsequent changes to the mmc core and the
> mmc_hw_reset() interface. In principle, these changes means the
> mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
> the SDIO card, as to indicate to the caller that the reset needed to be
> scheduled asynchronously through a hotplug mechanism of the SDIO card.
>
> Let's prepare the mwifiex driver to support the upcoming new behaviour of
> mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
> support the asynchronous SDIO HW reset path. This also means, we need to
> allow the ->remove() callback to run, without waiting for the FW to be
> loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
> called when a reset has been scheduled, but waiting to be executed. In this
> scenario let's simply return -EBUSY to abort the suspend process, as to
> allow the reset to be completed first.
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
>  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
>  3 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index a9657ae6d782..dbdbdd6769a9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -76,6 +76,7 @@ static int mwifiex_register(void *card, struct device *dev,
>         *padapter = adapter;
>         adapter->dev = dev;
>         adapter->card = card;
> +       adapter->is_adapter_up = false;

Probably not needed.  The 'adapter' was kzalloc-ed a few lines above
and there's no need to re-init to 0.


> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index 24c041dad9f6..2417c94c29c0 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
>                 return 0;
>         }
>
> +       if (!adapter->is_adapter_up)
> +               return -EBUSY;

I'm moderately concerned that there might be cases where firmware
never got loaded but we could suspend/resume OK.  ...and now we never
will?  I'm not familiar enough with the code to know if this is a real
concern, so I guess we can do this and then see...


> @@ -2220,22 +2223,30 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
>         struct sdio_func *func = card->func;
>         int ret;
>
> +       /* Prepare the adapter for the reset. */
>         mwifiex_shutdown_sw(adapter);
> +       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> +       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
>
> -       /* power cycle the adapter */
> +       /* Run a HW reset of the SDIO interface. */
>         sdio_claim_host(func);
> -       mmc_hw_reset(func->card->host);
> +       ret = mmc_hw_reset(func->card->host);
>         sdio_release_host(func);
>
> -       /* Previous save_adapter won't be valid after this. We will cancel
> -        * pending work requests.
> -        */
> -       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> -       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);

I don't know enough about the clearing of these bits to confirm that
it's OK to move their clearing to be before the mmc_hw_reset().
Possibly +Brian Norris does?


I can't promise that I didn't miss anything, but to the best of my
knowledge this is good now:

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
