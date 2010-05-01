From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
Date: Sat, 1 May 2010 15:00:09 -0700
Message-ID: <g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	 <v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	 <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
	 <t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
	 <q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
	 <20100422110025.GC20008@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37512 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab0EAWAK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 May 2010 18:00:10 -0400
In-Reply-To: <20100422110025.GC20008@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Apr 22, 2010 at 4:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Apr 17, 2010 at 06:58:49AM +0200, Linus Walleij wrote:
>> 2010/4/15 Dan Williams <dan.j.williams@intel.com>:
>>
>> > Getting closer... I have pushed out the dma40 driver (v3), 4, and =
6.
>>
>> That's great!
>>
>> > The other patch in -mm I could take as well but that needs an ack =
from
>> > Russell.
>>
>> Nah, I'll push that in through Russells tree hopefully, it needs reb=
asing on
>> the latest board setup code anyway.
>>
>> > 5 is pending the review comment and 9 does not apply cleanly (does=
 it
>> > depend on something in the spi tree?)
>>
>> OK I'm sending updated versions soon, along with a DMA40 bug fix
>> all on top of async_tx instead.
>>
>> Number 9 fails since it is based on -next where all the #include <sl=
ab.h>
>> business has taken place, I don't know how that is resolved in the e=
nd
>> but it now includes that include and applies cleanly on async_tx.
>>
>> I'll keep working on getting the PL011 and PL180 DMA tested on the
>> RealView somehow so those can also be accepted.
>
> So has this (which has now been applied to Dan's tree) been tested
> as I asked on Versatile platforms, or do we have something that could
> be incompatible with those platforms?
>
> I'm basically not acking or applying these patches until something
> along those lines has happened. =A0(And unfortunately I don't have th=
e
> resources to apply to this at present.)

Just to clarify are you nak'ing these patches for upstream inclusion
until this testing occurs?  Or do we just need a !ARCH_VERSATILE
somewhere to allow any incompatibilities to be worked out later
in-tree?

I am not convinced this is the long term approach we want to follow
for architecture specific extensions to dmaengine, but it is has the
nice property of being minimally obtrusive and the best proposal of
the moment.

--
Dan
