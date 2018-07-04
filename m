From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 13/19] mmc: mmci: send stop cmd if a data command fail
Date: Wed, 4 Jul 2018 15:37:39 +0200
Message-ID: <CAPDyKFrbHcyy+rcVPrJAvO+y-ywQ=yE=gT3dbG2kqroQAhMF2Q@mail.gmail.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-14-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-14-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The mmc framework follows the requirement of SD_Specification:
> the STOP_TRANSMISSION is sent on multiple write/read commands
> and the stop command (alone), not needed on other ADTC commands.
>
> But, some variants require a stop command "STOP_TRANSMISION" to clear
> the DPSM "Data Path State Machine" if an error happens on command or data
> step. If it's not done the next data command will freeze hardware block.
> Needed to support the STM32 sdmmc variant.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 36 +++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 87724e1..9af7db8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -24,6 +24,7 @@
>  #include <linux/mmc/pm.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/amba/bus.h>
>  #include <linux/clk.h>
> @@ -522,11 +523,28 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
>         host->mask1_reg = mask;
>  }
>
> -static void mmci_stop_data(struct mmci_host *host)
> +static int mmci_stop_data(struct mmci_host *host)

Let's leave this as void function and instead add a check in
mmci_start_command(), to see if the command is a
MMC_STOP_TRANSMISSION. If so, then add host->variant->cmdreg_stop to
the register that is written in it.

And actually, I think this change alone should be a separate patch
coming before $subject patch in the series, as it addresses the first
problem of two.

>  {
> +       struct mmc_command *stop = &host->stop_abort;
> +       struct mmc_data *data = host->data;
> +       unsigned int cmd = 0;
> +
>         mmci_write_datactrlreg(host, 0);
>         mmci_set_mask1(host, 0);
>         host->data = NULL;
> +
> +       if (host->variant->cmdreg_stop) {
> +               cmd |= host->variant->cmdreg_stop;
> +               if (!data->stop) {
> +                       memset(stop, 0, sizeof(struct mmc_command));
> +                       stop->opcode = MMC_STOP_TRANSMISSION;
> +                       stop->arg = 0;
> +                       stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> +                       data->stop = stop;

I don't understand why you want the host->stop_abort being present in
the mmci host struct? Can we get rid of that?

Anyway, re-using the data->stop pointer seems reasonable.

> +               }
> +       }
> +
> +       return cmd;
>  }
>
>  static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
> @@ -703,6 +721,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>               unsigned int status)
>  {
>         unsigned int status_err;
> +       unsigned int cmd_reg = 0;
>
>         /* Make sure we have data to handle */
>         if (!data)
> @@ -761,7 +780,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>         if (status & MCI_DATAEND || data->error) {
>                 mmci_dma_finalize(host, data);
>
> -               mmci_stop_data(host);
> +               cmd_reg = mmci_stop_data(host);
>
>                 if (!data->error)
>                         /* The error clause is handled above, success! */
> @@ -770,7 +789,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 if (!data->stop || host->mrq->sbc) {
>                         mmci_request_end(host, data->mrq);
>                 } else {
> -                       mmci_start_command(host, data->stop, 0);
> +                       mmci_start_command(host, data->stop, cmd_reg);
>                 }
>         }
>  }
> @@ -780,6 +799,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>              unsigned int status)
>  {
>         void __iomem *base = host->base;
> +       struct mmc_data *data = host->data;
> +       unsigned int cmd_reg = 0;
>         bool sbc;
>
>         if (!cmd)
> @@ -865,11 +886,16 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         }
>
>         if ((!sbc && !cmd->data) || cmd->error) {
> -               if (host->data) {
> +               if (data) {
>                         /* Terminate the DMA transfer */
>                         mmci_dma_error(host);
>
> -                       mmci_stop_data(host);
> +                       cmd_reg = mmci_stop_data(host);
> +
> +                       if (data->stop) {

This means a change in behavior for !host->variant->cmdreg_stop
variants, because the mmc core may have assigned data->stop. Did you
test this path for any of the old variants?

The change as such anyway seems like a good idea. If we had data, we
may play safe and send a stop command to let the card to try to close
down the transfer. On the other hand, we don't want this to come as
side-effect, but rather it deserves is own standalone patch.

I guess there are two options going forward.
1) Split the patch and see if this works for other variants first and
the add your changes on top for the new ST variant.
2) Make this change only to affect the new ST variant.

I am fine with both.

> +                               mmci_start_command(host, data->stop, cmd_reg);
> +                               return;
> +                       }
>                 }
>                 mmci_request_end(host, host->mrq);
>         } else if (sbc) {
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 2d7e901..4b4cd1d 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -243,6 +243,7 @@ struct mmci_host;
>   * @cmdreg_lrsp_crc: enable value for long response with crc
>   * @cmdreg_srsp_crc: enable value for short response with crc
>   * @cmdreg_srsp: enable value for short response without crc
> + * @cmdreg_stop: enable value for stop and abort transmission
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -298,6 +299,7 @@ struct variant_data {
>         unsigned int            cmdreg_lrsp_crc;
>         unsigned int            cmdreg_srsp_crc;
>         unsigned int            cmdreg_srsp;
> +       unsigned int            cmdreg_stop;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> @@ -343,6 +345,7 @@ struct mmci_host {
>         struct mmc_request      *mrq;
>         struct mmc_command      *cmd;
>         struct mmc_data         *data;
> +       struct mmc_command      stop_abort;
>         struct mmc_host         *mmc;
>         struct clk              *clk;
>         bool                    singleirq;
> --
> 2.7.4
>

Kind regards
Uffe
