From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: only set blockaddressed for > 2GiB cards
Date: Sat, 31 Jul 2010 10:49:17 +0200
Message-ID: <AANLkTi=AyRucpxCXf1Mg1TDtM+ru9QjVqpV+OhndeBxf@mail.gmail.com>
References: <1277194762-21399-1-git-send-email-rabin.vincent@stericsson.com>
	<AANLkTin-EGaq9q0ATgRfm=XKTgJ7EYT_Q-Ruzr_OQXsY@mail.gmail.com>
	<20100730163457.a54cb0f1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58201 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab0GaItS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Jul 2010 04:49:18 -0400
In-Reply-To: <20100730163457.a54cb0f1.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Hanumath Prasad <hanumath.prasad@stericsson.com>, Rabin Vincent <rabin.vincent@stericsson.com>

2010/7/31 Andrew Morton <akpm@linux-foundation.org>:
> On Fri, 30 Jul 2010 19:28:44 +0200
> Linus Walleij <linus.walleij@stericsson.com> wrote:
>
>> 2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:
>>
>> > From: Hanumath Prasad <hanumath.prasad@stericsson.com>
>> >
>> > A non-zero value of SEC_COUNT does not indicate that the card is sector
>> > addressed. __According to the MMC specification, cards with a density
>> > greater than 2GiB are sector addressed.
>>
>> What's happening with this beauty? Andrew would you mind
>> picking this one up please?
>
> I merged that a month ago, for 2.6.36.

Aha sorry I didn't see it, it wasn't in -next I rely too much on that tree
I believe. I'll check directly in your patchstack for stuff henceforth.

Thanks and sorry for the trouble!

Yours,
Linus Walleij
