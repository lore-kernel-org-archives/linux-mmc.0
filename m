From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 09/11] mmc: kconfig: replace PPC_OF with PPC
Date: Thu, 5 Mar 2015 14:50:15 +0100
Message-ID: <CAPDyKFpRcoXOvnvoiDx72nVsvrADODDCncdAz=YP19kRM99Ucw@mail.gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
	<1424952503-8247-10-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38540 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbCENuP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:50:15 -0500
Received: by mail-qa0-f53.google.com with SMTP id j7so1738556qaq.12
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 05:50:15 -0800 (PST)
In-Reply-To: <1424952503-8247-10-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 26 February 2015 at 13:08, Kevin Hao <haokexin@gmail.com> wrote:
> The PPC_OF is a ppc specific option which is used to mean that the
> firmware device tree access functions are available. Since all the
> ppc platforms have a device tree, it is aways set to 'y' for ppc.
> So it makes no sense to keep a such option in the current kernel.
> Replace it with PPC.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied, thanks!

Kind regards
Uffe


> ---
> v2: No change.
>
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 61ac63a3776a..7858d7a52818 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -132,7 +132,7 @@ config MMC_SDHCI_OF_ARASAN
>  config MMC_SDHCI_OF_ESDHC
>         tristate "SDHCI OF support for the Freescale eSDHC controller"
>         depends on MMC_SDHCI_PLTFM
> -       depends on PPC_OF
> +       depends on PPC
>         select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>         help
>           This selects the Freescale eSDHC controller support.
> @@ -144,7 +144,7 @@ config MMC_SDHCI_OF_ESDHC
>  config MMC_SDHCI_OF_HLWD
>         tristate "SDHCI OF support for the Nintendo Wii SDHCI controllers"
>         depends on MMC_SDHCI_PLTFM
> -       depends on PPC_OF
> +       depends on PPC
>         select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> --
> 1.9.3
>
