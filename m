From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: arasan: Add polling card detect
Date: Mon, 15 May 2017 11:28:20 +0200
Message-ID: <CAPDyKFqnxxhrwZCdi=Y0dfWk7J0cc2jwaWFBPH8kB37961+czg@mail.gmail.com>
References: <1492667088-20866-1-git-send-email-shubhrajyoti.datta@xilinx.com> <1492667088-20866-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34073 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760413AbdEOJ21 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2017 05:28:27 -0400
Received: by mail-qk0-f170.google.com with SMTP id k74so88796982qke.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2017 02:28:26 -0700 (PDT)
In-Reply-To: <1492667088-20866-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, shubhrajyoti.datta@gmail.com

On 20 April 2017 at 07:44, Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
> Add MMC_CAP_NEEDS_POLL flag for card detect if
> no gpio is passed otherwise use gpio as card detect.
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 812e75a..7e02190 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -728,6 +730,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_add_host;
>
> +       if (mmc_card_is_removable(host->mmc) &&
> +           mmc_gpio_get_cd(host->mmc) < 0) {
> +               host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       }
> +
>         pm_runtime_put(&pdev->dev);
>         return 0;
>
> --
> 2.7.4
>

Why don't you use the "broken-cd" DT binding instead?

Kind regards
Uffe
