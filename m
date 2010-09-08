From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCHv6 3/3] mmc_test: collect data and show it via sysfs by demand
Date: Wed, 8 Sep 2010 12:08:58 +0300
Message-ID: <AANLkTikV4TvwtwQHnb_p9HBsJTV4hVmbpvjKs6MvbYo=@mail.gmail.com>
References: <09f59cd98b59bf521a5866ab58c216e0a0347a6c.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<ba5173c9b420d9554c83965f47d0b5cba642743a.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<d7cf4d98c6e0396da903c2e49b028f240853bfc2.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<20100907152753.4726c076.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35318 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0IHJI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Sep 2010 05:08:59 -0400
In-Reply-To: <20100907152753.4726c076.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hunter Adrian <adrian.hunter@nokia.com>, Chris Ball <cjb@laptop.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Wed, Sep 8, 2010 at 1:27 AM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
>> Here is a patch which brings possibility to get test results via sys=
fs. It
>> helps to do tests non-interactively.
>>
>> We have the file created under sysfs already and we could use it to =
out test
>> results.
>
> So what we end up with is extremely thin. =C2=A0Something about addin=
g
> something to sysfs.
Yeah, agree with you. How to proceed with commit messages?
Should I make newer version of this certain patch with updated commit m=
essage?

> This is not enough! =C2=A0You're proposing an addition to the kernel-=
>user
> ABI. =C2=A0Please fully describe this interface so that we can unders=
tand
> and review it. =C2=A0What are the names of these sysfs files? =C2=A0W=
hat do they
> do?
The sysfs file already exists for me as for feature contributor. I
think I could issue separate
patch to update documentation  part.

> Provide us with example output in the changelog so we can see for
> ourselves.
Will do.

> Please consider documenting the thing in a permanent documentation
> file. =C2=A0(I don't believe that Documentation/ABI/ is appropriate, =
given
> mmc_test's scope).
Adrian pointed me once to some standalone documentation about this stuf=
f.
I will talk to him how we could use this and apply to kernel.

> afacit the only useful info we have about mmc_test is
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Development driver that performs a =
series of reads and writes
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to a memory card in order to expose=
 certain well known bugs
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in host controllers. The tests are =
executed by writing to the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"test" file in sysfs under each car=
d. Note that whatever is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on your card will be overwritten by=
 these tests.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver is only of interest to =
those developing or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testing a host driver. Most people =
should say N here.
>
> which I guess is good enough, given the smallness and sophistication =
of
> its users. =C2=A0It could be improved on though!
Ok.
Thanks.

--=20
With Best Regards,
Andy Shevchenko
