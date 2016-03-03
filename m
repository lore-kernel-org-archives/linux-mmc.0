From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 4/7] mmc: tmio: Add UHS-I mode support
Date: Thu, 3 Mar 2016 15:41:13 +0100
Message-ID: <CAPDyKFpxE3XU8ocRLTyMvBo-FPOECY7zeJAr7O1oLwKXEZ20zQ@mail.gmail.com>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
	<1455913003-6140-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455913003-6140-5-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

On 19 February 2016 at 21:16, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
>
> Based on work by Shinobu Uehara and Ben Dooks.  This adds the voltage
> switch operation needed for all UHS-I modes, but not the tuning needed
> for SDR-104 which will come later.
>
> The card_busy implementation is a bit of a guess, but works for me on
> an R8A7790 chip.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/tmio_mmc.h     |  3 +++
>  drivers/mmc/host/tmio_mmc_pio.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index b44b5890290622..aabd36955e73fb 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -101,6 +101,9 @@ struct tmio_mmc_host {
>         void (*clk_disable)(struct tmio_mmc_host *host);
>         int (*multi_io_quirk)(struct mmc_card *card,
>                               unsigned int direction, int blk_size);
> +
> +       int (*start_signal_voltage_switch)(struct tmio_mmc_host *host,
> +                                          unsigned char signal_voltage);

Do you really need to add a new tmio specific callback for this?

Why can't you instead have the tmio variant driver assign the
->start_signal_voltage_switch() callback into the struct mmc_host_ops
instead?

>  };
>
>  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index ae81b34f17a5a5..081a3def9305c1 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1012,12 +1012,43 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
>         return blk_size;
>  }
>
> +static int tmio_mmc_start_signal_voltage_switch(struct mmc_host *mmc,
> +       struct mmc_ios *ios)
> +{
> +       struct tmio_mmc_host *host = mmc_priv(mmc);
> +
> +       if (!host->start_signal_voltage_switch)
> +               return 0;
> +
> +       return host->start_signal_voltage_switch(host, ios->signal_voltage);
> +}
> +
> +static int tmio_mmc_card_busy(struct mmc_host *mmc)
> +{
> +       struct tmio_mmc_host *host = mmc_priv(mmc);
> +       u32 status;
> +
> +       pm_runtime_get_sync(mmc_dev(mmc));

This isn't needed as the mmc core already deal with runtime PM of the
host device via mmc_claim|release_host().

> +       status = sd_ctrl_read32(host, CTL_STATUS);
> +       pm_runtime_mark_last_busy(mmc_dev(mmc));
> +       pm_runtime_put_autosuspend(mmc_dev(mmc));

Ditto.

> +
> +       /*
> +        * Card signals busy by pulling down all of DAT[3:0].  This status
> +        * flag appears to reflect DAT3.
> +        */
> +       return !(status & TMIO_STAT_SIGSTATE_A);
> +}
> +
>  static const struct mmc_host_ops tmio_mmc_ops = {
>         .request        = tmio_mmc_request,
>         .set_ios        = tmio_mmc_set_ios,
>         .get_ro         = tmio_mmc_get_ro,
>         .get_cd         = mmc_gpio_get_cd,
>         .enable_sdio_irq = tmio_mmc_enable_sdio_irq,
> +       .start_signal_voltage_switch
> +                       = tmio_mmc_start_signal_voltage_switch,
> +       .card_busy      = tmio_mmc_card_busy,
>         .multi_io_quirk = tmio_multi_io_quirk,
>  };
>

Kind regards
Uffe
