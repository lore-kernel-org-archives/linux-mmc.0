From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Fri, 30 Mar 2012 09:48:16 -0600
Message-ID: <4F75D5C0.5050307@wwwdotorg.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <201203271619.13320.arnd@arndb.de> <4F7553D1.4030008@st.com> <201203301136.05038.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201203301136.05038.arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 03/30/2012 05:36 AM, Arnd Bergmann wrote:
> On Friday 30 March 2012, Viresh Kumar wrote:
>> On 3/27/2012 9:49 PM, Arnd Bergmann wrote:
>>> These bindings came up in a discussion IRC today. I think it's rather bad that
>>> we can't agree on a common way to name the properties for mmc. We have
>>> bindings being proposed or already included from Anton, Stephen, Shawn,
>>> Rajendra, Viresh, Lee and Thomas. Almost all of them define GPIO pins
>>> for card detect and write protect, as well properties to define the bus
>>> width and high-speed modes, but we seem to have almost as many different
>>> definitions of these as we have drivers.
>>>
>>> Can we please come up with a common binding for these?
>>
>> Is there any progress on this? Sorry i wasn't following all mails.
>> How should i progress for sdhci-spear?
> 
> No progress so far. I would suggest we apply the patch below to unify
> the bindings we have. I tried to minimize the impact by picking the most
> common version for each property, but if we know about devices that would
> get broken by this, we may have to be more careful.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -0,0 +1,25 @@
> +These properties are common to multiple MMC host controllers. Any host
> +that requires the respective functionality should implement them using
> +these definitions.
> +
> +Required properties:
> +- bus-width: Number of data lines, can be <1>, <4>, or <8>

That property looks very reasonable.

Question: This would be a non-backwards-compatible change to the binding
definition. How should this be handled? In the past, I believe it's been
stated that new kernels need to run against old device trees, and hence
once a DT binding was defined and in use, it couldn't change except in a
backwards-compatible way. However, more recently, Grant has said that
his opinion is that (some or all?) bindings are currently considered
experimental and subject to change. And besides, the .dts files are
contained in the kernel tree at present... Some generally stated and
agreed upon policy here might be useful.

> +Optional properties:
> +- cd-gpios : Specify GPIOs for card detection, see gpio binding
> +- wp-gpios : Specify GPIOs for write protection, see gpio binding

> +- cd-inverted: when present, polarity on the wp gpio line is inverted
> +- wp-inverted: when present, polarity on the wp gpio line is inverted

I'm not sure about those two: Some of the GPIO bindings have flags in
the GPIO specifier (Tegra, ARM PL061, gpio.txt mentions the possibility
of polarity being in the specifier), and bit 0 of the flags is used to
indicate inversion. I think that either we should rely on GPIO
specifiers having such flags and remove these xxx-inverted properties
from the MMC binding, or remove that flag bit from the GPIO bindings.

Note that anything using of_gpio_simple_xlate() is going to end up using
the GPIO flag definitions from <linux/of_gpio.h> in their GPIO
specifier, and there a number of active users of this feature; grep for
OF_GPIO_ACTIVE_LOW.

The rather begs the question why of_get_named_gpio() exists; surely
of_get_named_gpio_flags() should always be used so that consumers know
whether the GPIO value should be inverted, or are the GPIO flags
supposed to be processed by the OF/GPIO core or GPIO driver somehow, and
act transparently to GPIO consumers?

> diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
...
> -- interrupts : Should contain SD/MMC interrupt
> +- interrupt  : Should contain SD/MMC interrupt

Isn't that usually pluralized, so interrupts?

> +- bus-width : Number of data lines, can be <1>, <4>, or <8>

For the device-specific binding documentation, rather than repeating the
core bindings, shouldn't we say something like:

This binding is based on the core MMC bindings documented in mmc.txt.
This file only documents additions or changes to those bindings.

... and then remove any of the common properties from the individual files?

> diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
...
> @@ -66,5 +67,6 @@
>  
>  	sdhci@78000400 {
>  		support-8bit;
> +		bus-width = <8>;
>  	};
>  };

Ah OK, so the first phase is to add all the new standardize properties,
then later remove all the legacy properties once the drivers have been
updated.

You've missed additions of "non-removable", but I can add them later. or
provide you an incremental patch or something.

> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c

This doesn't seem to decode cd-inverted, or do anything with the
bus-width property value that it reads. Was that intentional?
