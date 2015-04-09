From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/1] mmc: dw_mmc: Add runtime pm to dw_mmc
Date: Thu, 9 Apr 2015 11:43:46 +0200
Message-ID: <CAPDyKFpEnsiW3zgMtqni6jvUEp-U17J+XP-OWaeoHMOXNo-deg@mail.gmail.com>
References: <1426772661-25506-1-git-send-email-k.wrona@samsung.com>
	<1426772661-25506-2-git-send-email-k.wrona@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426772661-25506-2-git-send-email-k.wrona@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Karol Wrona <k.wrona@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 19 March 2015 at 14:44, Karol Wrona <k.wrona@samsung.com> wrote:
> This patch adds runtime pm handling to dw_mmc.
> It mainly uses mci_request/mci_request_end for mmc host state information.
> The goal of the runtime pm in dw_mmc host is mainly for giving an information
> for containing it power domain about its activity.
>
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |  117 +++++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/dw_mmc.h |    2 +
>  2 files changed, 110 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 47dfd0e..086cabc 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -38,6 +38,7 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/mmc/slot-gpio.h>
> +#include <linux/pm_runtime.h>
>
>  #include "dw_mmc.h"
>
> @@ -104,6 +105,29 @@ static bool dw_mci_reset(struct dw_mci *host);
>  static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>  static int dw_mci_card_busy(struct mmc_host *mmc);
>
> +#ifdef CONFIG_PM
> +static inline int dw_mci_pm_runtime_get(struct dw_mci *host)
> +{
> +       return pm_runtime_get_sync(host->dev);
> +}
> +
> +static inline int dw_mci_pm_runtime_put(struct dw_mci *host)
> +{
> +       pm_runtime_mark_last_busy(host->dev);
> +       return pm_runtime_put_autosuspend(host->dev);
> +}
> +#else /* !CONFIG_PM */
> +static inline int dw_mci_pm_runtime_get(struct dw_mci *host)
> +{
> +       return 0;
> +}
> +
> +static inline int dw_mci_pm_runtime_put(struct dw_mci *host)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_PM */

Please remove these wrapper functions, I don't think they add something useful.

