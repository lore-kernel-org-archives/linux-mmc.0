From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 3/5] mmc: sunxi: Factor out clock phase setting code
 into a helper function
Date: Sat, 30 Jul 2016 17:14:34 +0200
Message-ID: <20160730151433.GP6215@lukather>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-4-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2058068838927845174=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-4-git-send-email-hdegoede@redhat.com>
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


--===============2058068838927845174==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Content-Disposition: inline


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 30, 2016 at 04:25:46PM +0200, Hans de Goede wrote:
> Add a sunxi_mmc_clk_set_phase() helper function.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXnMRZAAoJEBx+YmzsjxAgtbwP/1UA+JlB2Z2QI2cqOyqxtyi5
zO4kOlLL3WKEgjTbtRkulxiPi66IGCNdIb2x7VHcEuy+4XHIYwmwEFgZzgE0Z8lI
xzDkIXiIDWQSesx+5nA7R+H1RCtAaudcCWj5ilTs7NzivAWOMHzNnLaZRUrwP4Gc
hAlyexV/CX34u1j5vpZhTb4AEgra9Bsjx9cYPJv/MvqZbW7J7azaMQGSHc+CafWG
5yVi72jSjXdou0QDj0xTgnO0UXVxKg4x3PtAf5IECmigi63jr5cGKAUDkdjXKkrG
saSesxosbdRTL/M3c3tjPWeQvKOhOcwrG04LnSeewDOMLFsjrA+MGsYbktQvNqlV
+AZi1RFIGIcce7okvcmpGwpQVb4IbXfA/+j3rdKEYTs7iGaznJUQK9GlLQUYBXP5
WS2aVpIUBY2z2EPAQRGqVdOZwoRHlLbdXIH0qB9+o3Og0YajJiJzjSVpVk6z5TUN
hrybu7gSqQ8Qz2hYAwsjuztYdpAtEG8pKTT+hbHtDYwj2XYzDvZiLQF6s9A6TT5X
Lm5inShnGx42W0ypYX7gsHXug78X2HdL/qggQNAUJBdVmVeexXDEzbSFs8c5JcMf
NJ/tnZv9T8CKRUGaXr4m9yabYl64z+EpgYlQBwK6ojLY9U4ARQ4Fy2S3POFaETDo
HWY+RnuueiwxOpPJOUdd
=tUxA
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--


--===============2058068838927845174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2058068838927845174==--
