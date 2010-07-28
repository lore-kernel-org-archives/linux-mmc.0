From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] sdhci-s3c: add regulator support
Date: Wed, 28 Jul 2010 10:14:20 -0700
Message-ID: <20100728171420.GA22544@opensource.wolfsonmicro.com>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
 <1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
 <4C504326.30708@gmail.com>
 <3482ADFC-0FFB-47AE-B809-C88AC8B92C7F@opensource.wolfsonmicro.com>
 <4C50638E.7010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C50638E.7010101@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 28, 2010 at 07:06:22PM +0200, Maurus Cuelenaere wrote:
>  Op 28-07-10 17:41, Mark Brown schreef:

> >>> +	if (sc->vmmc) {
> >>> +		int ret = regulator_disable(sc->vmmc);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +		mdelay(2);

> >> Shouldn't these delays be handled in the regulator framework itself?

> > A 2ms delay on power down seems suspicious for a regulator. I'm not
> > sure why this is required but if it is I suspect it's due to a large
> > cap on the regulator output and light load rather than something
> > that's always true for whatever regulator is providing the supply.

> I wasn't suggesting to do the delay in the framework *itself*, rather in the
> regulator driver and/or the board platform code which needs this delay.

It's unlikely to be a property of the regulator in general, it sounds
like it's a property of the MMC application somehow (most likely due to
very light loading).  Possibly it should be platform configurable, but I
suspect in the MMC driver.

It'd be nice to know exactly what the delay is for...
