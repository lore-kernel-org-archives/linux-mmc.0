From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: slot-gpio: Fix debounce time to use miliseconds again
Date: Fri, 28 Sep 2018 15:03:55 +0200
Message-ID: <CACRpkdawaqu9jyLa7cbFs0Jaoc6h12ZF0AL+Op2TB3G3cDFpMQ@mail.gmail.com>
References: <CGME20180928122141eucas1p2feee237ecf064b6abddeda569f356c86@eucas1p2.samsung.com>
 <20180928122040.2221-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180928122040.2221-1-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, ext Tony Lindgren <tony@atomide.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 28, 2018 at 2:21 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> The debounce value passed to mmc_gpiod_request_cd() function is in
> microseconds, but msecs_to_jiffies() requires the value to be in
> miliseconds to properly calculate the delay, so adjust the value stored
> in cd_debounce_delay_ms context entry.
>
> Fixes: 1d71926bbd59 ("mmc: core: Fix debounce time to use microseconds")
> Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card
> after card is inserted")
> Cc: stable@vger.kernel.org # v4.18+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This seems correct, after some reading and scratching my head:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
