From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc-pltfm: fix the potential NULL pointer dereference
Date: Tue, 25 Oct 2016 10:48:17 +0200
Message-ID: <CAPDyKFrc=ZcQ0abQ+=rGhHuGfWZNcP1QuqOC4KbZSYEjg3uqbA@mail.gmail.com>
References: <20161021105757.22712-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35344 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbcJYIsT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2016 04:48:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id c78so149726805wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2016 01:48:18 -0700 (PDT)
In-Reply-To: <20161021105757.22712-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, "# 4.0+" <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 21 October 2016 at 12:57, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> platform_get_resource can be returned the NULL pointer.
> Then regs->start should be referred to NULL Pointer.
> devm_ioremap_resource() checks whether res is NULL or not.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for fixes abd I also added a stable tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index b486fef..1236d49b 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -47,12 +47,13 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>         host->pdata = pdev->dev.platform_data;
>
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       /* Get registers' physical base address */
> -       host->phy_regs = regs->start;
>         host->regs = devm_ioremap_resource(&pdev->dev, regs);
>         if (IS_ERR(host->regs))
>                 return PTR_ERR(host->regs);
>
> +       /* Get registers' physical base address */
> +       host->phy_regs = regs->start;
> +
>         platform_set_drvdata(pdev, host);
>         return dw_mci_probe(host);
>  }
> --
> 2.10.1
>
