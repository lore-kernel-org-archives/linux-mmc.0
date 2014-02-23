From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 2/8] clk: sunxi: Implement MMC phase control
Date: Sun, 23 Feb 2014 12:31:43 -0800
Message-ID: <20140223203143.22529.81640@quantum>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100221.15040.47203.stgit@pagira.o2s.ch>
 <20140218141532.GH3142@lukather> <20140219052125.8345.70717@quantum>
 <20140219083606.GR3142@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDO333VC4INBBNFVVGMAKGQE7MRM4XY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140219083606.GR3142@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?utf-8?q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?utf-8?q?Emilio_L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Quoting Maxime Ripard (2014-02-19 00:36:06)
> Hi Mike,
>=20
> On Tue, Feb 18, 2014 at 09:21:25PM -0800, Mike Turquette wrote:
> > Quoting Maxime Ripard (2014-02-18 06:15:32)
> > > Hi,
> > >=20
> > > On Mon, Feb 17, 2014 at 11:02:21AM +0100, David Lanzend=C3=B6rfer wro=
te:
> > > > From: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> > > >=20
> > > > Signed-off-by: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> > >=20
> > > You're missing your Signed-off-by here too.  Remember, for every patc=
h
> > > you send, your Signed-off-by must be there, regardless wether you're
> > > the author or not.
> > >=20
> > > A commit log would be very much welcome too.
> > >=20
> > > Now, down to the patch itself, I remember Mike saying that he would
> > > prefer adding a function in the framework instead of hardcoding
> > > it. Mike, what's your feeling on this? Would merging this seem
> > > reasonnable to you as is, or do you want to take this to the
> > > framework?
> >=20
> > Hi Maxime & Emilio,
> >=20
> > Maybe something like the following RFC? If it seems sufficient for this
> > case then I will post to the wider list with an eye towards merging it
> > for 3.15. I've Cc'd Dinh since this came up on the socfpga thread as
> > well.
> >=20
> > Regards,
> > Mike
> >=20
> >=20
> >=20
> > From 56fa297591be5c5e22df6d2ca43fccf285a45636 Mon Sep 17 00:00:00 2001
> > From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Date: Tue, 18 Feb 2014 20:33:50 -0800
> > Subject: [PATCH] clk: introduce clk_set_phase function & callback
> >=20
> > A common operation for a clock signal generator is to shift the phase o=
f
> > that signal. This patch introduces a new function to the clk.h API to
> > dynamically adjust the phase of a clock signal. Additionally this patch
> > introduces support for the new function in the common clock framework
> > via the .set_phase call back in struct clk_ops.
> >=20
> > Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> > This patch is totally untested. It may make your board burst into
> > flames.
> >=20
> >  drivers/clk/clk.c            | 84 ++++++++++++++++++++++++++++++++++++=
+++++---
> >  include/linux/clk-private.h  |  1 +
> >  include/linux/clk-provider.h |  5 +++
> >  include/linux/clk.h          | 29 +++++++++++++++
> >  4 files changed, 115 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index ea2ca9f..635170a 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -106,11 +106,11 @@ static void clk_summary_show_one(struct seq_file =
*s, struct clk *c, int level)
> >       if (!c)
> >               return;
> > =20
> > -     seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu",
> > +     seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu %-3d",
> >                  level * 3 + 1, "",
> >                  30 - level * 3, c->name,
> >                  c->enable_count, c->prepare_count, clk_get_rate(c),
> > -                clk_get_accuracy(c));
> > +                clk_get_accuracy(c), clk_get_phase(c));
> >       seq_printf(s, "\n");
> >  }
> > =20
> > @@ -132,8 +132,8 @@ static int clk_summary_show(struct seq_file *s, voi=
d *data)
> >  {
> >       struct clk *c;
> > =20
> > -     seq_printf(s, "   clock                        enable_cnt  prepar=
e_cnt  rate        accuracy\n");
> > -     seq_printf(s, "--------------------------------------------------=
-------------------------------\n");
> > +     seq_printf(s, "   clock                        enable_cnt  prepar=
e_cnt  rate        accuracy   phase\n");
> > +     seq_printf(s, "--------------------------------------------------=
---------------------------------------\n");
> > =20
> >       clk_prepare_lock();
> > =20
> > @@ -171,6 +171,7 @@ static void clk_dump_one(struct seq_file *s, struct=
 clk *c, int level)
> >       seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
> >       seq_printf(s, "\"rate\": %lu", clk_get_rate(c));
> >       seq_printf(s, "\"accuracy\": %lu", clk_get_accuracy(c));
> > +     seq_printf(s, "\"phase\": %d", clk_get_phase(c));
> >  }
> > =20
> >  static void clk_dump_subtree(struct seq_file *s, struct clk *c, int le=
vel)
> > @@ -257,6 +258,11 @@ static int clk_debug_create_one(struct clk *clk, s=
truct dentry *pdentry)
> >       if (!d)
> >               goto err_out;
> > =20
> > +     d =3D debugfs_create_u32("clk_phase", S_IRUGO, clk->dentry,
> > +                     (u32 *)&clk->phase);
> > +     if (!d)
> > +             goto err_out;
> > +
> >       d =3D debugfs_create_x32("clk_flags", S_IRUGO, clk->dentry,
> >                       (u32 *)&clk->flags);
> >       if (!d)
> > @@ -1766,6 +1772,76 @@ out:
> >  EXPORT_SYMBOL_GPL(clk_set_parent);
> > =20
> >  /**
> > + * clk_set_phase - adjust the phase shift of a clock signal
> > + * @clk: clock signal source
> > + * @degrees: number of degrees the signal is shifted
> > + *
> > + * Shifts the phase of a clock signal by the specified degrees. Return=
s 0 on
> > + * success, -EERROR otherwise.
> > + *
> > + * This function makes no distiction about the input or reference sign=
al that
> > + * we adjust the clock signal phase against. For example phase locked-=
loop
> > + * clock signal generators we may shift phase with respect to feedback=
 clock
> > + * signal input, but for other cases the clock phase may be shifted wi=
th
> > + * respect to some other, unspecified signal.
> > + *
> > + * Additionally the concept of phase shift does not propagate through =
the clock
> > + * tree hierarchy, which sets it appart from clock rates and clock acc=
uracy. A
> > + * parent clock phase attribute does not have an impact on the phase a=
ttribute
> > + * of a child clock.
> > + */
> > +int clk_set_phase(struct clk *clk, int degrees)
>=20
> Actually, while this is what I had in mind too, we'd need a bit more
> control here. We have two phases to control (namely, input and
> sample).
>=20
> Maybe passing an additional enum to tell which phase we want to
> adjust, that could easily be extended by new drivers need would fit
> our need here?

Maxime,

Do you have any documentation you could share with me on your
requirements? I'd like to better understand them so we can get the API
right.

Shifting phase with respect to an input signal makes a lot of sense to
me, but I don't really understand "sample".

Thanks,
Mike

>=20
> Thanks!
> Maxime
>=20
>=20
> --=20
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
