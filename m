From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc/host/sdhci-of-arasan.c: Omit superfluous error messages
Date: Tue, 28 Oct 2014 10:49:25 +0100
Message-ID: <CAPDyKFrOCV4EWmVpGfNR9ggST0BJTh95de0aU_Y4TtgC0Er+Xw@mail.gmail.com>
References: <CAPDyKFpuiPqZ+5h-SS2-7XeVVh4J2v3SQr=RtjaTZw=0=bXABw@mail.gmail.com>
	<1414482801-3773-1-git-send-email-mike.looijmans@topic.nl>
	<1414482801-3773-2-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:47934 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbaJ1Jt0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Oct 2014 05:49:26 -0400
Received: by mail-qa0-f47.google.com with SMTP id dc16so159799qab.20
        for <linux-mmc@vger.kernel.org>; Tue, 28 Oct 2014 02:49:25 -0700 (PDT)
In-Reply-To: <1414482801-3773-2-git-send-email-mike.looijmans@topic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, Chris Ball <chris@printf.net>

On 28 October 2014 08:53, Mike Looijmans <mike.looijmans@topic.nl> wrote:
> sdhci_add_host and sdhci_platfm_init already report failure,
> so don't emit error messages when a failure occurs. This prevents
> occurences of "deferred" messages when required power supplies
> are not ready for operation yet.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 7ac6718..75bea2e 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -161,7 +161,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
> -               dev_err(&pdev->dev, "platform init failed (%d)\n", ret);
>                 goto clk_disable_all;
>         }
>
> @@ -171,10 +170,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         pltfm_host->clk = clk_xin;
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "platform register failed (%d)\n", ret);
> +       if (ret)
>                 goto err_pltfm_free;
> -       }
>
>         return 0;
>
> --
> 1.7.9.5
>
