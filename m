From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4] mmc: add a function to get regulators, supplying
 card's power
Date: Tue, 12 Jun 2012 18:52:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206121850590.6800@axis700.grange>
References: <Pine.LNX.4.64.1206121743260.6800@axis700.grange>
 <41FE983D-844B-47B8-885F-96B89FE128B9@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <41FE983D-844B-47B8-885F-96B89FE128B9@marvell.com>
Sender: linux-sh-owner@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 12 Jun 2012, Philip Rakity wrote:

> 
> On Jun 12, 2012, at 8:57 AM, Guennadi Liakhovetski wrote:
> 
> > Add a function to get regulators, supplying card's Vdd and Vccq on a
> > specific host. If a Vdd supplying regulator is found, the function checks,
> > whether a valid OCR mask can be obtained from it. The Vccq regulator is
> > optional. A failure to get it is not fatal.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > v4:
> > 
> > 1. add _GPL to EXPORT_SYMBOL (note: a recently posted patch changes 
> > another occurrence of EXPORT_SYMBOL too, so, this patch will apply with a 
> > fuzz, if merged after)
> > 
> > 2. add an optional vqmmc regulator, which also changes the function 
> > prototype
> > 
> > 3. print a warning, if failed to get an OCR mask
> > 
> > Thanks to all, who commented
> > 
> > drivers/mmc/core/core.c  |   27 +++++++++++++++++++++++++++
> > include/linux/mmc/host.h |   12 ++++++++++++
> > 2 files changed, 39 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 0b6141d..d77a238 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1013,6 +1013,33 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
> > }
> > EXPORT_SYMBOL(mmc_regulator_set_ocr);
> > 
> > +int mmc_regulator_get_supply(struct mmc_host *mmc, struct mmc_supply *s)
> > +{
> > +	struct device *dev = mmc_dev(mmc);
> > +	struct regulator *supply;
> > +	int ret;
> > +
> > +	if (!mmc || !s)
> > +		return -EINVAL;
> > +
> > +	supply = devm_regulator_get(dev, "vmmc");
> > +
> > +	if (IS_ERR(supply))
> > +		return PTR_ERR(supply);
> > +
> > +	s->vmmc = supply;
> > +	s->vqmmc = devm_regulator_get(dev, "vqmmc");
> 
> Should we set vqmmc to NULL if an error was returned ?

Don't think so, drivers can perfectly check for IS_ERR() themselves.

> > +
> > +	ret = mmc_regulator_get_ocrmask(supply);
> > +	if (ret > 0)
> > +		mmc->ocr_avail = ret;
> > +	else
> > +		dev_warn(mmc_dev(mmc), "Failed getting OCR mask: %d\n", ret);
> 
> I was wondering if  sdhci (or the other SD Host drivers can work if no ocr_avail mask is set ?  

Yes, e.g., if it's a dummy regulator and the board actually doesn't need 
one.

> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
> > +
> > #endif /* CONFIG_REGULATOR */
> > 
> > /*
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 0707d22..3192335 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -359,11 +359,17 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
> > 
> > struct regulator;
> > 
> > +struct mmc_supply {
> > +	struct regulator *vmmc;		/* Card power supply */
> > +	struct regulator *vqmmc;	/* Optional Vccq supply */
> > +};
> > +
> > #ifdef CONFIG_REGULATOR
> > int mmc_regulator_get_ocrmask(struct regulator *supply);
> > int mmc_regulator_set_ocr(struct mmc_host *mmc,
> > 			struct regulator *supply,
> > 			unsigned short vdd_bit);
> > +int mmc_regulator_get_supply(struct mmc_host *mmc, struct mmc_supply *s);
> > #else
> > static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
> > {
> > @@ -376,6 +382,12 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
> > {
> > 	return 0;
> > }
> > +
> > +static inline int mmc_regulator_get_supply(struct mmc_host *mmc,
> > +					   struct mmc_supply *s)
> > +{
> > +	return 0;
> > +}
> > #endif
> > 
> > int mmc_card_awake(struct mmc_host *host);
> > -- 
> > 1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
