From: "Yaniv Gardi" <ygardi@codeaurora.org>
Subject: RE: [PATCH v6 0/2] *** adding and exposing SANITIZE capability to the user space via a unique IOCTL ***
Date: Tue, 12 Jun 2012 19:19:31 +0300
Message-ID: <002201cd48b7$27897fb0$769c7f10$@codeaurora.org>
References: <1339079942-23542-1-git-send-email-ygardi@codeaurora.org> <CANfBPZ9ab=x=gbYHH_Zj7mjO+zP4diuAvT+t8CamnQh3qZN8Vg@mail.gmail.com> <000b01cd470f$daef74a0$90ce5de0$@codeaurora.org> <17296D9F8FF2234F831FC3DF505A87A90FE9A104@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:36759 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab2FLQTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 12:19:34 -0400
In-Reply-To: <17296D9F8FF2234F831FC3DF505A87A90FE9A104@SHSMSX102.ccr.corp.intel.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'Dong, Chuanxiao'" <chuanxiao.dong@intel.com>, "'S, Venkatraman'" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, merez@codeaurora.org



=3D > -----Original Message-----
=3D > From: Dong, Chuanxiao [mailto:chuanxiao.dong@intel.com]
=3D > Sent: Monday, June 11, 2012 6:04 AM
=3D > To: Yaniv Gardi; 'S, Venkatraman'
=3D > Cc: linux-mmc@vger.kernel.org; merez@codeaurora.org
=3D > Subject: RE: [PATCH v6 0/2] *** adding and exposing SANITIZE capa=
bility
to
=3D > the user space via a unique IOCTL ***
=3D >=20
=3D > Hi Yaniv
Hi Chuanxiao,

