From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] libertas/sdio: set ECSI and SCSI bits for 1-bit
 transfers
Date: Wed, 31 Mar 2010 11:08:36 +0200
Message-ID: <20100331090836.GA30801@buzzloop.caiaq.de>
References: <1269970733-24681-1-git-send-email-daniel@caiaq.de>
 <x2ve2d7436a1003310207t16a7d1d6r7853de2dfa647c6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <x2ve2d7436a1003310207t16a7d1d6r7853de2dfa647c6c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alagu Sankar <alagusankar-LW5URSxhY0VBDgjK7y7TUQ@public.gmane.org>, Volker Ernst <volker.ernst-YiJBWufK+bc@public.gmane.org>, Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>, Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 31, 2010 at 11:07:06AM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> 2010/3/30 Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>:
> [...]
> > @@ -1022,6 +1025,27 @@ static int if_sdio_probe(struct sdio_func *f=
unc,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto disable=
;
> >
> > + =C2=A0 =C2=A0 =C2=A0 /* For 1-bit transfers, we need to enable th=
e interrupt flags in
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* the CCCR register. Temporarily set t=
he function number to 0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* for that. */
> > + =C2=A0 =C2=A0 =C2=A0 if ((host->caps & MMC_CAP_SDIO_IRQ) &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (host->ios.bus_width =3D=3D MM=
C_BUS_WIDTH_1)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int num=
 =3D func->num;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 reg;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func->num =3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D sdio_rea=
db(func, SDIO_CCCR_IF, &ret);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto release_int;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg |=3D SDIO_BU=
S_ECSI | SDIO_BUS_SCSI;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdio_writeb(func=
, reg, SDIO_CCCR_IF, &ret);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto release_int;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func->num =3D nu=
m;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0card->ioport =3D sdio_readb(func, IF_SDI=
O_IOPORT, &ret);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto release=
_int;
>=20
> You should probably just use mmc_io_rw_direct() in this case instead
> of abusing func->num.

Hmm, that function isn't exported, and I didn't want to change this. Yo=
u
say you'd prefer that? I can cook up something that does it, no problem=
=2E


Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
