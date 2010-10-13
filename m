From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: append a file to change host clock at run time
Date: Wed, 13 Oct 2010 10:08:14 +0300
Message-ID: <AANLkTinvBhcUBQHXRcLeuFW9a0f5xb9G7TzffPP+=7_5@mail.gmail.com>
References: <1286896642-27772-1-git-send-email-ext-andriy.shevchenko@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34497 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab0JMHIP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 03:08:15 -0400
In-Reply-To: <1286896642-27772-1-git-send-email-ext-andriy.shevchenko@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Tue, Oct 12, 2010 at 6:17 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> For debugging power managment features there is quite convenient to h=
ave a
> possibility to change MMC host controller clock at run time. This pat=
ch adds
> 'clock' file under MMC host root of debugfs.
>
> Usage as follows:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# cat /sys/kernel/debug/mmc0/clock
> =C2=A0 =C2=A0 =C2=A0 =C2=A024000000
Actually this value should be 52000000 here.

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# echo "1000000000" > /sys/kernel/debug/mm=
c0/clock
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# cat /sys/kernel/debug/mmc0/clock
> =C2=A0 =C2=A0 =C2=A0 =C2=A052000000
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# echo "48000000" > /sys/kernel/debug/mmc0=
/clock
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# cat /sys/kernel/debug/mmc0/clock
> =C2=A0 =C2=A0 =C2=A0 =C2=A048000000
>
> The second piece of example shows limits which are applied accordingl=
y to used
> host driver.


--=20
With Best Regards,
Andy Shevchenko
