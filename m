From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: drivers/mmc/host/sdhci-of-core.c on sparc64
Date: Fri, 14 Jan 2011 00:57:07 -0700
Message-ID: <AANLkTinkc0ejTpd5ZrXhDDejwojp2rgUy1NSFMYVqh+x@mail.gmail.com>
References: <20110113151033.dbfd7524.akpm@linux-foundation.org>
 <20110113233828.GA21404@void.printf.net> <20110113154140.7176df4c.akpm@linux-foundation.org>
 <20110114011212.GA22374@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58058 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab1ANH52 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jan 2011 02:57:28 -0500
Received: by iyj18 with SMTP id 18so2283163iyj.19
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jan 2011 23:57:28 -0800 (PST)
In-Reply-To: <20110114011212.GA22374@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>

On Thu, Jan 13, 2011 at 6:12 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Jan 13, 2011 at 03:41:40PM -0800, Andrew Morton wrote:
>> > > drivers/mmc/host/sdhci-of-core.c:24:25: asm/machdep.h: No such f=
ile or directory
>> > > drivers/mmc/host/sdhci-of-core.c: In function `sdhci_of_wp_inver=
ted':
>> > > drivers/mmc/host/sdhci-of-core.c:115: error: implicit declaratio=
n of function `machine_is'
>> > >
>> > > That code's been there for a while. =A0Did someone change Kconfi=
g?
>> >
>> > Can you attach a .config? =A0<asm/machdep.h> is arch-specific, so =
I'd
>> > suggest that you're building on an unsupported arch.
>> >
>>
>> sparc64 allmodconfig.
>
> You're right, Andrew -- Rob (CC'd) changed the MMC Kconfig to build t=
his
> driver on Sparc. =A0Mainline commit 236cdc7bc71 ("of: make drivers de=
pend
> on CONFIG_OF instead of CONFIG_PPC_OF").
>
> Rob also posted a patch to devicetree-discuss@, on top of the one abo=
ve
> ("mmc: sdhci-of: fix build on non-powerpc platforms"), to fix up the
> Sparc build by ifdef'ing for PPC inside the driver. =A0Grant merged t=
he
> first patch but not the second, hence sparc64 allmodconfig is broken
> now. =A0The reason Grant didn't merge the second patch may be that Wo=
lfram
> objected to #ifdef proliferation inside the driver.
>
> Options, as I see it:
> =A0* revert the commit such that MMC_SDHCI_OF once again depends on P=
PC_OF
> =A0* take the second patch as-is
> =A0* come up with a less-#ifdeffy second patch
>
> Wolfram, would appreciate your input on what we should do here. =A0Th=
anks,

I've applied the 2nd patch.  I had applied it to my test tree, and
indeed I replied saying I did, but I had a corrupt git tree event
shortly after applying it to my test branch and evidently lost track
of it.

It's been pushed out to my next-devicetree branch:

git://git.secretlab.ca/git/linux-2.6.git next-devicetree

I'll ask Linus to pull after doing some sanity testing.

g.
