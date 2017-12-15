From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/6 v3] mmc: s3cmci: Fix platform_get_irq's error checking
Date: Fri, 15 Dec 2017 10:17:36 +0100
Message-ID: <CAPDyKFrXmV8OgLj_YcBTqVWCUKFO=Q19fJU1iFPm61=TFLCjOw@mail.gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <870b1a28108a8c0f3885bd345f3d27dda67621d5.1511066652.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <870b1a28108a8c0f3885bd345f3d27dda67621d5.1511066652.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Adrian Hunter <adrian.hunter@intel.com>, Viresh Kumar <vireshk@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 19 November 2017 at 05:52, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL instead of host->irq.
>
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index f7f157a..36daee1 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1658,7 +1658,7 @@ static int s3cmci_probe(struct platform_device *pdev)
>         }
>
>         host->irq = platform_get_irq(pdev, 0);
> -       if (host->irq == 0) {
> +       if (host->irq <= 0) {
>                 dev_err(&pdev->dev, "failed to get interrupt resource.\n");
>                 ret = -EINVAL;
>                 goto probe_iounmap;
> --
> 2.7.4
>
