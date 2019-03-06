From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/5] mmc: mmci: qcom: define get_dctrl_cfg
Date: Wed, 6 Mar 2019 14:31:42 +0100
Message-ID: <CAPDyKFqVssTzjQYQq1n+CVEFODzjUdSiv=OUPkhycWYcxMoHGQ@mail.gmail.com>
References: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com> <1551694625-6414-4-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551694625-6414-4-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Mon, 4 Mar 2019 at 11:17, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch defines get_dctrl_cfg callback for qcom variant.
> qcom variant has a specific block size definition.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci_qcom_dml.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 25d0a75..d7b083d 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -183,9 +183,17 @@ static int qcom_dma_setup(struct mmci_host *host)
>         return 0;
>  }
>
> +u32 qcom_get_dctrl_cfg(struct mmci_host *host)

This can be static.

> +{
> +       struct variant_data *variant = host->variant;
> +
> +       return variant->datactrl_dpsm_enable | (host->data->blksz << 4);
> +}
> +
>  static struct mmci_host_ops qcom_variant_ops = {
>         .prep_data = mmci_dmae_prep_data,
>         .unprep_data = mmci_dmae_unprep_data,
> +       .get_datactrl_cfg = qcom_get_dctrl_cfg,
>         .get_next_data = mmci_dmae_get_next_data,
>         .dma_setup = qcom_dma_setup,
>         .dma_release = mmci_dmae_release,
> --
> 2.7.4
>

Kind regards
Uffe
