From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Tue, 17 Mar 2015 10:38:29 +0000
Message-ID: <20150317103829.GA28806@sirena.org.uk>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-2-git-send-email-dianders@chromium.org>
 <CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
 <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
 <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Eo6Jsvut/kxSJJ94"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kerne>
List-Id: linux-mmc@vger.kernel.org


--Eo6Jsvut/kxSJJ94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2015 at 11:23:33AM +0100, Ulf Hansson wrote:
> On 16 March 2015 at 16:12, Doug Anderson <dianders@chromium.org> wrote:

> > * Try to set the voltage to exactly 1,200,000 uV (1.2V).
> > * If you can't get 1.2V exactly, a tolerance ("tol") of 100,000 uV
> > (.1V) is OK.
> > * In other words, 1.1V - 1.3V are OK, but aim for 1.2V

> So what happens in the case when 1.3V and 1.1V, but not 1.2V. Which
> value will be used? Is that algorithm defined by the regulator core or
> does it depend per regulator implementation?

It's done in the core.  It first tries to hit the target voltage to the
maximum (picking the lowest voltage in that range) then tries to pick
the lowest voltage to the target, though that's an implementation detail
and we really should be trying to get as close as possible to the
target.  We don't do that yet because it can be expensive to work out so
we do the current thing which is cheap and mostly good enough.

--Eo6Jsvut/kxSJJ94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCAQlAAoJECTWi3JdVIfQ0VYH/iZeQc/hihsEyP2+K+a9Gs7R
JSVKhWCEk+XDG5aQELFL0ZrWGqlYqA/2ChT2vuWowjKNB8F7ygAMQffeJSozoH25
G2H0OU3vV4xPQCe8NWPLAbRjrj/wbJ7b96okb7twTIZ41qk3Wi6wXzrTdwKmrxqH
+IxpL2EfJQDoaJcLrC3wcDCfRMFq6wzFwswf7fB+Z3tlLVQB8MFH/5YmAOvL6/dj
s3c9/KErYeBe9Zy0AJhzuJbwAoLKfsIAHLOMs8tdGdZFEWIjhin7MumA2RY57SCm
wTnvtBM8XH39SAnRyIugSriSGstNpvIZAcuVEBWwwGoEhzCSqB805RdshtuHFYM=
=9NOH
-----END PGP SIGNATURE-----

--Eo6Jsvut/kxSJJ94--
