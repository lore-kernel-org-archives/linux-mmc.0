From: Ludovic BARRE <ludovic.barre@st.com>
Subject: RE: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Mon, 15 Jul 2019 07:39:23 +0000
Message-ID: <1563176363071.36427@st.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com>
 <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>,<CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com>
Content-Language: fr-FR
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf=0A=
=0A=
like scheduled, I send you a "gentleman ping" about this series.=0A=
=0A=
Regards,=0A=
Ludo=0A=
________________________________________=0A=
De : Ulf Hansson <ulf.hansson@linaro.org>=0A=
Envoy=E9 : jeudi 20 juin 2019 15:50=0A=
=C0 : Ludovic BARRE=0A=
Cc : Rob Herring; Srinivas Kandagatla; Maxime Coquelin; Alexandre TORGUE; L=
inux ARM; Linux Kernel Mailing List; DTML; linux-mmc@vger.kernel.org; linux=
-stm32@st-md-mailman.stormreply.com=0A=
Objet : Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc varia=
nt=0A=
=0A=
Hi Ludovic,=0A=
=0A=
On Thu, 13 Jun 2019 at 15:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:=
=0A=
>=0A=
> On Thu, 13 Jun 2019 at 15:02, Ludovic BARRE <ludovic.barre@st.com> wrote:=
=0A=
> >=0A=
> > hi Ulf=0A=
> >=0A=
> > Just a "gentleman ping" about this series.=0A=
> > I know you are busy, it's just to be sure you do not forget me :-)=0A=
>=0A=
> Thanks! I started briefly to review, but got distracted again. I will=0A=
> come to it, but it just seems to take more time than it should, my=0A=
> apologies.=0A=
=0A=
Alright, so I planned to review this this week - but failed. I have=0A=
been overwhelmed with work lately (as usual when vacation is getting=0A=
closer).=0A=
=0A=
I need to gently request to come back to this as of week 28, when I=0A=
will give this the highest prio. Again apologize for the delays!=0A=
=0A=
Kind regards=0A=
Uffe=0A=
=0A=
>=0A=
> Br=0A=
> Uffe=0A=
>=0A=
> >=0A=
> > Regards=0A=
> > Ludo=0A=
> >=0A=
> > On 6/3/19 5:55 PM, Ludovic Barre wrote:=0A=
> > > From: Ludovic Barre <ludovic.barre@st.com>=0A=
> > >=0A=
> > > This patch series adds busy detect for stm32 sdmmc variant.=0A=
> > > Some adaptations are required:=0A=
> > > -Clear busy status bit if busy_detect_flag and busy_detect_mask are=
=0A=
> > >   different.=0A=
> > > -Add hardware busy timeout with MMCIDATATIMER register.=0A=
> > >=0A=
> > > V3:=0A=
> > > -rebase on latest mmc next=0A=
> > > -replace re-read by status parameter.=0A=
> > >=0A=
> > > V2:=0A=
> > > -mmci_cmd_irq cleanup in separate patch.=0A=
> > > -simplify the busy_detect_flag exclude=0A=
> > > -replace sdmmc specific comment in=0A=
> > > "mmc: mmci: avoid fake busy polling in mmci_irq"=0A=
> > > to focus on common behavior=0A=
> > >=0A=
> > > Ludovic Barre (3):=0A=
> > >    mmc: mmci: fix read status for busy detect=0A=
> > >    mmc: mmci: add hardware busy timeout feature=0A=
> > >    mmc: mmci: add busy detect for stm32 sdmmc variant=0A=
> > >=0A=
> > >   drivers/mmc/host/mmci.c | 49 ++++++++++++++++++++++++++++++++++++++=
+++--------=0A=
> > >   drivers/mmc/host/mmci.h |  3 +++=0A=
> > >   2 files changed, 44 insertions(+), 8 deletions(-)=0A=
> > >=0A=
