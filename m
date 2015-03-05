From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] mmc: omap_hsmmc: simplify cover/card detect logic
Date: Thu, 5 Mar 2015 14:43:48 +0100
Message-ID: <CAPDyKFoepEcJsW16zry9tNsyXx8=GMk8SfjwkTbw+ySHTVg7+g@mail.gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 3 March 2015 at 13:28, Andreas Fenkart <afenkart@gmail.com> wrote:
> These patches are trying to clean up the cover/card detect logic.
>
>   Mobile phones (some) have no card detect pin, but
>   can detect if the cover is removed. The purpose is the
>   same; detect if card is being added/removed, but the
>   details differ.
>   When the cover is removed, it does not mean the card is
>   gone. But it might, since it is accessible now. It's like
>   a warning. All the driver does is to limit write access to
>   the card, see protect_card flag. In contrast, card detect
>   notifies us after the fact, e.g. card is gone, card is
>   inserted.
>
> While cover detect is only used by one platform (rx51), it
> complicates the card detect logic. By separating the code
> paths they both become easier to understand and maintain
>
> Patches have been tested by reverting: 95bebb5696ab
> 'mmc: omap_hsmmc: use mmc_of_parse to parse common mmc configuration'
> otherwise gpio detection is handled by mmc_of_parse
>
> compile tested
> OMAP2:
> CONFIG_MACH_OMAP2_TUSB6010=y
> CONFIG_MACH_OMAP3_BEAGLE=y
> CONFIG_MACH_DEVKIT8000=y
> CONFIG_MACH_OMAP_LDP=y
> CONFIG_MACH_OMAP3530_LV_SOM=y
> CONFIG_MACH_OMAP3_TORPEDO=y
> CONFIG_MACH_OVERO=y
> CONFIG_MACH_OMAP3517EVM=y
> CONFIG_MACH_CRANEBOARD=y
> CONFIG_MACH_OMAP3_PANDORA=y
> CONFIG_MACH_TOUCHBOOK=y
> CONFIG_MACH_OMAP_3430SDP=y
> CONFIG_MACH_NOKIA_N810=y
> CONFIG_MACH_NOKIA_N810_WIMAX=y
> CONFIG_MACH_NOKIA_N8X0=y
> CONFIG_MACH_NOKIA_RX51=y
> CONFIG_MACH_CM_T35=y
> CONFIG_MACH_CM_T3517=y
> CONFIG_MACH_CM_T3730=y
> CONFIG_MACH_SBC3530=y
> CONFIG_MACH_TI8168EVM=y
> CONFIG_MACH_TI8148EVM=y
>
> Andreas Fenkart (6):
>   mmc: omap_hsmmc: remove unused fields from struct omap_hsmmc_host
>   mmc: omap_hsmmc: use slot-gpio functions to manage read-only pin
>     directly
>   mmc: omap_hsmmc: use distinctive code paths for cover / card detect
>     logic
>   ARM: OMAP2: HSMMC: platform_data: explicit gpio_cover / gpio_cd fields
>   mmc: omap_hsmmc: simplify card/cover detect isr
>   mmc: omap_hsmmc: use generic slot-gpio isr to manage card detect pin
>
>  arch/arm/mach-omap2/hsmmc.c              | 33 +++++++++----
>  drivers/mmc/host/omap_hsmmc.c            | 80 +++++++++-----------------------
>  include/linux/platform_data/hsmmc-omap.h |  6 +--
>  3 files changed, 48 insertions(+), 71 deletions(-)
>
> --
> 2.1.4
>

Applied patch 1->3, thanks!

If I get an ack for patch 4 (ARM) and can take them all through my tree.

Kind regards
Uffe
