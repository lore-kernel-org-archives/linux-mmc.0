From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/6] mmc: mmci: add helper functions to define datactrl
 value for variants
Date: Thu, 21 Mar 2019 17:43:28 +0100
Message-ID: <CAPDyKFoq-pvw=KNPK4XzNu=0Jeu_OPDB0KZrhWVQ88LjNAu5nw@mail.gmail.com>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com> <1551976742-4358-3-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551976742-4358-3-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 7 Mar 2019 at 17:39, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds default helper functions to define datactrl value.
> Each variant could use these helpers to define datactrl and adds
> their specific field.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 25 +++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |  5 +++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 9e6a2c1..28b76c5 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -983,6 +983,31 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>         mmci_unprep_data(host, data, err);
>  }
>
> +u32 mmci_dctrl_blksz(struct mmci_host *host)
> +{
> +       return (ffs(host->data->blksz) - 1) << 4;
> +}

Overall, this function and the other helpers added here, could be made
static inline functions, implemented in mmci.h.

If I understood Russell's point correctly, that's also we he suggested.

> +
> +u32 mmci_dctrl_dir(struct mmci_host *host)
> +{
> +       return host->data->flags & MMC_DATA_READ ? MCI_DPSM_DIRECTION : 0;

As pointed out by Russell, drop this and keep this in the common
mmci_start_data().

Or you need this for the stm32_sdmmc later? Then perhaps make that a
separate change on top.

> +}
> +
> +u32 mmci_dctrl_ddr(struct mmci_host *host)
> +{
> +       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
> +           host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
> +               return host->variant->datactrl_mask_ddrmode;

This seems a bit like an unnecessary helper. How about moving this
into the ux500v2 and qcom variants ->datactrl() callbacks instead,
thus we can also remove ->datactrl_mask_ddrmode from the variant
struct.

Does that make sense?

> +       return 0;
> +}
> +
> +u32 mmci_dctrl_sdio(struct mmci_host *host)
> +{
> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card))
> +               return host->variant->datactrl_mask_sdio;
> +       return 0;
> +}
> +
>  static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct variant_data *variant = host->variant;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index a59049b..32ae41d 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -430,6 +430,11 @@ struct mmci_host {
>  void mmci_write_clkreg(struct mmci_host *host, u32 clk);
>  void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
>
> +u32 mmci_dctrl_blksz(struct mmci_host *host);
> +u32 mmci_dctrl_dir(struct mmci_host *host);
> +u32 mmci_dctrl_ddr(struct mmci_host *host);
> +u32 mmci_dctrl_sdio(struct mmci_host *host);
> +
>  #ifdef CONFIG_DMA_ENGINE
>  int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>                         bool next);
> --
> 2.7.4
>

Overall, I have to admit that it's tricky to fine a decent balance of
callbacks/helpers/variant-data. I guess we simply have to continue
evolve this, along the lines of what suggest here and just see how it
turns out. We can always patch the code on top if we find other/better
solutions along the road.

Kind regards
Uffe
