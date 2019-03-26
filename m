From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 0/5] mmc: mmci: add get_datactrl_cfg callback
Date: Tue, 26 Mar 2019 18:57:22 +0100
Message-ID: <CAPDyKFpvN5ZV-mh5tw8LJCHqtEg7tKTfYOpGXfPpMaBVOkg6-g@mail.gmail.com>
References: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 26 Mar 2019 at 10:11, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series adds get_datactrl_cfg callback in mmci_host_ops
> to allow to get datactrl configuration specific at variant.
>
> change V3:
> -keep the common functions in mmci_start_data. define
> function used by some variants like an helper
> (example mmci_dctrl_blks used by mmci and sdmmc).
> -To be consistent rename callback for ux500v2
>
> change V2:
> -This V2 has been rebased on
> "mmc: mmci: Cleanup some variant related code" series
> -add helpers functions to define default datactrl value,
> each variant could use these helpers to define datactrl
> and adds their specific bits.
> -use static in qcom and stm32
> -regroup mmci_(ux500v2)variant_init in header file
> to avoid checkpatch warning:
> "WARNING: externs should be avoided in .c files"
> -remove unused variant properties:
>  "datactrl_dpsm_enable"
>  "blksz_datactrl16"
>  "blksz_datactrl4"
>
> Ludovic Barre (5):
>   mmc: mmci: add get_datactrl_cfg callback and helper functions
>   mmc: mmci: define get_dctrl_cfg for legacy variant
>   mmc: mmci: qcom: define get_dctrl_cfg
>   mmc: mmci: stm32: define get_dctrl_cfg
>   mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback
>
>  drivers/mmc/host/mmci.c             | 57 ++++++++++++++++---------------------
>  drivers/mmc/host/mmci.h             | 21 +++++++++-----
>  drivers/mmc/host/mmci_qcom_dml.c    |  6 ++++
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++
>  4 files changed, 63 insertions(+), 39 deletions(-)
>
> --
> 2.7.4
>

Overall I think think this is step in right direction, nice work!

However, I also think there are more things that should be moved from
mmci_start_data() into the new ->get_datactrl_cfg() ops, such as the
SDIO things and the DDR mode things. Although, let's consider that as
improvements that can be made on top.

Besides the little comment I had on patch2, this looks good to me.

Kind regards
Uffe
