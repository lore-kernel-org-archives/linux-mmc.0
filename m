From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: mmci: Add sdio enable mask in variant data
Date: Wed, 10 Sep 2014 09:47:35 +0200
Message-ID: <CAPDyKFrVp4DHiHbsRpov0zG=YyiYxuz+TVjPJ16k2fYGsdFjRg@mail.gmail.com>
References: <1408683219-7939-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1408683295-8030-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1408683295-8030-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2014 06:54, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch adds sdio enable mask in variant data, SOCs like ST have
> special bits in datactrl register to enable sdio. Unconditionally setting
> this bit in this driver breaks other SOCs like Qualcomm which maps this
> bits to something else, so making this enable bit to come from variant
> data solves the issue.
>
> Originally the issue is detected while testing WLAN ath6kl on Qualcomm
> APQ8064.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 533ad2b..a25759e 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -67,6 +67,7 @@ static unsigned int fmax = 515633;
>   * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
>   * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
>   *                  register
> + * @datactrl_mask_sdio: SDIO enable mask in datactrl register
>   * @pwrreg_powerup: power up value for MMCIPOWER register
>   * @f_max: maximum clk frequency supported by the controller.
>   * @signal_direction: input/out direction of bus signals can be indicated
> @@ -89,6 +90,7 @@ struct variant_data {
>         unsigned int            fifohalfsize;
>         unsigned int            data_cmd_enable;
>         unsigned int            datactrl_mask_ddrmode;
> +       unsigned int            datactrl_mask_sdio;
>         bool                    sdio;
>         bool                    st_clkdiv;
>         bool                    blksz_datactrl16;
> @@ -138,6 +140,7 @@ static struct variant_data variant_u300 = {
>         .clkreg_enable          = MCI_ST_U300_HWFCEN,
>         .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
>         .datalength_bits        = 16,
> +       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
>         .sdio                   = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
>         .f_max                  = 100000000,
> @@ -151,6 +154,7 @@ static struct variant_data variant_nomadik = {
>         .fifohalfsize           = 8 * 4,
>         .clkreg                 = MCI_CLK_ENABLE,
>         .datalength_bits        = 24,
> +       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
>         .sdio                   = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -168,6 +172,7 @@ static struct variant_data variant_ux500 = {
>         .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
>         .clkreg_neg_edge_enable = MCI_ST_UX500_NEG_EDGE,
>         .datalength_bits        = 24,
> +       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
>         .sdio                   = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -187,6 +192,7 @@ static struct variant_data variant_ux500v2 = {
>         .clkreg_neg_edge_enable = MCI_ST_UX500_NEG_EDGE,
>         .datactrl_mask_ddrmode  = MCI_ST_DPSM_DDRMODE,
>         .datalength_bits        = 24,
> +       .datactrl_mask_sdio     = MCI_ST_DPSM_SDIOEN,
>         .sdio                   = true,
>         .st_clkdiv              = true,
>         .blksz_datactrl16       = true,
> @@ -812,16 +818,10 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>         if (data->flags & MMC_DATA_READ)
>                 datactrl |= MCI_DPSM_DIRECTION;
>
> -       /* The ST Micro variants has a special bit to enable SDIO */
>         if (variant->sdio && host->mmc->card)
>                 if (mmc_card_sdio(host->mmc->card)) {
> -                       /*
> -                        * The ST Micro variants has a special bit
> -                        * to enable SDIO.
> -                        */
>                         u32 clk;
> -
> -                       datactrl |= MCI_ST_DPSM_SDIOEN;
> +                       datactrl |= variant->datactrl_mask_sdio;
>
>                         /*
>                          * The ST Micro variant for SDIO small write transfers
> --
> 1.9.1
>
