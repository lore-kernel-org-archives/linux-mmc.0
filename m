From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCHv6 3/3] mmc_test: collect data and show it via sysfs by demand
Date: Wed, 8 Sep 2010 12:14:05 +0300
Message-ID: <AANLkTik2Tmi1uKp5k=ri454ZfmxKg-tNOZghOn__NCED@mail.gmail.com>
References: <09f59cd98b59bf521a5866ab58c216e0a0347a6c.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<ba5173c9b420d9554c83965f47d0b5cba642743a.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<d7cf4d98c6e0396da903c2e49b028f240853bfc2.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<20100907152753.4726c076.akpm@linux-foundation.org>
	<20100907225843.GA26240@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49262 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab0IHJOQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Sep 2010 05:14:16 -0400
In-Reply-To: <20100907225843.GA26240@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hunter Adrian <adrian.hunter@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Wed, Sep 8, 2010 at 1:58 AM, Chris Ball <cjb@laptop.org> wrote:
> Hoping Andy doesn't mind me jumping in, here's an attempt at a better
> changelog:
Thanks. I will take into account this.

> Prior to this patch, the "test" file under each card's sysfs node was
> write-only, and results were obtained by looking at dmesg. =C2=A0This=
 patch
> improves programmatic access to the test results, making them availab=
le
> by reading back from the same "test" file:
>
> [root@host mmc0:e624]# echo 6 > test
> [root@host mmc0:e624]# cat test
> Test 6: 2
It even better to get this sample for performance tests as well.

> I think we should do this by modifying the Kconfig text as well:
At least. And add documentation and link to it in Kconfig.

> Separately, Andy, I think we should translate the general result retu=
rn
> code for the user, i.e. print OK/FAIL/UNSUP_HOST/UNSUP_CARD for retur=
n
> values 0-3. =C2=A0Would you mind adding that? =C2=A0(Unfortunately, i=
t invalidates
> the usage example I just gave above, so that should change too..)
I thought about it. But for the scripts may be better to keep numeric
value as well.
I will think again hot to implement better.

Thanks.

--=20
With Best Regards,
Andy Shevchenko
