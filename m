From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v6 0/2] *** adding and exposing SANITIZE capability to
 the user space via a unique IOCTL ***
Date: Thu, 14 Jun 2012 03:22:54 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A90FEA4B7C@SHSMSX102.ccr.corp.intel.com>
References: <1339079942-23542-1-git-send-email-ygardi@codeaurora.org>
 <CANfBPZ9ab=x=gbYHH_Zj7mjO+zP4diuAvT+t8CamnQh3qZN8Vg@mail.gmail.com>
 <000b01cd470f$daef74a0$90ce5de0$@codeaurora.org>
 <17296D9F8FF2234F831FC3DF505A87A90FE9A104@SHSMSX102.ccr.corp.intel.com>
 <002201cd48b7$27897fb0$769c7f10$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:46145 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058Ab2FNDW6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 23:22:58 -0400
In-Reply-To: <002201cd48b7$27897fb0$769c7f10$@codeaurora.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "merez@codeaurora.org" <merez@codeaurora.org>



> -----Original Message-----
> From: Yaniv Gardi [mailto:ygardi@codeaurora.org]
> Sent: Wednesday, June 13, 2012 12:20 AM
> To: Dong, Chuanxiao; 'S, Venkatraman'
> Cc: linux-mmc@vger.kernel.org; merez@codeaurora.org
> Subject: RE: [PATCH v6 0/2] *** adding and exposing SANITIZE capabili=
ty to the user
> space via a unique IOCTL ***
>=20
>=20
>=20
> =3D > -----Original Message-----
> =3D > From: Dong, Chuanxiao [mailto:chuanxiao.dong@intel.com] =3D > S=
ent: Monday,
> June 11, 2012 6:04 AM =3D > To: Yaniv Gardi; 'S, Venkatraman'
> =3D > Cc: linux-mmc@vger.kernel.org; merez@codeaurora.org =3D > Subje=
ct: RE:
> [PATCH v6 0/2] *** adding and exposing SANITIZE capability to =3D > t=
he user space
> via a unique IOCTL *** =3D > =3D > Hi Yaniv Hi Chuanxiao,
>=20
> =3D > > -----Original Message-----
> =3D > > From: linux-mmc-owner@vger.kernel.org =3D > >
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Yaniv Gardi =3D=
 > > Sent:
> Sunday, June 10, 2012 9:49 PM =3D > > To: 'S, Venkatraman'
> =3D > > Cc: linux-mmc@vger.kernel.org; merez@codeaurora.org =3D > > S=
ubject: RE:
> [PATCH v6 0/2] *** adding and exposing SANITIZE =3D > > capability to=
 the user space
> via a unique IOCTL *** =3D > > =3D > > First, the REQ_SECURE + REQ_DI=
SCARD are used
> for specific sector/s.
> =3D > > SANITIZE is a generic command that erase all unmapped sectors=
=2E
> =3D > If a lot of sectors, like 4GBytes, have been marked as unmapped=
, how long =3D >
> will SANITIZE command take to erase all of them? Will it cause a long=
 time =3D > delay
> for other requests?
>=20
> The answer is YES and NO.
> Yes - the SANITIZE might take a long time (few minutes) and thus ther=
e is a special
> timeout for this request.
If the timeout happens, how could driver to handle this timeout event? =
Will SANITIZE operation continue or failed at somewhere?

> NO - it should not cause delay, since SANITIZE request is not intende=
d to be issued
> as part of operational functioning of the card, but On the carrier la=
bs for example,
> by a dedicated user application
>=20
>=20
> =3D > > Second, secure erase for a specific sector (SECURE TRIM) is n=
o longer
> =3D > supported.
> =3D > REQ_SECURE can still erase a specific sector in current MMC dri=
ver.
> =3D > If the device support SANITIZE, driver will first use ERASE/TRI=
M command
> =3D > to mark unmapped sectors, and then issue SANITIZE command to er=
ase
> =3D > them. eMMC4.5 specification has said clearly that ERASE/TRIM co=
mmand
> =3D > can move the mapped host address range to the unmapped host add=
ress
> =3D > range.
> =3D > If the device cannot support SANTIZE, driver will use secure er=
ase/trim
> =3D > command directly.
> =3D >
> The whole point of using SANITIZE is to separate the ERAER/TRIM/DISCA=
RD
> requests from the SANITIZE operation
> For example -
> A card can get many DISCARD, ERASE and TRIM requests, and weeks after=
 can
