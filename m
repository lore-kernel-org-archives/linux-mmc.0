From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
Date: Mon, 1 Aug 2016 18:26:03 +0200
Message-ID: <20160801182603.6f44af17e0bb801353f4b5e0@free.fr>
References: <E1bUDNG-0000pR-Fv@bombadil.infradead.org>
	<20160801153016.GB17146@leverpostej>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBJ7Q7W6AKGQEWXJNY3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160801153016.GB17146@leverpostej>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 1 Aug 2016 16:30:19 +0100
Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:

> On Mon, Aug 01, 2016 at 03:10:29PM +0200, Jean-Francois Moine wrote:
> > Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> > a 'New Timings' mode.
> > Set this capacity in the DT and use it when possible.
>=20
> What exactly is this "New Timings" mode?
>=20
> Why do we wnat to set it? Improved performance, power?
>=20
> Is it *necessary* to use it?

This mode is described at least in the Allwinner's documentation of the
A83T, A64 and H3.
>From my tests, it is required to access the eMMC of the Banana Pi M3
(mmc2).

> > Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> > ---
> > I don't know if this mode works or is needed at 25MHz.
> > ---
> >  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  1 +
> >  drivers/mmc/host/sunxi-mmc.c                        | 21 +++++++++++++=
++++++--
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Docu=
mentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > index 4bf41d8..a541bf4 100644
> > --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > @@ -19,6 +19,7 @@ Optional properties:
> >   - reset-names : must contain "ahb"
> >   - for cd, bus-width and additional generic mmc parameters
> >     please refer to mmc.txt within this directory
> > + - allwinner,new-timings: the controller may accept the "New Timings" =
mode
>=20
> It's not at all clear to me what this means. This needs a better
> description.
>=20
> Which devices have this? Can we determine this based on compatible
> string?

No, only some devices of the SoCs have this capability: the mmc2 of the
A83T, the smhc0 and smhc1 of the A64, and the mmc1 and mmc2 of the H3.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
