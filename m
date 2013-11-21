From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v3 1/8] mmc: omap_hsmmc: use devm_regulator API
Date: Thu, 21 Nov 2013 16:08:45 +0100
Message-ID: <CAPDyKFoS3i3eMKy817emRWoZ5OMKr7LgP3mjj2ePBBGcN5ZB2w@mail.gmail.com>
References: <20130613174554.GB1403@sirena.org.uk>
	<1385043627-30439-1-git-send-email-balajitk@ti.com>
	<1385043627-30439-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1385043627-30439-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 21 November 2013 15:20, Balaji T K <balajitk@ti.com> wrote:
> Use devm_regulator API, while at it use
> devm_regulator_get_optional for optional vmmc_aux supply
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index dbd32ad..1eb4350 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -316,7 +316,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>         struct regulator *reg;
>         int ocr_value = 0;
>
> -       reg = regulator_get(host->dev, "vmmc");
> +       reg = devm_regulator_get(host->dev, "vmmc");
>         if (IS_ERR(reg)) {
>                 dev_err(host->dev, "vmmc regulator missing\n");
>                 return PTR_ERR(reg);
> @@ -336,7 +336,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>                 }
>
>                 /* Allow an aux regulator */
> -               reg = regulator_get(host->dev, "vmmc_aux");
> +               reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
>                 host->vcc_aux = IS_ERR(reg) ? NULL : reg;
>
>                 /* For eMMC do not power off when not in sleep state */
> @@ -366,8 +366,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>
>  static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
>  {
> -       regulator_put(host->vcc);
> -       regulator_put(host->vcc_aux);
>         mmc_slot(host).set_power = NULL;
>  }

While you are touching this code I would suggest to convert to
mmc_regulator_get_supply instead. That mean the vmmc_aux change name
to vqmmc though, so you need to adapt for this as well then.

Kind regards
Ulf Hansson

>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
