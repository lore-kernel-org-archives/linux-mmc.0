From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pic32: remove owner assignment
Date: Mon, 11 Apr 2016 15:33:21 +0200
Message-ID: <CAPDyKFqx=JkU5OXzXbjzcuvdaHTdacA=DZ3nQozmzj0cx0s4-g@mail.gmail.com>
References: <1460092958-16591-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33549 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933078AbcDKNd1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2016 09:33:27 -0400
Received: by mail-vk0-f44.google.com with SMTP id k1so212466890vkb.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2016 06:33:27 -0700 (PDT)
In-Reply-To: <1460092958-16591-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 8 April 2016 at 07:22, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> A platform_driver does not need to set an owner, it will be populated
> by the driver core.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-pic32.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index 059df70..72c13b6 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -243,7 +243,6 @@ MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
>  static struct platform_driver pic32_sdhci_driver = {
>         .driver = {
>                 .name   = "pic32-sdhci",
> -               .owner  = THIS_MODULE,
>                 .of_match_table = of_match_ptr(pic32_sdhci_id_table),
>         },
>         .probe          = pic32_sdhci_probe,
> --
> 1.9.1
>
