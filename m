From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mmc: mxs-mmc: add non-removeable property
Date: Fri, 05 Apr 2013 14:14:06 +0200
Message-ID: <515EC00E.5060009@pengutronix.de>
References: <CAAAP30HvkQNTS1+7QddAV4CZVo=g3vaJGjJNNFu3CCbGDHTqsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8576662197906746493=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAAAP30HvkQNTS1+7QddAV4CZVo=g3vaJGjJNNFu3CCbGDHTqsQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8576662197906746493==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DFPMFRDEQNIJOSNAGSHL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DFPMFRDEQNIJOSNAGSHL
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/05/2013 02:01 PM, Alexandre Pereira da Silva wrote:
> I just sent a patch to fix the same thing to the list, without seeing
> yours first.
>=20
> But in the discussion, I learned that I should be checking for
> broken-cd instead of non-removable.

I'm not subscribed to linux-mmc and on
http://news.gmane.org/gmane.linux.kernel.mmc I just see Marek's
Reviewed-by. Can you point me to the discussion?

In fact my board has an eMMC, which is soldered to the board and the
card detect is not connected...the documentation says:

>   - broken-cd: There is no card detection available; polling must be us=
ed.
>   - non-removable: non-removable slot (like eMMC); assume always presen=
t.

I see no point in using polling if the card is in deed always present.

> Would you like for me to send a separate patch for broken-cd or do you
> prefer to check on yours when you resubmit?

If your card detect is not connected and the card is removable, you
should use broken-cd and base you patch on mine.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2DFPMFRDEQNIJOSNAGSHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFewBIACgkQjTAFq1RaXHPfyQCbBWECKJ51GfRNkA0DTs26F8Ym
eakAoIWbIQ84WgPwQLApfEDQPkC3Pyf0
=gsXK
-----END PGP SIGNATURE-----

------enig2DFPMFRDEQNIJOSNAGSHL--


--===============8576662197906746493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8576662197906746493==--
