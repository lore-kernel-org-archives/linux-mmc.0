From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: wmt-sdmmc: Fix NULL pointer dereference
Date: Mon, 21 Oct 2013 08:39:32 +0530
Message-ID: <CAK9yfHwBOHANM0XQM6qU0K8ugzRFBR5qwBtQi9G3BmAQz7j+7g@mail.gmail.com>
References: <1378974078-15416-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52112 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3JUDJc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2013 23:09:32 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so5901734pab.22
        for <linux-mmc@vger.kernel.org>; Sun, 20 Oct 2013 20:09:32 -0700 (PDT)
In-Reply-To: <1378974078-15416-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>

On 12 September 2013 13:51, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'of_id' is dereferenced before NULL pointer check. Move it to
> after the check.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Compile tested.
> ---
>  drivers/mmc/host/wmt-sdmmc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 34231d5..3523a72 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -771,7 +771,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         struct device_node *np = pdev->dev.of_node;
>         const struct of_device_id *of_id =
>                 of_match_device(wmt_mci_dt_ids, &pdev->dev);
> -       const struct wmt_mci_caps *wmt_caps = of_id->data;
> +       const struct wmt_mci_caps *wmt_caps;
>         int ret;
>         int regular_irq, dma_irq;
>
> @@ -780,6 +780,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
>                 return -EFAULT;
>         }
>
> +       wmt_caps = of_id->data;
> +
>         if (!np) {
>                 dev_err(&pdev->dev, "Missing SDMMC description in devicetree\n");
>                 return -EFAULT;
> --
> 1.7.9.5
>

Gentle ping...

-- 
With warm regards,
Sachin
