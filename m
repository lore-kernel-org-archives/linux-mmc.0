From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/17 v2] tmio: mmc: header cleanup / sh_mobile_cleanup
Date: Tue, 20 Jan 2015 10:09:53 +0100
Message-ID: <CAPDyKFpAgAJN6wnwzDA3p5u1L-+Wc44n1tmzpWMtt4PDfk3KCg@mail.gmail.com>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+ MFD maintainer

On 13 January 2015 at 05:56, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Ulf
>
> These are v2 of tmio mmc / sh_mobile_sdhi cleanup patches.
> v1 patch and in its discuss, we need 3 type of patch-set
>  1. header cleanup
>  2. sh_mobile_sdhi DMA
>  3. DMAEngine cleanup
>
> These are including 1. header cleanup, and one part of 2. sh_mobile_sdhi DMA.
> If these are accepted, I will send 3. DMAEngine cleanup patch to DMAEngine ML,
> and, left of 2. sh_mobile_sdhi DMA to MMC ML again.
>
>  1) -  9) are header cleanup
> 10) - 17) are one part of sh_mobile_sdhi DMA
>
> Kuninori Morimoto (17):
>        1) mmc: tmio: add tmio_mmc_host_alloc/free()
>        2) mmc: tmio: tmio_mmc_host has .dma
>        3) mmc: tmio: tmio_mmc_host has .write16_hook
>        4) mmc: tmio: tmio_mmc_host has .clk_enable
>        5) mmc: tmio: tmio_mmc_host has .clk_disable
>        6) mmc: tmio: tmio_mmc_host has .multi_io_quirk
>        7) mmc: tmio: tmio_mmc_host has .bus_shift
>        8) mmc: tmio: tmio_mmc_data has .alignment_shift
>        9) mmc: tmio: tmio_mmc_data has .dma_rx_offset
>       10) mmc: tmio: add .enable_dma on tmio_mmc_data
>       11) mmc: tmio: enable SoC specific DMA buswidth settings
>       12) mmc: sh_mobile_sdhi: remove .init/.cleanup
>       13) mmc: sh_mobile_sdhi: tidyup mmc_data->bus_shift for latest SoC
>       14) mmc: sh_mobile_sdhi: add new macro for mmc_host to sh_mobile_sdhi
>       15) mmc: sh_mobile_sdhi: use .enable_dma
>       16) mmc: sh_mobile_sdhi: enable 32bit DMA access
>       17) mmc: remove TMIO_MMC_HAVE_CTL_DMA_REG flag
>
>  drivers/mmc/host/sh_mobile_sdhi.c  |  117 ++++++++++++++++++++----------------
>  drivers/mmc/host/tmio_mmc.c        |   15 +++--
>  drivers/mmc/host/tmio_mmc.h        |   43 +++++++++----
>  drivers/mmc/host/tmio_mmc_dma.c    |   38 ++++++------
>  drivers/mmc/host/tmio_mmc_pio.c    |   59 ++++++++++--------
>  include/linux/mfd/tmio.h           |   28 +--------
>  include/linux/mmc/sh_mobile_sdhi.h |   15 -----
>  7 files changed, 164 insertions(+), 151 deletions(-)
>
>
> Best regards
> ---
> Kuninori Morimoto
