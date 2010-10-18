From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 18 Oct 2010 16:48:07 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de> <87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com> <20101013082930.GA11286@pengutronix.de> <8762x6xx00.fsf@lechat.rtp-net.org> <A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net> <20101013100632.GC11286@pengutronix.de> <4CB58565.5020806@eukrea.com> <A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net> <20101013102055.GD11286@pengutronix.de> <20101015102729.GB4276@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:52527 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0JRIr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 04:47:57 -0400
Received: from mail97-tx2 (localhost.localdomain [127.0.0.1])	by
 mail97-tx2-R.bigfish.com (Postfix) with ESMTP id CA01B5C8227	for
 <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 08:47:54 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.242])	by
 mail97-tx2.bigfish.com (Postfix) with ESMTP id 5A60619C0053	for
 <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 08:47:54 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o9I8lq5S010037	for <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 01:47:52
 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 o9I8lpVc015912	for <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 03:47:51
 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: =?iso-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guo Shawn-R65073 <R65073@freescale.com>

Hi Wolfram:
I tested your serial patches with Eric's platform related codes on i.MX=
51 BBG3.0 board.
Two phenomena:
The debug msg "mmc0: mmc_rescan: trying to init card at 400000 Hz..." a=
re dumped out repeatedly.
ROOT: There are pr_info codes in the mmc_rescan func.

The other:
Encounter the Timeout and CRC error when the sandisk 4G SDHC card are u=
sed as the ROOTFS storage media
When I boot up the BBG board.

It seems that the "SDHCI_QUIRK_BROKEN_TIMEOUT_VAL" is mandatory require=
d at my side when I did the tests
 on BBG3.0 board, and the i.MX51 board can support the "MULTI-BLOCK".

Hi Eric:
What's kinds of tests and environment you did at your side?

BTW, I still can't fetch out the latest codes out, that means I still c=
an't found the V5 patches, although I run
the git fetch and git rebase. :(

Best Regards
Richard Zhu


> -----Original Message-----
> From: Zhu Richard-R65037
> Sent: Monday, October 18, 2010 11:30 AM
> To: 'Wolfram Sang'
> Cc: Eric B=E9nard; Arnaud Patard; linux-mmc@vger.kernel.org; linux-ar=
m-
> kernel@lists.infradead.org
> Subject: RE: [PATCH 0/6] SD/MMC driver for MX25/35/51
>=20
> Hi Wolfram:
> Can you sync-up the http URL of your repos with your latest patches?
> I can't get fetch and sync-up with your latest codes now, since I can
> only used the HTTP URL to clone your codes.
>=20
> Best Regards
> Richard Zhu
>=20
>=20
> > -----Original Message-----
> > From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> > Sent: Friday, October 15, 2010 6:27 PM
> > To: Zhu Richard-R65037
> > Cc: Eric B=E9nard; Arnaud Patard; linux-mmc@vger.kernel.org; linux-=
arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
> >
> > Richard,
> >
> > > > I take one day leave yesterday for one examination that had bee=
n
> > > > booked a few days ago,  and missed Eric's patches, so regretful=
=2E
> > >
> > > No problem, such things happen. If you'd have time to review thos=
e
> > > patches now, that would be great, too.
> >
> > Do you have time to check the latest series (V5, just posted)? BTW
> > which patch-set are you using now for development?
> >
> > Regards,
> >
> >    Wolfram
> >
> > --
> > Pengutronix e.K.                           | Wolfram Sang
> > |
> > Industrial Linux Solutions                 | http://www.pengutronix=
=2Ede/
> > |

