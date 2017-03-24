From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/2] mmc: factor out getting dma direction from host
 drivers
Date: Fri, 24 Mar 2017 09:14:22 +0800
Message-ID: <bb5f5138-6d64-1eb0-39a2-277c16dc6ca8@rock-chips.com>
References: <44d784c1-ab30-db59-9037-db8c87935b43@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:43888 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCXBO0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2017 21:14:26 -0400
In-Reply-To: <44d784c1-ab30-db59-9037-db8c87935b43@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Heiner,

On 2017/3/24 5:17, Heiner Kallweit wrote:
> Several host drivers contain identical code for determining the
> DMA direction. Therefore factor this out to the core.

I like this patchset, at least it removes more lines than insertions :)

Only a small nit,

s3cmci_prepare_dma seems need some more cleanup as the rw variable
isn't useful personally. Anyway,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>



>
> Heiner Kallweit (2):
>   mmc: core: add mmc_get_dma_dir
>   mmc: use new core function mmc_get_dma_dir
>
>  drivers/mmc/host/android-goldfish.c | 10 ++--------
>  drivers/mmc/host/atmel-mci.c        |  6 ++----
>  drivers/mmc/host/davinci_mmc.c      | 10 +++-------
>  drivers/mmc/host/dw_mmc.c           | 14 +++-----------
>  drivers/mmc/host/jz4740_mmc.c       |  9 ++-------
>  drivers/mmc/host/mmc_spi.c          |  5 +----
>  drivers/mmc/host/mtk-sd.c           |  8 ++------
>  drivers/mmc/host/mvsdio.c           | 11 +++++------
>  drivers/mmc/host/omap_hsmmc.c       | 17 ++++-------------
>  drivers/mmc/host/s3cmci.c           |  4 ++--
>  drivers/mmc/host/sdhci.c            |  9 +++------
>  drivers/mmc/host/sunxi-mmc.c        | 14 +++-----------
>  include/linux/mmc/host.h            |  6 ++++++
>  13 files changed, 38 insertions(+), 85 deletions(-)
>

