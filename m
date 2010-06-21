From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: change initial clock setting
Date: Mon, 21 Jun 2010 13:29:21 +0900
Message-ID: <4C1EEAA1.4020005@samsung.com>
References: <4C1AF098.1080400@samsung.com> <87iq5gfr6j.fsf@linux-g6p1.site>
Reply-To: jh80.chung@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51232 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab0FUE3V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2010 00:29:21 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4C007XXKGWPJ30@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Jun 2010 13:29:20 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4C00DG4KGWGA@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Jun 2010 13:29:20 +0900 (KST)
In-reply-to: <87iq5gfr6j.fsf@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org, linux-mmc@vger.kernel.org

On 2010-06-18 =EC=98=A4=ED=9B=84 9:42, Matt Fleming wrote:
> On Fri, 18 Jun 2010 13:05:44 +0900, Jaehoon Chung <jh80.chung@samsung=
=2Ecom> wrote:
>> This patch is bug fixed..
>> I think that host->ios.clock(initial clock) will be set lower than 4=
00KHz.
>> But in this code, if host->f_min is higher than 400KHz, print warnin=
g message and set higher than 400KHz.
>> And We use SDHCI_QUIRK_NONSTANDARD_CLOCK..so using get_min_clock fun=
ction.=20
>> but didn't effect nothing through used get_min_clock function.
>=20
> I'm a little confused. What problem are you fixing with this patch? W=
hat
> issue are you seeing? SDHCI_QUIRK_NONSTANDARD_CLOCK is only for sdhci=
=2E
> If this is the old "my card won't initialise at 400kHz" chestnut I do=
n't
> think a solution has ever been agreed upon. The problem was that whil=
e
> some cards won't initialise at 400kHz, some controllers will try to
> initialise at too low a frequency which causes other problems.
>=20
> Sascha Hauer explains the reason for setting ios.clock to 400kHz here=
,
>=20
>        http://lkml.org/lkml/2010/1/5/120
>=20
> So I think your patch will cause problems.
>=20
> Which driver are you using? The driver should have set the f_min valu=
e
> to be <=3D 400kHz. Maybe it is a good idea to set the value of ios.cl=
ock
> to 400kHz if the driver has set a bogus f_min value, we will at least
> have a fighting chance of initialising the card (though I would say t=
hat
> the driver was broken, but at least core.c will print a warning).
>=20

when ios.clock is higher than 400KHz, why not change 400KHz?(if 400KHz =
seemed like good value)
if clock value is higher than 400KHz, i think card can't initialize...m=
aybe

when sdhci controller set f_min value(ie, 300KHz), clock changed 400KHz=
 in core.c.
just this code purpose to print warning message?
