From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 1/2] mmc: mmci: add variant property to set command
 stop bit
Date: Tue, 11 Dec 2018 10:47:07 +0100
Message-ID: <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com> <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 6 Dec 2018 at 16:13, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> On cmd12 (STOP_TRANSMISSION), STM32 sdmmc variant needs to set
> cmdstop bit in command register. The CPSM ("Command Path State Machine")
> treats the command as a Stop Transmission command and signals
> abort to the DPSM ("Data Path State Machine").
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Withholding patch2 for a while, as I need some more time to review it.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 6 ++++++
>  drivers/mmc/host/mmci.h | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 13fa640..e352f5a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/highmem.h>
>  #include <linux/log2.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/mmc/pm.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> @@ -274,6 +275,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>         .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>         .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>         .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>         .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>         .datactrl_first         = true,
> @@ -1100,6 +1102,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 mmci_reg_delay(host);
>         }
>
> +       if (host->variant->cmdreg_stop &&
> +           cmd->opcode == MMC_STOP_TRANSMISSION)
> +               c |= host->variant->cmdreg_stop;
> +
>         c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136)
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 550dd39..2422909 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -264,6 +264,7 @@ struct mmci_host;
>   * @cmdreg_lrsp_crc: enable value for long response with crc
>   * @cmdreg_srsp_crc: enable value for short response with crc
>   * @cmdreg_srsp: enable value for short response without crc
> + * @cmdreg_stop: enable value for stop and abort transmission
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -316,6 +317,7 @@ struct variant_data {
>         unsigned int            cmdreg_lrsp_crc;
>         unsigned int            cmdreg_srsp_crc;
>         unsigned int            cmdreg_srsp;
> +       unsigned int            cmdreg_stop;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> --
> 2.7.4
>
