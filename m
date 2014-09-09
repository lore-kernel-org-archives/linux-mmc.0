From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7 v3] mmc: remove MMC_CAP2_NO_MULTI_READ flags
Date: Tue, 9 Sep 2014 11:43:16 +0900
Message-ID: <20140909024310.GE31320@verge.net.au>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
 <87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50198 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbaIICnT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Sep 2014 22:43:19 -0400
Content-Disposition: inline
In-Reply-To: <87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tue, Sep 02, 2014 at 07:08:02PM -0700, Kuninori Morimoto wrote:
> 
> Hi Ulf, Chris, and Simon
> 
> These are v3 patches of removing MMC_CAP2_NO_MULTI_READ from mmc.
> 
> Simon
> 5) and 6) are for sh-arm patches.
> Can you check it ?
> 
> Kuninori Morimoto (7):
>       mmc: add .multi_io_quirk callback for multi I/O HW bug
>       mmc: use .multi_io_quirk on omap_hsmmc
>       mmc: use .multi_io_quirk on tmio_mmc
>       mmc: use .multi_io_quirk on sh_mobile
>       ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from koelsch
>       ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from lager

Hi Morimoto-san,

could you let me know about the dependencies for the above two patches?

>       mmc: remove MMC_CAP2_NO_MULTI_READ flags
> 
>  arch/arm/mach-shmobile/board-koelsch.c |    3 ---
>  arch/arm/mach-shmobile/board-lager.c   |    2 --
>  drivers/mmc/card/block.c               |   13 +++++++++----
>  drivers/mmc/host/omap_hsmmc.c          |   17 ++++++++++++++++-
>  drivers/mmc/host/sh_mobile_sdhi.c      |   20 +++++++++++++++++++-
>  drivers/mmc/host/tmio_mmc_pio.c        |   13 +++++++++++++
>  include/linux/mfd/tmio.h               |    4 ++++
>  include/linux/mmc/host.h               |    8 +++++++-
>  8 files changed, 68 insertions(+), 12 deletions(-)
> 
> Best regards
> ---
> Kuninori Morimoto
> 
