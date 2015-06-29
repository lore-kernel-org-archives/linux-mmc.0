From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/6] pinctrl: sh-pfc: Implement pinconf power-source
 param for voltage switching
Date: Mon, 29 Jun 2015 10:17:30 +0200
Message-ID: <CAMuHMdXk7GZDQ2sexTy5E9-9xOMm6GLnyUgS_e034uFmPqQ2gw@mail.gmail.com>
References: <1435332116.23818.7.camel@codethink.co.uk>
	<1435332204.23818.9.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435332204.23818.9.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 26, 2015 at 5:23 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> The pfc in the R8A7790 (and probably others in the R-Car gen 2 family)
> supports switching SDHI signals between 3.3V and 1.8V voltage, and the
> SD driver should do that when selecting a higher-speed mode.
>
> Add a flag for pins that support low voltage mode and SoC operations to
> get and set it.  Implement the pinconf power-source parameter using these
> operations.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  4 ++-
>  drivers/pinctrl/sh-pfc/pinctrl.c                   | 34 ++++++++++++++++++++--
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |  6 ++++
>  3 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> index bfe72ec055e3..93651742f1c1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> @@ -69,7 +69,9 @@ Pin Configuration Node Properties:
>
>  The pin configuration parameters use the generic pinconf bindings defined in
>  pinctrl-bindings.txt in this directory. The supported parameters are
> -bias-disable, bias-pull-up and bias-pull-down.
> +bias-disable, bias-pull-up, bias-pull-down and power-source. For pins that
> +can operate with either 3.3V or 1.8V signals, the power-source value should
> +be 0 for 3.3V or 1 for 1.8V.

> @@ -121,6 +125,8 @@ struct sh_pfc_soc_operations {
>         unsigned int (*get_bias)(struct sh_pfc *pfc, unsigned int pin);
>         void (*set_bias)(struct sh_pfc *pfc, unsigned int pin,
>                          unsigned int bias);
> +       bool (*get_low_voltage)(struct sh_pfc *pfc, unsigned int pin);
> +       void (*set_low_voltage)(struct sh_pfc *pfc, unsigned int pin, bool low);
>  };

Given the sh-pfc driver is used for a whole range of SoCs, I think a boolean
value is a bit too limiting.

E.g. In addition to 1.8V and 3.3 V, R-Car M2 has pins supporting three
voltage levels (1.35V, 1.5V, and 18.V).
R-Mobile APE6 supports 1.2V, 1.8V, and 3.3V, but max. only 2 out of 3 for
a single pin.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
