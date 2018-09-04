From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/14] mmc: mmci: prepare dma callbacks with mmci_host_ops
Date: Tue, 4 Sep 2018 12:00:35 +0200
Message-ID: <CAPDyKFqArwShaUZAit4fHa7F6UNC_z7Yc1GMpBuQcrkkwrB84g@mail.gmail.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series prepares and adds callbacks for dma transfert at
> mmci_host_ops. This series is composed of 3 parts:
> -Internalize specific needs of legacy dmaengine.
> -Create and setup dma_priv pointer
> -Create generic callbacks  which share some features
> (like cookie...) and call specific needs

I have now reviewed part of this series and provided you with some
comments, but will stop at this point.

Overall, the comments are about renaming and picking better function
names. Those comments should be easy to address in a new version.

However, the other more important point is the number of variant
callbacks you are adding. It's of course a balance to pick the right
level, to get both flexibility but also to avoid open coding. In the
end we don't want to get too many callbacks, but then it's better to
share common mmci code for variants, through mmci.h.

Finally, I would like to see a patch on top adding the support for the
new ST variant, so I can see how the callbacks and changes really are
being used. Can you please add that?

>
> This patch series must be applied on top of
> "mmc: mmci: Add and implement a ->dma_setup() callback for qcom dml"
>
> Ludovic Barre (14):
>   mmc: mmci: fix qcom dma issue during mmci init with new dma_setup
>     callback
>   mmc: mmci: internalize dma map/unmap into mmci dma functions
>   mmc: mmci: internalize dma_inprogress into mmci dma functions
>   mmc: mmci: introduce dma_priv pointer to mmci_host
>   mmc: mmci: move mmci next cookie to mci host
>   mmc: mmci: merge prepare data functions
>   mmc: mmci: add prepare/unprepare_data callbacks
>   mmc: mmci: add get_next_data callback
>   mmc: mmci: modify dma_setup callback
>   mmc: mmci: add dma_release callback
>   mmc: mmci: add dma_start callback
>   mmc: mmci: add dma_finalize callback
>   mmc: mmci: add dma_error callback
>   mmc: mmci: add validate_data callback
>
>  drivers/mmc/host/mmci.c          | 458 ++++++++++++++++++++++++---------------
>  drivers/mmc/host/mmci.h          |  45 ++--
>  drivers/mmc/host/mmci_qcom_dml.c |  15 +-
>  3 files changed, 322 insertions(+), 196 deletions(-)
>
> --
> 2.7.4
>

Kind regards
Uffe
