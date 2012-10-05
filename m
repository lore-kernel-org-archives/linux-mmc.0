From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 09/16] ARM: OMAP: Split plat/mmc.h into local headers and platform_data
Date: Fri, 5 Oct 2012 12:08:50 +0530
Message-ID: <CAOyx1LpfdM1_BE23-GVvGAcNAHos694J-Ob1cHNkLid31O-sSw@mail.gmail.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
	<20121004220454.26676.10131.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51880 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab2JEGiw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Oct 2012 02:38:52 -0400
In-Reply-To: <20121004220454.26676.10131.stgit@muffinssi.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Fri, Oct 5, 2012 at 3:34 AM, Tony Lindgren <tony@atomide.com> wrote:
> We need to remove this from plat for ARM common zImage
> support.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks Tony. I suppose this should go into your tree..
Acked-by: Venkatraman S <svenkatr@ti.com>

> ---
>  arch/arm/mach-omap1/board-h2-mmc.c         |    5 +--
>  arch/arm/mach-omap1/board-h3-mmc.c         |    3 +-
>  arch/arm/mach-omap1/board-htcherald.c      |    2 +
>  arch/arm/mach-omap1/board-innovator.c      |    2 +
>  arch/arm/mach-omap1/board-nokia770.c       |    2 +
>  arch/arm/mach-omap1/board-sx1-mmc.c        |    3 +-
>  arch/arm/mach-omap1/devices.c              |    2 +
>  arch/arm/mach-omap1/mmc.h                  |   18 +++++++++++
>  arch/arm/mach-omap2/board-4430sdp.c        |    2 +
>  arch/arm/mach-omap2/board-n8x0.c           |    2 +
>  arch/arm/mach-omap2/board-omap4panda.c     |    2 +
>  arch/arm/mach-omap2/board-rm680.c          |    2 +
>  arch/arm/mach-omap2/hsmmc.c                |    2 +
>  arch/arm/mach-omap2/mmc.h                  |   23 ++++++++++++++
>  arch/arm/mach-omap2/msdi.c                 |    2 +
>  arch/arm/mach-omap2/omap4-common.c         |    2 +
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    2 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +
>  drivers/mmc/host/omap.c                    |    3 +-
>  drivers/mmc/host/omap_hsmmc.c              |    2 +
>  include/linux/platform_data/mmc-omap.h     |   45 +---------------------------
>  24 files changed, 67 insertions(+), 67 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/mmc.h
>  create mode 100644 arch/arm/mach-omap2/mmc.h
