From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 10/19] mmc: mmci: add variant property to allow remain data
Date: Thu, 5 Jul 2018 15:55:37 +0200
Message-ID: <CAPDyKFpS6EPBtPstTi7wg3jJ+C-7k6mzypR1OcuHpV94VWjvkw@mail.gmail.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-11-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-11-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds a boolean property to read remaining data.
> Needed to support the STM32 sdmmc variant. MMCIDATACNT
> register should be read only after the data transfer is complete.
> When reading after an error event the read data count value may be
> different from the real number of data bytes transferred.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 17 +++++++++++++++--
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 83c3572..abddad7 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -58,6 +58,7 @@ static struct variant_data variant_arm = {
>         .datalength_bits        = 16,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,

According to the description in the changelog, it sounds like
MMCIDATACNT is broken (or useless for the STM32 variant). I suggest to
rename the new variant to something along those lines instead.

Like "datacnt_broken", then you only need to set it to true for the
STM32 variant and legacy variants can remain as is.

>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 100000000,
>         .reversed_irq_handling  = true,
> @@ -78,6 +79,7 @@ static struct variant_data variant_arm_extended_fifo = {
>         .datalength_bits        = 16,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,
>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 100000000,
>         .mmcimask1              = true,
> @@ -98,6 +100,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
>         .datalength_bits        = 16,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,
>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 100000000,
>         .mmcimask1              = true,
> @@ -120,6 +123,7 @@ static struct variant_data variant_u300 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                        = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
>         .f_max                  = 100000000,
> @@ -146,6 +150,7 @@ static struct variant_data variant_nomadik = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -175,6 +180,7 @@ static struct variant_data variant_ux500 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -209,6 +215,7 @@ static struct variant_data variant_ux500v2 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .blksz_datactrl16       = true,
> @@ -244,6 +251,7 @@ static struct variant_data variant_stm32 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -270,6 +278,7 @@ static struct variant_data variant_qcom = {
>         .datalength_bits        = 24,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,
>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 208000000,
>         .explicit_mclk_control  = true,
> @@ -711,8 +720,12 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                  * can be as much as a FIFO-worth of data ahead.  This
>                  * matters for FIFO overruns only.
>                  */
> -               remain = readl(host->base + MMCIDATACNT);
> -               success = data->blksz * data->blocks - remain;
> +               if (host->variant->datacnt_remain) {
> +                       remain = readl(host->base + MMCIDATACNT);
> +                       success = data->blksz * data->blocks - remain;
> +               } else {
> +                       success = 0;
> +               }
>
>                 dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
>                         status_err, success);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 5091025..12ee2e6 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -260,6 +260,8 @@ struct mmci_host;
>   * @datactrl_blksz: block size in power of two
>   * @datactrl_dpsm_enable: enable value for DPSM
>   * @datactrl_first: true if data must be setup before send command
> + * @datacnt_remain: true if you could read datacnt register
> + *                  to define remain data
>   * @pwrreg_powerup: power up value for MMCIPOWER register
>   * @f_max: maximum clk frequency supported by the controller.
>   * @signal_direction: input/out direction of bus signals can be indicated
> @@ -303,6 +305,7 @@ struct variant_data {
>         unsigned int            datactrl_blocksz;
>         unsigned int            datactrl_dpsm_enable;
>         bool                    datactrl_first;
> +       bool                    datacnt_remain;
>         bool                    st_sdio;
>         bool                    st_clkdiv;
>         bool                    blksz_datactrl16;
> --
> 2.7.4
>

Kind regards
Uffe
