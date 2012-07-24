From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add busmode selection support
Date: Tue, 24 Jul 2012 20:09:05 +0900
Message-ID: <500E8251.906@samsung.com>
References: <1343042200-19524-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1343042200-19524-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, will.newton@imgtec.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

Well..just tested on my board.
this patch didn't work.(eMMC card didn't initialize)
meaning of ios->bus_mode and synosys's bus_mode is same?
How did you test this patch?

Best Regards,
Jaehoon Chung

On 07/23/2012 08:16 PM, Girish K S wrote:
> Synopsis Designware host controller has suppport for open
> drain mode selection. During the mmc card initialization the
> host controller can select the open-drain bit to allow the device
> initialization in the open-drain mode. Once the device enters
> the standby mode this bit can be reset to enter push-pull mode.
> 
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c |   14 ++++++++++++++
>  drivers/mmc/host/dw_mmc.h |    1 +
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 72dc3cd..da11e5a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -773,6 +773,18 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	spin_unlock_bh(&host->lock);
>  }
>  
> +static void dw_mci_set_busmode(struct dw_mci_slot *slot)
> +{
> +	struct mmc_ios *ios = &slot->mmc->ios;
> +	u32 reg;
> +
> +	reg = mci_readl(slot->host, CTRL);
> +	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
> +		mci_writel(slot->host, CTRL, reg | SDMMC_CTRL_ENABLE_OD);
> +	else
> +		mci_writel(slot->host, CTRL, reg & ~SDMMC_CTRL_ENABLE_OD);
> +}
> +
>  static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
> @@ -818,6 +830,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	default:
>  		break;
>  	}
> +
> +	dw_mci_set_busmode(slot);
>  }
>  
>  static int dw_mci_get_ro(struct mmc_host *mmc)
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 15c27e1..1a53fb2 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -67,6 +67,7 @@
>  
>  /* Control register defines */
>  #define SDMMC_CTRL_USE_IDMAC		BIT(25)
> +#define SDMMC_CTRL_ENABLE_OD		BIT(24)
>  #define SDMMC_CTRL_CEATA_INT_EN		BIT(11)
>  #define SDMMC_CTRL_SEND_AS_CCSD		BIT(10)
>  #define SDMMC_CTRL_SEND_CCSD		BIT(9)
> 
