From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] regulator: pbias: program pbias register offset
 in pbias driver
Date: Fri, 4 Sep 2015 16:17:32 +0100
Message-ID: <20150904151732.GN5313@sirena.org.uk>
References: <1441368025-21182-1-git-send-email-kishon@ti.com>
 <1441368025-21182-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5505380206831694397=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441368025-21182-2-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, nsekhar@ti.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============5505380206831694397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nWqF9Q8pq9VTXuIf"
Content-Disposition: inline


--nWqF9Q8pq9VTXuIf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 05:30:24PM +0530, Kishon Vijay Abraham I wrote:
> Add separate compatible strings for every platform and populate the
> pbias register offset in the driver data.
> This helps avoid depending on the dt for pbias register offset.

If there are any changes from the already applied patch for this please
send an incremental patch.  Please don't resend already applied patches.

--nWqF9Q8pq9VTXuIf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6bYLAAoJECTWi3JdVIfQS0oH/iTGdObqUdleqiDezsMsoH3U
gJCee9Nlztwh1YLi36qn95IIP/KquitAsZiytRTxaHklezaWuokMwkX5yvGCJdOU
T9UloT5Ky8UbwZ3LtYlnEJNiAzS4yRx7vP1/BRe+PrC+6ux+zEwv4EDDIWO+tvCb
IY9RRrmctRBcsSoXD8Fd8WtW1PwF5KiF18L1tkmnnDNMA16/cwxszVXuxXWeYQ+o
CGGtbH9EGqKuIg3FrUg57FuzVlAgh4SQcbyTMlv7TPuwsGanj9uO63N1hanXWPJV
mmGgmOV9MaedRnVZrjZu/+gssS1DLFultjGn+HBoAua3qCJjOmRTENiO1G1kZno=
=NprE
-----END PGP SIGNATURE-----

--nWqF9Q8pq9VTXuIf--


--===============5505380206831694397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5505380206831694397==--
