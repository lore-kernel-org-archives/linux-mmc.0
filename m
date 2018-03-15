From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/8] mmc: sunxi: Move the power off action in a
 separate function
Date: Thu, 15 Mar 2018 10:23:15 +0100
Message-ID: <CAPDyKFpdX5Xg_S0daFeFWE-4CQFRa=MC-qdmzqNyCaipyxAj3Q@mail.gmail.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
 <bd3c692c488e0e3ee8f4cc169980a74384717ec2.1520520655.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <bd3c692c488e0e3ee8f4cc169980a74384717ec2.1520520655.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Quentin Schulz <quentin.schulz@bootlin.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 8 March 2018 at 15:52, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> We'll need to have the power off behaviour in order to implement
> runtime_pm. Move it outside of the .set_ios callback for an easier access.

This isn't correct. To implement runtime PM for the sunxi device,
which I think is what your goal is, you should not disable/enable
regulators to the (e)MMC/SD/SDIO card.

If you also want runtime PM deployment for the card, that is managed
by the mmc core already. All you have to do is to set
MMC_CAP_AGGRESSIVE_PM for your mmc host, if you want that.

>
> And it improves readibility as a bonus.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index f9723797a9f8..a53e39d8b07e 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -855,6 +855,22 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>         return 0;
>  }
>
> +static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct sunxi_mmc_host *host = mmc_priv(mmc);
> +
> +       dev_dbg(mmc_dev(mmc), "Powering off\n");
> +
> +       sunxi_mmc_reset_host(host);
> +       if (!IS_ERR(mmc->supply.vmmc))
> +               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +
> +       if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
> +               regulator_disable(mmc->supply.vqmmc);
> +
> +       host->vqmmc_enabled = false;
> +}
> +
>  static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> @@ -892,14 +908,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 break;
>
>         case MMC_POWER_OFF:
> -               dev_dbg(mmc_dev(mmc), "power off!\n");
> -               sunxi_mmc_reset_host(host);
> -               if (!IS_ERR(mmc->supply.vmmc))
> -                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> -
> -               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
> -                       regulator_disable(mmc->supply.vqmmc);
> -               host->vqmmc_enabled = false;
> +               sunxi_mmc_power_off(mmc, ios);
>                 break;
>         }
>
> --
> git-series 0.9.1

Kind regards
Uffe
