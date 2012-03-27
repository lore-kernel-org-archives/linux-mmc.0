From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 11:40:48 +0200
Message-ID: <20120327114048.6af2e178@eb-e6520>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
	<20120312132423.GC2459@pengutronix.de>
	<9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
	<0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
	<a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
	<85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
	<20120327101259.73525f9d@eb-e6520>
	<ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
	<20120327090148.GB6790@pengutronix.de>
	<20120327110615.3bfaf969@eb-e6520>
	<7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:36396 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069Ab2C0Jk6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 05:40:58 -0400
In-Reply-To: <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Le Tue, 27 Mar 2012 11:33:57 +0200,
joancarles <joancarles@fqingenieria.es> a =E9crit :
> >> Interesting question is now why it worked on your older kernel? Th=
e=20
> >> code
> >> around BROKEN_TIMEOUT is there for much longer, I'd think.
> >>
> > not in fact it seems to have been broken from a long time and I thi=
nk
> > I'm responsible of that in 37865fe91582582a6f6c00652f6a2b1ff71f8a78
> > "mmc: sdhci-esdhc-imx: fix timeout on i.MX's sdhc"
> > because unlike the i.MX35 it seems that the i.MX25 manages to read
> > properly the partition table even without the timeout quirk and it
> > seems that I didn't do more extensive tests for this patch.
>=20
> Might be unrelated, however I have been keeping my eyes on the fix of=
=20
> ENGcm07207 quirk introduced with 16a790bcc. According to the=20
> IMX25CE.pdf, to abort data transfers on the AHB, software can reset t=
he=20
> eSDHC by writing 1 to SYSCTL[24] (RSTA), which currently is not done=20
> with SDHCI_QUIRK_NO_MULTIBLOCK. It sets the max_blk_count to 1 instea=
d=20
> of 65535. Not sure if this is also limiting the speed.
>=20
I tried to increase max_blk_count and it breaks after a few tests.
Using an oscilloscope it seems we have a big latency between each
transfer which could explain the low throughput, I didn't have the
time to look deeper at this problem.

> I have tried putting the SD card into an ALL-in-One reader via USB an=
d=20
> I get 6MB/s read and 15MB/s write performance. Since I didn't know th=
e=20
> exact class of the card, this reassures me that there is nothing=20
> substantially wrong with the card per se.
>=20
> So, how can we find a solution to this speed issue? Also, do you plan=
=20
> on submitting your patch to revert the timeout quirk for MX25?
>=20
yes, I'm writing a proper commit message and will send it in a few
minutes.

Eric
