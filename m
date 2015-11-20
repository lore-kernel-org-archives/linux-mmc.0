From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: fix mmc_{un,}register_pm_notifier prototypes
Date: Fri, 20 Nov 2015 16:25:29 +0100
Message-ID: <CAPDyKFrakOWJy4_nxYHR40yR=yG=Z_E8_u=_fMp6uSOPjd72Kg@mail.gmail.com>
References: <7826361.qqKATxLhCV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34756 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759817AbbKTPZb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2015 10:25:31 -0500
Received: by ykfs79 with SMTP id s79so168401166ykf.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2015 07:25:30 -0800 (PST)
In-Reply-To: <7826361.qqKATxLhCV@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20 November 2015 at 11:28, Arnd Bergmann <arnd@arndb.de> wrote:
> The mmc pm notifiers were recently reworked, but the new
> code produces a lot of warnings when CONFIG_PM_SLEEP is disabled:
>
> In file included from ../drivers/mmc/core/sdio_bus.c:27:0:
> drivers/mmc/core/core.h:97:13: warning: 'mmc_register_pm_notifier' defined but not used [-Wunused-function]
>
> The obvious solution is to add the 'inline' keyword at the
> function definition, as it should be for any function defined
> in a header file.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0e40be7c20e0 ("mmc: core: Refactor code to register the MMC PM notifier")

My bad. How could I even *not* notice those warnings.

Thanks for helping out Arnd, patch applied!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index bd00ac2cdc1b..0fa86a2afc26 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -94,8 +94,8 @@ int mmc_hs400_to_hs200(struct mmc_card *card);
>  void mmc_register_pm_notifier(struct mmc_host *host);
>  void mmc_unregister_pm_notifier(struct mmc_host *host);
>  #else
> -static void mmc_register_pm_notifier(struct mmc_host *host) { }
> -static void mmc_unregister_pm_notifier(struct mmc_host *host) { }
> +static inline void mmc_register_pm_notifier(struct mmc_host *host) { }
> +static inline void mmc_unregister_pm_notifier(struct mmc_host *host) { }
>  #endif
>
>  #endif
>
