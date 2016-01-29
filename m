From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 02/15] mmc: sunxi: Return error on mmc_regulator_set_ocr()
 fail in .set_ios op
Date: Fri, 29 Jan 2016 12:40:03 +0100
Message-ID: <CAPDyKFo1+c6RXvo=LRT9ofKLRF4-sWyHD2e5DBD1BfvUp7Z8FQ@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
	<1453354002-28366-3-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453354002-28366-3-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

On 21 January 2016 at 06:26, Chen-Yu Tsai <wens@csie.org> wrote:
> Let .set_ios() fail if mmc_regulator_set_ocr() fails to enable and set a
> proper voltage for vmmc.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index cce5ca540857..790f01662b4e 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -711,7 +711,10 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 break;
>
>         case MMC_POWER_UP:
> -               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +               host->ferror = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> +                                                    ios->vdd);
> +               if (host->ferror)
> +                       return;
>
>                 host->ferror = sunxi_mmc_init_host(mmc);
>                 if (host->ferror)
> --
> 2.7.0.rc3
>
