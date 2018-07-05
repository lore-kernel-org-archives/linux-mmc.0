From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 18/19] mmc: mmci: add specific clk/pwr procedure for stm32
 sdmmc
Date: Thu, 5 Jul 2018 16:49:55 +0200
Message-ID: <CAPDyKFp+PZeO55T2Djh=vRF8nDL6EZ+68pGJH72Pgs10PCdNPg@mail.gmail.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-19-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1528809280-31116-19-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds specific clock and power ios for stm32 sdmmc variant.
> power ios: stm32 dedicated procedure must be done to perform power
> off/on procedures. To power off, the sdmmc must be reset and set
> to power cycle state before to disabling vqmmc. This drives low
> SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK to prevent the Card from
> being supplied through the signal lines.
> To power on, set the SDMMC in power-off SDMMC_D[7:0], SDMMC_CMD
> and SDMMC_CK are driven high. Then we can set the SDMMC to
> Power-on state.
>
> clock ios: specific bits behavior:
> -clock divider card_clk = mclk / (2 * clkdiv)
> -ddr activation
> -wide bus 1/4/8bits
> -bus speed
> -receive clock selection (in_ck/ck_in/fb_ck)
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 86aef4f..af27a0a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -50,6 +50,10 @@
>
>  static unsigned int fmax = 515633;
>
> +static void mmci_sdmmc_set_pwrreg(struct mmci_host *host,
> +                                 unsigned char power_mode, unsigned int pwr);
> +static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired);
> +
>  static struct variant_data variant_arm = {
>         .fifosize               = 16 * 4,
>         .fifohalfsize           = 8 * 4,
> @@ -490,6 +494,114 @@ static void mmci_set_pwrreg(struct mmci_host *host, unsigned char power_mode,
>         mmci_write_pwrreg(host, pwr);
>  }
>
> +static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
> +{
> +       unsigned int clk = 0, ddr = 0;
> +
> +       if (host->mmc->ios.timing == MMC_TIMING_MMC_DDR52 ||
> +           host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> +               ddr = MCI_STM32_CLK_DDR;
> +
> +       /*
> +        * cclk = mclk / (2 * clkdiv)
> +        * clkdiv 0 => bypass
> +        * in ddr mode bypass is not possible
> +        */
> +       if (desired) {
> +               if (desired >= host->mclk && !ddr) {
> +                       host->cclk = host->mclk;
> +               } else {
> +                       clk = DIV_ROUND_UP(host->mclk, 2 * desired);
> +                       if (clk > MCI_STM32_CLK_CLKDIV_MSK)
> +                               clk = MCI_STM32_CLK_CLKDIV_MSK;
> +                       host->cclk = host->mclk / (2 * clk);
> +               }
> +       }
> +
> +       if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
> +               clk |= MCI_STM32_CLK_WIDEBUS_4;
> +       if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
> +               clk |= MCI_STM32_CLK_WIDEBUS_8;
> +
> +       clk |= MCI_STM32_CLK_HWFCEN;
> +       clk |= host->clk_reg_add;
> +       clk |= ddr;
> +
> +       /*
> +        * SDMMC_FBCK is selected when an external Delay Block is needed
> +        * with SDR104.
> +        */
> +       if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50) {
> +               clk |= MCI_STM32_CLK_BUSSPEED;
> +               if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104) {
> +                       clk &= ~MCI_STM32_CLK_SEL_MSK;
> +                       clk |= MCI_STM32_CLK_SELFBCK;
> +               }
> +       }
> +
> +       mmci_write_clkreg(host, clk);
> +}
> +
> +static void mmci_sdmmc_set_pwrreg(struct mmci_host *host,
> +                                 unsigned char power_mode, unsigned int pwr)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +
> +       pwr |= host->pwr_reg_add;
> +
> +       switch (power_mode) {
> +       case MMC_POWER_OFF:
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +
> +               /* Only a reset could disable sdmmc */
> +               reset_control_assert(host->rst);
> +               udelay(2);
> +               reset_control_deassert(host->rst);

Could you please elaborate on what goes on here. Do you need to
reset-the controller when powering off the card?

> +
> +               /* default mask (probe) must be activated */
> +               writel(MCI_IRQENABLE | host->variant->start_err,
> +                      host->base + MMCIMASK0);

The above seems like it could be made generic. There is no reason to
keep IRQs enabled when the card is powered off.

> +
> +               /*
> +                * Set the SDMMC in Power-cycle state before to disabling vqmmc.
> +                * This will make that the SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK
> +                * are driven low, to prevent the Card from being supplied
> +                * through the signal lines.
> +                */
> +               mmci_write_pwrreg(host, MCI_STM32_PWR_CYC | pwr);
> +
> +               if (!IS_ERR(host->mmc->supply.vqmmc) && host->vqmmc_enabled) {
> +                       regulator_disable(host->mmc->supply.vqmmc);
> +                       host->vqmmc_enabled = false;
> +               }
> +               break;
> +       case MMC_POWER_UP:
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> +                                             mmc->ios.vdd);
> +               break;
> +       case MMC_POWER_ON:
> +               if (!IS_ERR(host->mmc->supply.vqmmc) && !host->vqmmc_enabled) {
> +                       if (regulator_enable(host->mmc->supply.vqmmc) < 0)
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "failed to enable vqmmc regulator\n");
> +                       else
> +                               host->vqmmc_enabled = true;
> +               }
> +
> +               /*
> +                * After a power-cycle state, we must set the SDMMC in
> +                * Power-off. The SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are
> +                * driven high. Then we can set the SDMMC to Power-on state
> +                */
> +               mmci_write_pwrreg(host, MCI_PWR_OFF | pwr);
> +               mdelay(1);
> +               mmci_write_pwrreg(host, MCI_PWR_ON | pwr);

This looks odd. MMC_POWER_ON is the last power phase. For every single
additional ios change (timing, clock, etc), you will hit this piece of
code. In other words, there will be a mdelay(1) each time, which is
probably not needed.

> +               break;
> +       }
> +}
> +
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> --
> 2.7.4
>

Overall I am wondering if mmci_sdmmc_set_pwrreg() can be made generic
inside the common mmci ->set_ios() functions instead.

For example, the reset can be optional and checked with
if(!IS_ERR(host->rst)) - and the others can probably be conditional
based on a variant data.

What do you think?

Kind regards
Uffe
