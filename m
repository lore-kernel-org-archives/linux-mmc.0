From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/7] ARM: dts: MMC fixes for DRA7 based boards
Date: Wed, 5 Aug 2015 03:54:00 -0700
Message-ID: <20150805105400.GF16878@atomide.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438244020-4244-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150730 01:16]:
> Miscellaneous fixes in dts files for MMC device tree nodes.
> 
> Did basic read/write test in J6, J6 Eco and Beagle-x15
> 
> Balaji T K (1):
>   ARM: dts: dra7-evm: add evm_3v3_sd regulator
> 
> Kishon Vijay Abraham I (5):
>   ARM: dts: dra72-evm: add evm_3v3_sd regulator
>   ARM: dts: dra72-evm: Set max clock frequency of MMC1 and MMC2
>   ARM: dts: am57xx-beagle-x15: mmc1: remove redundant pbias-supply
>     property
>   ARM: dts: dra7-evm: Fix spurious card insert/removal interrupt
>   ARM: dts: dra72-evm: Fix spurious card insert/removal interrupt
> 
> Nishanth Menon (1):
>   ARM: dts: dra7-evm: Add MMCSD card removal GPIO
> 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
>  arch/arm/boot/dts/dra7-evm.dts          |   18 +++++++++++++++++-
>  arch/arm/boot/dts/dra72-evm.dts         |   16 ++++++++++++++--
>  3 files changed, 31 insertions(+), 4 deletions(-)

Thanks applying all these into omap-for-v4.3/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
