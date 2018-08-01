From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/14] mmc: mmci: fix qcom dma issue during mmci init with
 new dma_setup callback
Date: Wed, 1 Aug 2018 12:08:38 +0200
Message-ID: <CAPDyKFq4Qx5e8Hk40F5DpTJn3g1bnm6sbQERS0Lt-OGmzEdLyQ@mail.gmail.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533116221-380-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch fixes qcom dma issue during mmci init.
> Like init callback of qcom variant is not set, the qcom dma
> is not correctly initialized and fail while dma transfer
> ("buggy DMA detected. Taking evasive action").
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 1 +
>  drivers/mmc/host/mmci.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 71e9336..1841d250 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -208,6 +208,7 @@ static struct variant_data variant_qcom = {
>         .mmcimask1              = true,
>         .start_err              = MCI_STARTBITERR,
>         .opendrain              = MCI_ROD,
> +       .init                   = qcom_variant_init,
>  };
>
>  /* Busy detection for the ST Micro variant */
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 517591d..696a066 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -338,3 +338,4 @@ struct mmci_host {
>  #endif
>  };
>
> +void qcom_variant_init(struct mmci_host *host);

This isn't needed.

> --
> 2.7.4
>

Anyway, we can just drop this patch from your series as I amended the
patch causing the problem.

I will continue to review the rest.

Kind regards
Uffe
