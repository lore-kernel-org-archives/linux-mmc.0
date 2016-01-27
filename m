From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable CONFIG_REGULATOR_PBIAS
Date: Wed, 27 Jan 2016 15:15:47 +0100
Message-ID: <CAPDyKFohvK3B0jF+SU-MLpiJ-DwJqW1pRtayK3nyKwVQkR1nUw@mail.gmail.com>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452762920-2588-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, Pavel Machek <pavel@ucw.cz>, sre@debian.org, Sebastian Reichel <sre@ring0.de>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.de>, linux-mmc <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 14 January 2016 at 10:15, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms that
> have PBIAS regulator) in order for MMC1 to work.
>
> Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for users
> using a olddefconfig or a custom .config.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks,applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 7fb0753..7086bd6 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>         host->pbias = devm_regulator_get_optional(host->dev, "pbias");
>         if (IS_ERR(host->pbias)) {
>                 ret = PTR_ERR(host->pbias);
> -               if ((ret != -ENODEV) && host->dev->of_node)
> +               if ((ret != -ENODEV) && host->dev->of_node) {
> +                       dev_err(host->dev,
> +                       "SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
>                         return ret;
> +               }
>                 dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
>                         PTR_ERR(host->pbias));
>                 host->pbias = NULL;
> --
> 1.7.9.5
>
