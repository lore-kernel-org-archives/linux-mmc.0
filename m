From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 4/5] mmc: mmci: stm32: define get_dctrl_cfg
Date: Wed, 27 Mar 2019 15:47:23 +0100
Message-ID: <CAPDyKFqh1pZhaiS9D22egZjDb_SL3_shs4Gr4PJUZVAXCbW5aA@mail.gmail.com>
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
 <1553677532-3539-5-git-send-email-ludovic.Barre@st.com> <CAPDyKFrGRojw5jmGZ_J-nmP4bHqd0BnKwyKweAr6aLD4C4NMPQ@mail.gmail.com>
 <bef06e28-4521-af86-adf4-bc904280707a@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bef06e28-4521-af86-adf4-bc904280707a@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Wed, 27 Mar 2019 at 15:44, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
>
> On 3/27/19 11:54 AM, Ulf Hansson wrote:
> > On Wed, 27 Mar 2019 at 10:05, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> This patch defines get_dctrl_cfg callback for sdmmc variant.
> >> sdmmc variant has specific stm32 transfer modes.
> >> sdmmc data transfer mode selection could be:
> >> -Block data transfer ending on block count.
> >> -SDIO multibyte data transfer.
> >> -MMC Stream data transfer (not used).
> >> -Block data transfer ending with STOP_TRANSMISSION command.
> >>
> >> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >> ---
> >>   drivers/mmc/host/mmci.h             |  5 +++++
> >>   drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++++++++
> >>   2 files changed, 23 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> >> index 35c91d0..82e9f94 100644
> >> --- a/drivers/mmc/host/mmci.h
> >> +++ b/drivers/mmc/host/mmci.h
> >> @@ -131,6 +131,11 @@
> >>   /* Control register extensions in the Qualcomm versions */
> >>   #define MCI_DPSM_QCOM_DATA_PEND        BIT(17)
> >>   #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
> >> +/* Control register extensions in STM32 versions */
> >> +#define MCI_DPSM_STM32_MODE_BLOCK      (0 << 2)
> >> +#define MCI_DPSM_STM32_MODE_SDIO       (1 << 2)
> >> +#define MCI_DPSM_STM32_MODE_STREAM     (2 << 2)
> >> +#define MCI_DPSM_STM32_MODE_BLOCK_STOP (3 << 2)
> >>
> >>   #define MMCIDATACNT            0x030
> >>   #define MMCISTATUS             0x034
> >> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> index cfbfc6f..8e83ae6 100644
> >> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> @@ -265,10 +265,28 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
> >>          }
> >>   }
> >>
> >> +static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
> >> +{
> >> +       u32 datactrl;
> >> +
> >> +       datactrl = mmci_dctrl_blksz(host);
> >> +
> >> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
> >> +           host->data->blocks == 1)
> >> +               datactrl |= MCI_DPSM_STM32_MODE_SDIO;
> >> +       else if (host->data->stop && !host->mrq->sbc)
> >> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
> >
> > Just a question here. Does this mean that the controller sends the
> > stop command automatically when a transfer has finished successfully?
>
> The controller not sends the stop command, this bit is just an
> information for the Data State Machine to know how the data transfer
> finish.

Okay, thanks for clarifying!

Kind regards
Uffe
