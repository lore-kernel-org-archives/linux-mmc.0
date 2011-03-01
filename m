From: Jens Axboe <axboe@kernel.dk>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 01 Mar 2011 13:48:17 -0500
Message-ID: <4D6D3F71.4040605@kernel.dk>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102241024.01437.arnd@arndb.de> <AANLkTikWKk0kE=Hh4gfA6Mwt+-65TVFnBcOYy_eRuQfw@mail.gmail.com> <201102251321.09232.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:40889 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350Ab1CASs3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Mar 2011 13:48:29 -0500
In-Reply-To: <201102251321.09232.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On 2011-02-25 07:21, Arnd Bergmann wrote:
> On Friday 25 February 2011, Andrei Warkentin wrote:
>> Yup. I understand :-).  That's the strategy I'm going to follow. For
>> page_size-alignment/splitting I'm looking at the block layer now. Is
>> that the right approach or should I still submit a (cleaned up) patch
>> to mmc/card/block.c for that performance improvement.
> 
> I guess it should live in block/cfq-iosched in the long run, but I don't
> know how easy it is to implement it there for test purposes.

I don't think I saw the original patch(es) for this?


-- 
Jens Axboe

