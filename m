From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: Use GFP_KERNEL instead of hard-coded value
Date: Wed, 14 May 2014 19:01:36 +0800
Message-ID: <CAFRkauBCjiePz-Nj46JmDoTmgOM7ch7BoA0s5SxQ2pn29F5aNg@mail.gmail.com>
References: <1398646711.10750.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:51437 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbaENLBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 07:01:36 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so2515174qgd.27
        for <linux-mmc@vger.kernel.org>; Wed, 14 May 2014 04:01:36 -0700 (PDT)
In-Reply-To: <1398646711.10750.0.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org

2014-04-28 8:58 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 34231d5..3605c37 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -852,7 +852,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         priv->dma_desc_buffer = dma_alloc_coherent(&pdev->dev,
>                                                    mmc->max_blk_count * 16,
>                                                    &priv->dma_desc_device_addr,
> -                                                  208);
> +                                                  GFP_KERNEL);

Hi Ulf,
This is a pretty trivial patch.
Would you pick up this patch?

Regards,
Axel
