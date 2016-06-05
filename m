From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: Add support to the Allwinner A83T
Date: Sun, 5 Jun 2016 20:58:42 +0800
Message-ID: <CAGb2v66JbDjOQdMGDnzsToiXK9ub91m0i4dbkoXtVf0MwURWOQ@mail.gmail.com>
References: <20160604100253.7141B2DE7D@muse.csie.ntu.edu.tw>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBGWE2C5AKGQEPDO2TNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160604100253.7141B2DE7D-Jpzvh7getMvJf3mlLi/bRIJY59XmG8rH@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, Jun 4, 2016 at 6:01 PM, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org> wrote:
> The A83T has different clock delays.
> The values have been adapted from the Banana Pi M3 driver.
>
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  3 ++-
>  drivers/mmc/host/sunxi-mmc.c                        | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 4bf41d8..45b8520 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -8,7 +8,8 @@ as the speed of SD standard 3.0.
>  Absolute maximum transfer rate is 200MB/s
>
>  Required properties:
> - - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
> + - compatible : "allwinner,sun4i-a10-mmc", "allwinner,sun5i-a13-mmc",
> +       "allwinner,sun8i-a83t-mmc" or "allwinner,sun9i-a80-mmc"
>   - reg : mmc controller base registers
>   - clocks : a list with 4 phandle + clock specifier pairs
>   - clock-names : must contain "ahb", "mmc", "output" and "sample"
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7fc8b7a..707e705 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -941,6 +941,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
>  static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun4i-a10-mmc", },
>         { .compatible = "allwinner,sun5i-a13-mmc", },
> +       { .compatible = "allwinner,sun8i-a83t-mmc", },
>         { .compatible = "allwinner,sun9i-a80-mmc", },
>         { /* sentinel */ }
>  };
> @@ -962,10 +963,17 @@ static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
>         [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
>         [SDXC_CLK_50M]          = { .output =  90, .sample = 120 },
>         [SDXC_CLK_50M_DDR]      = { .output =  60, .sample = 120 },
> -       /* Value from A83T "new timing mode". Works but might not be right. */

Please don't remove this. It was how I found a working value. Until we figure
out an actual correct value, the warning should stay there.

>         [SDXC_CLK_50M_DDR_8BIT] = { .output =  90, .sample = 180 },
>  };
>
> +static const struct sunxi_mmc_clk_delay sun8i_a83t_mmc_clk_delays[] = {
> +       [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
> +       [SDXC_CLK_25M]          = { .output = 180, .sample =  50 },
> +       [SDXC_CLK_50M]          = { .output =  60, .sample =  50 },

These 2 don't look right.

> +       [SDXC_CLK_50M_DDR]      = { .output =  180, .sample = 90 },
> +       [SDXC_CLK_50M_DDR_8BIT] = { .output =  180, .sample = 90 },

Nor does this one. As explained in the comment from the clock driver:

    We can only outphase the clocks by multiple of the PLL's period.

    Since the MMC clock in only a divider, and the formula to get the
    outphasing in degrees is deg = 360 * delta / period

Now, for the fishy ones I mentioned, MMC clock = card clock (or card * 2
for DDR 8 bit), and parent clock is PLL6 @ 600 MHz. A step would be 15,
30 or 60 degrees. Thus you cannot get an outphasing of 50 degrees, or 90
degrees for 50M DDR 8bit.

Could you provide a link to the original driver? Or perhaps just the
original delay values?

The values do work better on my Cubietruck plus, giving a throughput
of 36 MB/s read, instead of 17 MB/s with the original values. However
that is still only half of what it should be capable of. I will test
my BPI M3 tomorrow.


Regards
ChenYu

> +};
> +
>  static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
>         [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
>         [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
> @@ -987,6 +995,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>
>         if (of_device_is_compatible(np, "allwinner,sun9i-a80-mmc"))
>                 host->clk_delays = sun9i_mmc_clk_delays;
> +       else if (of_device_is_compatible(np, "allwinner,sun8i-a83t-mmc"))
> +               host->clk_delays = sun8i_a83t_mmc_clk_delays;
>         else
>                 host->clk_delays = sunxi_mmc_clk_delays;
>
> --
> 2.8.3
>
