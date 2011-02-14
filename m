From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Mon, 14 Feb 2011 13:29:59 -0600
Message-ID: <AANLkTin=bkzvdQXoWUKRfX8Xs=4bXnxWf88TUG+VvjPD@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102121937.24933.arnd@arndb.de>
	<AANLkTikGvUZ2sWfox9Ws+gbuCw1JiykO=y-rk9QjL8xJ@mail.gmail.com>
	<201102131839.08517.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:58455 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1BNTde (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 14:33:34 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1EJWW33022771
	for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 14:32:32 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1EJEriQ012482
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 14:32:32 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 11so4042295vws.15
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 11:33:31 -0800 (PST)
In-Reply-To: <201102131839.08517.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Sun, Feb 13, 2011 at 11:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I don't think it needs to be boot-time, it can easily be run-time
> tuneable using sysfs, where you can configure it using an init script
> or some other logic from user space.

True, definitely expose the controls through sysfs.

>
> Yes.
>
> What is "PE" here?
>

Ah sorry, I had to look that one up myself, I thought it was the local
jargon associated with the problem space :-). Program/Erase cycle.

>> So T suggested for random data to better go into buffer A. How? Two suggestions.
>> 1) Split smaller accesses into 8KB and write with reliable write.
>> 2) Split smaller accesses into 8KB and write in reverse.
>>
>> The patch does both and I am verifying if that is really necessary. I
>> need to go see the mmc spec and what it says about reliable write.
>
> I should add this to my test tool once I can reproduce it. If it turns
> out that other media do the same, we can also trigger the same behavior
> for those.
>

As I mentioned, I am checking with T right now on whether we can use
suggestion (1) or
suggestion (2) or if they need to be combined. The documentation we
got was open to interpretation and the patch created from that did
both.
You mentioned that writing in reverse is not a good idea. Could you
elaborate why? I would guess because you're always causing a write
into a different AU (on these Toshiba cards), causing extra GC on
every write?

>> Basically, whatever behavior you choose is going to be wrong some set
>> of cards. Which is why tuning it probably only makes sense for eMMC
>> parts, and should be a set of runtime/compile-time quirks. What do you
>> think?
>
> Your explanation makes sense, but I'd definitely favor a run-time solution
> over compile-time or boot-time, because it would be much more flexible.
> We should also be able to find some optimizations that are universally
> good so we can always use them.
>

Then that's the angle I will pursue. It is the most flexible and then
you don't have to pollute the block driver with little workarounds for
soon-to-be-obsolete hardware. Hopefully I'll have something for
re-review soon.

Thanks Again!
