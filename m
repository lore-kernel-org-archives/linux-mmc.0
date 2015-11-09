From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: MMC_GOLDFISH should depend on HAS_DMA
Date: Mon, 9 Nov 2015 13:43:51 +0100
Message-ID: <CAPDyKFrX53gM2u87FG3RyGcE2SfNFYyippDK+n_aetLrq6kCMg@mail.gmail.com>
References: <1447061761-19783-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36367 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbKIMnv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 07:43:51 -0500
Received: by ykba4 with SMTP id a4so261314518ykb.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2015 04:43:51 -0800 (PST)
In-Reply-To: <1447061761-19783-1-git-send-email-geert@linux-m68k.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Luis de Bethencourt <luisbg@osg.samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 9 November 2015 at 10:36, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If NO_DMA=y:
>
>     ERROR: dma_unmap_sg [drivers/mmc/host/android-goldfish.ko] undefined!
>     ERROR: dma_alloc_coherent [drivers/mmc/host/android-goldfish.ko] undefined!
>     ERROR: dma_map_sg [drivers/mmc/host/android-goldfish.ko] undefined!
>     ERROR: dma_free_coherent [drivers/mmc/host/android-goldfish.ko] undefined!
>
> Add a dependency on HAS_DMA to fix this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index af71de5fda3b48c9..1dee533634c986d7 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -473,6 +473,7 @@ config MMC_DAVINCI
>
>  config MMC_GOLDFISH
>         tristate "goldfish qemu Multimedia Card Interface support"
> +       depends on HAS_DMA
>         depends on GOLDFISH || COMPILE_TEST
>         help
>           This selects the Goldfish Multimedia card Interface emulation
> --
> 1.9.1
>
