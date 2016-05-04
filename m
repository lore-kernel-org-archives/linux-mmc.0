From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-of-arasan: fix set_clock when a phy is supported
Date: Wed, 4 May 2016 13:14:41 +0200
Message-ID: <CAPDyKFqDZ+V62fDa_MiZTKq-PjCnUMNr6OMHEbYt5y6B+r=qVg@mail.gmail.com>
References: <1462326204-5090-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462326204-5090-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 4 May 2016 at 03:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> commit 61b914eb81f8 ("mmc: sdhci-of-arasan: add phy support for
> sdhci-of-arasan") introduce phy support for arasan. According to
> the vendor's databook, we should make sure the phy is in poweroff
> status before we configure the clk stuff. Otherwise it may cause
> some IO sample timing issues from the test. And we don't need this
> extra operation while running in low performance mode since phy
> doesn't trigger sampling block.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
> Changes in v3:
> - avoid use sleep function with the scope of spinlock because
> phy APIs call mutex.
>
> Changes in v2:
> - Rename commit msg title to indicate it's a fix
>
>  drivers/mmc/host/sdhci-of-arasan.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 2e482b1..b6f4c1d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -55,8 +55,32 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>         return freq;
>  }
>
> +static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       bool ctrl_phy = false;
> +
> +       if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
> +               ctrl_phy = true;
> +
> +       if (ctrl_phy) {
> +               spin_unlock_irq(&host->lock);
> +               phy_power_off(sdhci_arasan->phy);
> +               spin_lock_irq(&host->lock);
> +       }
> +
> +       sdhci_set_clock(host, clock);
> +
> +       if (ctrl_phy) {
> +               spin_unlock_irq(&host->lock);
> +               phy_power_on(sdhci_arasan->phy);
> +               spin_lock_irq(&host->lock);
> +       }
> +}
> +
>  static struct sdhci_ops sdhci_arasan_ops = {
> -       .set_clock = sdhci_set_clock,
> +       .set_clock = sdhci_arasan_set_clock,
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_arasan_get_timeout_clock,
>         .set_bus_width = sdhci_set_bus_width,
> --
> 2.3.7
>
>
