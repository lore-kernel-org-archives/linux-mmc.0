From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: mmci: Support any block sizes for ux500v2 and
 qcom variant
Date: Wed, 10 Sep 2014 09:58:48 +0200
Message-ID: <CAPDyKFqJw0Dc8ac2i0tebJpuHVhUVd=YUnGHZDTHNd2AAJqOtg@mail.gmail.com>
References: <1408683219-7939-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2014 06:54, Srinivas Kandagatla
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

I am not sure how to handle this patch.

It will as you say in the cover letter for this patchset, improve
situations for the ath6kl driver when it's issuing 12 bytes and 24
bytes reads and solve those issues.

On the other hand, as stated earlier mmci_pio_write need to be fixed
to have full support for any block size. That applies to the qcom
variant as well.

For ux500, I am sure this won't cause any regressions since the cw1200
isn't probed. Also, I am not sure the "any block size" support is even
enabled for that driver.

How about, that we add a comment in the pio_write function describing
that we need to fix it for "SDIO any block size" support? And leave
that as a future improvement?

Kind regards
Uffe

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
