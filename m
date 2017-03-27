From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/2] mmc: factor out getting dma direction from host drivers
Date: Mon, 27 Mar 2017 10:22:33 +0200
Message-ID: <CAPDyKFqzwKdsa=6YrDFp6765jfx54-vRz5Ycf2tYhQzWsRcUiQ@mail.gmail.com>
References: <d3d01681-9456-0800-733f-369f6d3a26be@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33214 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdC0IWf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2017 04:22:35 -0400
Received: by mail-vk0-f47.google.com with SMTP id d188so42974143vka.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2017 01:22:34 -0700 (PDT)
In-Reply-To: <d3d01681-9456-0800-733f-369f6d3a26be@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 26 March 2017 at 20:39, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Several host drivers contain identical code for determining the
> DMA direction. Therefore factor this out to the core.
>
> v2:
> - use new function in more new places
> v3:
> - fix a compile error in change to atmel driver
>
> Heiner Kallweit (2):
>   mmc: core: add mmc_get_dma_dir
>   mmc: use new core function mmc_get_dma_dir
>
>  drivers/mmc/host/android-goldfish.c | 10 ++--------
>  drivers/mmc/host/atmel-mci.c        | 30 +++++++++++-------------------
>  drivers/mmc/host/davinci_mmc.c      | 14 ++++----------
>  drivers/mmc/host/dw_mmc.c           | 14 +++-----------
>  drivers/mmc/host/jz4740_mmc.c       |  9 ++-------
>  drivers/mmc/host/mmc_spi.c          |  5 +----
>  drivers/mmc/host/mmci.c             | 20 ++++++++------------
>  drivers/mmc/host/moxart-mmc.c       |  8 +++-----
>  drivers/mmc/host/mtk-sd.c           |  8 ++------
>  drivers/mmc/host/mvsdio.c           | 11 +++++------
>  drivers/mmc/host/omap_hsmmc.c       | 17 ++++-------------
>  drivers/mmc/host/s3cmci.c           |  4 ++--
>  drivers/mmc/host/sdhci.c            |  9 +++------
>  drivers/mmc/host/sunxi-mmc.c        | 14 +++-----------
>  include/linux/mmc/host.h            |  6 ++++++
>  15 files changed, 59 insertions(+), 120 deletions(-)
>
> --
> 2.12.0
>
>

Thanks, applied for next!

Kind regards
Uffe
