From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 3/7] OMAP4-HSMMC: Adding Card detect support
Date: Wed, 21 Apr 2010 19:11:46 -0500
Message-ID: <008b01cae1b0$65848dc0$544ff780@am.dhcp.ti.com>
References: <63568.10.24.255.18.1271874040.squirrel@dbdmail.itg.ti.com> <20100421190827.GH18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100421190827.GH18272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>, 'kishore kadiyala' <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, April 21, 2010 2:08 PM
> To: kishore kadiyala
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
> madhu.cr@ti.com; jarkko.lavinen@nokia.com; rmk+lkml@arm.linux.org.uk;
> santosh.shilimkar@ti.com
> Subject: Re: [PATCH 3/7] OMAP4-HSMMC: Adding Card detect support
> 
> * kishore kadiyala <kishore.kadiyala@ti.com> [100421 11:16]:
> > Since OMAP4's card detection doesn't support GPIO,this patch
> > basically moves card detection API from driver to Board file so
> > that it can handle in both GPIO and NON-GPIO case.
> > This Patch also adds a flag which can differentiate whether the
> > card-detect line is GPIO or NON-GPIO.
> >
> > Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c   |    1 +
> >  arch/arm/mach-omap2/hsmmc.c           |   74
> +++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/hsmmc.h           |    1 +
> >  arch/arm/plat-omap/include/plat/mmc.h |    3 +-
> >  drivers/mmc/host/omap_hsmmc.c         |   29 +-----------
> >  5 files changed, 81 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
> > index eae7c80..4e8f74e 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -89,6 +89,7 @@ static struct omap2_hsmmc_info mmc[] = {
> >  		 * but is a phoenix interrupt
> >  		 */
> >  		.gpio_cd	= 384,
> > +		.cd_type	= true,
> >  		.gpio_wp	= -EINVAL,
> >  	},
> >  	{
> > diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> > index 9ad2295..ca3d4c9 100644
> > --- a/arch/arm/mach-omap2/hsmmc.c
> > +++ b/arch/arm/mach-omap2/hsmmc.c
> > @@ -13,6 +13,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +#include <linux/i2c/twl.h>
> >  #include <mach/hardware.h>
> >  #include <plat/control.h>
> >  #include <plat/mmc.h>
> > @@ -27,7 +29,11 @@ static u16 control_devconf1_offset;
> >
> >  #define HSMMC_NAME_LEN	9
> >
> > +/* Phoenix Registers */
> > +#define TWL6030_MMCCTRL	0xEE
> 
> This define belongs to the twl code.
> 
> >  static struct hsmmc_controller {
> > +	struct omap_mmc_platform_data   *mmc;
> >  	char				name[HSMMC_NAME_LEN + 1];
> >  } hsmmc[OMAP34XX_NR_MMC];
> >
> > @@ -42,6 +48,50 @@ static int hsmmc_get_context_loss(struct device *dev)
> >  #define hsmmc_get_context_loss NULL
> >  #endif
> >
> > +static int twl_mmc_get_cover_state(struct device *dev, int slot)
> > +{
> > +	struct omap_mmc_platform_data *mmc = dev->platform_data;
> > +
> > +	/* NOTE: assumes card detect signal is active-low */
> > +	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
> > +}
> > +
> > +static int twl_mmc_card_detect(int irq)
> > +{
> > +	unsigned i;
> > +	u8 read_reg;
> > +	unsigned res;
> > +
> > +
> > +	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
> > +		struct omap_mmc_platform_data *mmc;
> > +
> > +		mmc = hsmmc[i].mmc;
> > +		if (!mmc)
> > +			continue;
> > +		if (irq != mmc->slots[0].card_detect_irq)
> > +			continue;
> > +
> > +		if (mmc->slots[0].nongpio_cd) {
> > +			/* BIT0 of REG_MMC_CTRL
> > +			 * 0 - Card not present
> > +			 * 1 - Card present
> > +			 */
> > +			res = twl_i2c_read_u8(TWL6030_MODULE_ID0,
> > +					&read_reg, TWL6030_MMCCTRL);
> > +			if (res >= 0)
> > +				return read_reg & 0x1;
> > +			return !gpio_get_value_cansleep
> > +					(mmc->slots[0].switch_pin);
> > +		} else {
> > +			/* NOTE: assumes card detect signal is active-low */
> > +			return !gpio_get_value_cansleep
> > +					(mmc->slots[0].switch_pin);
> > +		}
> > +	}
> > +	return -ENOSYS;
> > +}
> 
> You should just register a separate twl_card_detect function during init
> instead of doing these tests over and over again.
> 

