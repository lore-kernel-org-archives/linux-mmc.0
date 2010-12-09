From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Thu, 9 Dec 2010 17:46:20 +0000
Message-ID: <AANLkTi=BXxfNcnhNb6Bd_N3gVpDUMWBCQtZ0d=m9p_sa@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<20101209173525.GA29879@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:47219 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0LIRq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2010 12:46:59 -0500
In-Reply-To: <20101209173525.GA29879@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 9, 2010 at 5:35 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrew,
>
> On Thu, Dec 09, 2010 at 04:01:57PM +0000, Chris Ball wrote:
>> > > Is there something we could depend on that would stop this drive=
r being
>> > > presented to everyone, without being far too specific? =A0At the=
 moment
>> > > we'd be making x86 desktop users say whether they have this IP, =
which
>> > > isn't good. =A0Are the architectures that use this IP already up=
stream?
>> > > Are they all ARM architectures, for instance?
>> >
>> > I don't know of any architectures upstream that use this IP block.=
 There is an
>> > SoC from NXP that uses this it but it is not upstream:
>> >
>> > http://ics.nxp.com/support/software/lpc313x.bsp.linux/
>> >
>> > The architecture we tested and debugged this driver on is not upst=
ream either
>> > unfortunately. :-/
>>
>> Okay. =A0I think "depends on ARM" is appropriate for now, and we cou=
ld
>> expand that later if the block appears in a MIPS SoC or something.
>> Does that work for you?
>
> Oh, hey, rmk says that he seems to recall that akpm says that if the
> driver builds on x86 (it does), we should just allow it to be built
> there too so that it gets build coverage. =A0Andrew, does this still
> represent your stance?
>
> I've heard the distro maintainers complain about having to investigat=
e
> Kconfig entries for drivers that their users would never possibly use=
,
> though, and this certainly falls into that case. =A0Is there somethin=
g
> better we can do here, to correctly hide this driver from non-ARM use=
rs
> but also make it clear that it can be built if somebody wants to do a
> mass driver build?

The driver does build on x86{_64} and it has been useful for me to do
that in the past to test cosmetic changes. It might also be good to
have it building on x86 to get more compile testing, as I suspect a
lot more people doing randconfig builds are doing it on x86 rather
than arm.

But I'm fine with it either way.
