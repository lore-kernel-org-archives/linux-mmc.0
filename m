From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 3/6] pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
Date: Mon, 29 Jun 2015 11:50:29 +0300
Message-ID: <2044299.XRI5bVohtM@avalon>
References: <1435332116.23818.7.camel@codethink.co.uk> <1435332210.23818.10.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435332210.23818.10.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Friday 26 June 2015 16:23:30 Ben Hutchings wrote:
> All the SHDIs can operate with either 3.3V or 1.8V signals, depending
> on negotiation with the card.
> 
> Implement the {get,set}_low_voltage operations and set the low-voltage
> capability flag for the associated pins.
> 
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  drivers/pinctrl/sh-pfc/core.c        |  2 +-
>  drivers/pinctrl/sh-pfc/core.h        |  1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 67 ++++++++++++++++++++++++++++++++-
>  3 files changed, 68 insertions(+), 2
> deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 7b2c9495c383..7d51f96afc9a 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -92,7 +92,7 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
>  	return 0;
>  }
> 
> -static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
> +void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
>  {
>  	struct sh_pfc_window *window;
>  	phys_addr_t address = reg;
> diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
> index 6dc8a6fc2746..af355629c5d2 100644
> --- a/drivers/pinctrl/sh-pfc/core.h
> +++ b/drivers/pinctrl/sh-pfc/core.h
> @@ -57,6 +57,7 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
>  int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
>  int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
> 
> +void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 address);
>  u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
>  void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
> u32 data);
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 22a5470889f5..38be7cbea4ca
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -1739,10 +1739,20 @@ static const u16 pinmux_data[] = {
>  #define PIN_NUMBER(r, c) (((r) - 'A') * 31 + (c) + 200)
>  #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
> 
> +#define PIN_LOW_VOLTAGE(bank, _pin, _name, sfx)		\
> +	[RCAR_GP_PIN(bank, _pin)].configs = SH_PFC_PIN_CFG_LOW_VOLTAGE
> +
>  static const struct sh_pfc_pin pinmux_pins[] = {
>  	PINMUX_GPIO_GP_ALL(),
> 
> -	/* Pins not associated with a GPIO port */
> +	/*
> +	 * All pins assigned to GPIO bank 3 can be used for SD interfaces
> +	 * in which case they support low voltage (1.8V) signalling.
> +	 */
> +	PORT_GP_32(3, PIN_LOW_VOLTAGE, unused),

Ouch. I didn't know gcc would even support initializing fields of array member 
structures separately from full initialization of the array member structure. 
Is it standard C ? Is it supported by LLVM ? I would prefer replacing 
PINMUX_GPIO_GP_ALL instead with a version that initializes the config field 
appropriately.

Another idea I've been toying with is it replace the config field by an 
operation that returns the config value for a given pin. It would increase 
execution time slightly, but would likely save memory as the logic is often 
easy to express in C code and doesn't require a per-pin array.

> +	/* Pins not associated with a GPIO port, placed after all the GPIOs */
> +	[RCAR_GP_PIN(5, 31) + 1] =
>  	SH_PFC_PIN_NAMED(ROW_GROUP_A('F'), 15, AF15),
>  	SH_PFC_PIN_NAMED(ROW_GROUP_A('G'), 15, AG15),
>  	SH_PFC_PIN_NAMED(ROW_GROUP_A('H'), 15, AH15),
> @@ -4595,6 +4605,55 @@ static const char * const vin3_groups[] = {
>  	"vin3_clk",
>  };
> 
> +static bool sdhi_get_low_voltage(struct sh_pfc *pfc, unsigned int pin)
> +{
> +	void __iomem *mapped_reg;
> +	u32 data, mask;
> +
> +	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31),
> +		 "sdhi_get_low_voltage: invalid pin %#x", pin))
> +		return 0;

If the rest of the driver behaves correctly this should never happen, right ?

> +	/* Map IOCTRL6 */
> +	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
> +
> +	/* Bits in IOCTRL6 are numbered in opposite order to pins */
> +	mask = 0x80000000 >> (pin & 0x1f);
> +
> +	data = sh_pfc_read_raw_reg(mapped_reg, 32);

Given that we know the register width here I would replace this with a direct 
call to ioread32(). Same for the read and write calls below.

> +
> +	return !(data & mask);
> +}
> +
> +static void
> +sdhi_set_low_voltage(struct sh_pfc *pfc, unsigned int pin, bool low)
> +{
> +	void __iomem *mapped_reg;
> +	u32 data, mask;
> +
> +	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31),
> +		 "sdhi_set_low_voltage: invalid pin %#x", pin))
> +		return;
> +
> +	/* Map IOCTRL6 */
> +	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
> +
> +	/* Bits in IOCTRL6 are numbered in opposite order to pins */
> +	mask = 0x80000000 >> (pin & 0x1f);
> +
> +	data = sh_pfc_read_raw_reg(mapped_reg, 32);
> +
> +	if (low)
> +		data &= ~mask;
> +	else
> +		data |= mask;
> +
> +	sh_pfc_write_raw_reg(
> +		sh_pfc_phys_to_virt(pfc, pfc->info->unlock_reg), 32,
> +		~data);
> +	sh_pfc_write_raw_reg(mapped_reg, 32, data);
> +}
> +
>  static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(audio_clk),
>  	SH_PFC_FUNCTION(avb),
> @@ -5586,8 +5645,14 @@ static const struct pinmux_cfg_reg
> pinmux_config_regs[] = { { },
>  };
> 
> +static const struct sh_pfc_soc_operations pinmux_ops = {
> +	.get_low_voltage = sdhi_get_low_voltage,
> +	.set_low_voltage = sdhi_set_low_voltage,
> +};
> +
>  const struct sh_pfc_soc_info r8a7790_pinmux_info = {
>  	.name = "r8a77900_pfc",
> +	.ops = &pinmux_ops,
>  	.unlock_reg = 0xe6060000, /* PMMR */
> 
>  	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },

-- 
Regards,

Laurent Pinchart

