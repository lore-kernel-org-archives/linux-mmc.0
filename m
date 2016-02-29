From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 1/7] pinctrl: sh-pfc: r8a7790: Implement voltage switching
 for SDHI
Date: Mon, 29 Feb 2016 11:53:52 +0100
Message-ID: <CAMuHMdXQWfYGRAuA-o+baN2dWnx-G1fOtRTU8xApZTxc5h_Sbg@mail.gmail.com>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
	<1455913003-6140-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455913003-6140-2-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Fri, Feb 19, 2016 at 9:16 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> All the SHDIs can operate with either 3.3V or 1.8V signals, depending
> on negotiation with the card.
>
> Implement the {get,set}_io_voltage operations and set the related
> capability flag for the associated pins.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Shouldn't the "From" line have Ben's authorship, too?
You can list your modifications in "[...]".

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks!

> Cc: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>
> The get/set-functions introduced here are the same for all Gen2, except for
> the pin-sanity checks at the beginning. Somehow a generic function might be
> nice for consistency reasons (I don't care so much about the code savings).
> But not sure if it is worth the hazzle.
>
> @Uli, Geert: Since bias support is probably similar, what do you think? Does
> it make sense to add gen{2,3}.c?

It's up to you.
We can always consolidate later.

>  drivers/pinctrl/sh-pfc/core.c        |  2 +-
>  drivers/pinctrl/sh-pfc/core.h        |  1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 60 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 181ea98a63b7ab..315f9db9f5affe 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -88,7 +88,7 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
>         return 0;
>  }
>
> -static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
> +void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)

You don't need to make sh_pfc_phys_to_virt() non-static...

>  {
>         struct sh_pfc_window *window;
>         phys_addr_t address = reg;
> diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
> index 62f53b22ae8500..ca041a753a2521 100644
> --- a/drivers/pinctrl/sh-pfc/core.h
> +++ b/drivers/pinctrl/sh-pfc/core.h
> @@ -59,6 +59,7 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
>  int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
>  int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
>
> +void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 address);

... and declare it...

>  u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
>  void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
>                           u32 data);
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> index 0f4d48f9400ba0..ed51d67609050d 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c

> @@ -4691,6 +4696,53 @@ static const char * const vin3_groups[] = {
>         "vin3_clk",
>  };
>
> +#define IOCTRL6 0xe606008c

... if you use 0x8c here...

> +static int r8a7790_get_io_voltage(struct sh_pfc *pfc, unsigned int pin)
> +{
> +       void __iomem *reg;
> +       u32 data, mask;
> +
> +       if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31), "invalid pin %#x", pin))
> +               return -EINVAL;
> +
> +       reg = sh_pfc_phys_to_virt(pfc, IOCTRL6);

... and use "pfc->windows->virt + IOCTRL6" here and in
r8a7790_set_io_voltage(), cfr. r8a7778_pinmux_get_bias().

> +       data = ioread32(reg);
> +
> +       /* Bits in IOCTRL6 are numbered in opposite order to pins */
> +       mask = 0x80000000 >> (pin & 0x1f);
> +
> +       return (data & mask) ? 3300 : 1800;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
