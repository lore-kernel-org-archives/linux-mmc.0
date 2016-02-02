From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-iproc: use sdhci_pltfm_unregister directly
Date: Tue, 2 Feb 2016 14:11:07 +0100
Message-ID: <CAPDyKFoo4xWSwb5QCX4QS=NWTTZMFo80WevNkwDMwKgKjJWEUQ@mail.gmail.com>
References: <1453803963-6385-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36817 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbcBBNLI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 08:11:08 -0500
Received: by mail-yk0-f178.google.com with SMTP id z7so106977104yka.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 05:11:07 -0800 (PST)
In-Reply-To: <1453803963-6385-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, bcm-kernel-feedback-list@broadcom.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 26 January 2016 at 11:26, Jisheng Zhang <jszhang@marvell.com> wrote:
> The sdhci_iproc_remove() is jsut a wrapper to sdhci_pltfm_unregister.
> So use the sdhci_pltfm_unregister() for the .remove hook directly.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-iproc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 3b423b0..24c5546 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -220,11 +220,6 @@ err:
>         return ret;
>  }
>
> -static int sdhci_iproc_remove(struct platform_device *pdev)
> -{
> -       return sdhci_pltfm_unregister(pdev);
> -}
> -
>  static struct platform_driver sdhci_iproc_driver = {
>         .driver = {
>                 .name = "sdhci-iproc",
> @@ -232,7 +227,7 @@ static struct platform_driver sdhci_iproc_driver = {
>                 .pm = SDHCI_PLTFM_PMOPS,
>         },
>         .probe = sdhci_iproc_probe,
> -       .remove = sdhci_iproc_remove,
> +       .remove = sdhci_pltfm_unregister,
>  };
>  module_platform_driver(sdhci_iproc_driver);
>
> --
> 2.7.0
>
