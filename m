From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v3 3/6] pinctrl: sh-pfc: r8a7790: Implement voltage
 switching for SDHI
Date: Tue, 30 Jun 2015 00:44:19 +0100
Message-ID: <1435621459.23818.28.camel@codethink.co.uk>
References: <1435332116.23818.7.camel@codethink.co.uk>
	 <1435332210.23818.10.camel@codethink.co.uk> <2044299.XRI5bVohtM@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:35475 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbbF2Xo0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jun 2015 19:44:26 -0400
In-Reply-To: <2044299.XRI5bVohtM@avalon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Mon, 2015-06-29 at 11:50 +0300, Laurent Pinchart wrote:
> Hi Ben,
> 
> Thank you for the patch.
> 
> On Friday 26 June 2015 16:23:30 Ben Hutchings wrote:
> > All the SHDIs can operate with either 3.3V or 1.8V signals, depending
> > on negotiation with the card.
> > 
> > Implement the {get,set}_low_voltage operations and set the low-voltage
> > capability flag for the associated pins.
> > 
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > ---
> >  drivers/pinctrl/sh-pfc/core.c        |  2 +-
> >  drivers/pinctrl/sh-pfc/core.h        |  1 +
> >  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 67 ++++++++++++++++++++++++++++++++-
> >  3 files changed, 68 insertions(+), 2
> > deletions(-)
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> > index 7b2c9495c383..7d51f96afc9a 100644
> > --- a/drivers/pinctrl/sh-pfc/core.c
> > +++ b/drivers/pinctrl/sh-pfc/core.c
> > @@ -92,7 +92,7 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
> >  	return 0;
> >  }
> > 
> > -static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
> > +void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
> >  {
> >  	struct sh_pfc_window *window;
> >  	phys_addr_t address = reg;
> > diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
> > index 6dc8a6fc2746..af355629c5d2 100644
> > --- a/drivers/pinctrl/sh-pfc/core.h
> > +++ b/drivers/pinctrl/sh-pfc/core.h
> > @@ -57,6 +57,7 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
> >  int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
> >  int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
> > 
> > +void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 address);
> >  u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
> >  void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
> > u32 data);
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 22a5470889f5..38be7cbea4ca
> > 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > @@ -1739,10 +1739,20 @@ static const u16 pinmux_data[] = {
> >  #define PIN_NUMBER(r, c) (((r) - 'A') * 31 + (c) + 200)
> >  #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
> > 
> > +#define PIN_LOW_VOLTAGE(bank, _pin, _name, sfx)		\
> > +	[RCAR_GP_PIN(bank, _pin)].configs = SH_PFC_PIN_CFG_LOW_VOLTAGE
> > +
> >  static const struct sh_pfc_pin pinmux_pins[] = {
> >  	PINMUX_GPIO_GP_ALL(),
> > 
> > -	/* Pins not associated with a GPIO port */
> > +	/*
> > +	 * All pins assigned to GPIO bank 3 can be used for SD interfaces
> > +	 * in which case they support low voltage (1.8V) signalling.
> > +	 */
> > +	PORT_GP_32(3, PIN_LOW_VOLTAGE, unused),
> 
> Ouch. I didn't know gcc would even support initializing fields of array member 
> structures separately from full initialization of the array member structure. 
> Is it standard C ? Is it supported by LLVM ? I would prefer replacing 
> PINMUX_GPIO_GP_ALL instead with a version that initializes the config field 
> appropriately.

It appears to be defined in the C99 standard.  (I only have the final
draft here, though.)

[...] 
> > +static bool sdhi_get_low_voltage(struct sh_pfc *pfc, unsigned int pin)
> > +{
> > +	void __iomem *mapped_reg;
> > +	u32 data, mask;
> > +
> > +	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31),
> > +		 "sdhi_get_low_voltage: invalid pin %#x", pin))
> > +		return 0;
> 
> If the rest of the driver behaves correctly this should never happen, right ?

Right.

> > +	/* Map IOCTRL6 */
> > +	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
> > +
> > +	/* Bits in IOCTRL6 are numbered in opposite order to pins */
> > +	mask = 0x80000000 >> (pin & 0x1f);
> > +
> > +	data = sh_pfc_read_raw_reg(mapped_reg, 32);
> 
> Given that we know the register width here I would replace this with a direct 
> call to ioread32(). Same for the read and write calls below.
[...]

OK.

Ben.


