From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: slot-gpio: Fix debounce time to use miliseconds
 again
Date: Fri, 28 Sep 2018 09:30:11 -0700
Message-ID: <20180928163010.GR5659@atomide.com>
References: <CGME20180928122141eucas1p2feee237ecf064b6abddeda569f356c86@eucas1p2.samsung.com>
 <20180928122040.2221-1-m.szyprowski@samsung.com>
 <CAPDyKFqbwGhLOZ+VrS07KDWY-j8RLC0mwJEKvhWVHbQQdZqUrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqbwGhLOZ+VrS07KDWY-j8RLC0mwJEKvhWVHbQQdZqUrw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [180928 15:50]:
> On 28 September 2018 at 14:20, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > The debounce value passed to mmc_gpiod_request_cd() function is in
> > microseconds, but msecs_to_jiffies() requires the value to be in
> > miliseconds to properly calculate the delay, so adjust the value stored
> > in cd_debounce_delay_ms context entry.
> >
> > Fixes: 1d71926bbd59 ("mmc: core: Fix debounce time to use microseconds")
> > Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card
> > after card is inserted")
> > Cc: stable@vger.kernel.org # v4.18+
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Applied for fixes!

Heh thanks for fixing it, looks like I totally missed that part :)

Tony
