From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Wed, 13 Oct 2010 18:13:25 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de> <87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com> <20101013082930.GA11286@pengutronix.de> <8762x6xx00.fsf@lechat.rtp-net.org> <A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net> <20101013100632.GC11286@pengutronix.de> <4CB58565.5020806@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:11983 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0JMKNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 06:13:21 -0400
Received: from mail51-tx2 (localhost.localdomain [127.0.0.1])	by
 mail51-tx2-R.bigfish.com (Postfix) with ESMTP id 9766613D011D	for
 <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 10:13:20 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.252])	by
 mail51-tx2.bigfish.com (Postfix) with ESMTP id 2C57D10D0055	for
 <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 10:13:20 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o9DADHmG027340	for <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 03:13:19
 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 o9DADGt7011764	for <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 05:13:16
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <4CB58565.5020806@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Wolfram&Eric:
I take one day leave yesterday for one examination that had been booked=
 a few days ago,
 and missed Eric's patches, so regretful.

Best Regards
Richard Zhu



> -----Original Message-----
> From: Eric B=E9nard [mailto:eric@eukrea.com]
> Sent: Wednesday, October 13, 2010 6:10 PM
> To: Wolfram Sang
> Cc: Zhu Richard-R65037; Arnaud Patard; linux-mmc@vger.kernel.org; lin=
ux-
> arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
>=20
> Hi Wolfram,
>=20
> Le 13/10/2010 12:06, Wolfram Sang a =E9crit :
> > great to have you back! Did you have the chance to test my latest
> > patch-series? And can you help Eric with the comments for the
> > clock-calculation on MX51?
> >
> that's solved in the latest version of the patch (and the max value
> checks in the function were improved at the same time).
>=20
> Eric


