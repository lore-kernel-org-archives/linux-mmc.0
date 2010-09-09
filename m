From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCHv6 3/3] mmc_test: collect data and show it via sysfs by demand
Date: Thu, 9 Sep 2010 08:51:58 +0300
Message-ID: <AANLkTin-RiDEnKWh_9xT-ssNhgX94mRkx5+gHxoNv_uU@mail.gmail.com>
References: <09f59cd98b59bf521a5866ab58c216e0a0347a6c.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<ba5173c9b420d9554c83965f47d0b5cba642743a.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<d7cf4d98c6e0396da903c2e49b028f240853bfc2.1283862780.git.ext-andriy.shevchenko@nokia.com>
	<20100907152753.4726c076.akpm@linux-foundation.org>
	<20100907225843.GA26240@void.printf.net>
	<20100909035951.GA3945@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48544 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0IIFv7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 01:51:59 -0400
In-Reply-To: <20100909035951.GA3945@kroah.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hunter Adrian <adrian.hunter@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Thu, Sep 9, 2010 at 6:59 AM, Greg KH <greg@kroah.com> wrote:
> Why is this in sysfs at all anyway?
I don't know. The author of module should be asked.

> Why not put it in debugfs?
I thought about this. I even have somewhere a draft patch.

> And for every sysfs file, you need to have a Documenation/ABI/ entry.
>
> Remember, sysfs is "one value per file". =C2=A0Does that work with th=
is file?
> At first glance, it doesn't look like it.
>
> Please use debugfs instead.
I guess to optimize a work I may do another patch which shifts from
sysfs to debugfs.

--=20
With Best Regards,
Andy Shevchenko
