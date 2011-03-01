From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 1 Mar 2011 15:33:24 -0600
Message-ID: <AANLkTikqmVpMqiqXn3dHRzeWi6u5vJtcE8eP4S87AY=b@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201103012011.51855.arnd@arndb.de>
	<4D6D45D2.2020900@kernel.dk>
	<201103012051.13768.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <201103012051.13768.arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 1, 2011 at 1:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 01 March 2011 20:15:30 Jens Axboe wrote:
>> Thanks for the recap. One way to handle this would be to have a dm
>> target that ensures that requests are never built up to violate any of
>> the above items. Doing splitting is a little silly, when you can prevent
>> it from happening in the first place.
>
> Ok, that sounds good. I didn't know that it's possible to prevent
> bios from getting created that violate this.
>

Wouldn't someone still be able to perform a generic_make_request that
would violate the conditions (i.e. cross alignment boundary while
performing unaligned write)? You could prevent the merges that would
result in violating the conditions, sure, but you would need to handle
single unaligned accesses correctly too... Sorry, I'm just groping my
way around the block layer...a lot I'm still trying to draw a mental
picture for.

P.S. I've submitted for review the first 3 patches. Tear into them :).

A