> +
>  #if defined(CONFIG_DEBUG_FS)
>  static int dw_mci_req_show(struct seq_file *s, void *v)
>  {
> @@ -113,6 +137,8 @@ static int dw_mci_req_show(struct seq_file *s, void *v)
>         struct mmc_command *stop;
>         struct mmc_data *data;
>
> +       dw_mci_pm_runtime_get(slot->host);
> +
>         /* Make sure we get a consistent snapshot */
>         spin_lock_bh(&slot->host->lock);
>         mrq = slot->mrq;
> @@ -142,6 +168,8 @@ static int dw_mci_req_show(struct seq_file *s, void *v)
>
>         spin_unlock_bh(&slot->host->lock);
>
> +       dw_mci_pm_runtime_put(slot->host);
> +
>         return 0;
>  }
>
> @@ -1071,6 +1099,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         WARN_ON(slot->mrq);
>
> +       dw_mci_pm_runtime_get(host);
> +
>         /*
>          * The check for card presence and queueing of the request must be
>          * atomic, otherwise the card could be removed in between and the
> @@ -1082,6 +1112,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 spin_unlock_bh(&host->lock);
>                 mrq->cmd->error = -ENOMEDIUM;
>                 mmc_request_done(mmc, mrq);
> +
> +               dw_mci_pm_runtime_put(host);
>                 return;
>         }
>
> @@ -1109,6 +1141,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 slot->ctype = SDMMC_CTYPE_1BIT;
>         }
>
> +       dw_mci_pm_runtime_get(slot->host);
> +
>         regs = mci_readl(slot->host, UHS_REG);
>
>         /* DDR mode set */
> @@ -1139,7 +1173,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                                 dev_err(slot->host->dev,
>                                         "failed to enable vmmc regulator\n");
>                                 /*return, if failed turn on vmmc*/
> -                               return;
> +                               goto out;
>                         }
>                 }
>                 set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
> @@ -1192,6 +1226,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
>                 slot->host->state = STATE_IDLE;
> +
> +out:
> +       dw_mci_pm_runtime_put(slot->host);
>  }
>
>  static int dw_mci_card_busy(struct mmc_host *mmc)
> @@ -1199,12 +1236,16 @@ static int dw_mci_card_busy(struct mmc_host *mmc)
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>         u32 status;
>
> +       dw_mci_pm_runtime_get(slot->host);
> +
>         /*
>          * Check the busy bit which is low when DAT[3:0]
>          * (the data lines) are 0000
>          */
>         status = mci_readl(slot->host, STATUS);
>
> +       dw_mci_pm_runtime_put(slot->host);
> +
>         return !!(status & SDMMC_STATUS_BUSY);
>  }
>
> @@ -1215,7 +1256,9 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>         u32 uhs;
>         u32 v18 = SDMMC_UHS_18V << slot->id;
>         int min_uv, max_uv;
> -       int ret;
> +       int ret = 0;
> +
> +       dw_mci_pm_runtime_get(host);
>
>         /*
>          * Program the voltage.  Note that some instances of dw_mmc may use
> @@ -1239,12 +1282,16 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>                         dev_dbg(&mmc->class_dev,
>                                          "Regulator set error %d: %d - %d\n",
>                                          ret, min_uv, max_uv);
> -                       return ret;
> +
> +                       goto out;
>                 }
>         }
>         mci_writel(host, UHS_REG, uhs);
>
> -       return 0;
> +out:
> +       dw_mci_pm_runtime_put(host);
> +
> +       return ret;
>  }
>
>  static int dw_mci_get_ro(struct mmc_host *mmc)
> @@ -1253,6 +1300,8 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>         int gpio_ro = mmc_gpio_get_ro(mmc);
>
> +       dw_mci_pm_runtime_get(slot->host);
> +
>         /* Use platform get_ro function, else try on board write protect */
>         if ((slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT) ||
>                         (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT))
> @@ -1263,6 +1312,8 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>                 read_only =
>                         mci_readl(slot->host, WRTPRT) & (1 << slot->id) ? 1 : 0;
>
> +       dw_mci_pm_runtime_put(slot->host);
> +
>         dev_dbg(&mmc->class_dev, "card is %s\n",
>                 read_only ? "read-only" : "read-write");
>
> @@ -1277,6 +1328,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>         struct dw_mci *host = slot->host;
>         int gpio_cd = mmc_gpio_get_cd(mmc);
>
> +       dw_mci_pm_runtime_get(host);
> +
>         /* Use platform get_cd function, else try onboard card detect */
>         if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
>                 present = 1;
> @@ -1296,6 +1349,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>         }
>         spin_unlock_bh(&host->lock);
>
> +       dw_mci_pm_runtime_put(host);
> +
>         return present;
>  }
>
> @@ -1304,6 +1359,8 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>         struct dw_mci *host = slot->host;
>
> +       dw_mci_pm_runtime_get(host);
> +
>         /*
>          * Low power mode will stop the card clock when idle.  According to the
>          * description of the CLKENA register we should disable low power mode
> @@ -1331,6 +1388,8 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>                                      SDMMC_CMD_PRV_DAT_WAIT, 0);
>                 }
>         }
> +
> +       dw_mci_pm_runtime_put(host);
>  }
>
>  static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
> @@ -1340,6 +1399,9 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>         unsigned long irqflags;
>         u32 int_mask;
>
> +       if (enb)
> +               dw_mci_pm_runtime_get(slot->host);

Are sure this "get" will be properly balanced with below "put"?

> +
>         spin_lock_irqsave(&host->irq_lock, irqflags);
>
>         /* Enable/disable Slot Specific SDIO interrupt */
> @@ -1351,6 +1413,10 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>         mci_writel(host, INTMASK, int_mask);
>
>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +
> +       /* If interrupt is enabled leave device active. */
> +       if (!enb)
> +               dw_mci_pm_runtime_put(slot->host);
>  }
>
>  static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> @@ -1360,8 +1426,13 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         const struct dw_mci_drv_data *drv_data = host->drv_data;
>         int err = -ENOSYS;
>
> +       dw_mci_pm_runtime_get(host);
> +
>         if (drv_data && drv_data->execute_tuning)
>                 err = drv_data->execute_tuning(slot);
> +
> +       dw_mci_pm_runtime_put(host);
> +
>         return err;
>  }
>
> @@ -1371,9 +1442,13 @@ static int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios
>         struct dw_mci *host = slot->host;
>         const struct dw_mci_drv_data *drv_data = host->drv_data;
>
> +       dw_mci_pm_runtime_get(host);
> +
>         if (drv_data && drv_data->prepare_hs400_tuning)
>                 return drv_data->prepare_hs400_tuning(host, ios);
>
> +       dw_mci_pm_runtime_put(host);
> +
>         return 0;
>  }
>
> @@ -1414,10 +1489,13 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>         } else {
>                 dev_vdbg(host->dev, "list empty\n");
>
> -               if (host->state == STATE_SENDING_CMD11)
> +               if (host->state == STATE_SENDING_CMD11) {
>                         host->state = STATE_WAITING_CMD11_DONE;
> -               else
> +               } else {
> +                       dw_mci_pm_runtime_put(host);
> +
>                         host->state = STATE_IDLE;
> +               }
>         }
>
>         spin_unlock(&host->lock);
> @@ -2688,6 +2766,11 @@ int dw_mci_probe(struct dw_mci *host)
>                 return -ENODEV;
>         }
>
> +       pm_runtime_enable(host->dev);
> +       pm_runtime_get_sync(host->dev);
> +       pm_runtime_set_autosuspend_delay(host->dev, DWMMC_AUTOSUSPEND_DELAY);
> +       pm_runtime_use_autosuspend(host->dev);

