From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/5] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Tue, 30 Apr 2019 13:13:57 +0200
Message-ID: <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -Avoid to check and poll busy status when is not expected.
> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>  different.
> -Add hardware busy timeout with MMCIDATATIMER register.
>
> V2:
> -mmci_cmd_irq cleanup in separate patch.
> -simplify the busy_detect_flag exclude
> -replace sdmmc specific comment in
> "mmc: mmci: avoid fake busy polling in mmci_irq"
> to focus on common behavior
>
> Ludovic Barre (5):
>   mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
>   mmc: mmci: avoid fake busy polling in mmci_irq
>   mmc: mmci: fix clear of busy detect status
>   mmc: mmci: add hardware busy timeout feature
>   mmc: mmci: add busy detect for stm32 sdmmc variant
>
>  drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 51 insertions(+), 13 deletions(-)
>
> --
> 2.7.4
>

Ludovic, just wanted to let you know that I am reviewing and testing
this series.

However, while running some tests on Ux500 for validating the busy
detection code, even without your series applied, I encounter some odd
behaviors. I am looking into the problem to understand better and will
let you know as soon as I have some more data to share.

Kind regards
Uffe
