From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 00/23] mmc: mmci: add sdmmc variant for stm32
Date: Tue, 9 Oct 2018 09:30:41 +0200
Message-ID: <CAPDyKFp0oHHS=bkXj_AbiLmbNxW07pFnk-4m9kwQtYkh_ogKgw@mail.gmail.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On 8 October 2018 at 14:08, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The goal of this serie is to add support of sdmmc for stm32.
> Be to able to add this new variant it is needed to do some changes in
> mmci core:
> -Internalize specific needs of legacy dmaengine.
> -Create and setup dma_priv pointer.
> -Create generic callbacks which share some features (like cookie...)
>  and call specific needs.
>
> change v6:
> -move mmci_variant_init in mmci.c
> -dma_setup/release: let the variants clean up themselves.
>
> change v5:
> -error management in mmci_dmae_setup and qcom_dma_setup
>  mmci_dmae_setup: fail when tx & rx are not defined.
>  qcom_dma_setup: faill if one of channels is not defined.
> -define mmci_variant_init following CONFIG_DMA_ENGINE state.
> -squash dma_setup/dma_release callback.
>
> change v4:
> -checkpatch fix bool to u8
> -add use_dma variable to fallback to pio mode
> -move to optional reset with dt binding note for sdmmc
> -separate patch for DT doc
>
> change v3:
> -remove __dma_inprogress rename
> -remove bad space at end of "st,use-ckin"
>
> change v2:
> -rename to mmci_prep/unprep_data
> -rename specific dma engine structure to mmci_dmae_next/priv
> -follow "_" recommandation
> -remove dma prefixe of mmci_dmae_priv fields
>
> Ludovic Barre (23):
>   mmc: mmci: create common mmci_dma_setup/release
>   mmc: mmci: introduce dma_priv pointer to mmci_host
>   mmc: mmci: merge prepare data functions
>   mmc: mmci: add prepare/unprepare_data callbacks
>   mmc: mmci: add get_next_data callback
>   mmc: mmci: add dma_start callback
>   mmc: mmci: add dma_finalize callback
>   mmc: mmci: add dma_error callback
>   mmc: mmci: add validate_data callback
>   mmc: mmci: add set_clk/pwrreg callbacks
>   mmc: mmci: add datactrl block size variant property
>   mmc: mmci: expand startbiterr to irqmask and error check
>   mmc: mmci: add variant properties to define cpsm & cmdresp bits
>   mmc: mmci: add variant property to define dpsm bit
>   mmc: mmci: add variant property to define irq pio mask
>   mmc: mmci: add variant property to write datactrl before command
>   mmc: mmci: add variant property to not read datacnt
>   dt-bindings: mmci: add optional reset property
>   mmc: mmci: add optional reset property
>   mmc: mmci: add clock divider for stm32 sdmmc
>   mmc: mmci: add stm32 sdmmc registers
>   dt-bindings: mmci: add stm32 sdmmc variant
>   mmc: mmci: add stm32 sdmmc variant
>
>  Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
>  drivers/mmc/host/Kconfig                       |  10 +
>  drivers/mmc/host/Makefile                      |   1 +
>  drivers/mmc/host/mmci.c                        | 628 ++++++++++++++++++-------
>  drivers/mmc/host/mmci.h                        | 140 +++++-
>  drivers/mmc/host/mmci_qcom_dml.c               |  17 +-
>  drivers/mmc/host/mmci_stm32_sdmmc.c            | 282 +++++++++++
>  7 files changed, 886 insertions(+), 203 deletions(-)
>  create mode 100644 drivers/mmc/host/mmci_stm32_sdmmc.c
>
> --
> 2.7.4
>

Applied for next, thanks!

FYI, I made little fixup of the help text in the Kconfig for the last patch.

Kind regards
Uffe