I think you shall change these four lines into:

pm_runtime_set_active();
pm_runtime_set_autosuspend_delay();
pm_runtime_use_autosuspend();
pm_runtime_enable();

And move them just before calling dw_mci_init_slot(). In that way you
will have clocks enabled+prepared and the runtime PM state reflects
that.

Later, when you might want to add clock (un)gating as a part of
runtime PM suspend/resume callbacks, you will need the above change
anyway.

> +
>         host->biu_clk = devm_clk_get(host->dev, "biu");
>         if (IS_ERR(host->biu_clk)) {
>                 dev_dbg(host->dev, "biu clock not available\n");
> @@ -2877,6 +2960,10 @@ int dw_mci_probe(struct dw_mci *host)
>         if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>                 dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
>
> +       /* no pm runtime wrappers in probe just to be consistent */
> +       pm_runtime_mark_last_busy(host->dev);
> +       pm_runtime_put_autosuspend(host->dev);

According the change suggested above, remove the "put".

> +
>         return 0;
>
>  err_dmaunmap:
> @@ -2891,6 +2978,9 @@ err_clk_biu:
>         if (!IS_ERR(host->biu_clk))
>                 clk_disable_unprepare(host->biu_clk);
>
> +       pm_runtime_put_sync(host->dev);

According the change suggested above, remove the "put".

> +       pm_runtime_disable(host->dev);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL(dw_mci_probe);
> @@ -2899,6 +2989,8 @@ void dw_mci_remove(struct dw_mci *host)
>  {
>         int i;
>
> +       pm_runtime_get_sync(host->dev);
> +
>         mci_writel(host, RINTSTS, 0xFFFFFFFF);
>         mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>
> @@ -2915,6 +3007,9 @@ void dw_mci_remove(struct dw_mci *host)
>         if (host->use_dma && host->dma_ops->exit)
>                 host->dma_ops->exit(host);
>
> +       pm_runtime_put_sync(host->dev);
> +       pm_runtime_disable(host->dev);
> +

Change to:
pm_runtime_disable();
pm_runtime_put_noidle();

>         if (!IS_ERR(host->ciu_clk))
>                 clk_disable_unprepare(host->ciu_clk);
>
> @@ -2937,11 +3032,13 @@ EXPORT_SYMBOL(dw_mci_suspend);
>
>  int dw_mci_resume(struct dw_mci *host)
>  {
> -       int i, ret;
> +       int i;
> +
> +       dw_mci_pm_runtime_get(host);
>
>         if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
> -               ret = -ENODEV;
> -               return ret;
> +               dw_mci_pm_runtime_put(host);
> +               return -ENODEV;
>         }
>
>         if (host->use_dma && host->dma_ops->init)
> @@ -2976,6 +3073,8 @@ int dw_mci_resume(struct dw_mci *host)
>         /* Now that slots are all setup, we can enable card detect */
>         dw_mci_enable_cd(host);
>
> +       dw_mci_pm_runtime_put(host);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(dw_mci_resume);
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index d239867..2317f4b7 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -209,6 +209,8 @@ extern int dw_mci_suspend(struct dw_mci *host);
>  extern int dw_mci_resume(struct dw_mci *host);
>  #endif
>
> +#define DWMMC_AUTOSUSPEND_DELAY 50
> +
>  /**
>   * struct dw_mci_slot - MMC slot state
>   * @mmc: The mmc_host representing this slot.
> --
> 1.7.9.5
>

Kind regards
Uffe
