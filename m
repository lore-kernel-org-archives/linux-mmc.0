From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-at91: Fix module autoload
Date: Fri, 21 Oct 2016 10:21:51 +0200
Message-ID: <CAPDyKFoFTV96V-OSdQ40QNZvXVNaKVFACzP6DXW-1U6t4BdbGw@mail.gmail.com>
References: <1476720825-30442-1-git-send-email-javier@osg.samsung.com> <1476720825-30442-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34044 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754112AbcJUIVx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 04:21:53 -0400
Received: by mail-qt0-f172.google.com with SMTP id q7so77755662qtq.1
        for <linux-mmc@vger.kernel.org>; Fri, 21 Oct 2016 01:21:52 -0700 (PDT)
In-Reply-To: <1476720825-30442-2-git-send-email-javier@osg.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 17 October 2016 at 18:13, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
>
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
>
> Before this patch:
>
> $ modinfo drivers/mmc/host/sdhci-of-at91.ko | grep alias
> $
>
> After this patch:
>
> $ modinfo drivers/mmc/host/sdhci-of-at91.ko | grep alias
> alias:          of:N*T*Catmel,sama5d2-sdhciC*
> alias:          of:N*T*Catmel,sama5d2-sdhci
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-at91.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index a9b7fc06c434..2f9ad213377a 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -100,6 +100,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>         { .compatible = "atmel,sama5d2-sdhci", .data = &soc_data_sama5d2 },
>         {}
>  };
> +MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>
>  #ifdef CONFIG_PM
>  static int sdhci_at91_runtime_suspend(struct device *dev)
> --
> 2.7.4
>
