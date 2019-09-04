From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Using 180 sample phase if all
 phases work
Date: Wed, 4 Sep 2019 08:32:23 +0200
Message-ID: <CAPDyKFpmh2zcz7=zL77XGBHUhxcFquoMSiRHf8w3dnvwH50aYw@mail.gmail.com>
References: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1567564030-83224-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 4 Sep 2019 at 04:28, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>
> default_sample_phase is used to make sure the cards are enumurated
> properly and will be set to 0 if not assigned. However, the sample
> phase should depends on the tuned phase if running higher clock rate.
> If all phases work but default_sample_phase isn't assigned, driver
> set sample phase to 0 for this case, which isn't the best choice,
> because we always expect to set phase to the middle of window. To
> solve the following continually issues we have seen in the test, we
> need set phase to the more stable one, 180, if all phases work.
>
> mmcblk1: error -84 transferring data, sector 1735064, nr 8, cmd
> response 0x900, card status 0xb00
> mmcblk1: retrying using single block read
> dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
> mmcblk1: retrying because a re-tune was needed
>
> .....
>
> mmcblk1: error -84 transferring data, sector 1728672, nr 248, cmd
> response 0x900, card status 0xb00
> mmcblk1: retrying using single block read
> dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Is this ready to be tagged for stable, or think its better to get it
tested a while and then send a backport to Greg etc instead?

In any case, applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index d4d0213..9ef9723 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -209,9 +209,8 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>         }
>
>         if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
> -               clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> -               dev_info(host->dev, "All phases work, using default phase %d.",
> -                        priv->default_sample_phase);
> +               clk_set_phase(priv->sample_clk, 180);
> +               dev_info(host->dev, "All phases work, using phase 180.");
>                 goto free;
>         }
>
> --
> 1.9.1
>
>
>
