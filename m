From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/2] mmc: renesas_shci: remove wrong depends on to enable
 compile test
Date: Wed, 8 Nov 2017 15:41:02 +0900
Message-ID: <CAK7LNAT5vQcmDhuhjU0pVw9Fjfea_9N6GocaeU0vYQo_6CZpwQ@mail.gmail.com>
References: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com> <1510041442-15176-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:56109 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbdKHGmI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2017 01:42:08 -0500
In-Reply-To: <1510041442-15176-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

2017-11-07 16:57 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> ARCH_RENESAS is a stronger condition than (ARM || ARM64).
> If ARCH_RENESAS is enabled, (ARM || ARM64) is met as well.
>
> What is worse, the first depends on line prevents COMPILE_TEST from
> enabling this driver.  It should be removed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

A typo in the subject.

renesas_shci  ->  renesas_sdhc




>  drivers/mmc/host/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5420da5..5bc6388 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -581,7 +581,6 @@ config MMC_TMIO
>
>  config MMC_SDHI
>         tristate "Renesas SDHI SD/SDIO controller support"
> -       depends on SUPERH || ARM || ARM64
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         select MMC_TMIO_CORE
>         help
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
