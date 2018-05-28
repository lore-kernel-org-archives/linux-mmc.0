From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
Date: Mon, 28 May 2018 13:30:21 +0200
Message-ID: <CAPDyKFqe4fPpJLh6d+timZ_w+J0BVZbO61PTacFM=X6BuUP-Yw@mail.gmail.com>
References: <20180525210752.1794502-1-arnd@arndb.de> <CAPDyKFoyBZ=k5UQyTmgkPd+30Htymw99Xeh3C+bDPo+VGyjrNw@mail.gmail.com>
 <CAK8P3a2AGu4Lec1pwi87gb4QYn9QTy7mG2i9kWtfAR=An+k-7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2AGu4Lec1pwi87gb4QYn9QTy7mG2i9kWtfAR=An+k-7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 May 2018 at 13:13, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 28, 2018 at 1:04 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 25 May 2018 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
>>> The newly added runtime-pm functions cause a harmless warning
>>> when CONFIG_PM is disabled:
>>>
>>> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
>>>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>>>             ^~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
>>>  static int sunxi_mmc_runtime_resume(struct device *dev)
>>>
>>> This marks them as __maybe_unused to shut up the warning.
>>
>> Most mmc drivers uses #ifdef CONFIG_PM instead of the __maybe_unused() option.
>>
>> It's not a big deal, but consistency is always good. Would you mind changing?
>
> I'd prefer not to. Most uses of #ifdef CONFIG_PM that get introduced are wrong,
> and cause additional randconfig warnings that I end up having to fix,
> so I always
> do it with __maybe_unused.

Right.

>
> I don't mind if you treat my patch as a bug report and decide to fix
> it differently
> yourself, but you won't get that patch from me ;-)

No, worries then. As stated, it's not a big deal.

Applied for next!

Kind regads
Uffe
