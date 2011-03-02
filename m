From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Wed, 2 Mar 2011 04:34:19 -0600
Message-ID: <AANLkTimLnd=8oiLeZaaJLNwifG3KJ71kmwy5DDY25j_V@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102251321.09232.arnd@arndb.de>
	<4D6D3F71.4040605@kernel.dk>
	<201103012011.51855.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <201103012011.51855.arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 1, 2011 at 1:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 01 March 2011 19:48:17 Jens Axboe wrote:
>>
>> On 2011-02-25 07:21, Arnd Bergmann wrote:
>> > On Friday 25 February 2011, Andrei Warkentin wrote:
>> >> Yup. I understand :-). =A0That's the strategy I'm going to follow=
=2E For
>> >> page_size-alignment/splitting I'm looking at the block layer now.=
 Is
>> >> that the right approach or should I still submit a (cleaned up) p=
atch
>> >> to mmc/card/block.c for that performance improvement.
>> >
>> > I guess it should live in block/cfq-iosched in the long run, but I=
 don't
>> > know how easy it is to implement it there for test purposes.
>>
>> I don't think I saw the original patch(es) for this?
>
> Nobody has posted one yet, only discussions. Andrei made a patch for =
the
> MMC block driver to split requests in some cases, but I think the
> concept has changed enough that it's probably not useful to look at
> that patch.
>

Before the generic improvements are made to the block layer, I think
there is some value
in implementing the (simpler) ones in mmc block code, as well as
expose an mmc block quirk interface by which its easy to add complex
workarounds. Some things will never be able to completely stay above
mmc block code, for example, when splitting up smaller accesses, you
need to be careful on the Toshiba card, since the 4th consecutive 8KB
block results in the entire 32KB getting pushed  into the bigger 4MB
buffer. On our platform, there are a lot of accesses in the 16KB-32KB
range which benefit from the splitting. Data collected showed
splitting more than 32KB to have adverse effect on performance (I
guess that sort of makes sense, after all, why else would the
controller treat 4 consecutive 8KB accesses as a larger access and
treat it accordingly?) On the other hand, that data was collected on
code that used reliable write for every portion of the split access,
so I'm going to have to get some new data...
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
