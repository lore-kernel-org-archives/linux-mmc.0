From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci: introduce sdhci_compute_clock_config
Date: Mon, 4 Apr 2016 16:24:36 +0200
Message-ID: <CAPDyKFpgrdcTFukpOa7MvHrsBx9ajVoUWo5D2Q+Q5xoexE35rg@mail.gmail.com>
References: <1459778405-17218-1-git-send-email-ludovic.desroches@atmel.com>
	<1459778405-17218-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33929 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbcDDOYj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 10:24:39 -0400
Received: by mail-lb0-f179.google.com with SMTP id vo2so164246602lbb.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 07:24:38 -0700 (PDT)
In-Reply-To: <1459778405-17218-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

On 4 April 2016 at 16:00, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> In order to remove the SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST and to
> reduce code duplication, put the code relative to the SD clock
> configuration in a function which can be used by hosts for the
> implementation of the set_clock() callback.

I like this as it moves the code into the "library direction".

>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/sdhci.c | 43 ++++++++++++++++++++++++++-----------------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6bd3d17..ee095df 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1091,34 +1091,24 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>         return preset;
>  }
>
> -void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +void sdhci_compute_clock_config(struct sdhci_host *host, unsigned int clock,
> +                               u16 *clk_reg)

I would prefer that the value is returned as the result, instead of
providing it as an out-parameter.

>  {
>         int div = 0; /* Initialized for compiler warning */
>         int real_div = div, clk_mul = 1;
> -       u16 clk = 0;
> -       unsigned long timeout;
>         bool switch_base_clk = false;
>
> -       host->mmc->actual_clock = 0;
> -
> -       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> -       if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> -               mdelay(1);
> -
> -       if (clock == 0)
> -               return;
> -
>         if (host->version >= SDHCI_SPEC_300) {
>                 if (host->preset_enabled) {
>                         u16 pre_val;
>
> -                       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +                       *clk_reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>                         pre_val = sdhci_get_preset_value(host);
>                         div = (pre_val & SDHCI_PRESET_SDCLK_FREQ_MASK)
>                                 >> SDHCI_PRESET_SDCLK_FREQ_SHIFT;
>                         if (host->clk_mul &&
>                                 (pre_val & SDHCI_PRESET_CLKGEN_SEL_MASK)) {
> -                               clk = SDHCI_PROG_CLOCK_MODE;
> +                               *clk_reg = SDHCI_PROG_CLOCK_MODE;
>                                 real_div = div + 1;
>                                 clk_mul = host->clk_mul;
>                         } else {
> @@ -1142,7 +1132,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>                                  * Set Programmable Clock Mode in the Clock
>                                  * Control register.
>                                  */
> -                               clk = SDHCI_PROG_CLOCK_MODE;
> +                               *clk_reg = SDHCI_PROG_CLOCK_MODE;
>                                 real_div = div;
>                                 clk_mul = host->clk_mul;
>                                 div--;
> @@ -1185,9 +1175,28 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  clock_set:
>         if (real_div)
>                 host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
> -       clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> -       clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
> +       *clk_reg |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> +       *clk_reg |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>                 << SDHCI_DIVIDER_HI_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_compute_clock_config);
> +
> +void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +       u16 clk = 0;
> +       unsigned long timeout;
> +
> +       host->mmc->actual_clock = 0;
> +
> +       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +       if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> +               mdelay(1);
> +
> +       if (clock == 0)
> +               return;
> +
> +       sdhci_compute_clock_config(host, clock, &clk);
> +
>         clk |= SDHCI_CLOCK_INT_EN;
>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0f39f4f..4215eb7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -661,6 +661,8 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
>         return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
>  }
>
> +void sdhci_compute_clock_config(struct sdhci_host *host, unsigned int clock,
> +                               u16 *clk_reg);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
>  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>                      unsigned short vdd);
> --
> 2.5.0
>

Kind regards
Uffe
