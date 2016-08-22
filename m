From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: sdhci-bcm-kona: fix error return code in sdhci_bcm_kona_probe()
Date: Mon, 22 Aug 2016 15:39:12 +0200
Message-ID: <CAPDyKFqO3Qi4NW0mOhfbNXeAgkb1FjJr8L9MsOuDeh_quoH8Wg@mail.gmail.com>
References: <1469722664-15136-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38271 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbcHVNjP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 09:39:15 -0400
Received: by mail-wm0-f44.google.com with SMTP id o80so144704044wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2016 06:39:15 -0700 (PDT)
In-Reply-To: <1469722664-15136-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc <linux-mmc@vger.kernel.org>

On 28 July 2016 at 18:17, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> In clk_set_rate() or clk_prepare_enable() error handling case, the
> error return code ret is not set, so sdhci_bcm_kona_probe() return
> 0 in those error cases.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index e5c634b..51dd2fd 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -253,12 +253,14 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>                 goto err_pltfm_free;
>         }
>
> -       if (clk_set_rate(pltfm_priv->clk, host->mmc->f_max) != 0) {
> +       ret = clk_set_rate(pltfm_priv->clk, host->mmc->f_max);
> +       if (ret) {
>                 dev_err(dev, "Failed to set rate core clock\n");
>                 goto err_pltfm_free;
>         }
>
> -       if (clk_prepare_enable(pltfm_priv->clk) != 0) {
> +       ret = clk_prepare_enable(pltfm_priv->clk);
> +       if (ret) {
>                 dev_err(dev, "Failed to enable core clock\n");
>                 goto err_pltfm_free;
>         }
>
