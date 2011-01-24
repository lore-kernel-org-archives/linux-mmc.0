From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Mon, 24 Jan 2011 23:11:24 +0100
Message-ID: <AANLkTimZyv9f5b5VxmmYyO3qPrb9Y25-=yUV_GYma3e_@mail.gmail.com>
References: <20110114082310.GB27523@intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
	<20110120050803.GA5732@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20110120050803.GA5732@void.printf.net>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Tardy, Pierre" <pierre.tardy@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2011/1/20 Chris Ball <cjb@laptop.org>:
> On Wed, Jan 19, 2011 at 09:45:57AM +0000, Tardy, Pierre wrote:
>> Chris,
>> (Sorry for top posting)
>> Seems we have a intel intern disagreement.
>>
>> Could we have maintainer opinion on this ?
>
> Linus W and Ohad, any input here? =A0Thanks,

What I see is orthogonal purposes altogether. Usually there is
something like two clocks and two regulators or switches
available in every sufficiently advanced system:

- One regulator to power the card
- One clock to clock the card (MCLK)
- One regulator or switch to power the MMC IP block
- One clock to clock the MMC IP block

The MMC core regulator handling and the clock gating I
implemented is about the two first things.

I think this patch is about the two *other* things, if I read it
right.

So drivers can register PM runtime hooks to its class device
and that's probably a good thing, but doesn't it conflict with
the stuff we already have in place all over the core, that
makes sure that mmc_power_save_host() gets called
from the mmc bus.

I don't know how that fits with e.g. OMAP where they
already are doing this with mmc_power_save_host() so I
would really like input from them on this subject.
It looks like a duplication of that mechanism, just tied to the
class device instead of the mmc bus.

=46urther this patch cannot be applied as-is.
It needs a clause where it will wait for the clock gating to
be sync:ed *before* calling the suspend hook.

Just pm_generic_runtime_suspend won't do it. *If*
we have clock gating we certainly want to make sure
it is gated before this happens. With the current
mmc_power_save_host() we can do this in the driver
itself, taking the fact that the clock may be gated into
account.

The other question, whether the delay hysteresis
functions in runtime PM can be reused for clock gating
remains unanswered, the easiest thing to do is cook
up a patch. AFAICT that involves factoring out the
code dealing with that from runtime.c and when looking
at it that doesn't seem easy, it strictly requires a struct
device to live, and setting up abstract devices inside
the MMC framework for this doesn't seem like a good
idea to me.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
