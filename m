From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: use IS_ENABLE(CONFIG_LEDS_CLASS) to
 enable LED struct members
Date: Fri, 22 Apr 2016 14:54:53 +0200
Message-ID: <CAPDyKFrsyX_K58+otjSZTu2oHgFmTFv==mo+myXYGA+P1kb-7g@mail.gmail.com>
References: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
	<1460607580-22599-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38486 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbcDVMyz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2016 08:54:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so25536769wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2016 05:54:54 -0700 (PDT)
In-Reply-To: <1460607580-22599-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 14 April 2016 at 06:19, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>
> is equivalent to:
>
> IS_ENABLED(CONFIG_LEDS_CLASS)
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes in v2:
>   - Newly added
>
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0decc85..27e8603 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -428,7 +428,7 @@ struct sdhci_host {
>         struct mmc_host_ops mmc_host_ops;       /* MMC host ops */
>         u64 dma_mask;           /* custom DMA mask */
>
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> +#if IS_ENABLED(CONFIG_LEDS_CLASS)
>         struct led_classdev led;        /* LED control */
>         char led_name[32];
>  #endif
> --
> 1.9.1
>
