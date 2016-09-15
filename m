From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] MMC: meson: remove unused variable
Date: Thu, 15 Sep 2016 09:37:26 -0700
Message-ID: <7hh99hktkp.fsf@baylibre.com>
References: <20160915154349.3005248-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35742 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755358AbcIOQh2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2016 12:37:28 -0400
Received: by mail-pa0-f54.google.com with SMTP id oz2so12940561pac.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Sep 2016 09:37:28 -0700 (PDT)
In-Reply-To: <20160915154349.3005248-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Thu, 15 Sep 2016 17:43:35 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The newly added meson mmc driver causes a build warning from an unused
> variable:
>
> drivers/mmc/host/meson-gxbb.c: In function 'meson_mmc_request_done':
> drivers/mmc/host/meson-gxbb.c:411:22: error: unused variable 'cmd' [-Werror=unused-variable]
>
> This removes the variable.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4b331229dda9 ("MMC: meson: initial support for GXBB platforms")

kbuild test robot reported this also, so I already fixed it for linux-next.

Kevin

> ---
>  drivers/mmc/host/meson-gxbb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gxbb.c b/drivers/mmc/host/meson-gxbb.c
> index c73c62178764..193d343d0afe 100644
> --- a/drivers/mmc/host/meson-gxbb.c
> +++ b/drivers/mmc/host/meson-gxbb.c
> @@ -408,7 +408,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> -	struct mmc_command *cmd = host->cmd;
>  
>  	WARN_ON(host->mrq != mrq);