> perform SANITIZE.
> Also, an important note is to clarify that SANITIZE doesn't get START=
 SECTOR
> and NUMBER OF SECTORS.
> It a generic request working on the entire card.
>=20
> Is that helping in anyway ?

As current implementation, driver will only do one operation for eMMC c=
ard, and the order is DISCARD, TRIM and then ERASE. So if a card suppor=
t DISCARD, the DISCARD only. If not but support TRIM, TRIM only. If als=
o not, ERASE only.
And SANITIZE cannot erase the block operated by DISCARD command.

So to implement your scenario, how about only add mmc_blk_issue_sanitiz=
e_rq() for REQ_SANITIZE but not touch mmc_blk_issue_secdiscard_rq()? Wi=
th your changes in mmc_blk_issue_secdiscard_rq(), eMMC4.5 device will b=
e failed to operate secure trim/erase for REQ_SECURE request.

Thanks
Chuanxiao

>=20
>=20
> =3D > >
> =3D > > Anyhow, SANITIZE replaces the need to issue REQ_SECURE as par=
t of the
> =3D > > REQ_DISCARD request. In this way DISCARD request finishes muc=
h faster
> =3D > > (order of
> =3D > > magnitude) and thus improves system performance. When the NVM
> =3D > content
> =3D > > must be erased, the user may use SANITIZE to erase all unmapp=
ed
> =3D > sectors.
> =3D > >
> =3D > > An example of usage is refurbished devices in which the carri=
er wants
> =3D > > to erase NVM content (since the user used only DISCARDs), in =
this case
> =3D > > the a SANITIZE operation will be triggered in the carrier lab=
s from a
> =3D > > dedicated application through IOCTL that goes directly to the=
 device.
> =3D > > Note that no change to the FS is required for such operation.
> =3D > I think the usage you posted here is just what REQ_SECURE imple=
mented.
> =3D > REQ_SECURE will first unmapped the mapped host address and then=
 issue
> =3D > SANITIZE command to erase the contents.
> =3D >
> =3D > Thanks
> =3D > Chuanxiao
> =3D > >
> =3D > > Thanks,
> =3D > > Yaniv
> =3D > >
> =3D > > =3D > -----Original Message-----
> =3D > > =3D > From: S, Venkatraman [mailto:svenkatr@ti.com] =3D > Sen=
t: Friday,
> =3D > > June 08, 2012
> =3D > > 2:30 PM =3D > To: Yaniv Gardi =3D > Cc: linux-mmc@vger.kernel=
=2Eorg;
> =3D > > merez@codeaurora.org =3D > Subject: Re: [PATCH v6 0/2] *** ad=
ding and
> =3D > > exposing SANITIZE capability to =3D > the user space via a un=
ique IOCTL
> =3D > > *** =3D > =3D > On Thu, Jun 7, 2012 at 8:08 PM, Yaniv Gardi
> =3D > <ygardi@codeaurora.org> =3D > wrote:
> =3D > > =3D > > *** adding and exposing SANITIZE capability to the us=
er space
> =3D > > via a =3D > > unique IOCTL *** =3D > =3D > Well, is this real=
ly needed ? As
> =3D > > I understand, SANITIZE is identical to =3D > REQ_SECURE + REQ=
_DISCARD.
> =3D > > =3D > Mapping the device function to an existing attribute is=
 more easy
