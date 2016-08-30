From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v3] mmc: sunxi: Handle the 'New Timing' mode
Date: Tue, 30 Aug 2016 19:32:02 +0200
Message-ID: <20160830193202.4baaefd508a5d20d48b2cbed@free.fr>
References: <20160813175611.79E0323C@mail.free-electrons.com>
	<20160830162613.GG18605@lukather>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBFMGS67AKGQECFPIIZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160830162613.GG18605@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 30 Aug 2016 18:26:13 +0200
Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> > There are 2 flags saying that the new timing is used:
> > - the bit 'mode select' in the clock register, and
> > - the bit 'new timing' in the MMC register.
> > Both bits must be set/reset at the same time, otherwise the device
> > does not work (tested with wifi and eMMC in H3 and A83T boards).
> > So, some synchronization must exist.
> >=20
> > The previous versions was using a DT property for the MMC and a flag
> > in the clock driver. This did work with a correct configuration
> > on both sides, but experiment showed that it was easy to do an error.
>=20
> I still believe that we will need a property, at least to identify on
> which we can try the new mode, and on which clocks it's irrelevant (at
> least for the A33 and A83T).

As told above, setting the new mode on side (clock or MMC) and not on
the other one prevents the devices to work. Then, it is safer to have
the new mode capability flag only once for both sides.

Now, as the clocks are defined by memory tables and not by the DT, it
seems natural to have the flag on the clock side.

> However, I also believe we should make that mode switching explicit
> through a function call, instead of relying on some side effect (of
> some non-upstream code).

Do you mean a direct call from the MMC driver to the clock driver?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
