From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 3/4] mmc: sdio: support switching to 1-bit before
 turning off clocks
Date: Thu, 26 Mar 2015 08:49:26 +1100
Message-ID: <20150326084926.4bc3d55d@notabene.brown>
References: <20150224024023.22719.32436.stgit@notabene.brown>
	<20150224024223.22719.91536.stgit@notabene.brown>
	<CAPDyKFrt-rhsh4XAHma=F083Y-XYxJbGyLUEEh1C6KUni-RZ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/e1kfbeaxED.reVWb9Zavmbg"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60129 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbCYVtj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Mar 2015 17:49:39 -0400
In-Reply-To: <CAPDyKFrt-rhsh4XAHma=F083Y-XYxJbGyLUEEh1C6KUni-RZ7g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

--Sig_/e1kfbeaxED.reVWb9Zavmbg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2015 10:10:18 +0100 Ulf Hansson <ulf.hansson@linaro.org> wro=
te:

> On 24 February 2015 at 03:42, NeilBrown <neilb@suse.de> wrote:

> > @@ -941,8 +947,12 @@ void mmc_release_host(struct mmc_host *host)
> >
> >         WARN_ON(!host->claimed);
> >
> > -       if (host->ops->disable && host->claim_cnt =3D=3D 1)
> > -               host->ops->disable(host);
> > +       if (host->claim_cnt =3D=3D 1) {
> > +               if (atomic_read(&host->sdio_narrowed) =3D=3D 1)
> > +                       atomic_set(&host->sdio_narrowed, 0);
> > +               if (host->ops->disable)
> > +                       host->ops->disable(host);
> > +       }
>=20
> As omap_hsmmc in currently the only user of the
> host_ops->enable|disable() callbacks, I wonder if this approach will
> work "race-free" for those hosts that don't implement these callbacks?

Hi Ulf,
 you might have guessed, but to be explicit: I withdraw this patchset.
I much prefer the other approach that I suggested using runtime PM on
the mmc_host device and switching to 1-bit more in the pm_runtime_suspend
function.

As you say, omap_hsmmc is the only user of enable/disable and they were an
important part of my strategy in this patchset.
Which raises the question:  what is omap_hsmmc using enable/disable?

My guess is that it is largely historical - added because omap_hsmmc wanted
runtime pm before sufficient generic infrastructure was available.

I've tested a patch to remove it, and it seem fine.  I'll post it.

Thanks,
NeilBrown


--Sig_/e1kfbeaxED.reVWb9Zavmbg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVRMtZznsnt1WYoG5AQLJOw//ej5hR6VErL6zI5uNYcpk1SfTDBm17ktb
2EvIo38JXwN2FF6uIMsNqbdKEOfJkqAM4LSethhYtLqBeqgurX+7HOXK8r+cdjGO
aP4JsEQF0w6M6S84nnQ62Eh5c62KcgidCnyFZP7btWv84Ro5nXWp1YsrGgI2uujP
872BG0oWg79UDGNOrnKBTgV6aSTd7TfjIXwjl3Hy41zZVYLxflF3CzSFfEJThHa0
+XcXS8kRStZFOCb26OulCOxCTBotVUpiTRPQIwuwOqBBggZuwwBNFgbqgmy+fGiR
ofSWNKIq5tHyX/ofcRvTuBWshJpKBULpryiY7vYuJe9nwhd+o7UttpEHQMaX7fEr
0l9xUT93wNYKD1qqPh2jkVqK5h5IRQBsVFlNZlTr9LZ2Qk98ZYjQMsiMsuL/zwnz
ue2mOGa3XIvnOid+a8pnfum9wbT+oJJaiR9TkRZiLVyp4SJVBtMjtA5/rVlc8ZdG
1Zu1ZrU7mkMCJzF4wTVZ5eE6ht3xZitBRdIf8Igx+l3h2s8fP4tsOShOtSyUBUPT
F42z7iaSRCZJ6ITsr9DwagodOyMfcl3BNaDgiq2oWSSqXdcm97iABb1Ojo6PdjCM
/GHZpSmkmqN7StqX5v8+geL/b0V/Qy89iCIkEmnnlkMZGjRrZLh6QralHIyChHuI
paOz/X/cIXg=
=aR3D
-----END PGP SIGNATURE-----

--Sig_/e1kfbeaxED.reVWb9Zavmbg--
