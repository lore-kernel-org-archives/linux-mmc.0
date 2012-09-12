From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Wed, 12 Sep 2012 11:41:33 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA80426@DBDE01.ent.ti.com>
References: <1346764151-21323-1-git-send-email-gururaja.hebbar@ti.com>
 <CANrkHUYtxKEfL8QUA2e5vGJ-LSJLCNX+hmBm1hqFJ439asUefw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANrkHUYtxKEfL8QUA2e5vGJ-LSJLCNX+hmBm1hqFJ439asUefw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "cjb@laptop.org" <cjb@laptop.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 12, 2012 at 14:51:34, Krishnamoorthy, Balaji T wrote:
> On Tue, Sep 4, 2012 at 6:39 PM, Hebbar, Gururaja <gururaja.hebbar@ti.com> wrote:
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
> 
> Is this specific to some boards or all board with TI81xx ?
> What is the side-effect if not done ?

Platforms like (AM335x) needed this bit to be set in order to sustain high
speed transfers. This was concluded after HSMMC IP timing closure was 
completed for High speed Cards. 

This was confirmed on high speed cards with very low setup/hold delay (in the 
order of nsec) was tested. For AM335x, this bit was to be set to meet setup 
requirement and hold requirement for MMC/SD HS cards.

> 
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
> > :100644 100644 be76a23... ed271fc... M  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> > :100644 100644 eb3e4d5... 00c658b... M  arch/arm/plat-omap/include/plat/mmc.h
> > :100644 100644 c3e96a2... 0e14834... M  drivers/mmc/host/omap_hsmmc.c

..snip..
..snip..
..snip..

> >
> > +       /*
> > +        * Enable High-Speed Support
> > +        * Pre-Requisites
> > +        *      - Controller should support High-Speed-Enable Bit
> > +        *      - Controller should not be using DDR Mode
> > +        *      - Controller should advertise that it supports High Speed
> > +        *        in capabilities register
> > +        *      - MMC/SD clock coming out of controller > 25MHz
> > +        */
> > +       if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
> > +           (ios->timing != MMC_TIMING_UHS_DDR50) &&
> > +           ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
> > +               regval = OMAP_HSMMC_READ(host->base, HCTL);
> > +               if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
> 
> I think clkdiv is not needed
> clk_get_rate(host->fclk)/clkdiv is same as ios->clock

There are chances that the platform is not supporting Clock output from HSMMC
IP greater than 25 MHz even if the card is High Speed. So it would be better 
to check host->fclk than ios->clock. 

Kindly correct me if I am wrong.

> 
> > +                       regval |= HSPE;
> > +               else
> > +                       regval &= ~HSPE;
> > +
> > +               OMAP_HSMMC_WRITE(host->base, HCTL, regval);
> > +       }
> > +
> >         omap_hsmmc_start_clock(host);
> >  }
> >
> > @@ -1701,6 +1726,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
> >         if (of_find_property(np, "ti,needs-special-reset", NULL))
> >                 pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
> >
> > +       if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
> > +               pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
> > +
> >         return pdata;
> >  }
> >  #else
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Regards, 
Gururaja
