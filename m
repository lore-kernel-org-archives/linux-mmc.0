From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: constify dev_pm_ops structures.
Date: Tue, 11 Jul 2017 16:42:55 +0200
Message-ID: <CAPDyKFqUGoHLt7DqhP_Tz0VKOL83TKfCFW7K21ptwjKAoNdPBg@mail.gmail.com>
References: <8a917dbec5b7eb9fd463cc9b7a596ab831f04965.1498723559.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8a917dbec5b7eb9fd463cc9b7a596ab831f04965.1498723559.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 June 2017 at 10:09, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> dev_pm_ops are not supposed to change at runtime. All functions
> working with dev_pm_ops provided by <linux/device.h> work with const
> dev_pm_ops. So mark the non-const structs as const.
>
> File size before:
>    text    data     bss     dec     hex filename
>   11586     624       0   12210    2fb2 drivers/mmc/host/omap_hsmmc.o
>
> File size After adding 'const':
>    text    data     bss     dec     hex filename
>   11778     432       0   12210    2fb2 drivers/mmc/host/omap_hsmmc.o
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 8c39dcc..5b391dc 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2342,7 +2342,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> -static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
> +static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
>         .runtime_suspend = omap_hsmmc_runtime_suspend,
>         .runtime_resume = omap_hsmmc_runtime_resume,
> --
> 1.9.1
>
