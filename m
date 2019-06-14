From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 4/5] mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
Date: Fri, 14 Jun 2019 14:09:45 +0200
Message-ID: <CAPDyKFrJ4+zn7Ak0tYHkBfXUtH3N7erb5R7Q+hgugchZmCRGrw@mail.gmail.com>
References: <20190613234153.59309-1-dianders@chromium.org> <20190613234153.59309-5-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613234153.59309-5-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, brcm80211-dev-list.pdl@broadcom.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Double Lo <double.lo@cypress.com>, Brian Norris <briannorris@chromium.org>, linux-wireless <linux-wireless@vger.kernel.org>, Naveen Gupta <naveen.gupta@cypress.com>, Madhan Mohan R <madhanmohan.r@cypress.com>, Matthias Kaehlcke <mka@chromium.org>, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, netdev@vger.kernel.org, brcm80211-dev-list@cypress.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, 14 Jun 2019 at 01:42, Douglas Anderson <dianders@chromium.org> wrote:
>
> We want SDIO drivers to be able to temporarily stop retuning when the
> driver knows that the SDIO card is not in a state where retuning will
> work (maybe because the card is asleep).  We'll move the relevant
> functions to a place where drivers can call them.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

This looks good to me.

BTW, seems like this series is best funneled via my mmc tree, no? In
such case, I need acks for the brcmfmac driver patches.

Kind regards
Uffe




> ---
>
> Changes in v4:
> - Moved retune hold/release to SDIO API (Adrian).
>
> Changes in v3:
> - ("mmc: core: Export mmc_retune_hold_now() mmc_retune_release()") new for v3.
>
> Changes in v2: None
>
>  drivers/mmc/core/sdio_io.c    | 40 +++++++++++++++++++++++++++++++++++
>  include/linux/mmc/sdio_func.h |  3 +++
>  2 files changed, 43 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index f822a9630b0e..1b6fe737bd72 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -15,6 +15,7 @@
>  #include "sdio_ops.h"
>  #include "core.h"
>  #include "card.h"
> +#include "host.h"
>
>  /**
>   *     sdio_claim_host - exclusively claim a bus for a certain SDIO function
> @@ -770,3 +771,42 @@ void sdio_retune_crc_enable(struct sdio_func *func)
>         func->card->host->retune_crc_disable = false;
>  }
>  EXPORT_SYMBOL_GPL(sdio_retune_crc_enable);
> +
> +/**
> + *     sdio_retune_hold_now - start deferring retuning requests till release
> + *     @func: SDIO function attached to host
> + *
> + *     This function can be called if it's currently a bad time to do
> + *     a retune of the SDIO card.  Retune requests made during this time
> + *     will be held and we'll actually do the retune sometime after the
> + *     release.
> + *
> + *     This function could be useful if an SDIO card is in a power state
> + *     where it can respond to a small subset of commands that doesn't
> + *     include the retuning command.  Care should be taken when using
> + *     this function since (presumably) the retuning request we might be
> + *     deferring was made for a good reason.
> + *
> + *     This function should be called while the host is claimed.
> + */
> +void sdio_retune_hold_now(struct sdio_func *func)
> +{
> +       mmc_retune_hold_now(func->card->host);
> +}
> +EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
> +
> +/**
> + *     sdio_retune_release - signal that it's OK to retune now
> + *     @func: SDIO function attached to host
> + *
> + *     This is the complement to sdio_retune_hold_now().  Calling this
> + *     function won't make a retune happen right away but will allow
> + *     them to be scheduled normally.
> + *
> + *     This function should be called while the host is claimed.
> + */
> +void sdio_retune_release(struct sdio_func *func)
> +{
> +       mmc_retune_release(func->card->host);
> +}
> +EXPORT_SYMBOL_GPL(sdio_retune_release);
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
> index 4820e6d09dac..5a177f7a83c3 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -170,4 +170,7 @@ extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
>  extern void sdio_retune_crc_disable(struct sdio_func *func);
>  extern void sdio_retune_crc_enable(struct sdio_func *func);
>
> +extern void sdio_retune_hold_now(struct sdio_func *func);
> +extern void sdio_retune_release(struct sdio_func *func);
> +
>  #endif /* LINUX_MMC_SDIO_FUNC_H */
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
