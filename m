From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Fri, 18 Nov 2011 16:21:40 -0800
Message-ID: <20111119002140.GX31337@atomide.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
 <1320407441-29697-3-git-send-email-rnayak@ti.com>
 <20111114213026.GP31337@atomide.com>
 <4EC1E757.2000308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46353 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab1KSAVq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 19:21:46 -0500
Content-Disposition: inline
In-Reply-To: <4EC1E757.2000308@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: cjb@laptop.org, balajitk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, thomas.abraham@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [111114 19:40]:
> On Tuesday 15 November 2011 03:00 AM, Tony Lindgren wrote:
> >* Rajendra Nayak<rnayak@ti.com>  [111104 04:16]:
> >>@@ -1869,6 +1957,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
> >>  	struct omap_hsmmc_host *host = NULL;
> >>  	struct resource *res;
> >>  	int ret, irq;
> >>+	const struct of_device_id *match;
> >>+
> >>+	match = of_match_device(omap_mmc_of_match,&pdev->dev);
> >>+	if (match) {
> >>+		pdata = of_get_hsmmc_pdata(&pdev->dev);
> >>+		if (match->data)
> >>+			pdata->reg_offset = *(u16 *)match->data;
> >>+	}
> >
> >So this is now using both DT and pdata?
> >
> >We want to use DT only, and get rid of pdata. Other than the
> >deferred probe, is there some other dependency remaining to
> >having to use the pdata also?
> 
> We are using pdata today mainly for the platform function pointers
> that get passed for MMC, which can never be passed from DT.
> 
> The  omap_mmc_platform_data structure today has '17' function pointers.
> Most might be sparingly used, nevertheless, its an awfully large number.

Yeah OK.
 
> Here's the list...
> ---------
> int (*switch_slot)(struct device *dev, int slot);
> int (*init)(struct device *dev);
> void (*cleanup)(struct device *dev);
> void (*shutdown)(struct device *dev);
> int (*suspend)(struct device *dev, int slot);
> int (*resume)(struct device *dev, int slot);
> int (*get_context_loss_count)(struct device *dev);
> 
> per-slot functions
> 
> int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
> int (*set_power)(struct device *dev, int slot,
>                                  int power_on, int vdd);
> int (*get_ro)(struct device *dev, int slot);
> int (*set_sleep)(struct device *dev, int slot, int sleep,
>                                  int vdd, int cardsleep);
> void (*remux)(struct device *dev, int slot, int power_on);
> void (*before_set_reg)(struct device *dev, int slot,
>                                        int power_on, int vdd);
> void (*after_set_reg)(struct device *dev, int slot,
>                                       int power_on, int vdd);
> void (*init_card)(struct mmc_card *card);
> int (*get_cover_state)(struct device *dev, int slot);
> int (*card_detect)(struct device *dev, int slot);
> ---------

To me it seems we should move these into drivers/mmc/host/omap_hsmmc.c
and set them based on DT compatible (or some other) property.

If these functions tinker with some internal registers, then we need
to fix those too to use regulator/gpio API.

This way we don't need the platform_data any longer.

Regards,

Tony
