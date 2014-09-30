From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 03/12] clk: Add a function to retrieve phase
Date: Tue, 30 Sep 2014 00:01:17 -0700
Message-ID: <20140930070117.19023.51389@quantum>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140928001732.19023.2496@quantum> <20140929082421.GA4388@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140929082421.GA4388@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Emilio Lopez <emilio@elopez.com.ar>, linux-mmc@vger.kernel.org, chris@printf.net, Hans de Goede <hdegoede@redhat.com>, wens@csie.org, david.lanzendoerfer@o2s.ch, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Quoting Maxime Ripard (2014-09-29 01:24:21)
> Hi Mike,
> 
> On Sat, Sep 27, 2014 at 05:17:32PM -0700, Mike Turquette wrote:
> > Quoting Maxime Ripard (2014-09-11 13:18:17)
> > > The current phase API doesn't look into the actual hardware to get the phase
> > > value, but will rather get it from a variable only set by the set_phase
> > > function.
> > > 
> > > This will cause issue when the client driver will never call the set_phase
> > > function, where we can end up having a reported phase that will not match what
> > > the hardware has been programmed to by the bootloader or what phase is
> > > programmed out of reset.
> > > 
> > > Add a new get_phase function for the drivers to implement so that we can get
> > > this value.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > >  drivers/clk/clk.c            | 10 ++++++++++
> > >  include/linux/clk-provider.h |  5 +++++
> > >  2 files changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index d87661af0c72..113d75db371d 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -1934,6 +1934,16 @@ int __clk_init(struct device *dev, struct clk *clk)
> > >                 clk->accuracy = 0;
> > >  
> > >         /*
> > > +        * Set clk's phase.
> > > +        * Since a phase is by definition relative to its parent, just
> > > +        * query the current clock phase, or just assume it's in phase.
> > > +        */
> > > +       if (clk->ops->get_phase)
> > > +               clk->phase = clk->ops->get_phase(clk->hw);
> > > +       else
> > > +               clk->phase = 0;
> > 
> > I probably wasn't paying enough attention to this. Based on the
> > coverletter I thought that v3 would introduce something like
> > CLK_GET_PHASE_NOCACHE and stuff that logic into a __clk_get_phase
> > function? Looks like this version of the series doesn't handle phases
> > that can be changed by hardware (e.g. coming out of idle).
> > 
> > Correct me if I am wrong, but it looks like we retrieve the phase only
> > once at init and then never again? The rest of the time we rely on
> > clk->phase to always be accurate...
> 
> Yeah, I didn't have any use for it at the moment, and thought that if
> someone ever needed it, it would be trivial to add, so I left it out.
> 
> If you want me to still do it, I can send an additional patch.

No it is fine. A bit asymmetrical for my brain but it is dead code if no
one is using it (yet).

Regards,
Mike

> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
