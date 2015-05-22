From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix driver type B and D handling in sdhci_do_set_ios()
Date: Fri, 22 May 2015 15:47:49 +0200
Message-ID: <CAPDyKFoYQXnXFh5ybcn4Abg7XpKT04xmL3wQ82O6nKH6dUxsNg@mail.gmail.com>
References: <20150520213501.15A7322078C@puck.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:34071 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbbEVNru (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2015 09:47:50 -0400
Received: by qctt3 with SMTP id t3so8097150qct.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2015 06:47:49 -0700 (PDT)
In-Reply-To: <20150520213501.15A7322078C@puck.mtv.corp.google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 20 May 2015 at 23:35, Petri Gynther <pgynther@google.com> wrote:
> sdhci_do_set_ios() doesn't currently program SDHCI_HOST_CONTROL2
> register correctly when host->preset_enabled == false.
>
> Add code to handle the missing cases MMC_SET_DRIVER_TYPE_B and
> MMC_SET_DRIVER_TYPE_D.
>
> Signed-off-by: Petri Gynther <pgynther@google.com>

Thanks, applied.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c80287a..5d32a00 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1562,8 +1562,17 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>                         ctrl_2 &= ~SDHCI_CTRL_DRV_TYPE_MASK;
>                         if (ios->drv_type == MMC_SET_DRIVER_TYPE_A)
>                                 ctrl_2 |= SDHCI_CTRL_DRV_TYPE_A;
> +                       else if (ios->drv_type == MMC_SET_DRIVER_TYPE_B)
> +                               ctrl_2 |= SDHCI_CTRL_DRV_TYPE_B;
>                         else if (ios->drv_type == MMC_SET_DRIVER_TYPE_C)
>                                 ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
> +                       else if (ios->drv_type == MMC_SET_DRIVER_TYPE_D)
> +                               ctrl_2 |= SDHCI_CTRL_DRV_TYPE_D;
> +                       else {
> +                               pr_warn("%s: invalid driver type, default to "
> +                                       "driver type B\n", mmc_hostname(mmc));
> +                               ctrl_2 |= SDHCI_CTRL_DRV_TYPE_B;
> +                       }
>
>                         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>                 } else {
> --
> 2.2.0.rc0.207.ga3a616c
>
