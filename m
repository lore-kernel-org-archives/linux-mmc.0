From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 2/5] mmc: mmci: define get_dctrl_cfg for legacy variant
Date: Tue, 26 Mar 2019 18:46:44 +0100
Message-ID: <CAPDyKFoOugNTxN_g8Co1pBMkTku6+zMU40vqo-e0pZt+1rs9cw@mail.gmail.com>
References: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com> <1553591470-31419-3-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553591470-31419-3-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 26 Mar 2019 at 10:11, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch defines get_dctrl_cfg callback for legacy variants
> whatever DMA_ENGINE configuration.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 31 +++++++++++++++++++++++--------
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 9e6a2c1..4041e36 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -46,12 +46,6 @@
>
>  #define DRIVER_NAME "mmci-pl18x"
>
> -#ifdef CONFIG_DMA_ENGINE
> -static void mmci_variant_init(struct mmci_host *host);
> -#else
> -static inline void mmci_variant_init(struct mmci_host *host) {}
> -#endif

Looks like you are moving the declaration to the header file. I would
rather keep it here as there is no point in sharing to another c-file
(at least not yet). The same applies for the new ux500v2 init
function.

Other than that, this looks good to me!

Kind regards
Uffe
