From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-iproc: support standard byte register accesses
Date: Thu, 10 Nov 2016 23:21:24 +0100
Message-ID: <CAPDyKFrPwwXoAgJ7XGYSWDOiZiJqdjF3p6D0t5bUiPYEnn6ysg@mail.gmail.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com> <1478018277-10097-3-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478018277-10097-3-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

On 1 November 2016 at 17:37, Scott Branden <scott.branden@broadcom.com> wrote:
> Add bytewise register accesses support for newer versions of IPROC
> SDHCI controllers.
> Previous sdhci-iproc versions of SDIO controllers
> (such as Raspberry Pi and Cygnus) only allowed for 32-bit register
> accesses.
>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-iproc.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 7262466..d7046d6 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -143,6 +143,14 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
>  }
>
>  static const struct sdhci_ops sdhci_iproc_ops = {
> +       .set_clock = sdhci_set_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .reset = sdhci_reset,
> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_ops sdhci_iproc_32only_ops = {
>         .read_l = sdhci_iproc_readl,
>         .read_w = sdhci_iproc_readw,
>         .read_b = sdhci_iproc_readb,
> @@ -156,6 +164,28 @@ static const struct sdhci_ops sdhci_iproc_ops = {
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
> +       .quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
> +       .quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
> +       .ops = &sdhci_iproc_32only_ops,
> +};
> +
> +static const struct sdhci_iproc_data iproc_cygnus_data = {
> +       .pdata = &sdhci_iproc_cygnus_pltfm_data,
> +       .caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> +                       & SDHCI_MAX_BLOCK_MASK) |
> +               SDHCI_CAN_VDD_330 |
> +               SDHCI_CAN_VDD_180 |
> +               SDHCI_CAN_DO_SUSPEND |
> +               SDHCI_CAN_DO_HISPD |
> +               SDHCI_CAN_DO_ADMA2 |
> +               SDHCI_CAN_DO_SDMA,
> +       .caps1 = SDHCI_DRIVER_TYPE_C |
> +                SDHCI_DRIVER_TYPE_D |
> +                SDHCI_SUPPORT_DDR50,
> +       .mmc_caps = MMC_CAP_1_8V_DDR,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>         .quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
>         .quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
> @@ -182,7 +212,7 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>         .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>                   SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>                   SDHCI_QUIRK_MISSING_CAPS,
> -       .ops = &sdhci_iproc_ops,
> +       .ops = &sdhci_iproc_32only_ops,
>  };
>
>  static const struct sdhci_iproc_data bcm2835_data = {
> @@ -194,7 +224,8 @@ static const struct sdhci_iproc_data bcm2835_data = {
>
>  static const struct of_device_id sdhci_iproc_of_match[] = {
>         { .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
> -       { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_data },
> +       { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
> +       { .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
> --
> 2.5.0
>