=3D > > -----Original Message-----
=3D > > From: linux-mmc-owner@vger.kernel.org
=3D > > [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Yaniv Gar=
di
=3D > > Sent: Sunday, June 10, 2012 9:49 PM
=3D > > To: 'S, Venkatraman'
=3D > > Cc: linux-mmc@vger.kernel.org; merez@codeaurora.org
=3D > > Subject: RE: [PATCH v6 0/2] *** adding and exposing SANITIZE
=3D > > capability to the user space via a unique IOCTL ***
=3D > >
=3D > > First, the REQ_SECURE + REQ_DISCARD are used for specific secto=
r/s.
=3D > > SANITIZE is a generic command that erase all unmapped sectors.
=3D > If a lot of sectors, like 4GBytes, have been marked as unmapped, =
how
long
=3D > will SANITIZE command take to erase all of them? Will it cause a =
long
time
=3D > delay for other requests?

The answer is YES and NO.
Yes - the SANITIZE might take a long time (few minutes) and thus there =
is a
special timeout for this request.
NO - it should not cause delay, since SANITIZE request is not intended =
to be
issued as part of operational functioning of the card, but=20
On the carrier labs for example, by a dedicated user application


=3D > > Second, secure erase for a specific sector (SECURE TRIM) is no =
longer
=3D > supported.
=3D > REQ_SECURE can still erase a specific sector in current MMC drive=
r.
=3D > If the device support SANITIZE, driver will first use ERASE/TRIM =
command
=3D > to mark unmapped sectors, and then issue SANITIZE command to eras=
e
=3D > them. eMMC4.5 specification has said clearly that ERASE/TRIM comm=
and
=3D > can move the mapped host address range to the unmapped host addre=
ss
=3D > range.
=3D > If the device cannot support SANTIZE, driver will use secure eras=
e/trim
=3D > command directly.
=3D >=20
The whole point of using SANITIZE is to separate the ERAER/TRIM/DISCARD
requests from the SANITIZE operation=20
=46or example -=20
A card can get many DISCARD, ERASE and TRIM requests, and weeks after c=
an
perform SANITIZE.
Also, an important note is to clarify that SANITIZE doesn't get START S=
ECTOR
and NUMBER OF SECTORS.
It a generic request working on the entire card.

Is that helping in anyway ?


=3D > >
=3D > > Anyhow, SANITIZE replaces the need to issue REQ_SECURE as part =
of the
=3D > > REQ_DISCARD request. In this way DISCARD request finishes much =
faster
=3D > > (order of
=3D > > magnitude) and thus improves system performance. When the NVM
=3D > content
=3D > > must be erased, the user may use SANITIZE to erase all unmapped
=3D > sectors.
=3D > >
=3D > > An example of usage is refurbished devices in which the carrier=
 wants
=3D > > to erase NVM content (since the user used only DISCARDs), in th=
is case
=3D > > the a SANITIZE operation will be triggered in the carrier labs =
from a
=3D > > dedicated application through IOCTL that goes directly to the d=
evice.
=3D > > Note that no change to the FS is required for such operation.
=3D > I think the usage you posted here is just what REQ_SECURE impleme=
nted.
=3D > REQ_SECURE will first unmapped the mapped host address and then i=
ssue
=3D > SANITIZE command to erase the contents.
=3D >=20
=3D > Thanks
=3D > Chuanxiao
=3D > >
=3D > > Thanks,
=3D > > Yaniv
=3D > >
=3D > > =3D > -----Original Message-----
=3D > > =3D > From: S, Venkatraman [mailto:svenkatr@ti.com] =3D > Sent:=
 Friday,
=3D > > June 08, 2012
=3D > > 2:30 PM =3D > To: Yaniv Gardi =3D > Cc: linux-mmc@vger.kernel.o=
rg;
=3D > > merez@codeaurora.org =3D > Subject: Re: [PATCH v6 0/2] *** addi=
ng and
=3D > > exposing SANITIZE capability to =3D > the user space via a uniq=
ue IOCTL
=3D > > *** =3D > =3D > On Thu, Jun 7, 2012 at 8:08 PM, Yaniv Gardi
=3D > <ygardi@codeaurora.org> =3D > wrote:
=3D > > =3D > > *** adding and exposing SANITIZE capability to the user=
 space
=3D > > via a =3D > > unique IOCTL *** =3D > =3D > Well, is this really=
 needed ? As
=3D > > I understand, SANITIZE is identical to =3D > REQ_SECURE + REQ_D=
ISCARD.
=3D > > =3D > Mapping the device function to an existing attribute is m=
ore easy
=3D > > that =3D > creating the whole plumbing around SANITIZE, just be=
cause it
=3D > exists.
=3D > > =3D > Apart from the IOCTL, it would be useful to find if any f=
ile
=3D > > systems want to =3D > use this, and it is any way more friendly=
 than
SECURE
=3D > + DISCARD.
=3D > > =3D >
=3D > > =3D > >
=3D > > =3D > > changes patch v6:
=3D > > =3D > > fixed some code review comments
=3D > > =3D > > added timeout dependency for CMD6 when issueing the san=
itize =3D >
=3D > > command.
=3D > > =3D > >
=3D > > =3D > > changes patch v5:
=3D > > =3D > > added BUG_ON() where needed
=3D > > =3D > >
=3D > > =3D > > changes patch v4:
=3D > > =3D > > removed a few debug printouts
=3D > > =3D > >
=3D > > =3D > > changes patch v3:
=3D > > =3D > > split the patch into 2 commits - block and mmc/card add=
ed
=3D > > capability =3D > > MMC_CAP2_SANITIZE to mmc controller =3D > > =
=3D > > Yaniv
=3D > Gardi (2):
=3D > > =3D > > =A0block: ioctl support for sanitize in eMMC 4.5 =3D > =
> =A0mmc: card:
=3D > > Adding support for sanitize in eMMC 4.5 =3D > > =3D > > =A0bloc=
k/blk-
=3D > core.c
=3D > > | =A0 18
=3D > > +++++++++-- =3D > > =A0block/blk-lib.c =A0 =A0 =A0 =A0 =A0 | =A0=
 51
=3D > > +++++++++++++++++++++++++++++++ =3D > > =A0block/blk-merge.c =A0=
 =A0 =A0 =A0 |
=3D > > +++++++++++++++++++++++++++++++ 6
=3D > > ++++ =3D > > =A0block/elevator.c =A0 =A0 =A0 =A0 =A0| =A0 41 ++=
++++++++++++++++++++++-
=3D > > =3D > > =A0block/ioctl.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +++=
++ =3D > >
=3D > > drivers/mmc/card/block.c =A0| =A0 72 =3D > >
=3D > > ++++++++++++++++++++++++++++++++------------
=3D > > =3D > > =A0drivers/mmc/card/queue.c =A0| =A0 10 +++++- =3D > >
=3D > > include/linux/blk_types.h | =A0 =A05 ++- =3D > > =A0include/lin=
ux/blkdev.h
=3D > > | =A0 =A03 ++ =3D > > =A0include/linux/fs.h =A0 =A0 =A0 =A0| =A0=
 =A01 + =3D > >
=3D > > include/linux/mmc/host.h =A0| =A0 =A01 + =3D > > =A0kernel/trac=
e/blktrace.c =A0 |
=3D > > 2 + =3D > > =A012 files changed, 191 insertions(+), 28 deletion=
s(-) =3D > >
=3D > > =3D > > -- =3D > > 1.7.6 =3D > > -- =3D > > Sent by a consultan=
t of the
=3D > > Qualcomm Innovation Center, Inc.
=3D > > =3D > > The Qualcomm Innovation Center, Inc. is a member of the=
 Code
=3D > > Aurora =3D > > Forum =3D > > -- =3D > > To unsubscribe from thi=
s list: send
=3D > > the line "unsubscribe linux-mmc"
=3D > > =3D > > in the body of a message to majordomo@vger.kernel.org M=
ore =3D >
=3D > > majordomo =3D > > info at =A0http://vger.kernel.org/majordomo-i=
nfo.html
=3D > >
=3D > > --
=3D > > To unsubscribe from this list: send the line "unsubscribe linux=
-mmc"
=3D > > in the body of a message to majordomo@vger.kernel.org More
=3D > majordomo
=3D > > info at  http://vger.kernel.org/majordomo-info.html

