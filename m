From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Thu, 19 Mar 2015 11:36:46 +0000
Message-ID: <20150319113646.GQ2869@sirena.org.uk>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-2-git-send-email-dianders@chromium.org>
 <CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
 <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
 <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
 <CAD=FV=X=1=AnXCGgWWkJDcHLO-MfVqsSB2aJxi3WOgWJhD_ggA@mail.gmail.com>
 <CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0731255419863074195=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Alexandru Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tim Kryger <tim.kryger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Johan Rudholm <johan.rudholm-VrBV9hrLPhE@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--===============0731255419863074195==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+hz2tM55CCA8Ej21"
Content-Disposition: inline


--+hz2tM55CCA8Ej21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 12:14:11PM +0100, Ulf Hansson wrote:

> Agree. Moreover we need that API to also pick the closest value to
> target, when trying the range "target->minimum". I also believe it

The implementation *should* do that anyway, it's just not trivial to
implement in an efficient fashion with the current information we have
=66rom drivers.

> would be good to allow both upper and lower limits to be zero.

The lower limit can be zero already though it isn't clear to me that
this is useful.  Setting an upper limit of zero seems nonsensical, an
upper limit that is lower than the lower limit isn't terribly obvious
and removing the upper limit isn't safe - it means that we'll happily
oversupply things which is a road to physical damage.

--+hz2tM55CCA8Ej21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCrTNAAoJECTWi3JdVIfQt3sH/2eaSSvoyZOHqeqD0EBGzVsK
AnlyVjHBrgJSmTNb1QCs1Luy4WV5ACtVWz8FytizSkfjmaaYwMHiR17S7meDYlxi
SwRhRqW5PvSGHtahAF7vAk8W2ix2ZsSyhJmo1ZntTXUszPmgvgSvW3GWHZ4L1KPz
hKhkPxSw1gIuukQ818GZq9CwSR3DBtluvfuTp7OXZTzmEM2XSxPtqfT+k3xNjs/Y
z7J4dJtbacmfuxOzQv2HQTZwmzWkW9FAwKc7XnDrPK4Wi/nMXttMxDo8SdNOpN6E
nJ8eunD9nXnufl8qGGHmFCF4XaqoRHt0+9s1EB5XpjHu00QbYdlIn+58deSfDZo=
=hQFZ
-----END PGP SIGNATURE-----

--+hz2tM55CCA8Ej21--


--===============0731255419863074195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============0731255419863074195==--
