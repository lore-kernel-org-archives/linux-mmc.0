From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Mon, 14 Dec 2015 14:08:29 +0100
Message-ID: <CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	<1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36654 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbbLNNIa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2015 08:08:30 -0500
Received: by qkht125 with SMTP id t125so132620209qkh.3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2015 05:08:29 -0800 (PST)
In-Reply-To: <1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On 14 December 2015 at 05:24, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> The sdhci-of-esdhc driver needs the GUTS driver support
> to access the global utilities registers for SVR value.
> So we select FSL_GUTS for MMC_SDHCI_OF_ESDHC here.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
>         - None
> Changes for v3:
>         - None
> Changes for v4:
>         - Added this patch
> ---
>  drivers/mmc/host/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1526b8a..df57c14 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -142,6 +142,8 @@ config MMC_SDHCI_OF_ESDHC
>         depends on MMC_SDHCI_PLTFM
>         depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
>         select MMC_SDHCI_IO_ACCESSORS
> +       select SOC_FSL
> +       select FSL_GUTS

This is weird.

First, perhaps it would make sense to have stub functions for those
the FSL_GUTS driver provides via its API, thus the above wouldn't be
required at all. Of course this makes only sense if you think there
are/could be configurations for a cross SOC driver which don't need
the GUTS driver.

Second, even if you think the stubs above is a bad idea, I would from
the top-level Kconfig for your platform, add the needed "selects" as I
think it's where it belongs and then change this to "depends on"
instead.

Kind regards
Uffe
