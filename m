From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 06/19] mmc: mmci: add variant properties to define cpsm &
 cmdresp bits
Date: Thu, 5 Jul 2018 16:20:43 +0200
Message-ID: <CAPDyKFoFkfX=4znJL1z94kj9ZTojMe=t76xXUCAzYRX59=rpPQ@mail.gmail.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-7-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-7-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds command variant properties to define
> cpsm enable bit and responses.
> Needed to support the STM32 variant (shift of cpsm bit,
> specific definition of commands response).
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/mmci.h |  8 ++++++++
>  2 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 801c86b..52562fc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -51,6 +51,10 @@ static unsigned int fmax = 515633;
>  static struct variant_data variant_arm = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
> +       .cmdreg_cpsm_enable     = MCI_CPSM_ENABLE,
> +       .cmdreg_lrsp_crc        = MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
> +       .cmdreg_srsp_crc        = MCI_CPSM_RESPONSE,
> +       .cmdreg_srsp            = MCI_CPSM_RESPONSE,

Do these really needs to be a superset of each other?

Maybe it becomes easier for the STM32 variant later though...

[...]

> @@ -603,16 +639,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)

While at it, would you mind folding in a cleanup patch removing the
"u32 c" as in-parameter? It's currently always set to "0" by the
caller, so it's not needed.

>         dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
>             cmd->opcode, cmd->arg, cmd->flags);
>
> -       if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
> +       if (readl(base + MMCICOMMAND) & host->variant->cmdreg_cpsm_enable) {
>                 writel(0, base + MMCICOMMAND);
>                 mmci_reg_delay(host);
>         }
>
> -       c |= cmd->opcode | MCI_CPSM_ENABLE;
> +       c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136)
> -                       c |= MCI_CPSM_LONGRSP;
> -               c |= MCI_CPSM_RESPONSE;
> +                       c |= host->variant->cmdreg_lrsp_crc;

This looks weird. Probably because of the naming of the variant data.

Perhaps rename to "cmdreg_lrsp", thus skipping the "_crc" suffix?

> +               else if (cmd->flags & MMC_RSP_CRC)
> +                       c |= host->variant->cmdreg_srsp_crc;

Why is here an else? We can have both MMC_RSP_136 and MMC_RSP_CRC bits
set, right!?

> +               else
> +                       c |= host->variant->cmdreg_srsp;

What do you think about using a switch-case, perhaps with fall-through
- and then adding those bits that are needed for each response
bit+variant instead? Could that make this more readable?

>         }
>         if (/*interrupt*/0)
>                 c |= MCI_CPSM_INTERRUPT;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 7265ca6..e173305 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -239,6 +239,10 @@ struct mmci_host;
>   * @clkreg_enable: enable value for MMCICLOCK register
>   * @clkreg_8bit_bus_enable: enable value for 8 bit bus
>   * @clkreg_neg_edge_enable: enable value for inverted data/cmd output
> + * @cmdreg_cpsm_enable: enable value for CPSM
> + * @cmdreg_lrsp_crc: enable value for long response with crc
> + * @cmdreg_srsp_crc: enable value for short response with crc
> + * @cmdreg_srsp: enable value for short response without crc
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -282,6 +286,10 @@ struct variant_data {
>         unsigned int            clkreg_enable;
>         unsigned int            clkreg_8bit_bus_enable;
>         unsigned int            clkreg_neg_edge_enable;
> +       unsigned int            cmdreg_cpsm_enable;
> +       unsigned int            cmdreg_lrsp_crc;
> +       unsigned int            cmdreg_srsp_crc;
> +       unsigned int            cmdreg_srsp;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> --
> 2.7.4
>

Kind regards
Uffe
