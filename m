From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/11] mmc: omap: fix error return code
Date: Tue, 25 Aug 2015 17:26:51 +0200
Message-ID: <CAPDyKFotb6+iz=HkiLp=0XtBDgwFhWUBkVZ3beAU5eMKfACteA@mail.gmail.com>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
	<1440288682-12732-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440288682-12732-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, kernel-janitors@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2015 at 02:11, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> Return a negative error code on failure.
>
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>  drivers/mmc/host/omap.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 70dcf07..b763b11 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1420,8 +1420,10 @@ static int mmc_omap_probe(struct platform_device *pdev)
>         host->reg_shift = (mmc_omap7xx() ? 1 : 2);
>
>         host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
> -       if (!host->mmc_omap_wq)
> +       if (!host->mmc_omap_wq) {
> +               ret = -ENOMEM;
>                 goto err_plat_cleanup;
> +       }
>
>         for (i = 0; i < pdata->nr_slots; i++) {
>                 ret = mmc_omap_new_slot(host, i);
>
