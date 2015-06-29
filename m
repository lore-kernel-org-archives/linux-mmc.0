From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v3 2/6] pinctrl: sh-pfc: Implement pinconf power-source
 param for voltage switching
Date: Mon, 29 Jun 2015 22:55:18 +0100
Message-ID: <1435614918.23818.23.camel@codethink.co.uk>
References: <1435332116.23818.7.camel@codethink.co.uk>
	 <1435332204.23818.9.camel@codethink.co.uk> <3056637.adr2b5Zij1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <3056637.adr2b5Zij1@avalon>
Sender: linux-gpio-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2015-06-29 at 11:32 +0300, Laurent Pinchart wrote:
> Hi Ben,
> 
> Thank you for the patch.
> 
> On Friday 26 June 2015 16:23:24 Ben Hutchings wrote:
> > The pfc in the R8A7790 (and probably others in the R-Car gen 2 family)
> > supports switching SDHI signals between 3.3V and 1.8V voltage, and the
> > SD driver should do that when selecting a higher-speed mode.
> > 
> > Add a flag for pins that support low voltage mode and SoC operations to
> > get and set it.  Implement the pinconf power-source parameter using these
> > operations.
> 
> As Geert has already pointed out, we should use an integer value instead of a 
> boolean for voltages. How about expressing them in microvolts as done by the 
> regulators API ?

I did consider doing that but it seemed like over-engineering.  However,
given what Geert said about the other SoCs it seems worth doing.

However, pinconf arguments are limited to 16 bits so I think I will have
to make the units millivolts not microvolts.

[...]
> > diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> > b/drivers/pinctrl/sh-pfc/sh_pfc.h index c7508d5f6886..b95d60bf2f1b 100644
> > --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> > +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> > @@ -13,6 +13,7 @@
> > 
> >  #include <linux/bug.h>
> >  #include <linux/stringify.h>
> > +#include <linux/pinctrl/pinconf-generic.h>
> 
> Could you please keep the headers alphabetically sorted ?
> 
> > 
> >  enum {
> >  	PINMUX_TYPE_NONE,
> > @@ -26,8 +27,11 @@ enum {
> >  #define SH_PFC_PIN_CFG_OUTPUT		(1 << 1)
> >  #define SH_PFC_PIN_CFG_PULL_UP		(1 << 2)
> >  #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
> > +#define SH_PFC_PIN_CFG_LOW_VOLTAGE	(1 << 4)
> 
> As we should move away from using a bool to represent the voltage, I would 
> name this SH_PFC_PIN_CFG_IO_VOLTAGE, or possibly SH_PFC_PIN_CFG_POWER_SOURCE.

Right.

> >  #define SH_PFC_PIN_CFG_NO_GPIO		(1 << 31)
> > 
> > +struct sh_pfc;
> > +
> 
> I don't think this is needed, struct sh_pfc is already forward-declared right 
> above struct sh_pfc_soc_operations.

Right, this is left over from the previous version where I added an
operation to struct sh_pfc_pin.

> >  struct sh_pfc_pin {
> >  	u16 pin;
> >  	u16 enum_id;
> > @@ -121,6 +125,8 @@ struct sh_pfc_soc_operations {
> >  	unsigned int (*get_bias)(struct sh_pfc *pfc, unsigned int pin);
> >  	void (*set_bias)(struct sh_pfc *pfc, unsigned int pin,
> >  			 unsigned int bias);
> > +	bool (*get_low_voltage)(struct sh_pfc *pfc, unsigned int pin);
> > +	void (*set_low_voltage)(struct sh_pfc *pfc, unsigned int pin, bool low);
> 
> [gs]et_io_voltage() or [gs]et_power_source() ?

I prefer the former.

Ben.


