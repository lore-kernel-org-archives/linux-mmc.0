From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/5] mmc: sunxi: Disable sample clks on remove
Date: Sat, 30 Jul 2016 17:13:34 +0200
Message-ID: <20160730151334.GN6215@lukather>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6069493796991756291=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-2-git-send-email-hdegoede@redhat.com>
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


--===============6069493796991756291==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 30, 2016 at 04:25:44PM +0200, Hans de Goede wrote:
> When support for the sample clks was added calls to prepare_enable
> were added to the probe path, but matching calls to disable_unprepare
> were forgotten in the remove path, this fixes this.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXnMQeAAoJEBx+YmzsjxAgZV8QAISIvwHB9OsNe1Iru11dDdNn
kTnGoyTHhjH1PMi0UaBxhN3gmpyM/vQQ9pKRts5V3xkknanzGTgv2z64zpHJBvOj
1yF1UR1B3qzUG+yZUddczJtZsLE4Oonr44Gb/n98/1wnJ35lEIgjIvxwcqCCOtYd
MsRdinsl5vAX2nQOosWkvtpGAj7Y/UGCizvKBZx6IdzJV5Om9hs/qvfryuRDTgeB
zjVG+lyufrXQFnVB2M4n8KFgZgVUNePLyiq9BJUiseLU3qZRQ/Rx1gfHzeJ1ta2Q
STLn4hb453QMvCwkAzLicxfI+P75g3iVb07ZQQm1pZb9zDdTqL/1YST8qziTP1EK
69yHcetfUFXGGuWZqhxwNo394hxfU4UXz6I0qcIJ71+33ugRaDO4uM57Myn5IAME
GMst4DjNtZLlVtsWklF8YfMCsQFqpl0/ABDut9PQy6XZVJe08VDhtg7H6t8Pqf4q
zzzz1qZ346QQxxGaZV8VQXslApAWrXYAU1vcxzKTSZnFIO6+WoGkzvaJnsMvcHYY
DxKO+g7JuxtaY8YX8fv0DFyDYzmMPBPuS2mAJ66t4jLiXIn0GML4hpjlMRzpIHnC
oCERvLaF2DJJhs042YmB2iS6whb2Ps38W9sH32pbt+uWZXge08AN5lseD5lYblaR
usFqsbd5ROpqEtu3GdF7
=bu+u
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--


--===============6069493796991756291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6069493796991756291==--
