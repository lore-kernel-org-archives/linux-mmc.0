From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-xenon: remove pointless struct xenon_priv *priv
Date: Tue, 11 Jul 2017 16:44:33 +0200
Message-ID: <CAPDyKFo1h_xi4PovH8poDgvv+FX8tZC-36-WZAoYnpSygRJ62A@mail.gmail.com>
References: <1499328923-89408-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34230 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933435AbdGKOof (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:44:35 -0400
Received: by mail-qk0-f180.google.com with SMTP id d78so2755812qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:44:35 -0700 (PDT)
In-Reply-To: <1499328923-89408-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>

On 6 July 2017 at 10:15, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> It was never used and leave a long standing compile warning:
>
> drivers/mmc/host/sdhci-xenon.c: In function 'xenon_probe':
> drivers/mmc/host/sdhci-xenon.c:447:21: warning: variable 'priv' set but
> not used [-Wunused-but-set-variable]
>
> Remove it to fix the warning.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-xenon.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index bc1781b..6ef33aa 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -444,7 +444,6 @@ static int xenon_probe(struct platform_device *pdev)
>  {
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
> -       struct xenon_priv *priv;
>         int err;
>
>         host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
> @@ -453,7 +452,6 @@ static int xenon_probe(struct platform_device *pdev)
>                 return PTR_ERR(host);
>
>         pltfm_host = sdhci_priv(host);
> -       priv = sdhci_pltfm_priv(pltfm_host);
>
>         /*
>          * Link Xenon specific mmc_host_ops function,
> --
> 1.9.1
>
>
