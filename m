From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6 v3] mmc: sunxi-mmc: Handle return value of platform_get_irq
Date: Fri, 15 Dec 2017 10:18:03 +0100
Message-ID: <CAPDyKFrNsTr9=fpzz2K+aQSS04ziOnLs1KxV-K0StzN=Tb=4MQ@mail.gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <6ad5c6077b96353a77ea30d1b64651c77d5622f6.1511066652.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:46654 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755089AbdLOJSE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 04:18:04 -0500
Received: by mail-it0-f67.google.com with SMTP id t1so17924248ite.5
        for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2017 01:18:04 -0800 (PST)
In-Reply-To: <6ad5c6077b96353a77ea30d1b64651c77d5622f6.1511066652.git.arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Adrian Hunter <adrian.hunter@intel.com>, Viresh Kumar <vireshk@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>

On 19 November 2017 at 05:52, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> platform_get_irq() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL instead of host->irq.
>
>  drivers/mmc/host/sunxi-mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index cc98355d..c926ac8 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1255,6 +1255,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                 goto error_assert_reset;
>
>         host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq <= 0) {
> +               ret = -EINVAL;
> +               goto error_assert_reset;
> +       }
> +
>         return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
>                         sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
>
> --
> 2.7.4
>
