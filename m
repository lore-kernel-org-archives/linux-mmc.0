From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] mmc: sunxi: Handle the 'New Timing' mode
Date: Tue, 11 Oct 2016 16:55:53 +0200
Message-ID: <20161011145553.GZ3462@lukather>
References: <20160813175611.79E0323C@mail.free-electrons.com>
 <20160830162613.GG18605@lukather>
 <20160830193202.4baaefd508a5d20d48b2cbed@free.fr>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yywL3DpgDyP4yZ2G"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB6726O7QKGQEHCF3JHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160830193202.4baaefd508a5d20d48b2cbed-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--yywL3DpgDyP4yZ2G
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Aug 30, 2016 at 07:32:02PM +0200, Jean-Francois Moine wrote:
> On Tue, 30 Aug 2016 18:26:13 +0200
> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > > There are 2 flags saying that the new timing is used:
> > > - the bit 'mode select' in the clock register, and
> > > - the bit 'new timing' in the MMC register.
> > > Both bits must be set/reset at the same time, otherwise the device
> > > does not work (tested with wifi and eMMC in H3 and A83T boards).
> > > So, some synchronization must exist.
> > > 
> > > The previous versions was using a DT property for the MMC and a flag
> > > in the clock driver. This did work with a correct configuration
> > > on both sides, but experiment showed that it was easy to do an error.
> > 
> > I still believe that we will need a property, at least to identify on
> > which we can try the new mode, and on which clocks it's irrelevant (at
> > least for the A33 and A83T).
> 
> As told above, setting the new mode on side (clock or MMC) and not on
> the other one prevents the devices to work. Then, it is safer to have
> the new mode capability flag only once for both sides.
> 
> Now, as the clocks are defined by memory tables and not by the DT, it
> seems natural to have the flag on the clock side.

You can look at it from two sides.

Either you try to switch to the new mode all the time, or you try to
do it only for MMC controllers (and their associated clocks) that
support it.

In the former case, you'll need to ignore a failure in the switch
(mostly if the clock doesn't support it) only for the MMC controllers
that do not have that mode. For the controllers that support it, you
cannot ignore that error anymore. So you have to have some way to
identify in which case you are.

And you need to have that in the former case too, so there's really no
way you can go without such a flag.

> > However, I also believe we should make that mode switching explicit
> > through a function call, instead of relying on some side effect (of
> > some non-upstream code).
> 
> Do you mean a direct call from the MMC driver to the clock driver?

Yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--yywL3DpgDyP4yZ2G--
