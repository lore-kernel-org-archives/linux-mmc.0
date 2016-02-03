From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 2/8] pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
Date: Wed, 03 Feb 2016 11:59:34 +0200
Message-ID: <3375560.xz1gJhmReB@avalon>
References: <1435683177.23818.60.camel@codethink.co.uk> <6355006.FnTDFbP0bb@avalon> <1435879310.7541.2.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435879310.7541.2.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

Just realized this mail thread fell through the cracks, sorry :-/

On Friday 03 July 2015 00:21:50 Ben Hutchings wrote:
> On Wed, 2015-07-01 at 10:37 +0300, Laurent Pinchart wrote:
> [...]
> 
> > > +#define PIN_IO_VOLTAGE(bank, _pin, _name, sfx)		\
> > > +	[RCAR_GP_PIN(bank, _pin)].configs = SH_PFC_PIN_CFG_IO_VOLTAGE
> > > +
> > > 
> > >  static const struct sh_pfc_pin pinmux_pins[] = {
> > >  
> > >  	PINMUX_GPIO_GP_ALL(),
> > > 
> > > -	/* Pins not associated with a GPIO port */
> > > +	/*
> > > +	 * All pins assigned to GPIO bank 3 can be used for SD interfaces
> > > +	 * in which case they support both 3.3V and 1.8V signalling.
> > > +	 */
> > > +	PORT_GP_32(3, PIN_IO_VOLTAGE, unused),
> > > +
> > > +	/* Pins not associated with a GPIO port, placed after all the GPIOs 
*/
> > > +	[RCAR_GP_PIN(5, 31) + 1] =
> > 
> > I'm sorry but I still don't like this. gcc outputs a warning when
> > overriding an initializer if you enable -Wextra, which leads me to
> > believe this construct is dubious. It should at least be tested with
> > LLVM.
> > 
> > I'd much prefer replacing PINMUX_GPIO_GP_ALL() with a version that will
> > initialize the pins correctly right away.
> 
> [...]
> 
> Something like this?
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-emev2.c
> b/drivers/pinctrl/sh-pfc/pfc-emev2.c index 849c6943ed30..ad1a8281a91b
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-emev2.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-emev2.c
> @@ -228,7 +228,7 @@ enum {
> 
>  /* Expand to a list of sh_pfc_pin entries (named PORT#).
>   * NOTE: No config are recorded since the driver do not handle pinconf. */
> -#define __PIN_CFG(pn, pfx, sfx)  SH_PFC_PIN_CFG(pfx, 0)
> +#define __PIN_CFG(pn, pfx, sfx)  SH_PFC_PORT_CFG(pfx, 0)
>  #define PINMUX_EMEV_GPIO_ALL()	  CPU_ALL_PORT(__PIN_CFG, , unused)
> 
>  static const struct sh_pfc_pin pinmux_pins[] = {
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c index 280a56f97786..ca1538371563
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> @@ -1272,8 +1272,8 @@ static const u16 pinmux_data[] = {
>  #define __IO	(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
>  #define __PUD	(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
> 
> -#define R8A73A4_PIN_IO_PU_PD(pin)       SH_PFC_PIN_CFG(pin, __IO | __PUD)
> -#define R8A73A4_PIN_O(pin)              SH_PFC_PIN_CFG(pin, __O)
> +#define R8A73A4_PIN_IO_PU_PD(pin)       SH_PFC_PORT_CFG(pin, __IO | __PUD)
> +#define R8A73A4_PIN_O(pin)              SH_PFC_PORT_CFG(pin, __O)
> 
>  static const struct sh_pfc_pin pinmux_pins[] = {
>  	R8A73A4_PIN_IO_PU_PD(0), R8A73A4_PIN_IO_PU_PD(1),
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index b486e9d20cc2..92939cbd7ad0
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -1535,15 +1535,15 @@ static const u16 pinmux_data[] = {
>  #define __PU		(SH_PFC_PIN_CFG_PULL_UP)
>  #define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
> 
> -#define R8A7740_PIN_I_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PD)
> -#define R8A7740_PIN_I_PU(pin)		SH_PFC_PIN_CFG(pin, __I | __PU)
> -#define R8A7740_PIN_I_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __I | __PUD)
> -#define R8A7740_PIN_IO(pin)		SH_PFC_PIN_CFG(pin, __IO)
> -#define R8A7740_PIN_IO_PD(pin)		SH_PFC_PIN_CFG(pin, __IO | __PD)
> -#define R8A7740_PIN_IO_PU(pin)		SH_PFC_PIN_CFG(pin, __IO | __PU)
> -#define R8A7740_PIN_IO_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __IO | __PUD)
> -#define R8A7740_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
> -#define R8A7740_PIN_O_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __O | __PUD)
> +#define R8A7740_PIN_I_PD(pin)		SH_PFC_PORT_CFG(pin, __I | __PD)
> +#define R8A7740_PIN_I_PU(pin)		SH_PFC_PORT_CFG(pin, __I | __PU)
> +#define R8A7740_PIN_I_PU_PD(pin)	SH_PFC_PORT_CFG(pin, __I | __PUD)
> +#define R8A7740_PIN_IO(pin)		SH_PFC_PORT_CFG(pin, __IO)
> +#define R8A7740_PIN_IO_PD(pin)		SH_PFC_PORT_CFG(pin, __IO | __PD)
> +#define R8A7740_PIN_IO_PU(pin)		SH_PFC_PORT_CFG(pin, __IO | __PU)
> +#define R8A7740_PIN_IO_PU_PD(pin)	SH_PFC_PORT_CFG(pin, __IO | __PUD)
> +#define R8A7740_PIN_O(pin)		SH_PFC_PORT_CFG(pin, __O)
> +#define R8A7740_PIN_O_PU_PD(pin)	SH_PFC_PORT_CFG(pin, __O | __PUD)
> 
>  static const struct sh_pfc_pin pinmux_pins[] = {
>  	/* Table 56-1 (I/O and Pull U/D) */
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 1137bbc810cd..1e59e1775374
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -1740,20 +1740,23 @@ static const u16 pinmux_data[] = {
>  #define PIN_NUMBER(r, c) (((r) - 'A') * 31 + (c) + 200)
>  #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
> 
> -#define PIN_IO_VOLTAGE(bank, _pin, _name, sfx)		\
> -	[RCAR_GP_PIN(bank, _pin)].configs = SH_PFC_PIN_CFG_IO_VOLTAGE
> +/*
> + * All pins assigned to GPIO bank 3 can be used for SD interfaces in
> + * which case they support both 3.3V and 1.8V signalling.
> + */
> +#define GP_GPIO_IO_VOLTAGE(bank, _pin, _name, sfx)			\
> +	[RCAR_GP_PIN(bank, _pin)] =					\
> +		SH_PFC_GPIO_CFG(bank, _pin, _name, SH_PFC_PIN_CFG_IO_VOLTAGE)
> 
>  static const struct sh_pfc_pin pinmux_pins[] = {
> -	PINMUX_GPIO_GP_ALL(),
> -
> -	/*
> -	 * All pins assigned to GPIO bank 3 can be used for SD interfaces
> -	 * in which case they support both 3.3V and 1.8V signalling.
> -	 */
> -	PORT_GP_32(3, PIN_IO_VOLTAGE, unused),
> +	PORT_GP_32(0, _GP_GPIO, unused),
> +	PORT_GP_32(1, _GP_GPIO, unused),
> +	PORT_GP_32(2, _GP_GPIO, unused),
> +	PORT_GP_32(3, GP_GPIO_IO_VOLTAGE, unused),
> +	PORT_GP_32(4, _GP_GPIO, unused),
> +	PORT_GP_32(5, _GP_GPIO, unused),
> 
>  	/* Pins not associated with a GPIO port, placed after all the GPIOs */
> -	[RCAR_GP_PIN(5, 31) + 1] =
>  	SH_PFC_PIN_NAMED(ROW_GROUP_A('F'), 15, AF15),
>  	SH_PFC_PIN_NAMED(ROW_GROUP_A('G'), 15, AG15),
>  	SH_PFC_PIN_NAMED(ROW_GROUP_A('H'), 15, AH15),
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c index d2efbfb776ac..2c798550cd8c
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> @@ -1166,14 +1166,14 @@ static const u16 pinmux_data[] = {
>  #define __PU		(SH_PFC_PIN_CFG_PULL_UP)
>  #define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
> 
> -#define SH73A0_PIN_I_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PD)
> -#define SH73A0_PIN_I_PU(pin)		SH_PFC_PIN_CFG(pin, __I | __PU)
> -#define SH73A0_PIN_I_PU_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PUD)
> -#define SH73A0_PIN_IO(pin)		SH_PFC_PIN_CFG(pin, __IO)
> -#define SH73A0_PIN_IO_PD(pin)		SH_PFC_PIN_CFG(pin, __IO | __PD)
> -#define SH73A0_PIN_IO_PU(pin)		SH_PFC_PIN_CFG(pin, __IO | __PU)
> -#define SH73A0_PIN_IO_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __IO | __PUD)
> -#define SH73A0_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
> +#define SH73A0_PIN_I_PD(pin)		SH_PFC_PORT_CFG(pin, __I | __PD)
> +#define SH73A0_PIN_I_PU(pin)		SH_PFC_PORT_CFG(pin, __I | __PU)
> +#define SH73A0_PIN_I_PU_PD(pin)		SH_PFC_PORT_CFG(pin, __I | __PUD)
> +#define SH73A0_PIN_IO(pin)		SH_PFC_PORT_CFG(pin, __IO)
> +#define SH73A0_PIN_IO_PD(pin)		SH_PFC_PORT_CFG(pin, __IO | __PD)
> +#define SH73A0_PIN_IO_PU(pin)		SH_PFC_PORT_CFG(pin, __IO | __PU)
> +#define SH73A0_PIN_IO_PU_PD(pin)	SH_PFC_PORT_CFG(pin, __IO | __PUD)
> +#define SH73A0_PIN_O(pin)		SH_PFC_PORT_CFG(pin, __O)
> 
>  /* Pin numbers for pins without a corresponding GPIO port number are
> computed * from the row and column numbers with a 1000 offset to avoid
> collisions with diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 734f7a92229c..3eca740bba02 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -272,14 +272,18 @@ struct sh_pfc_soc_info {
>  		.enum_id = _pin##_DATA,					\
>  	}
> 
> -/* SH_PFC_PIN_CFG - Expand to a sh_pfc_pin entry (named PORT#) with config
> */
> -#define SH_PFC_PIN_CFG(_pin, cfgs)					\
> +/* SH_PFC_{PORT,GPIO}_CFG - Expand to a sh_pfc_pin entry with config */
> +#define _SH_PFC_PIN_CFG(_pin, _name, cfgs)				\
>  	{								\
>  		.pin = _pin,						\
> -		.name = __stringify(PORT##_pin),			\
> -		.enum_id = PORT##_pin##_DATA,				\
> +		.name = __stringify(_name),				\
> +		.enum_id = _name##_DATA,				\
>  		.configs = cfgs,					\
>  	}
> +#define SH_PFC_PORT_CFG(_pin, cfgs)				\
> +	_SH_PFC_PIN_CFG(PORT##_pin, PORT##_pin, cfgs)
> +#define SH_PFC_GPIO_CFG(bank, _pin, _name, cfgs)		\
> +	_SH_PFC_PIN_CFG((bank * 32) + _pin, _name, cfgs)
> 
>  /* SH_PFC_PIN_NAMED - Expand to a sh_pfc_pin entry with the given name */
>  #define SH_PFC_PIN_NAMED(row, col, _name)				\
> --- END ---
> 
> If you're happy with that, I'll re-send the series (hopefully for the
> last time!) with the r8a7790 changes squashed into "pinctrl: sh-pfc:
> r8a7790: Implement voltage switching for SDHI" and the SH_PFC_PIN_CFG
> macro change as a new patch before it.

That looks good to me. I'd split it in two patches though, one that reworks 
the existing macros (the drivers/pinctrl/sh-pfc/sh_pfc.h changes) and one that 
implements voltage switching for SDHI on r8a7790.

I would also avoid renaming SH_PFC_PIN_CFG to SH_PFC_PORT_CFG to avoid 
modifying unrelated files, you can name the low-level macro __SH_PFC_PIN_CFG 
and add

#define SH_PFC_PIN_CFG(_pin, cfgs)				\
	__SH_PFC_PIN_CFG(PORT##_pin, PORT##_pin, cfgs)

Additionally, your new SH_PFC_GPIO_CFG macro seems identical to _GP_GPIO now. 
It would make sense to merge the two.

-- 
Regards,

Laurent Pinchart

