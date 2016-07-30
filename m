From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
Date: Sat, 30 Jul 2016 17:16:19 +0200
Message-ID: <20160730151619.GR6215@lukather>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3015899393264239713=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
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


--===============3015899393264239713==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7tUYVWcdYzDJoZW"
Content-Disposition: inline


--r7tUYVWcdYzDJoZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 30, 2016 at 04:25:48PM +0200, Hans de Goede wrote:
> Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
> and newer.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This should probably go through Ulf tree together with the rest of
that serie to maintain the bisectability.

Thanks a lot for this work,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--r7tUYVWcdYzDJoZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXnMTDAAoJEBx+YmzsjxAgui8P/3lPuAz0Ha7HCFp3QiiA10SZ
G/MeZRPihcDoz1vmZO52oOxb9GqbUQo5mq1J1PXkKoUx1+53W2yiMX+c5kwW9DAr
wpxmRCDJ2cN9YscbAKusJgQSPUT/fN5kmcVE7eYQjsUCqsHW8ZBOXAyQe2e49It1
F7Ws3D72JBKYBkIa4uZo4BBqpmU+fRzxm/8FX/lihBL8dAI8v+ENGLJwKzVLliJb
p8BJE96Iex+Aa3s266hnFAizW7zScbFMbL09fPQin9B6Bf8R/7kzchrp4wUC5YBD
kxyl0bD7ZFufca+7HjB23eXcC/Sw4rjTgkw8vSNoZp7ODXdhtaHPh9rvEA/EQQK8
NS1ldMHJb9PKqMbBQ7LnFVWVxzZ3FO/WOTyuwb1fIXYLiehjKfo4FrGggW6MHmDf
fP5VlmQhRPeKGOX2yIQ+HfRKGSNZ9SFg7O/210dnBcl8NmYcWejizO5V6mXP83zK
T+GloX+i/V8gOMq9Pn11Dndn88ueQ/R4kQqDqRBLOX4hwwGnmQgiA26ZPfScJz1t
AnVlBlo5sKhNwUf9VOiH4yfdo2ZZ2gdOOXYJYQSE5T8hAjnpVZvkG/anyNOKz5oM
QOaKZt5y53pUl89KdPl4G4Vu4M0j5C22MdVzT5vH2yGtywUo7x1kZN6PIp1PXcdK
gb925B5xLUPf9pz+jDOY
=Ty1c
-----END PGP SIGNATURE-----

--r7tUYVWcdYzDJoZW--


--===============3015899393264239713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3015899393264239713==--
