From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Properly set
 corecfg_clockmultiplier on rk3399
Date: Thu, 1 Sep 2016 16:18:15 +0200
Message-ID: <CAPDyKFrwGhFzVOsxYeN_H+GdkNfEQJc=1p50D-6E7HH6LUV-pA@mail.gmail.com>
References: <1472201475-7970-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1472201475-7970-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 26 August 2016 at 10:51, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> corecfg_clockmultiplier indicates clock multiplier value of
> programmable clock generator which should be the same value
> of SDHCI_CAPABILITIES_1. The default value of the register,
> corecfg_clockmultiplier, is 0x10. But actually it is a mistake
> by designer as our intention was to set it to be zero which
> means we don't support programmable clock generator. So we have
> to make it to be zero on bootloader which seems work fine until
> now. But now we find an issue that when deploying genpd support
> for it, the remove callback will trigger the genpd to poweroff the
> power domain for sdhci-of-arasan which manage the controller, phy
> and corecfg_* stuff.
>
> So when we do bind/unbind the driver, we have already reinit
> the controller and phy, but without doing that for corecfg_*.
> Regarding to only the corecfg_clockmultipler is wrong, let's
> fix it by explicitly marking it to be zero when probing. With
> this change, we could do bind/unbind successfully.
>
> Reported-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes in v2:
> - fix some typos and build
> - move the configuration of corecfg_clockmultiplier after
>   enabling aclk_emmc to avoid the off state of aclk_emmc_grf.
>   I add a new function to make it more common for other coming
>   users who have the same requirment for setting diff clkmul.
>
>  drivers/mmc/host/sdhci-of-arasan.c | 46 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 0b3a9cf..33601a8 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -67,10 +67,12 @@ struct sdhci_arasan_soc_ctl_field {
>   * accessible via the syscon API.
>   *
>   * @baseclkfreq:       Where to find corecfg_baseclkfreq
> + * @clockmultiplier:   Where to find corecfg_clockmultiplier
>   * @hiword_update:     If true, use HIWORD_UPDATE to access the syscon
>   */
>  struct sdhci_arasan_soc_ctl_map {
>         struct sdhci_arasan_soc_ctl_field       baseclkfreq;
> +       struct sdhci_arasan_soc_ctl_field       clockmultiplier;
>         bool                                    hiword_update;
>  };
>
> @@ -100,6 +102,7 @@ struct sdhci_arasan_data {
>
>  static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
>         .baseclkfreq = { .reg = 0xf000, .width = 8, .shift = 8 },
> +       .clockmultiplier = { .reg = 0xf02c, .width = 8, .shift = 0},
>         .hiword_update = true,
>  };
>
> @@ -379,6 +382,45 @@ static const struct clk_ops arasan_sdcardclk_ops = {
>  };
>
>  /**
> + * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
> + *
> + * The corecfg_clockmultiplier is supposed to contain clock multiplier
> + * value of programmable clock generator.
> + *
> + * NOTES:
> + * - Many existing devices don't seem to do this and work fine.  To keep
> + *   compatibility for old hardware where the device tree doesn't provide a
> + *   register map, this function is a noop if a soc_ctl_map hasn't been provided
> + *   for this platform.
> + * - The value of corecfg_clockmultiplier should sync with that of corresponding
> + *   value reading from sdhci_capability_register. So this function is called
> + *   once at probe time and never called again.
> + *
> + * @host:              The sdhci_host
> + */
> +static void sdhci_arasan_update_clockmultiplier(struct sdhci_host *host,
> +                                               u32 value)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =
> +               sdhci_arasan->soc_ctl_map;
> +
> +       /* Having a map is optional */
> +       if (!soc_ctl_map)
> +               return;
> +
> +       /* If we have a map, we expect to have a syscon */
> +       if (!sdhci_arasan->soc_ctl_base) {
> +               pr_warn("%s: Have regmap, but no soc-ctl-syscon\n",
> +                       mmc_hostname(host->mmc));
> +               return;
> +       }
> +
> +       sdhci_arasan_syscon_write(host, &soc_ctl_map->clockmultiplier, value);
> +}
> +
> +/**
>   * sdhci_arasan_update_baseclkfreq - Set corecfg_baseclkfreq
>   *
>   * The corecfg_baseclkfreq is supposed to contain the MHz of clk_xin.  This
> @@ -559,6 +601,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         sdhci_get_of_property(pdev);
>         pltfm_host->clk = clk_xin;
>
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "rockchip,rk3399-sdhci-5.1"))
> +               sdhci_arasan_update_clockmultiplier(host, 0x0);
> +
>         sdhci_arasan_update_baseclkfreq(host);
>
>         ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
