From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH v2 2/2] mmc: mxs-mmc: add non-removable property
Date: Tue, 9 Apr 2013 17:14:27 +0200
Message-ID: <51643053.7030302@digi.com>
References: <1365166070-9370-1-git-send-email-mkl@pengutronix.de> <1365166070-9370-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365166070-9370-3-git-send-email-mkl@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, cjb@laptop.org, aletes.xgr@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Dear Marc Kleine-Budde,

On 04/05/2013 02:47 PM, Marc Kleine-Budde wrote:
> Some boards have non removable cards like eMMC. Handle such case.
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> changes since v1:
> - fix removeable typo
>
>   drivers/mmc/host/mxs-mmc.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 0cdf1f6..c231881 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -73,6 +73,7 @@ struct mxs_mmc_host {
>   	int				wp_gpio;
>   	bool				wp_inverted;
>   	bool				cd_inverted;
> +	bool				non_removable;
>   };
>
>   static int mxs_mmc_get_ro(struct mmc_host *mmc)
> @@ -96,8 +97,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>   	struct mxs_mmc_host *host =3D mmc_priv(mmc);
>   	struct mxs_ssp *ssp =3D &host->ssp;
>
> -	return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
> -		 BM_SSP_STATUS_CARD_DETECT)) ^ host->cd_inverted;
> +	return host->non_removable ||
> +		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
> +		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
>   }
>
>   static void mxs_mmc_reset(struct mxs_mmc_host *host)
> @@ -687,8 +689,10 @@ static int mxs_mmc_probe(struct platform_device =
*pdev)
>   		mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>   	else if (bus_width =3D=3D 8)
>   		mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> +	host->non_removable =3D of_property_read_bool(np, "non-removable");
> +	if (host->non_removable)
> +		mmc->caps |=3D MMC_CAP_NONREMOVABLE;
>   	host->wp_gpio =3D of_get_named_gpio_flags(np, "wp-gpios", 0, &flag=
s);
> -
>   	if (flags & OF_GPIO_ACTIVE_LOW)
>   		host->wp_inverted =3D 1;
>
>

It looks like Alexander and I were looking at the same in different thr=
eads:
   http://comments.gmane.org/gmane.linux.kernel.mmc/19964
   http://comments.gmane.org/gmane.linux.kernel/1471409

The following completes your 2/2 patch with broken-cd support as well (=
in both cases=20
system must assume card is always present):

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 206fe49..7a60097 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -72,6 +72,8 @@ struct mxs_mmc_host {
         int                             sdio_irq_en;
         int                             wp_gpio;
         bool                            wp_inverted;
+       bool                            broken_cd;
+       bool                            non_removable;
  };

  static int mxs_mmc_get_ro(struct mmc_host *mmc)
@@ -95,7 +97,8 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
         struct mxs_mmc_host *host =3D mmc_priv(mmc);
         struct mxs_ssp *ssp =3D &host->ssp;

-       return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+       return host->non_removable || host->broken_cd ||
+              !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
                  BM_SSP_STATUS_CARD_DETECT);
  }

@@ -686,8 +689,11 @@ static int mxs_mmc_probe(struct platform_device *p=
dev)
                 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
         else if (bus_width =3D=3D 8)
                 mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA=
;
+       host->broken_cd =3D of_property_read_bool(np, "broken-cd");
+       host->non_removable =3D of_property_read_bool(np, "non-removabl=
e");
+       if (host->non_removable)
+               mmc->caps |=3D MMC_CAP_NONREMOVABLE;
         host->wp_gpio =3D of_get_named_gpio_flags(np, "wp-gpios", 0, &=
flags);
-
         if (flags & OF_GPIO_ACTIVE_LOW)
                 host->wp_inverted =3D 1;


Regards,
--=20
H=E9ctor Palacios