I agree. Additionally it would make sense to limit the hsmmc.c file with the
current functionality and create a new file which could get compiled for
4430 specific boards. It would be clean and will avoid brining any twl6030
specific code into hsmmc.c.


> >  static void hsmmc1_before_set_reg(struct device *dev, int slot,
> >  				  int power_on, int vdd)
> >  {
> > @@ -189,8 +239,32 @@ void __init omap2_hsmmc_init(struct
> omap2_hsmmc_info
> >  		mmc->get_context_loss_count = hsmmc_get_context_loss;
> >
> >  		mmc->slots[0].switch_pin = c->gpio_cd;
> > +		mmc->slots[0].nongpio_cd = c->cd_type;
> >  		mmc->slots[0].gpio_wp = c->gpio_wp;
> >
> > +		/* TWL Card detect can be GPIO based or NON-GPIO Based */
> > +		if (!c->cd_type) {
> > +			if (gpio_is_valid(c->gpio_cd)) {
> > +				mmc->slots[0].card_detect_irq =
> > +						gpio_to_irq(c->gpio_cd);
> > +				if (c->cover_only)
> > +					mmc->slots[0].get_cover_state =
> > +						twl_mmc_get_cover_state;
> > +				else
> > +					mmc->slots[0].card_detect =
> > +							twl_mmc_card_detect;
> > +			} else
> > +				mmc->slots[0].switch_pin = -EINVAL;
> > +		} else {
> > +			mmc->slots[0].card_detect_irq = c->gpio_cd;
> > +			if (c->cover_only)
> > +				mmc->slots[0].get_cover_state =
> > +						twl_mmc_get_cover_state;
> > +			else
> > +				mmc->slots[0].card_detect =
> > +							twl_mmc_card_detect;
> > +		}
> > +
> >  		mmc->slots[0].remux = c->remux;
> >
> >  		if (c->cover_only)
> 
> Once you register separate twl_card_detect during init, this part will
> not be needed.
> 
> > diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
> > index 36f0ba8..3dfc43a 100644
> > --- a/arch/arm/mach-omap2/hsmmc.h
> > +++ b/arch/arm/mach-omap2/hsmmc.h
> > @@ -17,6 +17,7 @@ struct omap2_hsmmc_info {
> >  	bool	no_off;		/* power_saving and power is not to go off
> */
> >  	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep
> */
> >  	int	gpio_cd;	/* or -EINVAL */
> > +	bool	cd_type;	/* Card detect Type:NON-GPIO=true,GPIO=flase
*/
> >  	int	gpio_wp;	/* or -EINVAL */
> >  	char	*name;		/* or NULL for default */
> >  	struct device *dev;	/* returned: pointer to mmc adapter */
> > diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-
> omap/include/plat/mmc.h
> > index a1bac07..521decc 100644
> > --- a/arch/arm/plat-omap/include/plat/mmc.h
> > +++ b/arch/arm/plat-omap/include/plat/mmc.h
> > @@ -103,6 +103,7 @@ struct omap_mmc_platform_data {
> >  		unsigned vcc_aux_disable_is_sleep:1;
> >
> >  		int switch_pin;			/* gpio (card detect) */
> > +		unsigned nongpio_cd:1;	/* NON-GPIO=true , GPIO=false */
> >  		int gpio_wp;			/* gpio (write protect) */
> >
> >  		int (*set_bus_mode)(struct device *dev, int slot, int
> bus_mode);
> > @@ -132,7 +133,7 @@ struct omap_mmc_platform_data {
> >
> >  		/* Card detection IRQs */
> >  		int card_detect_irq;
> > -		int (*card_detect)(struct device *dev, int slot);
> > +		int (*card_detect)(int irq);
> >
> >  		unsigned int ban_openended:1;
> >
> 
> Why are you removing *dev from card_detect?
> 
> Will comment further after that all is fixed. Please also make sure
> omap_hsmmc.c compiles and works as a module.
> 
> Regards,
> 
> Tony

