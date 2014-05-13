From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv2] mmc: dw_mmc: change to use recommended reset procedure
Date: Tue, 13 May 2014 14:02:25 +0900
Message-ID: <002301cf6e68$8809ee00$981dca00$%jun@samsung.com>
References: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sonny Rao' <sonnyrao@chromium.org>, linux-mmc@vger.kernel.org
Cc: grundler@chromium.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, kgene.kim@samsung.com, joshi@samsung.com, t.figa@samsung.com, dianders@chromium.org, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

As I mentioned in previous version, you put all reset stuff in existing fifo_reset function.
Although databook mentions ciu_reset case for SBE error, it's not obvious when ciu_reset is needed in other error cases.
If you intend to add some robust error handing, it would be better to make another function.
Please check my comments below.

On Tue, May 13, 2014, Sonny Rao wrote:
> This patch changes the fifo reset code to follow the reset procedure
> outlined in the documentation of Synopsys  Mobile storage host databook
> 7.2.13.
> 
> v2: Add Generic DMA support
>     per the documentation, move interrupt clear before wait
>     make the test for DMA host->use_dma rather than host->using_dma
>     add proper return values (although it appears no caller checks)
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/dw_mmc.h |  1 +
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 55cd110..aff57e1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2325,6 +2325,7 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
> 
>  static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>  {
> +	u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
>  	/*
>  	 * Reseting generates a block interrupt, hence setting
>  	 * the scatter-gather pointer to NULL.
> @@ -2334,7 +2335,59 @@ static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>  		host->sg = NULL;
>  	}
> 
> -	return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
> +	/*
> +	 * The recommended method for resetting is to always reset the
> +	 * controller and the fifo, but differs slightly depending on the mode.
> +	 * The Generic DMA mode (non IDMAC) also needs to reset DMA where IDMAC
> +	 * mode resets IDMAC at the end.
> +	 *
> +	 */
> +#ifndef CONFIG_MMC_DW_IDMAC
Is it added for generic DMA?
IDMAC should be considered for dma_reseet as well.
Please check databook.

> +	if (host->use_dma)
> +		flags |= SDMMC_CTRL_DMA_RESET;
> +#endif
> +	if (dw_mci_ctrl_reset(host, flags)) {
> +		/*
> +		 * In all cases we clear the RAWINTS register to clear any
> +		 * interrupts.
> +		 */
I think interrupt masking is needed before reset because we will not handle it anymore.
And Is there any reason to move interrupt clear here compared with previous version?

> +		mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +
> +		/* if using dma we wait for dma_req to clear */
> +		if (host->use_dma) {
> +			unsigned long timeout = jiffies + msecs_to_jiffies(500);
> +			u32 status;
> +			do {
> +				status = mci_readl(host, STATUS);
> +				if (!(status & SDMMC_STATUS_DMA_REQ))
> +					break;
> +				cpu_relax();
What did you intend here?
If you intent busy-wait, how about using sleep instead?

> +			} while (time_before(jiffies, timeout));
> +
> +			if (status & SDMMC_STATUS_DMA_REQ) {
> +				dev_err(host->dev,
> +					"%s: Timeout waiting for dma_req to "
> +					"clear during reset", __func__);
> +				return false;
> +			}
> +
> +			/* when using DMA next we reset the fifo again */
> +			dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
> +		}
> +	} else {
> +		dev_err(host->dev, "%s: Reset bits didn't clear", __func__);
If ciu_reset is cleared, clk update below is needed?

Thanks,
Seungwon Jeon

> +		return false;
> +	}
> +
> +#ifdef CONFIG_MMC_DW_IDMAC
> +	/* It is also recommended that we reset and reprogram idmac */
> +	dw_mci_idmac_reset(host);
> +#endif
> +
> +	/* After a CTRL reset we need to have CIU set clock registers  */
> +	mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
> +
> +	return true;
>  }
> 
>  static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 6bf24ab..2505804 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -129,6 +129,7 @@
>  #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
>  /* Status register defines */
>  #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
> +#define SDMMC_STATUS_DMA_REQ		BIT(31)
>  /* FIFOTH register defines */
>  #define SDMMC_SET_FIFOTH(m, r, t)	(((m) & 0x7) << 28 | \
>  					 ((r) & 0xFFF) << 16 | \
> --
> 1.9.1.423.g4596e3a
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
