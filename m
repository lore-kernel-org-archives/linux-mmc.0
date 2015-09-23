From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: debugfs: implement ios show for driver type
Date: Wed, 23 Sep 2015 23:42:34 +0200
Message-ID: <CAPDyKFqEBC3fj3f32yyLjDGNtu9XzNopXc=UOgEUy3d8s-pNkg@mail.gmail.com>
References: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
	<1442884808-11652-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442884808-11652-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 September 2015 at 03:20, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch add ios->drv_type for mmc_ios_show to show the
> card's driver type.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/debugfs.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 31155e8..5243e5f 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -172,6 +172,25 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>         }
>         seq_printf(s, "signal voltage:\t%u (%s)\n", ios->chip_select, str);
>
> +       switch (ios->drv_type) {
> +       case MMC_SET_DRIVER_TYPE_A:
> +               str = "driver type A";
> +               break;
> +       case MMC_SET_DRIVER_TYPE_B:
> +               str = "driver type B";
> +               break;
> +       case MMC_SET_DRIVER_TYPE_C:
> +               str = "driver type C";
> +               break;
> +       case MMC_SET_DRIVER_TYPE_D:
> +               str = "driver type D";
> +               break;
> +       default:
> +               str = "invalid";
> +               break;
> +       }
> +       seq_printf(s, "driver type:\t%u (%s)\n", ios->drv_type, str);
> +
>         return 0;
>  }
>
> --
> 2.3.7
>
>
