From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] unshare and simplify omap_hsmmc platform struct
Date: Tue, 23 Sep 2014 09:22:49 -0700
Message-ID: <20140923162249.GF2451@atomide.com>
References: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com
List-Id: linux-mmc@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [140922 04:55]:
> mmci and omap_hsmmc share very little fields in the platform
> struct. unsharing significantly simplifies the omap_hsmmc driver

I think this is good to do. I was hoping we could drop omap3
legacy booting support and completely get rid of the platform_data
for omap_hsmmc. But that happens when it happens, so let's do
this meanwhile to remove some dependencies for the omap_hsmmc
clean-up work.

Some patches have missing descriptions, can you please add those?

Once the patches have proper descriptions, and assuming this
does not break the omap3 legacy booting with the board-*.c
files, please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

As it seems this is best merged via the MMC tree.

Regards,

Tony

 
> Andreas Fenkart (6):
>   omap_hsmmc: unshare platform data struct with mmci driver
>   omap_hsmmc: remove unused callbacks from platform data struct
>   omap_hsmmc: remove unused fields in platform_data
>   omap_hsmmc: remove unused get_context_loss_count callback
>   omap_hsmmc: remove un-initialized callbacks from platform data
>   omap_hsmmc: remove un-initialized get_cover_state callback
> 
>  arch/arm/mach-omap2/hsmmc.c                        |  61 ++--------
>  arch/arm/mach-omap2/hsmmc.h                        |  10 --
>  arch/arm/mach-omap2/mmc.h                          |   6 +-
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   6 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   6 +-
>  drivers/mmc/host/omap_hsmmc.c                      | 133 +++------------------
>  include/linux/platform_data/hsmmc-omap.h           | 103 ++++++++++++++++
>  7 files changed, 142 insertions(+), 183 deletions(-)
>  create mode 100644 include/linux/platform_data/hsmmc-omap.h
