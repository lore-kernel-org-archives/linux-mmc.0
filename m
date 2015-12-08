From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3, 3/5] mmc: kconfig: select MFD_SYSCON for MMC_SDHCI_OF_ESDHC
Date: Tue, 8 Dec 2015 14:49:44 +0100
Message-ID: <CAPDyKFowBMaB1YKD79wE5hr40mO8QufbEW3ZfoNcui708pX81g@mail.gmail.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	<1448594417-22515-4-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34512 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365AbbLHNtp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2015 08:49:45 -0500
Received: by vkbs1 with SMTP id s1so12115379vkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2015 05:49:44 -0800 (PST)
In-Reply-To: <1448594417-22515-4-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On 27 November 2015 at 04:20, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> The sdhci-of-esdhc driver needs the syscon support to do
> regmap and access the global utilities registers. So we
> select MFD_SYSCON for MMC_SDHCI_OF_ESDHC here.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
>         - None
> Changes for v3:
>         - Added this patch
> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1526b8a..4fb88ba 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -142,6 +142,7 @@ config MMC_SDHCI_OF_ESDHC
>         depends on MMC_SDHCI_PLTFM
>         depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
>         select MMC_SDHCI_IO_ACCESSORS
> +       select MFD_SYSCON

Perhaps "depends on" is better to use here.

>         help
>           This selects the Freescale eSDHC controller support.
>
> --
> 2.1.0.27.g96db324
>

Kind regards
Uffe
