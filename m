From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 040/102] mmc: sunxi: explicitly request exclusive reset control
Date: Thu, 27 Jul 2017 16:48:55 +0200
Message-ID: <CAPDyKFqcGup5T5=D=1+S9bHTFNOnNqHwmnU7aWC4voHqYO=Z-Q@mail.gmail.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de> <20170719152646.25903-41-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-41-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 July 2017 at 17:25, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>
> No functional changes.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>


Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d6fa2214aaae8..522b09d446494 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1168,7 +1168,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                 }
>         }
>
> -       host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
> +       host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +                                                               "ahb");
>         if (PTR_ERR(host->reset) == -EPROBE_DEFER)
>                 return PTR_ERR(host->reset);
>
> --
> 2.11.0
>
