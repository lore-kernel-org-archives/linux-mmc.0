From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 05/11] mmc: sunxi: Support controllers that
 can use both old and new timings
Date: Mon, 17 Jul 2017 11:20:45 +0200
Message-ID: <20170717092045.3hidokuo6w7cgorw@flea>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-6-wens@csie.org>
 <CAPDyKFoLTXJ10EJRfPPggJBg8bh9BpdwTnew-WL0G7LpnO43Pg@mail.gmail.com>
 <CAGb2v64gjLSdb83fR9OCZthtgMQz-UkmMhT9OmJkq3Xp6mJ-aA@mail.gmail.com>
 <CAPDyKFqe1hFmfWziu04fW=cQa0EGvT11YzuJ0f-eHy6+u7vutQ@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ehpzjnyhte6weth"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB6ECWLFQKGQEPND3H7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAPDyKFqe1hFmfWziu04fW=cQa0EGvT11YzuJ0f-eHy6+u7vutQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--4ehpzjnyhte6weth
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Fri, Jul 14, 2017 at 11:57:35AM +0200, Ulf Hansson wrote:
> >>> +       if (host->use_new_timings) {
> >>> +               ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
> >>
> >> Can't this be solved through some other generic API/interface?
> >
> > The old discussion is here: https://lkml.org/lkml/2017/5/5/77
> >
> > It is possible to piggy back on existing API, but as Maxime mentioned
> > back in the discussion, it is confusing.
> >
> > IIRC Mike said (via Maxime) an SoC specific call was the easy way
> > to handle this. I don't think there's anything generic about this.
> > Even if you could have a _set_mode callback for the clks, the modes
> > would be SoC specific anyway.
> 
> Right. But it would benefit that we can keep drivers generic, as they
> are using generic APIs/interfaces. I prefer that.
> 
> Anyway, let me try to dig up the earlier discussion.

There's really not any generic way to support that. Even if we reuse
some other function (clk_set_phase/clk_get_phase was suggested), and
use error codes and / or values to differentiate between two modes,
this will be very much implementation-specific as well, and any other
SoC that in theory would be using that will very likely to not
implement the same behaviour for its clocks.

And this driver is only used on one SoC family, so it's not really a
big deal anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--4ehpzjnyhte6weth--
