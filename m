From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO
 bitmap
Date: Wed, 26 Sep 2018 10:27:30 +0200
Message-ID: <20180926082731eucas1p1fb936eedca21be0b8cd4dd281e422f27~X5cmfM67m0415004150eucas1p1b@eucas1p1.samsung.com>
References: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
        <CGME20180925192325epcas1p41b5c57a1ff7c9bc00f9a6d3b2e601820@epcas1p4.samsung.com>
        <20180925192433.1377-1-jmkrzyszt@gmail.com>
        <7a4906d9-ffb1-f2af-07e7-d5815dcd0d8c@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a4906d9-ffb1-f2af-07e7-d5815dcd0d8c@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi again,

On 2018-09-26 10:14, Marek Szyprowski wrote:
> On 2018-09-25 21:24, Janusz Krzysztofik wrote:
>> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
>> get/set array") changed the way GPIO values are passed to
>> gpiod_get/set_array_value() and friends.  The updated code of
>> mmc_pwrseq_simple_set_gpios_value() incorrectly uses the 'value'
>> argument as a bitmap of GPIO values and assigns it directly to the
>> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
>> instead of filling that bitmap with bits equal to the 'value' argument.
>> As a result, boot hanging caused by incorrectly handled MMC device
>> has been observed.
>>
>> As a side effect of that incorrect interpreation of the 'value'
>> argument, wrong assumption is taken about the 'values' bitmap size
>> never exceding the number of bits of the 'value' argument type.
>>
>> Fix it.
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>> ---
>> Hi,
>>
>> I hope I've finally identified the root cause of the boot hang reported
>> by Marek Szyprowski.  I've reviewed the code of other divers updated for
>> the modified GPIO API and found no more issues of that kind.
>>
>> Marek, can you please test this fix on top of next-20180920 with the fix
>> "gpiolib: Fix missing updates of bitmap index" also applied?
>
> Yes, I've just did such test (next-20180920 + "gpiolib: Fix missing
> updates of bitmap index" + "mmc: pwrseq_simple: Fix incorrect handling
> of GPIO bitmap") and sadly it doesn't fix the boot hang.
>
> With some more debugs in mmc_pwrseq_simple I've noticed that
> gpiod_set_array_value_cansleep() never ends and busyloops somewhere.
> I'm checking this now.

I busyloops inside the internal do { } while loop (lines 3163-3201) in
gpiod_set_array_value_complex(). 'i' is never incremented.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