> =3D > > that =3D > creating the whole plumbing around SANITIZE, just =
because it
> =3D > exists.
> =3D > > =3D > Apart from the IOCTL, it would be useful to find if any=
 file
> =3D > > systems want to =3D > use this, and it is any way more friend=
ly than
> SECURE
> =3D > + DISCARD.
> =3D > > =3D >
> =3D > > =3D > >
> =3D > > =3D > > changes patch v6:
> =3D > > =3D > > fixed some code review comments
> =3D > > =3D > > added timeout dependency for CMD6 when issueing the s=
anitize =3D >
> =3D > > command.
> =3D > > =3D > >
> =3D > > =3D > > changes patch v5:
> =3D > > =3D > > added BUG_ON() where needed
> =3D > > =3D > >
> =3D > > =3D > > changes patch v4:
> =3D > > =3D > > removed a few debug printouts
> =3D > > =3D > >
> =3D > > =3D > > changes patch v3:
> =3D > > =3D > > split the patch into 2 commits - block and mmc/card a=
dded
> =3D > > capability =3D > > MMC_CAP2_SANITIZE to mmc controller =3D > =
> =3D > > Yaniv
> =3D > Gardi (2):
> =3D > > =3D > > =A0block: ioctl support for sanitize in eMMC 4.5 =3D =
> > =A0mmc: card:
> =3D > > Adding support for sanitize in eMMC 4.5 =3D > > =3D > > =A0bl=
ock/blk-
> =3D > core.c
> =3D > > | =A0 18
> =3D > > +++++++++-- =3D > > =A0block/blk-lib.c =A0 =A0 =A0 =A0 =A0 | =
=A0 51
> =3D > > +++++++++++++++++++++++++++++++ =3D > > =A0block/blk-merge.c =
=A0 =A0 =A0 =A0 |
> =3D > > +++++++++++++++++++++++++++++++ 6
> =3D > > ++++ =3D > > =A0block/elevator.c =A0 =A0 =A0 =A0 =A0| =A0 41
> ++++++++++++++++++++++++-
> =3D > > =3D > > =A0block/ioctl.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +=
++++ =3D > >
> =3D > > drivers/mmc/card/block.c =A0| =A0 72 =3D > >
> =3D > > ++++++++++++++++++++++++++++++++------------
> =3D > > =3D > > =A0drivers/mmc/card/queue.c =A0| =A0 10 +++++- =3D > =
>
> =3D > > include/linux/blk_types.h | =A0 =A05 ++- =3D > > =A0include/l=
inux/blkdev.h
> =3D > > | =A0 =A03 ++ =3D > > =A0include/linux/fs.h =A0 =A0 =A0 =A0| =
=A0 =A01 + =3D > >
> =3D > > include/linux/mmc/host.h =A0| =A0 =A01 + =3D > > =A0kernel/tr=
ace/blktrace.c =A0 |
> =3D > > 2 + =3D > > =A012 files changed, 191 insertions(+), 28 deleti=
ons(-) =3D > >
> =3D > > =3D > > -- =3D > > 1.7.6 =3D > > -- =3D > > Sent by a consult=
ant of the
> =3D > > Qualcomm Innovation Center, Inc.
> =3D > > =3D > > The Qualcomm Innovation Center, Inc. is a member of t=
he Code
> =3D > > Aurora =3D > > Forum =3D > > -- =3D > > To unsubscribe from t=
his list: send
> =3D > > the line "unsubscribe linux-mmc"
> =3D > > =3D > > in the body of a message to majordomo@vger.kernel.org=
 More =3D >
> =3D > > majordomo =3D > > info at =A0http://vger.kernel.org/majordomo=
-info.html
> =3D > >
> =3D > > --
> =3D > > To unsubscribe from this list: send the line "unsubscribe lin=
ux-mmc"
> =3D > > in the body of a message to majordomo@vger.kernel.org More
> =3D > majordomo
> =3D > > info at  http://vger.kernel.org/majordomo-info.html

