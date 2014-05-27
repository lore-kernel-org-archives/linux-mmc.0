From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 01/11] pinctrl: sunxi: create irq/pin
 mapping during init
Date: Tue, 27 May 2014 10:02:57 +0200
Message-ID: <20140527080257.GA4730@lukather>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBL4OSGOAKGQEX4VWG2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401090486-4414-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 26, 2014 at 09:47:56AM +0200, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>=20
> The irq/pin mapping is used to lookup the pin to mux to the irq
> function when the irq is enabled. It is created when gpio_to_irq
> is called. Creating the mapping during init allows us to map the
> interrupts directly from the device tree.

Can you be a bit more precise on this?

What is the issue that this patch fix?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThEaxAAoJEBx+YmzsjxAgmasP/0pIwFOAMul5CTnLuH7LmmKN
4TtcbA5vL+SuCmYhn2pIc2mkssaaj64BzWQC8dwB3Cb1sU10oplUo4aKI67H35YC
HEgFV3g00BTnGDcHjUDEEAwwG94VX9d+BzLvRoD6kwsfpImNwEiGO3odLfvN3TiY
dQXqa0pIl7kWv28z3cmMmn4Ls5MiIQmnrkDwtnekXHYoinqExtpPZKLTnJZpZ1de
k6LVhLk8f2PX615byERcFOTDFSeruvpJipkFbkZPXe2MrAd8ZPvXwXbq7xh4MHCM
YUHkWQIdmiekyLNIddeTU5pVaY9JZmv4v5VoPsYLaJeMw6/BHVfSHyJovtG2uCZq
ODuY6+9lHX+Ds/EKZR11J952AB56kcUA+AOvJyc1FymnfmHRdVsPGZ9B6gtsvPVk
96tBHoWuFind0unwQfy0DRtRJe83PUGCQXEa4HojokSMlru16gHdzlWtILXBqUGZ
7CtDIDdveaBzEuxztINNcjv9P95pmRPsU6soo/aAi1vS+M4BDpZ+KkwiB97e6w6L
ZPKb1EPzxAvE0T6rCgaHe8dV25Y/UBg+hjD8QBCzyuLwFwCDKvoiVPaXPnRLYC2a
MjcDvteNG/U2L6jMIlzIs/jOnh/8cG63isidbKFC2E+FFWOJoVupB/8FGbsIQu1P
xhbdj3LE0XUdONfh7MQe
=YcKo
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
