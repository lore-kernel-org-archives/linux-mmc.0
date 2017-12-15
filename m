From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/6 v3] mmc: sdhci-spear: Handle return value of platform_get_irq
Date: Fri, 15 Dec 2017 10:17:57 +0100
Message-ID: <CAPDyKFrGUniA53p=mDtLwSGXZKK-fihnJn_wcPuZkDAzWLTh_A@mail.gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <23382b551ade00543aadc588aa74b0648958b907.1511066652.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33289 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755089AbdLOJR6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 04:17:58 -0500
Received: by mail-it0-f66.google.com with SMTP id o130so28770933itg.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2017 01:17:58 -0800 (PST)
In-Reply-To: <23382b551ade00543aadc588aa74b0648958b907.1511066652.git.arvind.yadav.cs@gmail.com>
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
>  drivers/mmc/host/sdhci-spear.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 8c0f884..e04485e 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -82,6 +82,10 @@ static int sdhci_probe(struct platform_device *pdev)
>         host->hw_name = "sdhci";
>         host->ops = &sdhci_pltfm_ops;
>         host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq <= 0) {
> +               ret = -EINVAL;
> +               goto err_host;
> +       }
>         host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
>
>         sdhci = sdhci_priv(host);
> --
> 2.7.4
>
