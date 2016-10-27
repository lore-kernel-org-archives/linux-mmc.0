From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: sdhci-msm: Fix error return code in sdhci_msm_probe()
Date: Thu, 27 Oct 2016 09:47:28 +0200
Message-ID: <CAPDyKFq=xSgibqtKfUEKhGNFpBJqMR9w0Ed-P13or9O8TzYyoA@mail.gmail.com>
References: <1477494281-24246-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38900 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbcJ0P3Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 11:29:16 -0400
Received: by mail-wm0-f49.google.com with SMTP id n67so51906261wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 08:29:16 -0700 (PDT)
In-Reply-To: <1477494281-24246-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Georgi Djakov <georgi.djakov@linaro.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 26 October 2016 at 17:04, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fix to return a negative error code from the platform_get_irq_byname()
> error handling case instead of 0, as done elsewhere in this function.
>
> Fixes: ad81d3871004 ("mmc: sdhci-msm: Add support for UHS cards")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 795f16f..b78d72f 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -649,6 +649,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         if (msm_host->pwr_irq < 0) {
>                 dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
>                         msm_host->pwr_irq);
> +               ret = msm_host->pwr_irq;
>                 goto clk_disable;
>         }
>
