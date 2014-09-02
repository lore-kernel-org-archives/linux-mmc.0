From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH v2 03/12] clk: Add a function to retrieve phase
Date: Tue, 02 Sep 2014 13:03:58 +0200
Message-ID: <8168039.eGpGMdvNGO@dizzy-6.o2s.ch>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <54045820.7080102@redhat.com> <20140902095008.GT15297@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3765067576371511371=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140902095008.GT15297@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, linux-mmc@vger.kernel.org, chris@printf.net, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============3765067576371511371==
Content-Type: multipart/signed; boundary="nextPart1751503.O1r69vEWON"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart1751503.O1r69vEWON
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi
> Yep, except that if I see a value -1 as a phase, I would assume that
> it's 359, but maybe it's just me :)
=2D1 looks suspiciously like an error return value from somewhere...

=2D-=20
David Lanzend=F6rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
--nextPart1751503.O1r69vEWON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlQFpCIACgkQAeZw77btGjoPdACgi4h1ZPdor9qE1J+11efIfOHS
7Q0AmgI7YW9PTY/QaqpTC+AV200yv56f
=O9zQ
-----END PGP SIGNATURE-----

--nextPart1751503.O1r69vEWON--



--===============3765067576371511371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3765067576371511371==--
