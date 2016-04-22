From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: use IS_REACHABLE(CONFIG_LEDS_CLASS) to
 enable LED code
Date: Fri, 22 Apr 2016 14:54:58 +0200
Message-ID: <CAPDyKFrj1t_-9ErqWfz-X0CKLutS46Pw+kXbASRBTkUtXwLXyA@mail.gmail.com>
References: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36175 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbcDVMzA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2016 08:55:00 -0400
Received: by mail-wm0-f44.google.com with SMTP id v188so19960631wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2016 05:54:59 -0700 (PDT)
In-Reply-To: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 14 April 2016 at 06:19, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>     defined(CONFIG_MMC_SDHCI_MODULE))
>
> is equivalent to:
>
> defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>     defined(MODULE))
>
> and it can also be written shortly as:
>
> IS_REACHABLE(CONFIG_LEDS_CLASS)
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
> Changes in v2:
>   - Rebase on the next branch (7766e58f5be39dcc35d30a703422a3d0b8ec8c0c)
>
>  drivers/mmc/host/sdhci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b284924..eedc18a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -259,9 +259,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>
> -#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
> -                                  defined(CONFIG_MMC_SDHCI_MODULE))
> -
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>  static void sdhci_led_control(struct led_classdev *led,
>                               enum led_brightness brightness)
>  {
> --
> 1.9.1
>
