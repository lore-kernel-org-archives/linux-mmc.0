From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
Date: Mon, 11 Nov 2019 16:33:26 -0800
Message-ID: <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <20191109103046.26445-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191109103046.26445-4-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6f8342702c73..abf8f5eb0a1c 100644
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
> @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>         ret = host->bus_ops->hw_reset(host);
>         mmc_bus_put(host);
>
> -       if (ret)
> +       if (ret < 0)
>                 pr_warn("%s: tried to HW reset card, got error %d\n",
>                         mmc_hostname(host), ret);

Other callers besides marvell need to be updated?  In theory only SDIO
should have positive return values so I guess we don't care about the
caller in drivers/mmc/core/block.c, right?  What about:

drivers/net/wireless/ath/ath10k/sdio.c

...I guess I don't know if there is more than one function probed
there.  Maybe there's not and thus we're fine here too?


I didn't spend massive amounts of time looking for potential problems,
but in general seems workable to me.  Thanks!

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
