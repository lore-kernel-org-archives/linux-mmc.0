From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND] mmc: core: try to use an id from the devicetree
Date: Thu, 20 Jun 2019 17:37:14 +0200
Message-ID: <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
References: <20190620152432.1408278-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190620152432.1408278-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

+ Doug

On Thu, 20 Jun 2019 at 17:24, Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> If there's a mmc* alias in the device tree, take the device number from
> it, so that we end up with a device name that matches the alias.

Lots of people would be happy if I queue something along the lines of
what you propose. I am not really having any big problems with it, but
I am reluctant to queue it because of other peoples quite strong
opinions [1] that have been expressed in regards to this already.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/devicetree-spec/msg00254.html

>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/mmc/core/host.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 6a51f7a06ce7..4733ddb894da 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -411,7 +411,12 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         /* scanning will be enabled when we're ready */
>         host->rescan_disable = 1;
>
> -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> +       /* prefer an alias */
> +       err = of_alias_get_id(dev->of_node, "mmc");
> +       if (err < 0)
> +               err = 0;
> +
> +       err = ida_simple_get(&mmc_host_ida, err, 0, GFP_KERNEL);
>         if (err < 0) {
>                 kfree(host);
>                 return NULL;
> --
> 2.21.0
>
