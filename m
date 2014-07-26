From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv6] mmc: dw_mmc: change to use recommended reset procedure
Date: Sat, 26 Jul 2014 11:55:52 +0200
Message-ID: <CAPDyKFoAn_mry3dsr4GAKDk=hU+qw0ys9yNoGAoY=WT3Spmcng@mail.gmail.com>
References: <53C37029.20600@samsung.com>
	<1405375591-13409-1-git-send-email-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1405375591-13409-1-git-send-email-sonnyrao@chromium.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Doug Anderson <dianders@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 15 July 2014 00:06, Sonny Rao <sonnyrao@chromium.org> wrote:
> This patch changes the fifo reset code to follow the reset procedure
> outlined in the documentation of Synopsys Mobile storage host databook.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
> v2: Add Generic DMA support
>     per the documentation, move interrupt clear before wait
>     make the test for DMA host->use_dma rather than host->using_dma
>     add proper return values (although it appears no caller checks)
> v3: rename fifo reset function, and change callers
>     use this combined reset function in dw_mci_resume()
>     just one caller left (probe), so get rid of dw_mci_ctrl_all_reset()
>     use DMA reset bit for all systems which use DMA
>     remove extra IDMAC reset in dw_mci_work_routine_card()
>     do CIU clock update in error path, if CIU reset cleared
> v4: remove comment about FIFO reset in dw_mci_work_routine_card()
>     move down error message when control reset clears but others don't
>      and clarify the error stating that we will still update clocks
>     make flags for all reset bits a macro
> v5: don't use dw_mci_reset() in dw_mci_resume() and instead match what
>     is done in dw_mci_probe() and don't force inline dw_mci_resume()
> v6: add newlines to dev_err() messages
> ---
>  drivers/mmc/host/dw_mmc.c | 86 ++++++++++++++++++++++++++++++++++-------------
>  drivers/mmc/host/dw_mmc.h |  5 +++
>  2 files changed, 68 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 55cd110..0c0aecb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -111,8 +111,7 @@ static const u8 tuning_blk_pattern_8bit[] = {
>         0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
>  };
>
> -static inline bool dw_mci_fifo_reset(struct dw_mci *host);
> -static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host);
> +static bool dw_mci_reset(struct dw_mci *host);
>
>  #if defined(CONFIG_DEBUG_FS)
>  static int dw_mci_req_show(struct seq_file *s, void *v)
> @@ -1254,7 +1253,7 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
>                  * After an error, there may be data lingering
>                  * in the FIFO
>                  */
> -               dw_mci_fifo_reset(host);
> +               dw_mci_reset(host);
>         } else {
>                 data->bytes_xfered = data->blocks * data->blksz;
>                 data->error = 0;
> @@ -1371,7 +1370,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>
>                         /* CMD error in data command */
>                         if (mrq->cmd->error && mrq->data)
> -                               dw_mci_fifo_reset(host);
> +                               dw_mci_reset(host);
>
>                         host->cmd = NULL;
>                         host->data = NULL;
> @@ -1982,14 +1981,8 @@ static void dw_mci_work_routine_card(struct work_struct *work)
>                         }
>
>                         /* Power down slot */
> -                       if (present == 0) {
> -                               /* Clear down the FIFO */
> -                               dw_mci_fifo_reset(host);
> -#ifdef CONFIG_MMC_DW_IDMAC
> -                               dw_mci_idmac_reset(host);
> -#endif
> -
> -                       }
> +                       if (present == 0)
> +                               dw_mci_reset(host);
>
>                         spin_unlock_bh(&host->lock);
>
> @@ -2323,8 +2316,11 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
>         return false;
>  }
>
> -static inline bool dw_mci_fifo_reset(struct dw_mci *host)
> +static bool dw_mci_reset(struct dw_mci *host)
>  {
> +       u32 flags = SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET;
> +       bool ret = false;
> +
>         /*
>          * Reseting generates a block interrupt, hence setting
>          * the scatter-gather pointer to NULL.
> @@ -2334,15 +2330,59 @@ static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>                 host->sg = NULL;
>         }
>
> -       return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
> -}
> +       if (host->use_dma)
> +               flags |= SDMMC_CTRL_DMA_RESET;
>
> -static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
> -{
> -       return dw_mci_ctrl_reset(host,
> -                                SDMMC_CTRL_FIFO_RESET |
> -                                SDMMC_CTRL_RESET |
> -                                SDMMC_CTRL_DMA_RESET);
> +       if (dw_mci_ctrl_reset(host, flags)) {
> +               /*
> +                * In all cases we clear the RAWINTS register to clear any
> +                * interrupts.
> +                */
> +               mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +
> +               /* if using dma we wait for dma_req to clear */
> +               if (host->use_dma) {
> +                       unsigned long timeout = jiffies + msecs_to_jiffies(500);
> +                       u32 status;
> +                       do {
> +                               status = mci_readl(host, STATUS);
> +                               if (!(status & SDMMC_STATUS_DMA_REQ))
> +                                       break;
> +                               cpu_relax();
> +                       } while (time_before(jiffies, timeout));
> +
> +                       if (status & SDMMC_STATUS_DMA_REQ) {
> +                               dev_err(host->dev,
> +                                       "%s: Timeout waiting for dma_req to "
> +                                       "clear during reset\n", __func__);
> +                               goto ciu_out;
> +                       }
> +
> +                       /* when using DMA next we reset the fifo again */
> +                       if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET))
> +                               goto ciu_out;
> +               }
> +       } else {
> +               /* if the controller reset bit did clear, then set clock regs */
> +               if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
> +                       dev_err(host->dev, "%s: fifo/dma reset bits didn't "
> +                               "clear but ciu was reset, doing clock update\n",
> +                               __func__);
> +                       goto ciu_out;
> +               }
> +       }
> +
> +       if (IS_ENABLED(CONFIG_MMC_DW_IDMAC))
> +               /* It is also recommended that we reset and reprogram idmac */
> +               dw_mci_idmac_reset(host);
> +
> +       ret = true;
> +
> +ciu_out:
> +       /* After a CTRL reset we need to have CIU set clock registers  */
> +       mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
> +
> +       return ret;
>  }
>
>  #ifdef CONFIG_OF
> @@ -2555,7 +2595,7 @@ int dw_mci_probe(struct dw_mci *host)
>         }
>
>         /* Reset all blocks */
> -       if (!dw_mci_ctrl_all_reset(host))
> +       if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS))
>                 return -ENODEV;
>
>         host->dma_ops = host->pdata->dma_ops;
> @@ -2744,7 +2784,7 @@ int dw_mci_resume(struct dw_mci *host)
>                 }
>         }
>
> -       if (!dw_mci_ctrl_all_reset(host)) {
> +       if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
>                 ret = -ENODEV;
>                 return ret;
>         }
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 6bf24ab..9ab8ccd 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -129,6 +129,7 @@
>  #define SDMMC_CMD_INDX(n)              ((n) & 0x1F)
>  /* Status register defines */
>  #define SDMMC_GET_FCNT(x)              (((x)>>17) & 0x1FFF)
> +#define SDMMC_STATUS_DMA_REQ           BIT(31)
>  /* FIFOTH register defines */
>  #define SDMMC_SET_FIFOTH(m, r, t)      (((m) & 0x7) << 28 | \
>                                          ((r) & 0xFFF) << 16 | \
> @@ -150,6 +151,10 @@
>  /* Card read threshold */
>  #define SDMMC_SET_RD_THLD(v, x)                (((v) & 0x1FFF) << 16 | (x))
>
> +/* All ctrl reset bits */
> +#define SDMMC_CTRL_ALL_RESET_FLAGS \
> +       (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_DMA_RESET)
> +
>  /* Register access macros */
>  #define mci_readl(dev, reg)                    \
>         __raw_readl((dev)->regs + SDMMC_##reg)
> --
> 2.0.0.526.g5318336
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
