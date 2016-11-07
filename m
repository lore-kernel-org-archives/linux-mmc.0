From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3 v2] mmc: mmci: clean up header defines
Date: Mon, 7 Nov 2016 13:43:01 +0100
Message-ID: <CAPDyKFoPrQjxStaAdi+BUjXYGuqZbUevt6AtUSX0FHNO4AM=RQ@mail.gmail.com>
References: <1477386367-18514-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477386367-18514-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On 25 October 2016 at 11:06, Linus Walleij <linus.walleij@linaro.org> wrote:
> There was some confusion in the CPSM (Command Path State Machine)
> and DPSM (Data Path State Machine) regarding the naming of the
> registers, clarify the meaning of this acronym so the naming is
> understandable, and consistently use BIT() to define these fields.
>
> Consequently name the register bit defines MCI_[C|D]PSM_* and
> adjust the driver as well.
>
> Include new definitions for a few bits found in a patch from
> Srinivas Kandagatla.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> ChangeLog v1->v2:
> - Use more consequent register naming.
> ---
>  drivers/mmc/host/mmci.c | 16 ++++++------
>  drivers/mmc/host/mmci.h | 69 +++++++++++++++++++++++++++----------------------
>  2 files changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index df990bb8c873..6a8ea9c633d4 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -137,7 +137,7 @@ static struct variant_data variant_u300 = {
>         .clkreg_enable          = MCI_ST_U300_HWFCEN,
>         .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
>         .datalength_bits        = 16,
> -       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
> +       .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .st_sdio                        = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
>         .f_max                  = 100000000,
> @@ -152,7 +152,7 @@ static struct variant_data variant_nomadik = {
>         .clkreg                 = MCI_CLK_ENABLE,
>         .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
>         .datalength_bits        = 24,
> -       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
> +       .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -170,7 +170,7 @@ static struct variant_data variant_ux500 = {
>         .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
>         .clkreg_neg_edge_enable = MCI_ST_UX500_NEG_EDGE,
>         .datalength_bits        = 24,
> -       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
> +       .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -188,9 +188,9 @@ static struct variant_data variant_ux500v2 = {
>         .clkreg_enable          = MCI_ST_UX500_HWFCEN,
>         .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
>         .clkreg_neg_edge_enable = MCI_ST_UX500_NEG_EDGE,
> -       .datactrl_mask_ddrmode  = MCI_ST_DPSM_DDRMODE,
> +       .datactrl_mask_ddrmode  = MCI_DPSM_ST_DDRMODE,
>         .datalength_bits        = 24,
> -       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
> +       .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .blksz_datactrl16       = true,
> @@ -210,7 +210,7 @@ static struct variant_data variant_qcom = {
>                                   MCI_QCOM_CLK_SELECT_IN_FBCLK,
>         .clkreg_8bit_bus_enable = MCI_QCOM_CLK_WIDEBUS_8,
>         .datactrl_mask_ddrmode  = MCI_QCOM_CLK_SELECT_IN_DDR_MODE,
> -       .data_cmd_enable        = MCI_QCOM_CSPM_DATCMD,
> +       .data_cmd_enable        = MCI_CPSM_QCOM_DATCMD,
>         .blksz_datactrl4        = true,
>         .datalength_bits        = 24,
>         .pwrreg_powerup         = MCI_PWR_UP,
> @@ -295,7 +295,7 @@ static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
>  static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
>  {
>         /* Keep ST Micro busy mode if enabled */
> -       datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
> +       datactrl |= host->datactrl_reg & MCI_DPSM_ST_BUSYMODE;
>
>         if (host->datactrl_reg != datactrl) {
>                 host->datactrl_reg = datactrl;
> @@ -1614,7 +1614,7 @@ static int mmci_probe(struct amba_device *dev,
>
>         if (variant->busy_detect) {
>                 mmci_ops.card_busy = mmci_card_busy;
> -               mmci_write_datactrlreg(host, MCI_ST_DPSM_BUSYMODE);
> +               mmci_write_datactrlreg(host, MCI_DPSM_ST_BUSYMODE);
>                 mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>                 mmc->max_busy_timeout = 0;
>         }
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index a1f5e4f49e2a..7cabf270050b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -51,25 +51,27 @@
>  #define MCI_QCOM_CLK_SELECT_IN_DDR_MODE        (BIT(14) | BIT(15))
>
>  #define MMCIARGUMENT           0x008
> -#define MMCICOMMAND            0x00c
> -#define MCI_CPSM_RESPONSE      (1 << 6)
> -#define MCI_CPSM_LONGRSP       (1 << 7)
> -#define MCI_CPSM_INTERRUPT     (1 << 8)
> -#define MCI_CPSM_PENDING       (1 << 9)
> -#define MCI_CPSM_ENABLE                (1 << 10)
> -/* Argument flag extenstions in the ST Micro versions */
> -#define MCI_ST_SDIO_SUSP       (1 << 11)
> -#define MCI_ST_ENCMD_COMPL     (1 << 12)
> -#define MCI_ST_NIEN            (1 << 13)
> -#define MCI_ST_CE_ATACMD       (1 << 14)
>
> -/* Modified on Qualcomm Integrations */
> -#define MCI_QCOM_CSPM_DATCMD           BIT(12)
> -#define MCI_QCOM_CSPM_MCIABORT         BIT(13)
> -#define MCI_QCOM_CSPM_CCSENABLE                BIT(14)
> -#define MCI_QCOM_CSPM_CCSDISABLE       BIT(15)
> -#define MCI_QCOM_CSPM_AUTO_CMD19       BIT(16)
> -#define MCI_QCOM_CSPM_AUTO_CMD21       BIT(21)
> +/* The command register controls the Command Path State Machine (CPSM) */
> +#define MMCICOMMAND            0x00c
> +#define MCI_CPSM_RESPONSE      BIT(6)
> +#define MCI_CPSM_LONGRSP       BIT(7)
> +#define MCI_CPSM_INTERRUPT     BIT(8)
> +#define MCI_CPSM_PENDING       BIT(9)
> +#define MCI_CPSM_ENABLE                BIT(10)
> +/* Command register flag extenstions in the ST Micro versions */
> +#define MCI_CPSM_ST_SDIO_SUSP          BIT(11)
> +#define MCI_CPSM_ST_ENCMD_COMPL                BIT(12)
> +#define MCI_CPSM_ST_NIEN               BIT(13)
> +#define MCI_CPSM_ST_CE_ATACMD          BIT(14)
> +/* Command register flag extensions in the Qualcomm versions */
> +#define MCI_CPSM_QCOM_PROGENA          BIT(11)
> +#define MCI_CPSM_QCOM_DATCMD           BIT(12)
> +#define MCI_CPSM_QCOM_MCIABORT         BIT(13)
> +#define MCI_CPSM_QCOM_CCSENABLE                BIT(14)
> +#define MCI_CPSM_QCOM_CCSDISABLE       BIT(15)
> +#define MCI_CPSM_QCOM_AUTO_CMD19       BIT(16)
> +#define MCI_CPSM_QCOM_AUTO_CMD21       BIT(21)
>
>  #define MMCIRESPCMD            0x010
>  #define MMCIRESPONSE0          0x014
> @@ -78,22 +80,27 @@
>  #define MMCIRESPONSE3          0x020
>  #define MMCIDATATIMER          0x024
>  #define MMCIDATALENGTH         0x028
> +
> +/* The data control register controls the Data Path State Machine (DPSM) */
>  #define MMCIDATACTRL           0x02c
> -#define MCI_DPSM_ENABLE                (1 << 0)
> -#define MCI_DPSM_DIRECTION     (1 << 1)
> -#define MCI_DPSM_MODE          (1 << 2)
> -#define MCI_DPSM_DMAENABLE     (1 << 3)
> -#define MCI_DPSM_BLOCKSIZE     (1 << 4)
> +#define MCI_DPSM_ENABLE                BIT(0)
> +#define MCI_DPSM_DIRECTION     BIT(1)
> +#define MCI_DPSM_MODE          BIT(2)
> +#define MCI_DPSM_DMAENABLE     BIT(3)
> +#define MCI_DPSM_BLOCKSIZE     BIT(4)
>  /* Control register extensions in the ST Micro U300 and Ux500 versions */
> -#define MCI_ST_DPSM_RWSTART    (1 << 8)
> -#define MCI_ST_DPSM_RWSTOP     (1 << 9)
> -#define MCI_ST_DPSM_RWMOD      (1 << 10)
> -#define MCI_ST_DPSM_SDIOEN     (1 << 11)
> +#define MCI_DPSM_ST_RWSTART    BIT(8)
> +#define MCI_DPSM_ST_RWSTOP     BIT(9)
> +#define MCI_DPSM_ST_RWMOD      BIT(10)
> +#define MCI_DPSM_ST_SDIOEN     BIT(11)
>  /* Control register extensions in the ST Micro Ux500 versions */
> -#define MCI_ST_DPSM_DMAREQCTL  (1 << 12)
> -#define MCI_ST_DPSM_DBOOTMODEEN        (1 << 13)
> -#define MCI_ST_DPSM_BUSYMODE   (1 << 14)
> -#define MCI_ST_DPSM_DDRMODE    (1 << 15)
> +#define MCI_DPSM_ST_DMAREQCTL  BIT(12)
> +#define MCI_DPSM_ST_DBOOTMODEEN        BIT(13)
> +#define MCI_DPSM_ST_BUSYMODE   BIT(14)
> +#define MCI_DPSM_ST_DDRMODE    BIT(15)
> +/* Control register extensions in the Qualcomm versions */
> +#define MCI_DPSM_QCOM_DATA_PEND        BIT(17)
> +#define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
>
>  #define MMCIDATACNT            0x030
>  #define MMCISTATUS             0x034
> --
> 2.7.4
>
