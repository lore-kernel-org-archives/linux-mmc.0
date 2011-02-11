From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 06:08:23 +0800
Message-ID: <20110211220821.GA9289@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
 <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
 <19794.17994.381937.158944@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:19125
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756333Ab1BKOJM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Feb 2011 09:09:12 -0500
Received: from mail164-va3 (localhost.localdomain [127.0.0.1])	by
 mail164-va3-R.bigfish.com (Postfix) with ESMTP id C9D62130411	for
 <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 14:09:10 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.238])	by
 mail164-va3.bigfish.com (Postfix) with ESMTP id 77842194004F	for
 <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 14:09:10 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id p1BE8wAr000809	for
 <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 07:08:58 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1BE8vKr021894	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 08:08:58
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <19794.17994.381937.158944@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lothar,

On Wed, Feb 09, 2011 at 08:46:18AM +0100, Lothar Wa=DFmann wrote:
> Hi Shawn,
>=20
> Shawn Guo writes:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28=
=2E
> > The driver calls into mxs-dma via generic dmaengine api for both pi=
o
> > and data transfer.
> >=20
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/include/mach/mmc.h |   15 +
> >  drivers/mmc/host/Kconfig             |    9 +
> >  drivers/mmc/host/Makefile            |    1 +
> >  drivers/mmc/host/mxs-mmc.c           |  884 ++++++++++++++++++++++=
++++++++++++
> >  4 files changed, 909 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/include/mach/mmc.h
> >  create mode 100644 drivers/mmc/host/mxs-mmc.c
> >=20
> I've run the mmc-test kernel module with this driver on our TX28
> module which fails in the following tests:
> |mmc0: Test case 15. Correct xfer_size at write (start failure)...
> |mmc0: Result: ERROR (-110)
> |mmc0: Test case 16. Correct xfer_size at read (start failure)...
> |mmc0: Result: ERROR (-110)
> |mmc0: Test case 17. Correct xfer_size at write (midway failure)...
> |mmc0: Result: ERROR (-110)
> |mmc0: Test case 18. Correct xfer_size at read (midway failure)...
> |mmc0: Result: ERROR (-110)
>=20
> Could you try the test on your hardware?
>=20
I'm new to this test.  I enabled MMC_TEST but did not see "test"
under /sys for mmc.  Can you please elaborate how to launch this
test?  Thanks.

Regards,
Shawn

