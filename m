From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: davinci: suppress error message on EPROBE_DEFER
Date: Mon, 22 Jan 2018 08:27:31 +0100
Message-ID: <CAPDyKFqu42ophwEi7WTy6iW6nFF94qksAahW1y4qZv2Q=xEe-A@mail.gmail.com>
References: <1516566493-31348-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516566493-31348-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 21 January 2018 at 21:28, David Lechner <david@lechnology.com> wrote:
> This suppresses printing an error message during probe of the TI DaVinci
> MMC driver when the error is EPROBE_DEFER.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: David Lechner <david@lechnology.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/davinci_mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c5309cc..8e36317 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1253,8 +1253,9 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>                 pdev->id_entry = match->data;
>                 ret = mmc_of_parse(mmc);
>                 if (ret) {
> -                       dev_err(&pdev->dev,
> -                               "could not parse of data: %d\n", ret);
> +                       if (ret != -EPROBE_DEFER)
> +                               dev_err(&pdev->dev,
> +                                       "could not parse of data: %d\n", ret);
>                         goto parse_fail;
>                 }
>         } else {
> --
> 2.7.4
>
