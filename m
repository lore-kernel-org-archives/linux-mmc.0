From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] mmc: sdhci-of-arasan: add
 sdhci_arasan_voltage_switch for arasan,5.1
Date: Mon, 10 Oct 2016 14:38:16 +0200
Message-ID: <CAPDyKFr4HGkbgOvtyVTUQH90N6SUmirRR-s--2vKPQdg1sEmQg@mail.gmail.com>
References: <1475216340-15344-1-git-send-email-shawn.lin@rock-chips.com>
 <1475216340-15344-3-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1475216340-15344-3-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 30 September 2016 at 08:19, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> Per the vendor's requirement, we shouldn't do any setting for
> 1.8V Signaling Enable, otherwise the interaction/behaviour between
> phy and controller will be undefined. Mostly it works fine if we do
> that, but we still see failures. Anyway, let's fix it to meet the
> vendor's requirement. The error log looks like:
>
>  [   93.405085] mmc1: unexpected status 0x800900 after switch
>  [   93.408474] mmc1: switch to bus width 1 failed
>  [   93.408482] mmc1: mmc_select_hs200 failed, error -110
>  [   93.408492] mmc1: error -110 during resume (card was removed?)
>  [   93.408705] PM: resume of devices complete after 213.453 msecs
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>
> Changes in v3:
> - add tag from Adrian and Doug
>
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index da8e40a..1573a8d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -265,6 +265,28 @@ void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
>         }
>  }
>
> +static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
> +                                      struct mmc_ios *ios)
> +{
> +       switch (ios->signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               /*
> +                * Plese don't switch to 1V8 as arasan,5.1 doesn't
> +                * actually refer to this setting to indicate the
> +                * signal voltage and the state machine will be broken
> +                * actually if we force to enable 1V8. That's something
> +                * like broken quirk but we could work around here.
> +                */
> +               return 0;
> +       case MMC_SIGNAL_VOLTAGE_330:
> +       case MMC_SIGNAL_VOLTAGE_120:
> +               /* We don't support 3V3 and 1V2 */
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static struct sdhci_ops sdhci_arasan_ops = {
>         .set_clock = sdhci_arasan_set_clock,
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -661,6 +683,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>                 host->mmc_host_ops.hs400_enhanced_strobe =
>                                         sdhci_arasan_hs400_enhanced_strobe;
> +               host->mmc_host_ops.start_signal_voltage_switch =
> +                                       sdhci_arasan_voltage_switch;
>         }
>
>         ret = sdhci_add_host(host);
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
