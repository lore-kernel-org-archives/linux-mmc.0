From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [RESEND PATCH] mmc: omap_hsmmc: Enable HSPE bit for high speed
 cards
Date: Wed, 31 Oct 2012 05:17:02 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAB96FB@DBDE01.ent.ti.com>
References: <1351515408-19403-1-git-send-email-gururaja.hebbar@ti.com>
 <20121029161719.GI27566@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220Ab2JaFRT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 01:17:19 -0400
In-Reply-To: <20121029161719.GI27566@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, "cjb@laptop.org" <cjb@laptop.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On Mon, Oct 29, 2012 at 21:47:19, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Oct 29, 2012 at 06:26:48PM +0530, Hebbar, Gururaja wrote:
> > HSMMC IP on AM33xx need a special setting to handle High-speed cards.
> > Other platforms like TI81xx, OMAP4 may need this as-well. This depends
> > on the HSMMC IP timing closure done for the high speed cards.
> > 
> > From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
> > 
> > The MMC/SD/SDIO output signals can be driven on either falling edge or
> > rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
> > to reach better timing performance, and thus to increase data transfer
> > frequency.
> > 
> > There are few pre-requisites for enabling the HSPE bit
> > - Controller should support High-Speed-Enable Bit and
> > - Controller should not be using DDR Mode and
> > - Controller should advertise that it supports High Speed in
> >   capabilities register and
> > - MMC/SD clock coming out of controller > 25MHz
> > 
> > Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> > ---
> > Rebased on mmc-next (v3.7.0-rc1)
> > Only Build tested since EDMA support for AM335x is not yet added
> > 
> > :100644 100644 be76a23... ed271fc... M	Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > :100644 100644 8b4e4f2... 346af5b... M	arch/arm/plat-omap/include/plat/mmc.h
> > :100644 100644 54bfd0c... 3fd95cb... M	drivers/mmc/host/omap_hsmmc.c
> >  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
> >  arch/arm/plat-omap/include/plat/mmc.h              |    1 +
> >  drivers/mmc/host/omap_hsmmc.c                      |   30 +++++++++++++++++++-
> >  3 files changed, 31 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > index be76a23..ed271fc 100644
> > --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > @@ -19,6 +19,7 @@ ti,dual-volt: boolean, supports dual voltage cards
> >  "supply-name" examples are "vmmc", "vmmc_aux" etc
> >  ti,non-removable: non-removable slot (like eMMC)
> >  ti,needs-special-reset: Requires a special softreset sequence
> > +ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
> 
> can't you do runtime revision detection for this ?

Platforms like AM335x & TI814x both use the same IP. 
But only AM335x needed this bit to be set in order to sustain high
speed transfers. This was concluded after AM335x HSMMC IP timing
closure was completed for High speed Cards.

> 
> >  Example:
> >  	mmc1: mmc@0x4809c000 {
> > diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
> > index 8b4e4f2..346af5b 100644
> > --- a/arch/arm/plat-omap/include/plat/mmc.h
> > +++ b/arch/arm/plat-omap/include/plat/mmc.h
> > @@ -126,6 +126,7 @@ struct omap_mmc_platform_data {
> >  		/* we can put the features above into this variable */
> >  #define HSMMC_HAS_PBIAS		(1 << 0)
> >  #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
> > +#define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
> >  		unsigned features;
> >  
> >  		int switch_pin;			/* gpio (card detect) */
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > index 54bfd0c..3fd95cb 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -62,6 +62,7 @@
> >  
> >  #define VS18			(1 << 26)
> >  #define VS30			(1 << 25)
> > +#define HSS			(1 << 21)
> >  #define SDVS18			(0x5 << 9)
> >  #define SDVS30			(0x6 << 9)
> >  #define SDVS33			(0x7 << 9)
> > @@ -89,6 +90,7 @@
> >  #define MSBS			(1 << 5)
> >  #define BCE			(1 << 1)
> >  #define FOUR_BIT		(1 << 1)
> > +#define HSPE			(1 << 2)
> >  #define DDR			(1 << 19)
> >  #define DW8			(1 << 5)
> >  #define CC			0x1
> > @@ -489,6 +491,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
> >  	struct mmc_ios *ios = &host->mmc->ios;
> >  	unsigned long regval;
> >  	unsigned long timeout;
> > +	unsigned long clkdiv;
> >  
> >  	dev_vdbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
> >  
> > @@ -496,7 +499,8 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
> >  
> >  	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
> >  	regval = regval & ~(CLKD_MASK | DTO_MASK);
> > -	regval = regval | (calc_divisor(host, ios) << 6) | (DTO << 16);
> > +	clkdiv = calc_divisor(host, ios);
> > +	regval = regval | (clkdiv << 6) | (DTO << 16);
> 
> not part of $SUBJECT

The output of the calc_divisor() is reused in the below HSPE checking. So
instead of calling it twice I have taken the output of that function into
a variable and reused it.

> 
> >  	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
> >  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
> >  		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> > @@ -507,6 +511,27 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
> >  		&& time_before(jiffies, timeout))
> >  		cpu_relax();
> >  
> > +	/*
> > +	 * Enable High-Speed Support
> > +	 * Pre-Requisites
> > +	 *	- Controller should support High-Speed-Enable Bit
> > +	 *	- Controller should not be using DDR Mode
> > +	 *	- Controller should advertise that it supports High Speed
> > +	 *	  in capabilities register
> > +	 *	- MMC/SD clock coming out of controller > 25MHz
> > +	 */
> > +	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
> 
> is this really needed...

As explained above, this is needed only on platforms which requires the
Bit to be set (currently AM335x). Such platforms will set this
parameter in it .dts file

> 
> > +	    (ios->timing != MMC_TIMING_UHS_DDR50) &&
> > +	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
> 
> ... provided you check device's register ?

As explained above, both TI814x & AM335x support HSS but only AM335x
require HSPE bit set.


Regards, 
Gururaja

> 
> > +		regval = OMAP_HSMMC_READ(host->base, HCTL);
> > +		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
> > +			regval |= HSPE;
> > +		else
> > +			regval &= ~HSPE;
> > +
> > +		OMAP_HSMMC_WRITE(host->base, HCTL, regval);
> > +	}
> > +
> >  	omap_hsmmc_start_clock(host);
> >  }
> >  
> > @@ -1700,6 +1725,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
> >  	if (of_find_property(np, "ti,needs-special-reset", NULL))
> >  		pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
> >  
> > +	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
> > +		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
> > +
> >  	return pdata;
> >  }
> >  #else
> > -- 
> > 1.7.0.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi
> 
