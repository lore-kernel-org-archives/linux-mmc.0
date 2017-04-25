From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: sdhci-xenon: Remove redundant dev_err call in get_dt_pad_ctrl_data()
Date: Tue, 25 Apr 2017 09:57:05 +0200
Message-ID: <CAPDyKFp0rZB4MN7LJxvtb67emZ9B1D0x9yyHeDqbgOUiwwQueQ@mail.gmail.com>
References: <20170425063446.32726-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33573 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176227AbdDYH5H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Apr 2017 03:57:07 -0400
Received: by mail-qt0-f178.google.com with SMTP id m36so133193299qtb.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Apr 2017 00:57:06 -0700 (PDT)
In-Reply-To: <20170425063446.32726-1-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Hu Ziji <huziji@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Wei Yongjun <weiyongjun1@huawei.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 25 April 2017 at 08:34, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index 4bdbcd3..d43841e 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -639,11 +639,8 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
>
>         params->pad_ctrl.reg = devm_ioremap_resource(mmc_dev(host->mmc),
>                                                      &iomem);
> -       if (IS_ERR(params->pad_ctrl.reg)) {
> -               dev_err(mmc_dev(host->mmc), "Unable to get SoC PHY PAD ctrl register for %s\n",
> -                       np->name);
> +       if (IS_ERR(params->pad_ctrl.reg))
>                 return PTR_ERR(params->pad_ctrl.reg);
> -       }
>
>         ret = of_property_read_string(np, "marvell,pad-type", &name);
>         if (ret) {
>
>
>
