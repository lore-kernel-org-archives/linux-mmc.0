From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mmc: mxs-mmc: add non-removeable property
Date: Fri, 05 Apr 2013 14:49:22 +0200
Message-ID: <515EC852.8080404@pengutronix.de>
References: <CAAAP30HvkQNTS1+7QddAV4CZVo=g3vaJGjJNNFu3CCbGDHTqsQ@mail.gmail.com>
 <515EC00E.5060009@pengutronix.de>
 <CAAAP30GCRsS4JhAy0yP5su3mVm-NNTxtVS0cddxWGVwS3C6gNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5251219450435972301=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAAAP30GCRsS4JhAy0yP5su3mVm-NNTxtVS0cddxWGVwS3C6gNw@mail.gmail.com>
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
--===============5251219450435972301==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2OKRKIVSAERMMBGNKMMVD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OKRKIVSAERMMBGNKMMVD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/05/2013 02:31 PM, Alexandre Pereira da Silva wrote:
> On Fri, Apr 5, 2013 at 9:14 AM, Marc Kleine-Budde <mkl@pengutronix.de>
> wrote:
>> I'm not subscribed to linux-mmc and on
>> http://news.gmane.org/gmane.linux.kernel.mmc I just see Marek's
>> Reviewed-by. Can you point me to the discussion?
>=20
> http://marc.info/?l=3Dlinux-kernel&m=3D136515344220293&w=3D2

tnx

>> If your card detect is not connected and the card is removable, you
>> should use broken-cd and base you patch on mine.
>=20
> Ok, I will do that.

I've just posted an updated series.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2OKRKIVSAERMMBGNKMMVD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFeyFoACgkQjTAFq1RaXHO1DgCfXMB6fjpQXriihE0C5dm7Cdim
bNEAnRBKD99+BUyXB6Tk3Z+aoWW6JONH
=u/QF
-----END PGP SIGNATURE-----

------enig2OKRKIVSAERMMBGNKMMVD--


--===============5251219450435972301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5251219450435972301==--
