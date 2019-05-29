From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/5] mmc: mmci: fix clear of busy detect status
Date: Wed, 29 May 2019 12:36:50 +0200
Message-ID: <CAPDyKFqzNy3hDzovSxb6pd37u7SxWqYoJeu9+tf_qDF7gs0euA@mail.gmail.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <1556264798-18540-4-git-send-email-ludovic.Barre@st.com> <CAPDyKFrxp3Y3AudNvkkSRaph2Fe-A-F6Cs0jfy9RUja76GYeiA@mail.gmail.com>
 <a6a74431-50a6-6298-b77d-9d27a77fd6cc@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a6a74431-50a6-6298-b77d-9d27a77fd6cc@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Wed, 29 May 2019 at 11:20, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> On 5/27/19 8:17 PM, Ulf Hansson wrote:
> > On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> The "busy_detect_flag" is used to read/clear busy value of
> >> mmci status. The "busy_detect_mask" is used to manage busy irq of
> >> mmci mask.
> >> For sdmmc variant, the 2 properties have not the same offset.
> >> To clear the busyd0 status bit, we must add busy detect flag,
> >> the mmci mask is not enough.
> >>
> >> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >
> > Ludovic, again, apologies for the delay.
> >
> >> ---
> >>   drivers/mmc/host/mmci.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >> index a040f54..3cd52e8 100644
> >> --- a/drivers/mmc/host/mmci.c
> >> +++ b/drivers/mmc/host/mmci.c
> >> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
> >>                   * to make sure that both start and end interrupts are always
> >>                   * cleared one after the other.
> >>                   */
> >> -               status &= readl(host->base + MMCIMASK0);
> >> +               status &= readl(host->base + MMCIMASK0) |
> >> +                       host->variant->busy_detect_flag;
> >
> > I think this is not entirely correct, because it would mean we check
> > for busy even if we haven't unmasked the busy IRQ via the
> > variant->busy_detect_mask.
>
> if the variant is busy_detect false:
>   => no problem because the busy_detect_flag or busy_detect_mask is not
>      defined.

Right.

>
> if variant is busy_detect true:
> the busy handle is split in 3 steps (see mmci_cmd_irq):
> step 1: detection of busy line => unmasked the busy irq end
> step 2: in busy wait => ignore cmd irq while current busy flag is
> enabled.
> step 3: end of busy => clear and mask busy irq
>
> To detect the first step (see mmci_cmd_irq: which unmasks the busy irq)
> we need to know the current busy state. Actually, the status register is
> re-read in mmci_cmd_irq, why not used the status read in mmci_irq and in
> parameter ?

Right, I see your point.

On the other hand, that re-read of the status registers should really
not be needed. Maybe it's a leftover from my initial version of the
code, but in any case we should remove that.

>
> Regards,
> Ludo
>
> >
> > I suggest to store a new bool in the host (call it
> > "busy_detect_unmasked" or whatever makes sense to you), to track
> > whether we have unmasked the busy IRQ or not. Then take this flag into
> > account, before ORing the value of host->variant->busy_detect_flag,
> > according to above.
> >
> >>                  if (host->variant->busy_detect)
> >>                          writel(status & ~host->variant->busy_detect_mask,
> >>                                 host->base + MMCICLEAR);
> >> --
> >> 2.7.4

Kind regards
Uffe
