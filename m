From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/16] omap_hsmmc: Add ADMA support and UHS/HS200/DDR
 support
Date: Tue, 11 Jul 2017 19:27:00 +0530
Message-ID: <fc9c1576-7419-b174-ea42-97ccf4666cee@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <CAPDyKFo+ORA=OpdikiUZWj3gpx+ssuqbC5MtqiFJneyJhu84dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFo+ORA=OpdikiUZWj3gpx+ssuqbC5MtqiFJneyJhu84dA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Tuesday 11 July 2017 06:40 PM, Ulf Hansson wrote:
> On 16 June 2017 at 14:45, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>> This is the final part of the series originally sent as
>> part of [2].
>>
>> This series adds UHS, HS200, DDR mode and ADMA support to
>> omap_hsmmc driver used to improve the throughput of MMC/SD in dra7
>> SoCs.
>>
>> Changes from [2]:
>> *) No more updating omap2plus_defconfig or multi_v7_defconfig is
>>    required, so those patches are removed.
>> *) Addressed Rob Herring's comment on implementing a function
>>    instead of having a macro while getting pinctrl state.
>>
>> This series is created on top of [3], [4], [5] AND [6]
>> (i.e after
>>   ARM: dts: omap3-overo: Remove "vqmmc-supply" property from MMC dt node
>>   omap_hsmmc: use mmc_regulator_get_supply() to get regulators
>>   omap*: Fixes/Cleanups for MMC devicetree node
>>   ARM: dts: Add iodelay data for MMC)
>>
>> The functionality implemented in this series was sent before ([1]) but
>> was never followed up since supporting high speed modes in dra7 required
>> IODelay values to be configured. With IODelay driver being merged into
>> kernel, sending it as a fresh series with support for configuring IODelay
>> values.
> 
> Is it safe to queue this via mmc tree for 4.14 or is there a
> dependency I must consider? The above didn't quite tell me that, could
> you please elaborate.

There is a dependency with https://www.spinics.net/lists/arm-kernel/msg586215.html.

I'll resend the series after all the platform data specific stuff is merged.
> 
>>
>> Suggestions of migrating to sdhci driver (from omap_hsmmc driver) is not
>> addressed since
>> *) tuning ratio of MMC in dra7 is different from sdhci
>> *) IOdelay is required for dra7
>> *) GPIO based card detect is not supported in sdhci
> 
> Lots of sdhci drivers calls mmc_of_parse(), and uses the mmc slot gpio
> APIs, so I don't this this is correct statement.
> 
>> *) Some of the registers don't always have correct values as in sdhci
>>    (like PSTATE).
>> Supporting all of these in sdhci will result in adding lot of quirks in
>> sdhci driver.
> 
> Is it really that much different? It would be nice if some really took
> on the challenge of converting omap_hsmmc into an sdhci variant.

Okay. I'll give that a shot and see how far I can get.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
