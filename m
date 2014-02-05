From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts
 found on Allwinner sunxi SoCs
Date: Wed, 05 Feb 2014 14:33:56 +0100
Message-ID: <1929408.6EF83UbB9S@dizzy-6.o2s.ch>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <1387058295-20641-2-git-send-email-hdegoede@redhat.com> <20131215134415.GE3651@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4618468.3R4j7B2TP6"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBD2JL37LXEKRBTX3ZCLQKGQEJDB3QBY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131215134415.GE3651@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--nextPart4618468.3R4j7B2TP6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi
> I'm not that fond of these "default y" patterns. It forces the driver
> down to every user of the multiplatform kernels. I'd suggest removing
> the default and adding the driver to the defconfigs we have.
Ok. Removed it.

> > +static void sunxi_mmc_init_host(struct mmc_host *mmc)
> > +{
> > [...]
> > +	mci_writel(smc_host, REG_FUNS, 0xceaa0000);
> > +	mci_writel(smc_host, REG_DLBA, smc_host->sg_dma);
> I suppose we have no idea what these magics are all about ? :(
That's the parameters I could extract from the Chinese code.
Without proper documentation it will always stay magic what exactly these
values are meaning.

> > +#define mci_readl(host, reg) \
> > +	__raw_readl((host)->reg_base + SDXC_##reg)
> > +#define mci_writel(host, reg, value) \
> > +	__raw_writel((value), (host)->reg_base + SDXC_##reg)
> No barriers ? :(
Fixed that...

cheers
--nextPart4618468.3R4j7B2TP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlLyPcQACgkQAeZw77btGjrxLACgpz3H5aQ/vunQN1XdfYaM5kaX
8DwAoJU6kNPTjuR6FcRsdMmu/j1l7hpN
=/+my
-----END PGP SIGNATURE-----

--nextPart4618468.3R4j7B2TP6--
