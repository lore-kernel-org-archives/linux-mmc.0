From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: BUG/PATCH? mmcblk devices don't suspend properly.
Date: Wed, 4 Apr 2012 08:43:08 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C3318239EC@DBDE01.ent.ti.com>
References: <20120330134745.2baa2766@notabene.brown>
	<4F7543D9.7000100@codeaurora.org>
 <CAFEEs1mS1J0NMimAZF5fzs-B5eTar-2No=4bi18zKCz27GQR5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab2DDInV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Apr 2012 04:43:21 -0400
In-Reply-To: <CAFEEs1mS1J0NMimAZF5fzs-B5eTar-2No=4bi18zKCz27GQR5g@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: NeilBrown <neilb@suse.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Apr 03, 2012 at 02:13:54, Per Forlin wrote:
> On Fri, Mar 30, 2012 at 7:25 AM, Sujit Reddy Thumma
> <sthumma@codeaurora.org> wrote:
> > On 3/30/2012 8:17 AM, NeilBrown wrote:
> >>
> >>

=2E..snip...
=2E..snip...

> >>
> >> The net effect is that - as I observed - mmc_bus_suspend is never =
called.
> >>
> >> I added lines:
> >>
> >> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_bus=
_suspend,
> >> =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_bus=
_resume,
> >>
> >> to mmc_bus_pm_ops and can no longer reproduce the problem. =A0So m=
aybe this
> >> patch is appropriate:
> >>
> >> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> >> index 5d011a3..80c1e46 100644
> >> --- a/drivers/mmc/core/bus.c
> >> +++ b/drivers/mmc/core/bus.c
> >> @@ -169,6 +169,8 @@ static const struct dev_pm_ops mmc_bus_pm_ops =
=3D {
> >> =A0 =A0 =A0 =A0.runtime_suspend =A0 =A0 =A0 =A0=3D mmc_runtime_sus=
pend,
> >> =A0 =A0 =A0 =A0.runtime_resume =A0 =A0 =A0 =A0 =3D mmc_runtime_res=
ume,
> >> =A0 =A0 =A0 =A0.runtime_idle =A0 =A0 =A0 =A0 =A0 =3D mmc_runtime_i=
dle,
> >> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_bus_=
suspend,
> >> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_bus_=
resume,
> >> =A0};
> >>
> >> =A0#define MMC_PM_OPS_PTR =A0 =A0 =A0 =A0(&mmc_bus_pm_ops)
> >>
> >> however I suspect we should remove the 'legacy' pointers at the sa=
me
> >> time.(?).
> >
> > This was pointed out earlier and a patch is posted but looks like i=
t never
> > went into mmc tree -- http://comments.gmane.org/gmane.linux.kernel.=
mmc/9168
> >

We were also facing a similar issue related to mmc copy operation & sus=
pend/resume
from console.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg65425.html

We applied the above patch it started working properly.

Acked by me for this patch

=2E..snip...
=2E..snip...

> mmc_queue_suspend().
>=20
> Regards,
> Per
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


Regards,=20
Gururaja
