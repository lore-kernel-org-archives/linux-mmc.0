From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH repost] mmc: sh_mmcif: Fix suspend process
Date: Tue, 25 Aug 2015 17:27:33 +0200
Message-ID: <CAPDyKFoRZ2fns=i7tua+dDjLFeMLxOEkcUB4AOPdFHqXs-eYOw@mail.gmail.com>
References: <1440334688-20674-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440334688-20674-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2015 at 14:58, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> The clock should be enable when SDHI registers are accessed.

Yes, correct. But...

>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on mmc-next branch of Ulf Hansson's mmc tree.
>
> * Perhaps this relates to the need to enhance clock management
>
>  drivers/mmc/host/sh_mmcif.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 5a1fdd4..ad9ffea 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1632,7 +1632,9 @@ static int sh_mmcif_suspend(struct device *dev)
>  {
>         struct sh_mmcif_host *host = dev_get_drvdata(dev);
>
> +       pm_runtime_get_sync(dev);
>         sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
> +       pm_runtime_put(dev);

... when will the clock be gated, since the pm_runtime_put() here wont
do the trick!

That's a bit more complicated to deal with, but for now I will apply
this patch as is.

>
>         return 0;
>  }
> --
> 1.9.1
>

Thanks, applied for next!

Kind regards
Uffe
