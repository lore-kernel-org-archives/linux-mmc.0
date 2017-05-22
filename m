From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas-sdhi: export renesas_sdhi_probe
Date: Mon, 22 May 2017 17:51:57 +0200
Message-ID: <CAPDyKFoCVyL1D9yUgOXO1ETMTEYdFER7WLdixiRedtXs_7238g@mail.gmail.com>
References: <20170522133339.798278-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522133339.798278-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, Chris Brandt <chris.brandt@renesas.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 May 2017 at 15:33, Arnd Bergmann <arnd@arndb.de> wrote:
> We now build the sdhi driver in separate modules, which means we
> have to export the symbols that are called from another module:
>
> ERROR: "renesas_sdhi_remove" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
> ERROR: "renesas_sdhi_probe" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
>
> Fixes: 94418768f765 ("mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 846ee1a8e5a6..fa6c188e0327 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -638,6 +638,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  eprobe:
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
>
>  int renesas_sdhi_remove(struct platform_device *pdev)
>  {
> @@ -648,3 +649,4 @@ int renesas_sdhi_remove(struct platform_device *pdev)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
> --
> 2.9.0
>
