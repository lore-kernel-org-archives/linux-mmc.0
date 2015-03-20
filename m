From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Fri, 20 Mar 2015 11:28:28 +0000
Message-ID: <20150320112828.GF2869@sirena.org.uk>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-2-git-send-email-dianders@chromium.org>
 <CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
 <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
 <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
 <CAD=FV=X=1=AnXCGgWWkJDcHLO-MfVqsSB2aJxi3WOgWJhD_ggA@mail.gmail.com>
 <CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg@mail.gmail.com>
 <20150319113646.GQ2869@sirena.org.uk>
 <CAPDyKFroe9N3j9oMWKknH5huv7j8fkrBr5UKjjp190hkqNsNRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7828116290016607737=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFroe9N3j9oMWKknH5huv7j8fkrBr5UKjjp190hkqNsNRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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


--===============7828116290016607737==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4fo3mGi7Q6pk/+I3"
Content-Disposition: inline


--4fo3mGi7Q6pk/+I3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 11:55:50AM +0100, Ulf Hansson wrote:
> On 19 March 2015 at 12:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > The implementation *should* do that anyway, it's just not trivial to
> > implement in an efficient fashion with the current information we have
> > from drivers.

> The APIs regulator_count_voltages() and regulator_list_voltage(), are
> currently used from the mmc core to find out which voltages that is
> supported (with 0.1V granularity). Then that information can be used
> when trying to set a new voltage.

> But I guess such a wrapper API is out of the question?

> Anyway, I get the feeling that we will need to do the same for this case.

As previously discussed the problem is that there can be a *lot* of
voltages on a modern regulator with fine grained voltage steps and
tolerances are also used for things like cpufreq where we care about
performance.  We need something that doesn't require a linear scan of
possible values.

> >> would be good to allow both upper and lower limits to be zero.

> > The lower limit can be zero already though it isn't clear to me that
> > this is useful.  Setting an upper limit of zero seems nonsensical, an
> > upper limit that is lower than the lower limit isn't terribly obvious
> > and removing the upper limit isn't safe - it means that we'll happily
> > oversupply things which is a road to physical damage.

> I am not sure I follow here. In the regulator_set_voltage_tol() you
> can only specifiy one limit (tolerance?). What Dough proposed was to
> add a new API which can have both a low tolerance value and a high
> tolerance value.

Tolerances are not limits - when you say "limit" that sounds like a hard
value.  I can't see any reason why the code would prevent anyone setting
a tolerance of zero, though it should be rare that this is actually the
best thing to do.

--4fo3mGi7Q6pk/+I3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDARbAAoJECTWi3JdVIfQiPQH+wVECwfALfzRrxDM2hMMzyoO
EdpJfak+mGZrowaxAyb4AcfS1qxEETng0G2bK67QM2cX38ZvWnPZTRd3fG/huIZ4
VIlW63RyR5KGOUYa4QNplp4XdYt41d3fuc1Zee3iqEkCDfngoacWgdoYYh61h7F0
acEcg7nN1IjCLMp5c+aRAKsKKwpfJyYaQn3tSyS31sBKtk35tqZyGNO5Fl4k+vAg
ZJnAzzIpeEPJ+xiqt6WTb+Qr9R6+QIp/sxsfzbuYzbT5noAYBvj1Vknc4x+q/51E
93eHG+dcRrfqfx+FrfKtId9ObsYRfBQhHz+gogkQPSix75SPGUcKioc5eDj9hKY=
=pyen
-----END PGP SIGNATURE-----

--4fo3mGi7Q6pk/+I3--


--===============7828116290016607737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============7828116290016607737==--
