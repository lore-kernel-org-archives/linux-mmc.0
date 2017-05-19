From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/41] omap_hsmmc: Add ADMA support and UHS/HS200/DDR
 support
Date: Fri, 19 May 2017 15:13:45 -0700
Message-ID: <20170519221344.GI10472@atomide.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170519081541.26753-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170519 01:19]:
> This series adds UHS, HS200, DDR mode and ADMA support to
> omap_hsmmc driver used to improve the throughput of MMC/SD in dra7
> SoCs.

Certainly seems way less intrusive than earlier before the
dmaengine changes :)

> *) tuning ratio of MMC in dra7 is different from sdhci

Hmm what's the tuning ratio?

> This series has been tested on beagleboard, pandaboard, beaglebone-black,
> beaglebone, am335x-evm, am437x-evm, dra7xx-evm, dra72x-evm, am571x-idk
> and am572x-idk.

I gave this a quick try after manally applying next-20170519
after reverting 67d0687224a9 ("mm: drop HASH_ADAPT"). Looks like
something is missing as I got:

arch/arm/mach-omap2/pdata-quirks.c:445:23: error:
'struct omap_hsmmc_platform_data' has no member named 'version'
...

It's possible I messed up something while manually applying.

> I can split the series to go into Ulf Hansson's tree and Tony's tree 
> separately if that is required.

Yes please. Maybe send the dts parts first that are ready to
get merged, like the fixes and all the iodelay configuration.

Then the mmc driver changes as a separate set.

Then third set to follow-up and enable things once the mmc
driver changes are merged.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
