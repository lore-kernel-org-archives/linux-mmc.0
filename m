From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Thu, 26 Jul 2012 15:09:53 +0530
Message-ID: <CAJe_ZhfR2MT5F969fkLXPhYcxn2G6Lgoh_W6hE_qUmVRwX=b8w@mail.gmail.com>
References: <5006571A.7060103@de.bosch.com>
	<CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
	<50068696.8070408@de.bosch.com>
	<CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
	<5006C40D.300@de.bosch.com>
	<CAJe_Zhcyug17ZnKtmKnVhHT=Mm1PKdE68f21WWkUVtfCwNxSwg@mail.gmail.com>
	<50094168.2090900@de.bosch.com>
	<CAJe_Zhfu-k0V7q527JSqdThn_c7WfNcaHmYOwBBaaRh+A=2hKA@mail.gmail.com>
	<50110AFB.9090300@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43968 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab2GZJjy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jul 2012 05:39:54 -0400
Received: by vcbfk26 with SMTP id fk26so1463925vcb.19
        for <linux-mmc@vger.kernel.org>; Thu, 26 Jul 2012 02:39:53 -0700 (PDT)
In-Reply-To: <50110AFB.9090300@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Wohlrab Knut (CM-AI/PJ-CA33)" <Knut.Wohlrab@de.bosch.com>

On 26 July 2012 14:46, Dirk Behme <dirk.behme@de.bosch.com> wrote:

> ---
>  drivers/mmc/card/Kconfig |   27 +++++++++++++++++++++++++++
>  drivers/mmc/card/block.c |    2 +-
>  include/linux/mmc/host.h |    7 +++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> Index: a/drivers/mmc/card/Kconfig
> ===================================================================
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -50,6 +50,33 @@ config MMC_BLOCK_BOUNCE
>
>           If unsure, say Y here.
>
> +config MMC_SLOTINDEX
> +       bool "Use host index for enumerating mmxblkN"
> +       depends on MMC_BLOCK
> +       default n
> +       help
> +         On embedded devices, often there is a combination of
> +         removable mmc devices (e.g. MMC/SD cards) and hard
> +         wired ones (e.g. eMMC). Depending on the hardware
> +         configuration, the 'mmcblkN' node might change if
> +         the removable device is available or not at boot time.
> +
> +         E.g. if the removable device is attached at boot time,
> +         it might become mmxblk0. And the hard wired one mmcblk1.
> +         But if the removable device isn't there at boot time,
> +         the hard wired one will become mmcblk0. This makes it
> +         somehow difficult to hard code the root device to the
> +         non-removable device and boot fast.
> +
> +         Enabling this option will simply associating 'N' of
> +         'mmcblkN' with the slot index instead of the dynamic
> +         name index. The slot index is always the same, ensuring
> +         that the non-removable mmc device is associated always
> +         with the same mmcblkN. Independent of the availability of
> +         the removable one.
> +
> +         If unsure, say N here.
> +
>  config SDIO_UART
>         tristate "SDIO UART/GPS class support"
>         help
> Index: a/drivers/mmc/card/block.c
> ===================================================================
>
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1536,7 +1536,7 @@ static struct mmc_blk_data *mmc_blk_allo
>          */
>
>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> -                "mmcblk%d%s", md->name_idx, subname ? subname : "");
> +                "mmcblk%d%s", NAMEIDX, subname ? subname : "");
>
>
>         blk_queue_logical_block_size(md->queue.queue, 512);
>         set_capacity(md->disk, size);
> Index: a/include/linux/mmc/host.h
> ===================================================================
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -437,4 +437,11 @@ static inline unsigned int mmc_host_clk_
>         return host->ios.clock;
>  }
>  #endif
> +
> +#ifdef CONFIG_MMC_SLOTINDEX
> +#define NAMEIDX (card->host->index)
> +#else
> +#define NAMEIDX (md->name_idx)
> +#endif
> +
>  #endif /* LINUX_MMC_HOST_H */

I would suggest first attempting the original patch ...

        snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-                "mmcblk%d%s", md->name_idx, subname ? subname : "");
+                "mmcblk%d%s", card->host->index, subname ? subname : "");


That would either provide the simplest solution to the problem or
teach us the importance of current naming scheme, in which case you
could try this patch :)
