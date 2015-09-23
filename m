From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: Fix clk-delay settings
Date: Wed, 23 Sep 2015 23:50:24 +0200
Message-ID: <CAPDyKFpOFLgAAH5cVo-v+atfXYz=H7vxLH-BEzCA_i1Cu6wTFg@mail.gmail.com>
References: <1443038808-10965-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37606 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbIWVu0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 17:50:26 -0400
Received: by wicfx3 with SMTP id fx3so88386158wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2015 14:50:25 -0700 (PDT)
In-Reply-To: <1443038808-10965-1-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <chris@printf.net>, Mike Turquette <mturquette@linaro.org>, Jelle van der Waa <jelle@vdwaa.nl>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-sunxi@googlegroups.com

On 23 September 2015 at 22:06, Hans de Goede <hdegoede@redhat.com> wrote:
> In recent allwinner kernel sources the mmc clk-delay settings have been
> slightly tweaked, and for sun9i they are completely different then what
> we are using.
>
> This commit brings us in sync with what allwinner does, fixing problems
> accessing sdcards on some A33 devices (and likely others).
>
> For pre sun9i hardware this makes the following changes:
> -At 400Khz change the sample delay from 7 to 0 (introduced in A31 sdk)
> -At 50 Mhz change the sample delay from 5 to 4 (introduced in A23 sdk)
>
> This also drops the clk-delay calculation for clocks > 50 MHz, we do
> not need this as we've: mmc->f_max = 50000000, and the delays in the
> old code were not correct (at 100 MHz the delay must be a multiple of 60,
> at 200 MHz a multiple of 120).
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I assume you want me to take this as a fix? If so, can we point to
what commit it fixes?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 53 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e6226cd..83de82b 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -210,6 +210,16 @@
>  #define SDXC_IDMAC_DES0_CES    BIT(30) /* card error summary */
>  #define SDXC_IDMAC_DES0_OWN    BIT(31) /* 1-idma owns it, 0-host owns it */
>
> +#define SDXC_CLK_400K          0
> +#define SDXC_CLK_25M           1
> +#define SDXC_CLK_50M           2
> +#define SDXC_CLK_50M_DDR       3
> +
> +struct sunxi_mmc_clk_delay {
> +       u32 output;
> +       u32 sample;
> +};
> +
>  struct sunxi_idma_des {
>         u32     config;
>         u32     buf_size;
> @@ -229,6 +239,7 @@ struct sunxi_mmc_host {
>         struct clk      *clk_mmc;
>         struct clk      *clk_sample;
>         struct clk      *clk_output;
> +       const struct sunxi_mmc_clk_delay *clk_delays;
>
>         /* irq */
>         spinlock_t      lock;
> @@ -654,25 +665,19 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>
>         /* determine delays */
>         if (rate <= 400000) {
> -               oclk_dly = 180;
> -               sclk_dly = 42;
> +               oclk_dly = host->clk_delays[SDXC_CLK_400K].output;
> +               sclk_dly = host->clk_delays[SDXC_CLK_400K].sample;
>         } else if (rate <= 25000000) {
> -               oclk_dly = 180;
> -               sclk_dly = 75;
> +               oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
> +               sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
>         } else if (rate <= 50000000) {
>                 if (ios->timing == MMC_TIMING_UHS_DDR50) {
> -                       oclk_dly = 60;
> -                       sclk_dly = 120;
> +                       oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
> +                       sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
>                 } else {
> -                       oclk_dly = 90;
> -                       sclk_dly = 150;
> +                       oclk_dly = host->clk_delays[SDXC_CLK_50M].output;
> +                       sclk_dly = host->clk_delays[SDXC_CLK_50M].sample;
>                 }
> -       } else if (rate <= 100000000) {
> -               oclk_dly = 6;
> -               sclk_dly = 24;
> -       } else if (rate <= 200000000) {
> -               oclk_dly = 3;
> -               sclk_dly = 12;
>         } else {
>                 return -EINVAL;
>         }
> @@ -878,6 +883,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
>  static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun4i-a10-mmc", },
>         { .compatible = "allwinner,sun5i-a13-mmc", },
> +       { .compatible = "allwinner,sun9i-a80-mmc", },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> @@ -892,6 +898,20 @@ static struct mmc_host_ops sunxi_mmc_ops = {
>         .card_busy       = sunxi_mmc_card_busy,
>  };
>
> +static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
> +       [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
> +       [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
> +       [SDXC_CLK_50M]          = { .output =  90, .sample = 120 },
> +       [SDXC_CLK_50M_DDR]      = { .output =  60, .sample = 120 },
> +};
> +
> +static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
> +       [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
> +       [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
> +       [SDXC_CLK_50M]          = { .output = 150, .sample = 120 },
> +       [SDXC_CLK_50M_DDR]      = { .output =  90, .sample = 120 },
> +};
> +
>  static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                                       struct platform_device *pdev)
>  {
> @@ -903,6 +923,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>         else
>                 host->idma_des_size_bits = 16;
>
> +       if (of_device_is_compatible(np, "allwinner,sun9i-a80-mmc"))
> +               host->clk_delays = sun9i_mmc_clk_delays;
> +       else
> +               host->clk_delays = sunxi_mmc_clk_delays;
> +
>         ret = mmc_regulator_get_supply(host->mmc);
>         if (ret) {
>                 if (ret != -EPROBE_DEFER)
> --
> 2.5.0
>
