From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/2] mmc: host: sh_mobile_sdhi: don't populate unneeded functions
Date: Fri, 2 Sep 2016 11:26:16 +0900
Message-ID: <CANqRtoTJWN52roRwJHh1cZrb2Jqf5OD-ffjKgiW4Y5jqCeVzhg@mail.gmail.com>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com> <20160824093438.2478-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160824093438.2478-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 24, 2016 at 6:34 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Populating card_busy caused a side-effect on a chip variant we don't
> have documentation for (r8a73a4). So, enable it and voltage switching
> only on devices known to support those features.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index c4e63b7790d719..d679c8a533b6e5 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -376,8 +376,14 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         host->clk_update        = sh_mobile_sdhi_clk_update;
>         host->clk_disable       = sh_mobile_sdhi_clk_disable;
>         host->multi_io_quirk    = sh_mobile_sdhi_multi_io_quirk;
> -       host->card_busy = sh_mobile_sdhi_card_busy;
> -       host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
> +
> +       /* SDR speeds are only available on Gen2+ */
> +       if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
> +               /* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
> +               host->card_busy = sh_mobile_sdhi_card_busy;
> +               host->start_signal_voltage_switch =
> +                       sh_mobile_sdhi_start_signal_voltage_switch;
> +       }
>
>         /* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
>         if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
> --
> 2.9.3
>

Hi Wolfram,

Thanks for your efforts improving the code. The patch title says
something about unneeded functions, and then comments in the code
mentions SDR which makes me interested to dig a bit deeper. I know
that the SDHI hardware is supported on a wide range of hardware so I
wonder how you handle all the callbacks for such a wide range of
hardware with varying level of documentation.

Many years ago when I initially prototyped the SDHI driver we had no
access to any documentation - only the reverse engineered TMIO driver
and the register definitions in that driver existed. I remember being
very happy being able to remove some firmware binary used for register
access and fully rely on open source to access the hardware. These
days I believe developers have access to documentation for at least
the most recent hardware, however older SDHI hardware may still be
undocumented.

To my eye it looks like this patch might be adding a fix for a bug
introduced by another patch. R-Car Gen2 and later are quite recent
SoCs but I believe support for other mobile chips and earlier R-Car
SoCs also also covered by the SDHI driver. Also there are theTMIO
chips that share some software and are related but a bit different. So
in my opinion we need to thread lightly to avoid breakage.

I'm currently looking at this commit included in
renesas-drivers-2016-08-30-v4.8-rc4:
d11b9b7 mmc: host: sh_mobile_sdhi: don't populate unneeded functions

The code adds a feature flag check and in case of more recent hardware
the following callbacks are installed:
host->card_busy()
host->start_signal_voltage_switch()
Also the comment "/* SDR speeds are only available on Gen2+ */" was added.

My concern is what happened before this patch was applied. It looks
like the callbacks were installed for all hardware types which makes
me wonder because UHS/SDR support is only available for quite recent
hardware.

The ->card_busy() callback is not yet in mainline or -next. It was
introduced in:
0157290 mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi

However the ->start_signal_voltage_switch() is included in mainline.
It was introduced in:
057a459 mmc: sh_mobile_sdhi: Add UHS-I mode support

If this patch is fixing a recent commit then perhaps some patches
should be squashed together to prevent bisection breakage or if a
patch is already part of mainline then a "Fixes:" tag might be
suitable.

Thanks,

/ magnus
