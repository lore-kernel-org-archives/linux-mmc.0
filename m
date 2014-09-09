From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6 v4] mmc: remove MMC_CAP2_NO_MULTI_READ flags
Date: Tue, 9 Sep 2014 14:19:50 +0200
Message-ID: <CAPDyKFoSSjQfssnXOzGSKTzxLr=O6mduLGiC085YU8=0nRoTDg@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 9 September 2014 08:43, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Ulf, Chris, and Simon
>
> These are v4 patches of removing MMC_CAP2_NO_MULTI_READ from mmc.
>
> Simon
> 4) and 5) are for sh-arm patches.
> Can you check these, and give it your Acked-by ?
>
> Kuninori Morimoto (6):
>       1) mmc: use .multi_io_quirk on omap_hsmmc
>       2) mmc: use .multi_io_quirk on tmio_mmc
>       3) mmc: use .multi_io_quirk on sh_mobile
>       4) ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from koelsch
>       5) ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from lager
>       6) mmc: remove MMC_CAP2_NO_MULTI_READ flags

Thanks! Applied for next, with Simon's and Lee's acks.

Kind regards
Uffe

>
>  arch/arm/mach-shmobile/board-koelsch.c |    3 ---
>  arch/arm/mach-shmobile/board-lager.c   |    2 --
>  drivers/mmc/card/block.c               |    5 -----
>  drivers/mmc/host/omap_hsmmc.c          |   14 ++++++++++++--
>  drivers/mmc/host/sh_mobile_sdhi.c      |   20 +++++++++++++++++++-
>  drivers/mmc/host/tmio_mmc_pio.c        |   13 +++++++++++++
>  include/linux/mfd/tmio.h               |    3 +++
>  include/linux/mmc/host.h               |    1 -
>  8 files changed, 47 insertions(+), 14 deletions(-)
>
>
> Best regards
> ---
> Kuninori Morimoto
