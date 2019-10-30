From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Date: Wed, 30 Oct 2019 16:09:58 +0100
Message-ID: <CAPDyKFo9wYwhdy-1BDcRMJKTjADappsT-gBaKZE7hTLE4obxiA@mail.gmail.com>
References: <20191018131338.11713-1-hslester96@gmail.com> <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
 <20191023153313.GB5153@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191023153313.GB5153@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Chuhong Yuan <hslester96@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 23 Oct 2019 at 17:33, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Oct 21, 2019 at 04:32:49PM +0200, Ulf Hansson wrote:
> > On Fri, 18 Oct 2019 at 15:13, Chuhong Yuan <hslester96@gmail.com> wrote:
> > >
> > > renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
> > > failures.
> > > Add checks for them to fix the problem.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> > > index d4ada5cca2d1..dc5ad6632df3 100644
> > > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > > @@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
> > >         if (!IS_ERR(priv->pinctrl)) {
> > >                 priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
> > >                                                 PINCTRL_STATE_DEFAULT);
> > > +               if (IS_ERR(priv->pins_default))
> > > +                       return PTR_ERR(priv->pins_default);
> > > +
> > >                 priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl,
> > >                                                 "state_uhs");
> > > +               if (IS_ERR(priv->pins_uhs))
> > > +                       return PTR_ERR(priv->pins_uhs);
> > >         }
> >
> > This looks correct to me, as I guess if there is a pinctrl specified
> > for device node of the controller, it means that it should be used!?
> >
> > I understand that this is only used for those variants that supports
> > UHS-I via the renesas_sdhi_start_signal_voltage_switch(). Wolfram, is
> > this fine you think?
>
> Well, I don't like to bail out because this error is not fatal for basic
> operations. How about releasing priv->pinctrl again with an additional
> warning that pinctrl settings are broken and will prevent 1.8v modes?
>
> Opinions?

Hmm, from a mmc driver probe point of view, I don't quite share this approach.

I would rather fail as it forces the DTB to be corrected immediately,
rather than trusting some developer to look at a warning in a log. The
point is, in such a case it may never get fixed, if the product is
shipped with the wrong DTB.

My concern at this point is rather to break existing DTBs, but it
seems that should not be an issue, right?

Kind regards
Uffe
