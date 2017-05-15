From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Trivial print fix
Date: Mon, 15 May 2017 12:51:21 +0200
Message-ID: <CAPDyKFoWd_WJ98bnr5JND6FoNcM_P470D+Wd4HaSMKZUAfJ-Ew@mail.gmail.com>
References: <1493725383-17180-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35277 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbdEOKvW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2017 06:51:22 -0400
Received: by mail-qk0-f178.google.com with SMTP id a72so90287187qkj.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2017 03:51:22 -0700 (PDT)
In-Reply-To: <1493725383-17180-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, shubhrajyoti.datta@gmail.com

On 2 May 2017 at 13:43, Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
> ret is signed however is printed as unsigned fix the same.
> If printed as a negative number the result is easier to read.
> No functional change.
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v2:
> Change the subject
>
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 1de40e6..77cc68b 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -704,7 +704,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
> +               dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
>                 goto unreg_clk;
>         }
>
> --
> 2.7.4
>
