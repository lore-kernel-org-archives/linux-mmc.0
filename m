From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix wakeirq handling on removal
Date: Tue, 4 Sep 2018 22:11:09 +0200
Message-ID: <20180904221109.54604ebf@aktux>
References: <20180902073058.17053-1-andreas@kemnade.info>
        <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7=6K2spKo_oqu0jpG3fbWO_"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon <kishon@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-mmc@vger.kernel.org

--Sig_/7=6K2spKo_oqu0jpG3fbWO_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 4 Sep 2018 16:34:56 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 2 September 2018 at 09:30, Andreas Kemnade <andreas@kemnade.info> wrot=
e:
> > after unbinding mmc I get things like this:
> > [  185.294067] mmc1: card 0001 removed
> > [  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13
> >
> > The wakeirq stays in /proc-interrupts
> >
> > rebinding shows this:
> > [  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:w=
akeup) vs. 0000200a (480b4000.mmc:wakeup)
> > [  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
> > [  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling ba=
ck to polling
> >
> > That bug seems to be introduced by switching from devm_request_irq()
> > to generic wakeirq handling.
> >
> > So let us cleanup at removal.
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use =
generic wakeirq") =20
>=20
> Applied for fixes, and added a stable tag, thanks!
>=20
What also might be critical (still analyzing) of that patch I am fixing
is:
It keeps the wakeup irq also enabled when the sdio irq is disabled.

Regards,
Andreas=20

--Sig_/7=6K2spKo_oqu0jpG3fbWO_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluO5t0ACgkQfb1qx03i
kySTPw/+OGneOSwYXVhucGsyRSQ489fq5hX1hX/+hZiNZc8m+jb8tT1vxY9mqLAj
W9tC2aCARIXTRUi1/m7IaUx278Zv1WmbUZswWechQJoKiWLFdbed2KTcuH41tac/
5xyik3fnvmVfONPrYCkqbDdz/lzgPMI7WAoQY4G8Z4NRX3cGlfx/3MMjF4vxkAVy
13Y5C15ugE7NyQCpeoNUOc5ltmsHyS63GFryQjZik1i0khZDZxzXFrT56z+9ERpK
Vtc0RPsSJdzEP6qEOQTBJor174bBozkvAp0m2jHCnC83EWcqL7IoDbUWUnOUh2dX
pnNVPve7ZEgH0Zrq/++bfs0Z7VWZJVKQIUZIfElF/WPDh8McFRVscekv2fG1jYek
FLvk5bV3CE6+RgsVZG8T58YF11ifk7HW4QFMTacEejBQqqYusjQdRGRNahcPbuxa
LrdOndt7RGwGs8OZiGtzl7vI8YTZvj4Wgff6USzP/rDLfAOBDfL6KaBlt3CAHoN1
fAJ95chsv8SzA8U0+xXMhZGNkk2wPsv8lByKNqx/BRs4rqhi1Dm6GuN+nq0EgPDZ
C3yOEq/IoXqg6i1x35NR1yMjsk1gai6XUernvtiQ6qnNEHfdrj0lasmNwZhCsEDq
Td/IA5uX9QLf0NdLN1wzK3fiSks5GiP4/LdThtVmCKh0/2oUw/4=
=aY7t
-----END PGP SIGNATURE-----

--Sig_/7=6K2spKo_oqu0jpG3fbWO_--
