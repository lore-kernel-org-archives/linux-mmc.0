From: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
Subject: Re: [PATCH] sdio: pass unknown cis tuples to sdio drivers
Date: Fri, 11 Sep 2009 07:52:11 +0000 (GMT)
Message-ID: <354996.83066.qm@web28302.mail.ukl.yahoo.com>
References: <20090910203951.041d5c17.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090910203951.041d5c17.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm43xx-dev-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--- El vie, 11/9/09, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> escribi=F3=
:
> > Some manufacturers provide vendor information in
> non-vendor specific CIS
> > tuples. For example, Broadcom uses an Extended
> Function tuple to provide
> > the MAC address on some of their network cards, as in
> the case of the
> > Nintendo Wii WLAN daughter card.
> >=20
> > This patch allows passing correct tuples unknown to
> the SDIO core to
> > a matching SDIO driver instead of rejecting them and
> failing.
> >=20
>=20
> This looks leaky to me.
>=20

Hi Andrew, thanks for the review.
I hope I can clarify a bit what the patch does in the next comments.

>=20
> : =A0=A0=A0 =A0=A0=A0 if (i < ARRAY_SIZE(cis_tpl_list)) {
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 const struct cis_tpl *tpl =3D cis_tpl=
_list + i;
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (tpl_link < tpl->min_size) {
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printk(KERN_ERR
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0=A0=A0"%s: bad C=
IS tuple 0x%02x"
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0=A0=A0" (length =
=3D %u, expected >=3D %u)\n",
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0         =A0=A0=A0mmc_hostname(card->h=
ost),
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0=A0=A0tpl_code, =
tpl_link, tpl->min_size);
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D -EINVAL;
>=20
> ret =3D=3D -EINVAL
>=20

At this point ret is not -EINVAL. If it was -EINVAL the code would have=
 had exit at this snipped before:

                if (ret) {
                        kfree(this);
                        break;
                }


> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 } else if (tpl->parse) {
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D tpl->parse(card, fu=
nc,
> :                  =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0this->=
data, tpl_link);
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* already successfully parsed, not n=
eeded anymore */
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (!ret)
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 kfree(this);
>=20
> `this' doesn't get freed
>=20

Yes, that's the whole point of the patch. It must be freed _only_ if th=
e SDIO core parsed it. If the SDIO core cannot parse it then it gets pa=
ssed to the SDIO driver via the SDIO func struct tuple list (later).

> : =A0=A0=A0 =A0=A0=A0 } else {
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0/* unknown tuple */
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0ret =3D -EILSEQ;
> : =A0=A0=A0 =A0=A0=A0 }
> :
> : =A0=A0=A0 =A0=A0=A0 if (ret =3D=3D -EILSEQ) {
>=20
> `this' doesn't get remembered.
>=20

When ret is -EILSEQ `this' is linked to the SDIO func tuple list (later=
).

> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0/* this tuple is unknown to the core *=
/
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0this->next =3D NULL;
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0this->code =3D tpl_code;
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0this->size =3D tpl_link;
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0*prev =3D this;
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0prev =3D &this->next;
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0pr_debug("%s: queuing CIS tuple 0x%02x=
 length %u\n",
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0    =A0=A0=A0=A0=A0mmc_hostname(card->=
host), tpl_code, tpl_link);
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0/* keep on analyzing tuples */
> : =A0=A0=A0 =A0=A0=A0 =A0=A0=A0ret =3D 0;
> : =A0=A0=A0 =A0=A0=A0 }
> :=20
> : =A0=A0=A0 =A0=A0=A0 ptr +=3D tpl_link;
>=20
> `this' leaks.
>=20

`this' doesn't leak. `this' has been linked to the SDIO func tuple list=
 in:

*prev =3D this;


> : =A0=A0=A0 } while (!ret);
>=20
> Please check?
>=20

Thanks a lot for you comments,
Albert



     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
