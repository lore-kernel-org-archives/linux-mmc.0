From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Properly set corecfg_clockmultiplier
 on rk3399
Date: Fri, 26 Aug 2016 08:40:58 -0700
Message-ID: <CAD=FV=VO57j+cUe3YLRW+oziar2dVvpS9_KBgJeT2gbHfYjOkQ@mail.gmail.com>
References: <1472201475-7970-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:32999 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbcHZPlF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2016 11:41:05 -0400
Received: by mail-ua0-f172.google.com with SMTP id l94so81171967ual.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2016 08:41:05 -0700 (PDT)
In-Reply-To: <1472201475-7970-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Hi,

On Fri, Aug 26, 2016 at 1:51 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
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
> Reported-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
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

It would be nice if all the "Having a map is optional" and "If we have
a map, we expect to have a syscon" were shared between
"sdhci_arasan_update_clockmultiplier" and
"sdhci_arasan_update_baseclkfreq".  You could add a
"sdhci_arasan_syscon_write_opt" helper or something?

...but IMHO that could be done once the third copy is added, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
