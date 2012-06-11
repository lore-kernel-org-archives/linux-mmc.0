From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v6 0/2] *** adding and exposing SANITIZE capability to
 the user space via a unique IOCTL ***
Date: Mon, 11 Jun 2012 03:03:34 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A90FE9A104@SHSMSX102.ccr.corp.intel.com>
References: <1339079942-23542-1-git-send-email-ygardi@codeaurora.org>
 <CANfBPZ9ab=x=gbYHH_Zj7mjO+zP4diuAvT+t8CamnQh3qZN8Vg@mail.gmail.com>
 <000b01cd470f$daef74a0$90ce5de0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:32130 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab2FKDD5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jun 2012 23:03:57 -0400
In-Reply-To: <000b01cd470f$daef74a0$90ce5de0$@codeaurora.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "merez@codeaurora.org" <merez@codeaurora.org>

Hi Yaniv
> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Yaniv Gardi
> Sent: Sunday, June 10, 2012 9:49 PM
> To: 'S, Venkatraman'
> Cc: linux-mmc@vger.kernel.org; merez@codeaurora.org
> Subject: RE: [PATCH v6 0/2] *** adding and exposing SANITIZE capabili=
ty to the user
> space via a unique IOCTL ***
>=20
> First, the REQ_SECURE + REQ_DISCARD are used for specific sector/s. S=
ANITIZE is a
> generic command that erase all unmapped sectors.
If a lot of sectors, like 4GBytes, have been marked as unmapped, how lo=
ng will SANITIZE command take to erase all of them? Will it cause a lon=
g time delay for other requests?

> Second, secure erase for a specific sector (SECURE TRIM) is no longer=
 supported.
REQ_SECURE can still erase a specific sector in current MMC driver.
If the device support SANITIZE, driver will first use ERASE/TRIM comman=
d to mark unmapped sectors, and then issue SANITIZE command to erase th=
em. eMMC4.5 specification has said clearly that ERASE/TRIM command can =
move the mapped host address range to the unmapped host address range.
If the device cannot support SANTIZE, driver will use secure erase/trim=
 command directly.

>=20
> Anyhow, SANITIZE replaces the need to issue REQ_SECURE as part of the
> REQ_DISCARD request. In this way DISCARD request finishes much faster=
 (order of
> magnitude) and thus improves system performance. When the NVM content=
 must
> be erased, the user may use SANITIZE to erase all unmapped sectors.
>=20
> An example of usage is refurbished devices in which the carrier wants=
 to erase
> NVM content (since the user used only DISCARDs), in this case the a S=
ANITIZE
> operation will be triggered in the carrier labs from a dedicated appl=
ication through
> IOCTL that goes directly to the device. Note that no change to the FS=
 is required for
> such operation.
I think the usage you posted here is just what REQ_SECURE implemented. =
REQ_SECURE will first unmapped the mapped host address and then issue S=
ANITIZE command to erase the contents.

Thanks
Chuanxiao
>=20
> Thanks,
> Yaniv
>=20
> =3D > -----Original Message-----
> =3D > From: S, Venkatraman [mailto:svenkatr@ti.com] =3D > Sent: Frida=
y, June 08, 2012
> 2:30 PM =3D > To: Yaniv Gardi =3D > Cc: linux-mmc@vger.kernel.org;
> merez@codeaurora.org =3D > Subject: Re: [PATCH v6 0/2] *** adding and=
 exposing
> SANITIZE capability to =3D > the user space via a unique IOCTL *** =3D=
 > =3D > On Thu, Jun
> 7, 2012 at 8:08 PM, Yaniv Gardi <ygardi@codeaurora.org> =3D > wrote:
> =3D > > *** adding and exposing SANITIZE capability to the user space=
 via a =3D > >
> unique IOCTL *** =3D > =3D > Well, is this really needed ? As I under=
stand, SANITIZE is
> identical to =3D > REQ_SECURE + REQ_DISCARD.
> =3D > Mapping the device function to an existing attribute is more ea=
sy that =3D >
> creating the whole plumbing around SANITIZE, just because it exists.
> =3D > Apart from the IOCTL, it would be useful to find if any file sy=
stems want to =3D >
> use this, and it is any way more friendly than SECURE + DISCARD.
> =3D >
> =3D > >
> =3D > > changes patch v6:
> =3D > > fixed some code review comments
> =3D > > added timeout dependency for CMD6 when issueing the sanitize =
=3D >
> command.
> =3D > >
> =3D > > changes patch v5:
> =3D > > added BUG_ON() where needed
> =3D > >
> =3D > > changes patch v4:
> =3D > > removed a few debug printouts
> =3D > >
> =3D > > changes patch v3:
> =3D > > split the patch into 2 commits - block and mmc/card added cap=
ability =3D > >
> MMC_CAP2_SANITIZE to mmc controller =3D > > =3D > > Yaniv Gardi (2):
> =3D > > =A0block: ioctl support for sanitize in eMMC 4.5 =3D > > =A0m=
mc: card: Adding
> support for sanitize in eMMC 4.5 =3D > > =3D > > =A0block/blk-core.c =
=A0 =A0 =A0 =A0 =A0| =A0 18
> +++++++++-- =3D > > =A0block/blk-lib.c =A0 =A0 =A0 =A0 =A0 | =A0 51
> +++++++++++++++++++++++++++++++ =3D > > =A0block/blk-merge.c =A0 =A0 =
=A0 =A0 | =A0 =A06
> ++++ =3D > > =A0block/elevator.c =A0 =A0 =A0 =A0 =A0| =A0 41 ++++++++=
++++++++++++++++-
> =3D > > =A0block/ioctl.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +++++
> =3D > > =A0drivers/mmc/card/block.c =A0| =A0 72 =3D > >
> ++++++++++++++++++++++++++++++++------------
> =3D > > =A0drivers/mmc/card/queue.c =A0| =A0 10 +++++-
> =3D > > =A0include/linux/blk_types.h | =A0 =A05 ++-
> =3D > > =A0include/linux/blkdev.h =A0 =A0| =A0 =A03 ++
> =3D > > =A0include/linux/fs.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =3D > > =A0include/linux/mmc/host.h =A0| =A0 =A01 +
> =3D > > =A0kernel/trace/blktrace.c =A0 | =A0 =A02 + =3D > > =A012 fil=
es changed, 191
> insertions(+), 28 deletions(-) =3D > > =3D > > -- =3D > > 1.7.6 =3D >=
 > -- =3D > > Sent by a
> consultant of the Qualcomm Innovation Center, Inc.
> =3D > > The Qualcomm Innovation Center, Inc. is a member of the Code =
Aurora =3D > >
> Forum =3D > > -- =3D > > To unsubscribe from this list: send the line=
 "unsubscribe
> linux-mmc"
> =3D > > in the body of a message to majordomo@vger.kernel.org More =3D=
 >
> majordomo =3D > > info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
