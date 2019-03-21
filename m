From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/6] mmc: mmci: add get_datactrl_cfg callback
Date: Thu, 21 Mar 2019 17:57:38 +0100
Message-ID: <CAPDyKFq52dXPP+-peh82uCqTDFhmXvYWbTyncHDr_Oyo8Bd1VA@mail.gmail.com>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com> <1551976742-4358-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551976742-4358-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 7 Mar 2019 at 17:39, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds get_datactrl_cfg callback in mmci_host_ops
> to allow to get datactrl configuration specific at variant.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 6bde28c..a59049b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -362,6 +362,7 @@ struct mmci_host_ops {
>                          bool next);
>         void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
>                             int err);
> +       u32 (*get_datactrl_cfg)(struct mmci_host *host);
>         void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
>         int (*dma_setup)(struct mmci_host *host);
>         void (*dma_release)(struct mmci_host *host);
> --
> 2.7.4
>

Perhaps squash this change with patch2, they seems to belong to each
other as they are both the preparation that is needed for the
following changes on top.

Kind regards
Uffe
