From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Thu, 20 Jun 2019 15:50:26 +0200
Message-ID: <CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com> <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

Hi Ludovic,

On Thu, 13 Jun 2019 at 15:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 Jun 2019 at 15:02, Ludovic BARRE <ludovic.barre@st.com> wrote:
> >
> > hi Ulf
> >
> > Just a "gentleman ping" about this series.
> > I know you are busy, it's just to be sure you do not forget me :-)
>
> Thanks! I started briefly to review, but got distracted again. I will
> come to it, but it just seems to take more time than it should, my
> apologies.

Alright, so I planned to review this this week - but failed. I have
been overwhelmed with work lately (as usual when vacation is getting
closer).

I need to gently request to come back to this as of week 28, when I
will give this the highest prio. Again apologize for the delays!

Kind regards
Uffe

>
> Br
> Uffe
>
> >
> > Regards
> > Ludo
> >
> > On 6/3/19 5:55 PM, Ludovic Barre wrote:
> > > From: Ludovic Barre <ludovic.barre@st.com>
> > >
> > > This patch series adds busy detect for stm32 sdmmc variant.
> > > Some adaptations are required:
> > > -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> > >   different.
> > > -Add hardware busy timeout with MMCIDATATIMER register.
> > >
> > > V3:
> > > -rebase on latest mmc next
> > > -replace re-read by status parameter.
> > >
> > > V2:
> > > -mmci_cmd_irq cleanup in separate patch.
> > > -simplify the busy_detect_flag exclude
> > > -replace sdmmc specific comment in
> > > "mmc: mmci: avoid fake busy polling in mmci_irq"
> > > to focus on common behavior
> > >
> > > Ludovic Barre (3):
> > >    mmc: mmci: fix read status for busy detect
> > >    mmc: mmci: add hardware busy timeout feature
> > >    mmc: mmci: add busy detect for stm32 sdmmc variant
> > >
> > >   drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
> > >   drivers/mmc/host/mmci.h |  3 +++
> > >   2 files changed, 44 insertions(+), 8 deletions(-)
> > >
