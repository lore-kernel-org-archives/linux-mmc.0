From: Pierre Ossman <pierre-vCPtPcF4ZGuHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH] sdio: recognize io card without powercycle
Date: Fri, 11 Sep 2009 07:58:19 +0200
Message-ID: <20090911075819.1989d75b@mjolnir.ossman.eu>
References: <1252587402-7382-1-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-14418-1252648703-0001-2"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1252587402-7382-1-git-send-email-albert_herranz-mRCrAkd8dF0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm43xx-dev-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-14418-1252648703-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2009 14:56:41 +0200
Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org> wrote:

> SDIO Simplified Specification V2.00 states that it is strongly recommended
> that the host executes either a power reset or issues a CMD52 (I/O Reset)=
 to
> re-initialize an I/O only card or the I/O portion of a combo card.
> Additionally, the CMD52 must be issued first because it cannot be issued
> after a CMD0.
>=20
> With this patch the Nintendo Wii SDIO-based WLAN card is detected after a
> system reset, without requiring a complete system powercycle.
>=20
> Signed-off-by: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
> ---

I had problems with cards already in the idle state crashing when I
sent them a reset. I suggest a big round of testing before merging this.

> @@ -182,3 +189,20 @@ int mmc_io_rw_extended(struct mmc_card *card, int wr=
ite, unsigned fn,
>  	return 0;
>  }
> =20
> +int sdio_go_idle(struct mmc_host *host)
> +{

It might be clearer if you use the terminology from the spec, so either
sdio_abort() or sdio_reset().

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-14418-1252648703-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkqp5v4ACgkQ7b8eESbyJLjFQwCfSwwLYHjebMD8t/U2TEacJRIM
lV4An3v+gqIfRxLMtded3piLxrqXOQ5y
=pmXm
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-14418-1252648703-0001-2--
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
