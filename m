From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: mmci: Support any block sizes for ux500v2 and
 qcom variant
Date: Tue, 5 Mar 2019 23:25:16 +0100
Message-ID: <CACRpkdZtUJim0d0iC26d-Z8xBckdCX7uwh_v4PhJSKkHEcmmrw@mail.gmail.com>
References: <1408683219-7939-1-git-send-email-srinivas.kandagatla@linaro.org> <1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Sorry for top-posting, patch included for context.

I saw today that Brian has the Nexus 5 working with Broadcom/Cypress
4339 over SDIO on the MMCI.

Brian are you managing to use the WLAN without this patch or is this
something you stacked up to make it work? (If you want context I
can forward the rest of the conversation where we discuss how to
fix it properly.)

I discussed this patch several times with Ulf and I think Niklas looked
at it too, but we never got around to fix it up properly.

Yours,
Linus Walleij


On Fri, Aug 22, 2014 at 6:54 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For the ux500v2 variant of the PL18x block, any block sizes are
> supported. This will make it possible to decrease data overhead
> for SDIO transfers.
>
> This patch is based on Ulf Hansson patch
> http://www.spinics.net/lists/linux-mmc/msg12160.html
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>         enabled this support on qcom variant.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c11cb05..533ad2b 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -77,6 +77,7 @@ static unsigned int fmax = 515633;
>   * @qcom_fifo: enables qcom specific fifo pio read logic.
>   * @reversed_irq_handling: handle data irq before cmd irq.
>   * @qcom_dml: enables qcom specific dma glue for dma transfers.
> + * @any_blksize: true if block any sizes are supported
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -102,6 +103,7 @@ struct variant_data {
>         bool                    qcom_fifo;
>         bool                    reversed_irq_handling;
>         bool                    qcom_dml;
> +       bool                    any_blksize;
>  };
>
>  static struct variant_data variant_arm = {
> @@ -194,6 +196,7 @@ static struct variant_data variant_ux500v2 = {
>         .pwrreg_clkgate         = true,
>         .busy_detect            = true,
>         .pwrreg_nopower         = true,
> +       .any_blksize            = true,
>  };
>
>  static struct variant_data variant_qcom = {
> @@ -212,6 +215,7 @@ static struct variant_data variant_qcom = {
>         .explicit_mclk_control  = true,
>         .qcom_fifo              = true,
>         .qcom_dml               = true,
> +       .any_blksize            = true,
>  };
>
>  static int mmci_card_busy(struct mmc_host *mmc)
> @@ -239,10 +243,11 @@ static int mmci_card_busy(struct mmc_host *mmc)
>  static int mmci_validate_data(struct mmci_host *host,
>                               struct mmc_data *data)
>  {
> +       struct variant_data *variant = host->variant;
> +
>         if (!data)
>                 return 0;
> -
> -       if (!is_power_of_2(data->blksz)) {
> +       if (!is_power_of_2(data->blksz) && !variant->any_blksize) {
>                 dev_err(mmc_dev(host->mmc),
>                         "unsupported block size (%d bytes)\n", data->blksz);
>                 return -EINVAL;
> @@ -796,7 +801,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>         writel(host->size, base + MMCIDATALENGTH);
>
>         blksz_bits = ffs(data->blksz) - 1;
> -       BUG_ON(1 << blksz_bits != data->blksz);
>
>         if (variant->blksz_datactrl16)
>                 datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
> --
> 1.9.1
>
