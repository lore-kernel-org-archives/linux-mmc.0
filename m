From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
Date: Fri, 11 Jan 2019 11:55:57 -0800
Message-ID: <7hy37rm0j6.fsf@baylibre.com>
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com> <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Loys Ollivier <lollivier@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi,
>
> some nit-picks as well as my Tested-by (in case it's not too late) below.
> thank you for taking care of this!
>
> On Thu, Jan 10, 2019 at 4:40 PM Loys Ollivier <lollivier@baylibre.com> wrote:
>>
>> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> changed the behavior of "cd-inverted" to follow the device tree bindings
>> specification.
>> Lines specifying "cd-inverted" are now "active high".
> this depends on the polarity from the cd-gpios property. above commit
> caused cd-inverted to be applied twice (effectively making it a
> no-op). thus "cd-inverted" only means "active high" if cd-gpios also
> sets GPIO_ACTIVE_HIGH. if the polarity in cd-gpios is GPIO_ACTIVE_LOW
> together with "cd-inverted" then the GPIO will be treated as active
> low.
>
>> Fix the SD card for meson by setting the cd-gpios as "active low" according
>> to the boards specifications.
> not only switching to GPIO_ACTIVE_LOW, also dropping "cd-inverted"
>
>> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> in my patches for the 32-bit boards I used the commit which added SD
> card support to the board for the Fixes tag. however, I'm fine with
> this as well (I just wanted to point out that there's a small
> difference in our commits).
>
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> on my Khadas VIM(1), using Kevin's v5.0/fixes branch:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I can add this tested-by tag in my v5.0/fixes branch for now, and can
replace it with a follow up if Loys can update the changelog with your
suggestions/clarifications.

Thanks,

Kevin
