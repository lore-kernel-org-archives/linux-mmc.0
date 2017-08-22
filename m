From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: suppress errors when probe is deferred
Date: Tue, 22 Aug 2017 11:27:09 +0200
Message-ID: <CAPDyKFrmZmETqsih2OA9sxr7Yafnowrz6-WuEeha1ef7mBTfXA@mail.gmail.com>
References: <1502970766-23541-1-git-send-email-talho@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:37810 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932256AbdHVJ1K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 05:27:10 -0400
Received: by mail-qt0-f178.google.com with SMTP id 16so93741705qtz.4
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 02:27:10 -0700 (PDT)
In-Reply-To: <1502970766-23541-1-git-send-email-talho@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Timo Alho <talho@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 17 August 2017 at 13:52, Timo Alho <talho@nvidia.com> wrote:
> Don't print error message when clk_get() returns -EPROBE_DEFER. On
> recent Tegra chips (t186 onwards), the clocks are provided by
> auxiliary microprocessor (bpmp) and until the driver for it is probed
> clocks are not available.
>
> While at it, change the real error message more meaningful.
>
> Signed-off-by: Timo Alho <talho@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f668a6f..cdde9ff 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -501,8 +501,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>
>         clk = devm_clk_get(mmc_dev(host->mmc), NULL);
>         if (IS_ERR(clk)) {
> -               dev_err(mmc_dev(host->mmc), "clk err\n");
>                 rc = PTR_ERR(clk);
> +               if (rc != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev,
> +                               "failed to get controller clock: %d\n", rc);

There is no need to print an error in any case, as the common clk
framework deals with relevant error printing.

>                 goto err_clk_get;
>         }
>         clk_prepare_enable(clk);
> --
> 2.7.4
>

Kind regards
Uffe
