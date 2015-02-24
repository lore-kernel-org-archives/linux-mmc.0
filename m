From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] tmio: mmc: replace sh_mobile_sdhi_info to
 tmio_mmc_data
Date: Tue, 24 Feb 2015 21:53:12 +0530
Message-ID: <20150224162312.GG5208@intel.com>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13375 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbbBXQ0L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Feb 2015 11:26:11 -0500
Content-Disposition: inline
In-Reply-To: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Simon <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tue, Feb 24, 2015 at 11:07:25AM +0900, Kuninori Morimoto wrote:
> 
> Hi Ulf, Vinod, Simon
> 
> DMAEngine cleanup patches are accepted in v4.0-rc1
> 
> As I mentioned in
> http://thread.gmane.org/gmane.linux.ports.sh.devel/42669
> these are last of sh_mobile_sdhi DMA patches.
> 
> These patches uses tmio_mmc_data on platform,
> and remove sh_mobile_sdhi
> 
> These are based on
>  - linus's v4.0-rc1
>  - Vinod's dma/next (git://git.infradead.org/users/vkoul/slave-dma.git :: next)
> 
> Vinod
> 
> please let us know if it has stable tag or branch
Please use topic/sh. I will not rebase that, my next would be rebased
frequently...

-- 
~Vinod

> 
> Simon
> 
> can you check arch/arm/mach-shmobile parts ?
> 
> Kuninori Morimoto (2):
>       mmc: tmio: mmc: tmio: tmio_mmc_data has .chan_priv_?x
>       mmc: sh_mobile_sdhi: remove sh_mobile_sdhi_info
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   20 ++++++++++----------
>  arch/arm/mach-shmobile/board-bockw.c           |   14 +++++++-------
>  arch/arm/mach-shmobile/board-kzm9g.c           |   20 ++++++++++----------
>  arch/arm/mach-shmobile/board-marzen.c          |   10 +++++-----
>  arch/sh/boards/board-sh7757lcr.c               |    9 +++++----
>  arch/sh/boards/mach-ap325rxa/setup.c           |    9 +++++----
>  arch/sh/boards/mach-ecovec24/setup.c           |   20 ++++++++++----------
>  arch/sh/boards/mach-kfr2r09/setup.c            |   10 +++++-----
>  arch/sh/boards/mach-migor/setup.c              |    9 +++++----
>  arch/sh/boards/mach-se/7724/setup.c            |   17 +++++++++--------
>  drivers/mmc/host/sh_mobile_sdhi.c              |   24 +++++-------------------
>  drivers/mmc/host/tmio_mmc.h                    |    2 --
>  drivers/mmc/host/tmio_mmc_dma.c                |    6 +++---
>  include/linux/mfd/tmio.h                       |    2 ++
>  include/linux/mmc/sh_mobile_sdhi.h             |   10 ----------
>  15 files changed, 81 insertions(+), 101 deletions(-)
> 
> 
> Best regards
> ---
> Kuninori Morimoto

-- 
