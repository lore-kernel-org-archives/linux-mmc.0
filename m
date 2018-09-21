From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in
 get/set array
Date: Fri, 21 Sep 2018 16:14:06 +0200
Message-ID: <20180921141409eucas1p190a47e2608429870d23516ee5e75c191~Wb8z_FmwI1466414664eucas1p1F@eucas1p1.samsung.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
        <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
        <9860023.SlBYqtbjDV@z50>
        <CGME20180920161947epcas3p491e6c136fe05d9672c81b7b4b8328f64@epcas3p4.samsung.com>
        <15226900.TQMLYV7PZ0@z50>
        <20180921081806eucas1p182d4646e8510b5f0356214af7edba11e~WXF8Ptw4M0970709707eucas1p1p@eucas1p1.samsung.com>
        <CAGfqbt7xJxGbq3oOJp9S0Sg7Z9=T6Dy52MDNWSDdsU==kPt1KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAGfqbt7xJxGbq3oOJp9S0Sg7Z9=T6Dy52MDNWSDdsU==kPt1KQ@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,


On 2018-09-21 12:51, Janusz Krzysztofik wrote:
> 2018-09-21 10:18 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
>> On 2018-09-20 18:21, Janusz Krzysztofik wrote:
>>> On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik wrote:
>>>> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
>>>>> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
>>>>>> Certain GPIO descriptor arrays returned by gpio_get_array() may
>>>>>> contain
>>>>>> information on direct mapping of array members to pins of a single
>>>>>> GPIO
>>>>>> chip in hardware order.  In such cases, bitmaps of values can be
>>>>>> passed
>>>>>> directly from/to the chip's .get/set_multiple() callbacks without
>>>>>> wasting time on iterations.
>>>>>>
>>>>>> Add respective code to gpiod_get/set_array_bitmap_complex() functions.
>>>>>> Pins not applicable for fast path are processed as before, skipping
>>>>>> over the 'fast' ones.
>>>>>>
>>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>>>> I've just noticed that this patch landed in today's linux-next. Sadly
>>>>> it
>>>>> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
>>>>> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
>>>>>
>>>>> Booting hangs after detecting MMC cards. Reverting this patch fixes the
>>>>> boot. I will try later to add some debugs and investigate it further
>>>>> what
>>>>> really happens when booting hangs.
>>>> Hi Marek,
>>>>
>>>> Thanks for reporting. Could you please try the following fix?
>>> Hi again,
>>>
>>> I realized the patch was not correct, j, not i, should be updated in
>>> second
>>> hunk. Please try the following one.
>>>
>>> Thanks,
>>> Janusz
>>>
>>> >From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
>>> From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>> Date: Thu, 20 Sep 2018 17:37:21 +0200
>>> Subject: [PATCH] gpiolib: Fix bitmap index not updated
>>> While skipping fast path bits, bitmap index is not updated with next
>>> found zero bit position. Fix it.
>>>
>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>> This one also doesn't help. A quick compare of logs with this version and
>> a working system shows, that with your patch (and fix) there are no calls
>> to
>> gpx0-2 pin (which are a part of mmc pwrseq), what causes mmc failure. If
>> you need any more information (what kind of logs will help?), let me know.
> There is a debug message on array_info content available at the end of
> gpiod_get_array(), could you please activate it and post the message so
> we can understand better what is going on?

With debug enabled on next-20180919:
[    2.499153] pwrseq_simple mmc3_pwrseq: GPIO array info: chip=gpx0, 
size=2, get_mask=2, set_mask=2, invert_mask=2

On next-20180920 I get no this message and booting hangs.

Same with next-20180920 + your second fix from this thread.

I will try to debug this more on Monday.

> On the other hand, I've had a look your device-tree configuration and
> it looks like that specific setup won't benefit from the fast bitmap path.
> You have pin 2 at position 0 and pin 1 at position 1 of the array.
> Hence, the fast bitmap path covers only pin 1, and pin 2 is processed
> by the old path with apparently buggy code for skipping over fast pins.
>
> As a temporary workaround, you could try to revert the order of pins in
> your dts file (pin 1 at position 0, pin 2 at 1) and the mmc pwrseq code
> should work for you again by taking the original old path, not skipping
> over fast pins.  Results of such check may also help us to better
> understand and resolve the issue.

Changing the order of mmc pwrseq gpio pins fixes boot hang.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
