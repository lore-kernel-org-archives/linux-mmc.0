From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: fix spelling mistake: "Perpheral" -> "Peripheral"
Date: Mon, 27 Jun 2016 11:21:53 +0200
Message-ID: <CAPDyKFrfcwpN2zx537fhdEXvUo_xoD4NFfE_6BkGm4-LKkUdBQ@mail.gmail.com>
References: <1466675526-3176-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38285 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcF0JVz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 05:21:55 -0400
Received: by mail-wm0-f45.google.com with SMTP id r201so105720268wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2016 02:21:55 -0700 (PDT)
In-Reply-To: <1466675526-3176-1-git-send-email-colin.king@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 23 June 2016 at 11:52, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> trivial fix to spelling mistake in dev_err message
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 0653fe7..343e4bd 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -473,7 +473,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         msm_host->pclk = devm_clk_get(&pdev->dev, "iface");
>         if (IS_ERR(msm_host->pclk)) {
>                 ret = PTR_ERR(msm_host->pclk);
> -               dev_err(&pdev->dev, "Perpheral clk setup failed (%d)\n", ret);
> +               dev_err(&pdev->dev, "Peripheral clk setup failed (%d)\n", ret);
>                 goto bus_clk_disable;
>         }
>
> --
> 2.8.1
>
