From: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
Subject: Re: [PATCH] sdio: pass unknown cis tuples to sdio drivers
Date: Fri, 11 Sep 2009 08:21:49 +0000 (GMT)
Message-ID: <839237.19551.qm@web28308.mail.ukl.yahoo.com>
References: <20090911080659.2ac822fc@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090911080659.2ac822fc-OhHrUh4vRMS8I+09wXhka4dd74u8MsAO@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pierre Ossman <pierre-vCPtPcF4ZGuHXe+LvDLADg@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm43xx-dev-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--- El vie, 11/9/09, Pierre Ossman <pierre-vCPtPcF4ZGuHXe+LvDLADg@public.gmane.org> escribi=F3:
> The description for this patch should be made clearer. The title
> suggests it adds functionality that's already in place. It should be
> something along the lines of "Also pass malformed tuples to
> card drivers".

Hi Pierre,

Thanks for your patch review.

I didn't want to use "malformed" in the first place. I used "unknown" a=
s "unknown to the SDIO core". The SDIO core in Linux only knows about F=
UNCE tuples of type 1 (with a sane length) as described in the SDIO Sim=
plified Spec V2.00.

I think we just have a language issue here, but if you prefer the "malf=
ormed" wording I'm ok with that.

> In the sake of sanity, you might want to add this behaviour to all
> parsers, not just the FUNCE one.

I didn't find an application for the other parsers yet, so I tried to s=
tick to the strictly necessary and just did the FUNCE one which has a d=
irect application for Broadcom cards.

>=20
> I'm also unclear on how this is supposed to work. What does the
> broadcom tuple look like? This patch looks like it will silence a lot
> of legitimate warnings, and possibly pollute the card structures with
> bogus data.

The contents of the Broadcom FUNCE (type 0x22) tuple that contains the =
MAC address of a card looks like the following (tuple size 8):

04 06 00 1d bc 62 79 fd
^^ ^^ ^^^^^^^^^^^^^^^^^
 |  |                 |
 |  |                 +--- MAC address
 |  +--------------------- length (6 bytes for a ethernet MAC address)
 +------------------------ type 4 (CISTPL_FUNCE_LAN_NODE_ID)

If you prefer it, instead of passing al "unknown" (or "malformed") FUNC=
E tuples to SDIO drivers, I can let through only a subset of whiteliste=
d FUNCE types (starting with type 4).

>=20
> > diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_ci=
s.c
> > index 963f293..87934ac 100644
> > --- a/drivers/mmc/core/sdio_cis.c
> > +++ b/drivers/mmc/core/sdio_cis.c
> > @@ -123,8 +123,9 @@ static int cistpl_funce_func(struct sdio_func *=
func,
> >=A0 =A0=A0=A0 vsn =3D func->card->cccr.sdio_vsn;
> >=A0 =A0=A0=A0 min_size =3D (vsn =3D=3D SDIO_SDIO_REV_1_00) ? 28 : 42=
;
> >=A0=20
> > +=A0=A0=A0 /* let the SDIO driver take care of unknown tuples */
> >=A0 =A0=A0=A0 if (size < min_size || buf[0] !=3D 1)
>=20
> Misleading comment, the tuple is not unknown.
>=20

Same language issue described before.

> > -=A0=A0=A0 =A0=A0=A0 return -EINVAL;
> > +=A0=A0=A0 =A0=A0=A0 return -EILSEQ;
> >=A0=20
>=20
> What does this change improve?

-EILSEQ is used to indicate that the tuple was not parsed by the SDIO c=
ore and should be passed to the SDIO driver via the SDIO func tuple lis=
t.

>=20
> >=A0 =A0=A0=A0 /* TPLFE_MAX_BLK_SIZE */
> >=A0 =A0=A0=A0 func->max_blksize =3D
> buf[12] | (buf[13] << 8);
> > @@ -154,13 +155,7 @@ static int cistpl_funce(struct mmc_card *card,=
 struct sdio_func *func,
> >=A0 =A0=A0=A0 else
> >=A0 =A0=A0=A0 =A0=A0=A0 ret =3D cistpl_funce_common(card, buf, size)=
;
> >=A0=20
> > -=A0=A0=A0 if (ret) {
> > -=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "%s: bad CISTPL_FUNCE size %u =
"
> > -=A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0=A0=A0"type %u\n", mmc_hostname(car=
d->host), size, buf[0]);
> > -=A0=A0=A0 =A0=A0=A0 return ret;
> > -=A0=A0=A0 }
> > -
> > -=A0=A0=A0 return 0;
> > +=A0=A0=A0 return ret;
> >=A0 }
> >=A0=20
> >=A0 typedef int (tpl_parse_t)(struct mmc_card *, struct sdio_func *,
>=20
> Silencing a legitimate error.
>=20

Yes, I see your point.

I think we can keep this code but prevent displaying the error if ret =3D=
=3D -EILSEQ (i.e. the tuple is "unknown"/"malformed" BUT should be pass=
ed to the SDIO driver for parsing).

> > +=A0=A0=A0 =A0=A0=A0 if (ret =3D=3D -EILSEQ) {
> > +=A0=A0=A0 =A0=A0=A0
> =A0=A0=A0 /* this tuple is unknown to the core */
>=20
> Misleading comment, the tuple might be known but malformed.

Same languange issue again.

>=20
> Rgds
> --=20
> =A0 =A0=A0=A0-- Pierre Ossman

Thanks a lot for your comments,
Albert



     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
