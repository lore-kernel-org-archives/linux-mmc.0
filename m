From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Thu, 11 Apr 2019 15:29:11 +0200
Message-ID: <CAPDyKFpRA4mP-SHt_JuWk-Ee7=2Jgv6jKFh_08n_V20czKyvNg@mail.gmail.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com> <5b9fe100-6147-d64f-f676-6a5370a03016@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b9fe100-6147-d64f-f676-6a5370a03016@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Thu, 11 Apr 2019 at 14:37, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> Hi Ulf
>
> Just a gentleman ping about this series.
> I sent this series at same time of dt_mode
> (no dependence between both).

Thanks for pinging.

It's been a busy period, with travels etc. I am just catching up on
everything and I will soon come back to this.

I haven't tried to apply this on top of the other recent queued
changes for mmci, but perhaps you can check if a rebase is needed?
Especially since I plan to run this on my ux500 board.

Kind regards
Uffe

>
> BR
> Ludo
>
> On 3/5/19 5:10 PM, Ludovic Barre wrote:
> > From: Ludovic Barre <ludovic.barre@st.com>
> >
> > This patch series adds busy detect for stm32 sdmmc variant.
> > Some adaptations are required:
> > -Avoid to check and poll busy status when is not expected.
> > -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> >   different.
> > -Add hardware busy timeout with MMCIDATATIMER register.
> >
> > Ludovic Barre (4):
> >    mmc: mmci: avoid fake busy polling
> >    mmc: mmci: fix clear of busy detect status
> >    mmc: mmci: add hardware busy timeout feature
> >    mmc: mmci: add busy detect for stm32 sdmmc variant
> >
> >   drivers/mmc/host/mmci.c | 67 +++++++++++++++++++++++++++++++++++++++----------
> >   drivers/mmc/host/mmci.h |  3 +++
> >   2 files changed, 57 insertions(+), 13 deletions(-)
> >
