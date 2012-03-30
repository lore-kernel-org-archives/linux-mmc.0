From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Fri, 30 Mar 2012 18:45:07 +0000
Message-ID: <201203301845.07534.arnd@arndb.de>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <201203301136.05038.arnd@arndb.de> <4F75D5C0.5050307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F75D5C0.5050307@wwwdotorg.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@st.com>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-mmc@vger.kernel.org

On Friday 30 March 2012, Stephen Warren wrote:
> That property looks very reasonable.
> 
> Question: This would be a non-backwards-compatible change to the binding
> definition. How should this be handled? In the past, I believe it's been
> stated that new kernels need to run against old device trees, and hence
> once a DT binding was defined and in use, it couldn't change except in a
> backwards-compatible way. However, more recently, Grant has said that
> his opinion is that (some or all?) bindings are currently considered
> experimental and subject to change. And besides, the .dts files are
> contained in the kernel tree at present... Some generally stated and
> agreed upon policy here might be useful.

I tried to leave the ones that look like they've been around for a while
backwards compatible (gpio, esdhc), while changing the relatively new
ones without backwards compatibility code.

> > +Optional properties:
> > +- cd-gpios : Specify GPIOs for card detection, see gpio binding
> > +- wp-gpios : Specify GPIOs for write protection, see gpio binding
> 
> > +- cd-inverted: when present, polarity on the wp gpio line is inverted
> > +- wp-inverted: when present, polarity on the wp gpio line is inverted
> 
> I'm not sure about those two: Some of the GPIO bindings have flags in
> the GPIO specifier (Tegra, ARM PL061, gpio.txt mentions the possibility
> of polarity being in the specifier), and bit 0 of the flags is used to
> indicate inversion. I think that either we should rely on GPIO
> specifiers having such flags and remove these xxx-inverted properties
> from the MMC binding, or remove that flag bit from the GPIO bindings.

Maybe the GPIO maintainer can comment on this. My understanding is
that not all gpio controllers support this in their bindings. If they
do, I agree that we can remove the extra properties here.

> Note that anything using of_gpio_simple_xlate() is going to end up using
> the GPIO flag definitions from <linux/of_gpio.h> in their GPIO
> specifier, and there a number of active users of this feature; grep for
> OF_GPIO_ACTIVE_LOW.
> 
> The rather begs the question why of_get_named_gpio() exists; surely
> of_get_named_gpio_flags() should always be used so that consumers know
> whether the GPIO value should be inverted, or are the GPIO flags
> supposed to be processed by the OF/GPIO core or GPIO driver somehow, and
> act transparently to GPIO consumers?
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> ...
> > -- interrupts : Should contain SD/MMC interrupt
> > +- interrupt  : Should contain SD/MMC interrupt
> 
> Isn't that usually pluralized, so interrupts?

Right, my mistake.

> > +- bus-width : Number of data lines, can be <1>, <4>, or <8>
> 
> For the device-specific binding documentation, rather than repeating the
> core bindings, shouldn't we say something like:
> 
> This binding is based on the core MMC bindings documented in mmc.txt.
> This file only documents additions or changes to those bindings.
> 
> ... and then remove any of the common properties from the individual files?

yes, good idea.

> > diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
> ...
> > @@ -66,5 +67,6 @@
> >  
> >       sdhci@78000400 {
> >               support-8bit;
> > +             bus-width = <8>;
> >       };
> >  };
> 
> Ah OK, so the first phase is to add all the new standardize properties,
> then later remove all the legacy properties once the drivers have been
> updated.
> 
> You've missed additions of "non-removable", but I can add them later. or
> provide you an incremental patch or something.
> 
> > diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> 
> This doesn't seem to decode cd-inverted, or do anything with the
> bus-width property value that it reads. Was that intentional?

For now, I was trying to get the binding document right. I suppose as a follow-up,
we can actually add a common helper function to decode these attributes and set
the right flag in the mmc device, but that is not urgent. Right now, I mainly
want to make sure we gain no new users that have conflicting bindings.

	Arnd
