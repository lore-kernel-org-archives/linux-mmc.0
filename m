From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: Add MODULE_LICENSE
Date: Fri, 15 Dec 2017 10:18:46 +0100
Message-ID: <CAPDyKFoKdQ4YU9nCe2P1dwp1jV=bhRWRZGGPk62FuJE=PnZ5ig@mail.gmail.com>
References: <1513132380-7421-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:41232 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755236AbdLOJSr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 04:18:47 -0500
Received: by mail-it0-f68.google.com with SMTP id x28so18106628ita.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Dec 2017 01:18:47 -0800 (PST)
In-Reply-To: <1513132380-7421-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

On 13 December 2017 at 03:33, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>
> The following error occurs when loading renesas_sdhi_core.c module,
> so add MODULE_LICENSE("GPL v2").
>
>  renesas_sdhi_core: module license 'unspecified' taints kernel.
>
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Fixes: 9d08428afb72 ("mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file")
> Cc: <stable@vger.kernel.org> # v4.13+
> [Shimoda: Added Fixes tag and Cc to the stable ML]
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index fcf7235..157e1d9 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -24,6 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
>  #include <linux/slab.h>
> +#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/mmc/host.h>
> @@ -667,3 +668,5 @@ int renesas_sdhi_remove(struct platform_device *pdev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
> +
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>
