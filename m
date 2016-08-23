From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
Date: Tue, 23 Aug 2016 11:17:19 +0200
Message-ID: <20160823091719.GD2598@lukather>
References: <E1bUDNG-0000pR-Fv@bombadil.infradead.org>
 <20160801153016.GB17146@leverpostej>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBKVJ6C6QKGQEUZR2ZXI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160801153016.GB17146@leverpostej>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Mark,

On Mon, Aug 01, 2016 at 04:30:19PM +0100, Mark Rutland wrote:
> On Mon, Aug 01, 2016 at 03:10:29PM +0200, Jean-Francois Moine wrote:
> > Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> > a 'New Timings' mode.
> > Set this capacity in the DT and use it when possible.
> 
> What exactly is this "New Timings" mode?
> 
> Why do we wnat to set it? Improved performance, power?

Allwinner calls it under a rather generic name: "new mode" (which is
of course the opposite of the old mode).

In the old mode, the rate and phase controls were all handled by the
functional clock feeding the MMC controller.

In the new mode, the MMC controller itself is able to do some sort of
auto-calibration to adjust the rate and phase of the clock output on
the MMC bus.

> Is it *necessary* to use it?

Yes. Allwinner recommends to use it to enhance the compatibility with
MMC cards, and they say that it also improves the performances, even
though no one really checked. The main point for us at the moment is
that some eMMCs at least require the new mode to operate properly.

> > Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> > ---
> > I don't know if this mode works or is needed at 25MHz.
> > ---
> >  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  1 +
> >  drivers/mmc/host/sunxi-mmc.c                        | 21 +++++++++++++++++++--
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > index 4bf41d8..a541bf4 100644
> > --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > @@ -19,6 +19,7 @@ Optional properties:
> >   - reset-names : must contain "ahb"
> >   - for cd, bus-width and additional generic mmc parameters
> >     please refer to mmc.txt within this directory
> > + - allwinner,new-timings: the controller may accept the "New Timings" mode
> 
> It's not at all clear to me what this means. This needs a better
> description.
> 
> Which devices have this? Can we determine this based on compatible
> string?

On some SoCs, yes, on some, no.

The older SoCs (everything up to A80) only have the old mode, so the
compatible works there. The newer SoCs (H3, A64) support the new mode
on all their MMC controllers, so the compatible works too. However, in
the SoC Jean-Francois is currently working on, the A83T, the new mode
is only found in one (over three) controller.

So I really think we need a property to express this, at least in the
A83T case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--P+33d92oIH25kiaB--
