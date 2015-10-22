From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add hw_reset extension hook
Date: Thu, 22 Oct 2015 11:48:20 +0200
Message-ID: <CAPDyKFr6vmx4F6OShYmPvxYu=_vb70ijL-twFqBcotXTX9eEaQ@mail.gmail.com>
References: <1445494740-16778-1-git-send-email-shawn.lin@rock-chips.com>
	<1445494793-16905-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445494793-16905-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 October 2015 at 08:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch add hw_reset for dw_mmc to implement hw reset
> procedure. It's useful for mmc core to recover emmc devices
> if emmc runs into unexpected state. Add MMC_CAP_HW_RESET
> capability to dw_mmc extension driver directly if it needs hw_reset.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  drivers/mmc/host/dw_mmc.h | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8a0f2995..46b12de 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1482,6 +1482,10 @@ static void dw_mci_hw_reset(struct mmc_host *mmc)
>  {
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>         struct dw_mci *host = slot->host;
> +       const struct dw_mci_drv_data *drv_data = host->drv_data;
> +
> +       if (drv_data && drv_data->hw_reset)
> +               return drv_data->hw_reset(host);

dw_mmc is starting to walk the same bad path as sdhci has done.

Please, try to avoid adding non-needed callbacks and start to turn
dw_mmc into a library instead.

Kind regards
Uffe

>
>         if (host->use_dma == TRANS_MODE_IDMAC)
>                 dw_mci_idmac_reset(host);
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 9df18c1..21b9df4 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -282,6 +282,7 @@ struct dw_mci_slot {
>   * @set_ios: handle bus specific extensions.
>   * @parse_dt: parse implementation specific device tree properties.
>   * @execute_tuning: implementation specific tuning procedure.
> + * @hw_reset: implementation specific hw reset procedure.
>   *
>   * Provide controller implementation specific extensions. The usage of this
>   * data structure is fully optional and usage of each member in this structure
> @@ -299,5 +300,6 @@ struct dw_mci_drv_data {
>                                                 struct mmc_ios *ios);
>         int             (*switch_voltage)(struct mmc_host *mmc,
>                                           struct mmc_ios *ios);
> +       void            (*hw_reset)(struct dw_mci *host);
>  };
>  #endif /* _DW_MMC_H_ */
> --
> 2.3.7
>
>
