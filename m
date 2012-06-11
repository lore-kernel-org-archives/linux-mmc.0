From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v6 0/2] *** adding and exposing SANITIZE capability to the
 user space via a unique IOCTL ***
Date: Mon, 11 Jun 2012 20:25:34 +0530
Message-ID: <CANfBPZ_eV2r-VV-myQ+MYfNWjpx1+cojfxtEs7EE2XnJB=3-zw@mail.gmail.com>
References: <1339079942-23542-1-git-send-email-ygardi@codeaurora.org>
 <CANfBPZ9ab=x=gbYHH_Zj7mjO+zP4diuAvT+t8CamnQh3qZN8Vg@mail.gmail.com> <000b01cd470f$daef74a0$90ce5de0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34436 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753410Ab2FKO4A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jun 2012 10:56:00 -0400
Received: by bkcji2 with SMTP id ji2so4638061bkc.33
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jun 2012 07:55:56 -0700 (PDT)
In-Reply-To: <000b01cd470f$daef74a0$90ce5de0$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, merez@codeaurora.org

On Sun, Jun 10, 2012 at 7:19 PM, Yaniv Gardi <ygardi@codeaurora.org> wr=
ote:
> First, the REQ_SECURE + REQ_DISCARD are used for specific sector/s. S=
ANITIZE
> is a generic command that erase all unmapped sectors.
> Second, secure erase for a specific sector (SECURE TRIM) is no longer
> supported.
>
> Anyhow, SANITIZE replaces the need to issue REQ_SECURE as part of the
> REQ_DISCARD request. In this way DISCARD request finishes much faster=
 (order
> of magnitude) and thus improves system performance. When the NVM cont=
ent
> must be erased, the user may use SANITIZE to erase all unmapped secto=
rs.

SECURE is not used for all DISCARDs anyway - so that's how it works alr=
eady.

>
> An example of usage is refurbished devices in which the carrier wants=
 to
> erase NVM content (since the user used only DISCARDs), in this case t=
he a
> SANITIZE operation will be triggered in the carrier labs from a dedic=
ated
> application through IOCTL that goes directly to the device. Note that=
 no
> change to the FS is required for such operation.
>
> Thanks,
> Yaniv
>
> =3D > -----Original Message-----
> =3D > From: S, Venkatraman [mailto:svenkatr@ti.com]
> =3D > Sent: Friday, June 08, 2012 2:30 PM
> =3D > To: Yaniv Gardi
> =3D > Cc: linux-mmc@vger.kernel.org; merez@codeaurora.org
> =3D > Subject: Re: [PATCH v6 0/2] *** adding and exposing SANITIZE ca=
pability
> to
> =3D > the user space via a unique IOCTL ***
> =3D >
> =3D > On Thu, Jun 7, 2012 at 8:08 PM, Yaniv Gardi <ygardi@codeaurora.=
org>
> =3D > wrote:
> =3D > > *** adding and exposing SANITIZE capability to the user space=
 via a
> =3D > > unique IOCTL ***
> =3D >
> =3D > Well, is this really needed ? As I understand, SANITIZE is iden=
tical to
> =3D > REQ_SECURE + REQ_DISCARD.
> =3D > Mapping the device function to an existing attribute is more ea=
sy that
> =3D > creating the whole plumbing around SANITIZE, just because it ex=
ists.
> =3D > Apart from the IOCTL, it would be useful to find if any file sy=
stems
> want to
> =3D > use this, and it is any way more friendly than SECURE + DISCARD=
=2E
> =3D >
> =3D > >
> =3D > > changes patch v6:
> =3D > > fixed some code review comments
> =3D > > added timeout dependency for CMD6 when issueing the sanitize
> =3D > command.
> =3D > >
> =3D > > changes patch v5:
> =3D > > added BUG_ON() where needed
> =3D > >
> =3D > > changes patch v4:
> =3D > > removed a few debug printouts
> =3D > >
> =3D > > changes patch v3:
> =3D > > split the patch into 2 commits - block and mmc/card added cap=
ability
> =3D > > MMC_CAP2_SANITIZE to mmc controller
> =3D > >
> =3D > > Yaniv Gardi (2):
> =3D > > =A0block: ioctl support for sanitize in eMMC 4.5
> =3D > > =A0mmc: card: Adding support for sanitize in eMMC 4.5
> =3D > >
> =3D > > =A0block/blk-core.c =A0 =A0 =A0 =A0 =A0| =A0 18 +++++++++--
> =3D > > =A0block/blk-lib.c =A0 =A0 =A0 =A0 =A0 | =A0 51 +++++++++++++=
++++++++++++++++++
> =3D > > =A0block/blk-merge.c =A0 =A0 =A0 =A0 | =A0 =A06 ++++
> =3D > > =A0block/elevator.c =A0 =A0 =A0 =A0 =A0| =A0 41 +++++++++++++=
+++++++++++-
> =3D > > =A0block/ioctl.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +++++
> =3D > > =A0drivers/mmc/card/block.c =A0| =A0 72
> =3D > > ++++++++++++++++++++++++++++++++------------
> =3D > > =A0drivers/mmc/card/queue.c =A0| =A0 10 +++++-
> =3D > > =A0include/linux/blk_types.h | =A0 =A05 ++-
> =3D > > =A0include/linux/blkdev.h =A0 =A0| =A0 =A03 ++
> =3D > > =A0include/linux/fs.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =3D > > =A0include/linux/mmc/host.h =A0| =A0 =A01 +
> =3D > > =A0kernel/trace/blktrace.c =A0 | =A0 =A02 +
> =3D > > =A012 files changed, 191 insertions(+), 28 deletions(-)
> =3D > >
> =3D > > --
> =3D > > 1.7.6
> =3D > > --
> =3D > > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> =3D > > The Qualcomm Innovation Center, Inc. is a member of the Code =
Aurora
> =3D > > Forum
> =3D > > --
> =3D > > To unsubscribe from this list: send the line "unsubscribe lin=
ux-mmc"
> =3D > > in the body of a message to majordomo@vger.kernel.org More
> =3D > majordomo
> =3D > > info at =A0http://vger.kernel.org/majordomo-info.html
>
