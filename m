From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 33/35 linux-next] mmc: constify of_device_id array
Date: Tue, 17 Mar 2015 10:49:05 +0100
Message-ID: <CAPDyKFodW1zgrQ-sd5TPO_rCa_-tm95JkwCWiGX4BCUSFqPHdg@mail.gmail.com>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
	<1426535949-26107-1-git-send-email-fabf@skynet.be>
	<1426535949-26107-2-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426535949-26107-2-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris Ball <chris@printf.net>, Tony Prisk <linux@prisktech.co.nz>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 16 March 2015 at 20:59, Fabian Frederick <fabf@skynet.be> wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/mmc_spi.c   | 2 +-
>  drivers/mmc/host/wmt-sdmmc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index e4a0754..ae19d83 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1507,7 +1507,7 @@ static int mmc_spi_remove(struct spi_device *spi)
>         return 0;
>  }
>
> -static struct of_device_id mmc_spi_of_match_table[] = {
> +static const struct of_device_id mmc_spi_of_match_table[] = {
>         { .compatible = "mmc-spi-slot", },
>         {},
>  };
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index dd2e1aa..5af0055 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -744,7 +744,7 @@ static struct wmt_mci_caps wm8505_caps = {
>         .max_blk_size = 2048,
>  };
>
> -static struct of_device_id wmt_mci_dt_ids[] = {
> +static const struct of_device_id wmt_mci_dt_ids[] = {
>         { .compatible = "wm,wm8505-sdhc", .data = &wm8505_caps },
>         { /* Sentinel */ },
>  };
> --
> 2.1.0
>
