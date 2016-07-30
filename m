From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 2/5] mmc: sunxi: Introduce a sunxi_mmc_cfg struct
Date: Sat, 30 Jul 2016 17:14:13 +0200
Message-ID: <20160730151413.GO6215@lukather>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6088562201866812812=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-3-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============6088562201866812812==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYjWXklH5JTzT8n9"
Content-Disposition: inline


--TYjWXklH5JTzT8n9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 30, 2016 at 04:25:45PM +0200, Hans de Goede wrote:
> Create a struct to hold the various model / compatible string dependend
> settings.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--TYjWXklH5JTzT8n9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXnMRFAAoJEBx+YmzsjxAgkP8P+QHuWajOIMZ8fFWbhjkWuGld
OWtbL9RdFezw6k2qLwYvywERmObR8aIhZ892Z/EVfFz/lLNJpvc2t/sF5m73/8/w
WtuSDQ82hTT6uBeG+fuO2V1EPuwQ+d9BbPrZqNxZQp4otl4ctRlwC5PQLvZVHLhR
yHhyJhQon8jubl8ru0ScG5fZYQJyz+qtCBOcD13yOBMLF6J1tRYigAtUrewFu+6U
nKe5BgNRhPHoU0Sr+oyQCefEUak3YYznl6SYxMdzvqY5QMqLsbaJrLWq7+ExSTNQ
iA/6UAwv8GLTpZx5wdYB+VMTa/GnTW/4kfrf0kv87jhu8zzTm7/TacY7kEtZHJGD
4lSF6IcprymYTL3MxP69QTYRukbkIPyInHSxnAdTagDN3OaFfpSQoqpeTtjz5CPw
m/rRKMY/AKYEsEfcUFFqA7KN+eSVawwYdzrkhylQvqnxZjvct422derZYEqQvDh6
ayiJApUasz/PMKfS/ceuW74ChGM+mBkj5tvgqIo6V6NZ7ezsHJTUuABs/wDSpG4s
WTKt5HX5CjZCbmjKYcnHJRNodAigmxTTjqAehXjCKJIkxPTPDMQkP+emY+oenUP5
xVqn1h5uZOwnQ5Z8aMlh8YENPSuQZP3ch2hniG7auOHkRKuVCaaB+9aIQARaWDNu
QnTAANuEq1D7PiYYSof2
=SgAW
-----END PGP SIGNATURE-----

--TYjWXklH5JTzT8n9--


--===============6088562201866812812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6088562201866812812==--
