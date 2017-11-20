From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/3] mmc: tmio: support IP-builtin card detection logic
Date: Mon, 20 Nov 2017 17:03:13 +0900
Message-ID: <CAK7LNASd9nMr=HKwfFN5E35XT_THzGSJ9XLuUkyZ5wBtjvGnOQ@mail.gmail.com>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
 <1510136220-31853-4-git-send-email-yamada.masahiro@socionext.com> <20171119194502.bwxazcrg367pz74x@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171119194502.bwxazcrg367pz74x@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2017-11-20 4:45 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Nov 08, 2017 at 07:17:00PM +0900, Masahiro Yamada wrote:
>> A card detect GPIO is set up only for platforms with "cd-gpios"
>> DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
>> core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
>> if ctx->cd_gpio is unset.
>>
>> The bit 5 of the status register provides the current signal level
>> of the CD line.  Allow to use it if the GPIO is unused.
>
> I might be missing something: Why do we need to report something
> sensible in this case? The card insert/eject interrupts calling
> mmc_detect_change is not enough?
>

Not enough.

mmc_detect_change() just schedules mmc_rescan().

Without correct ->get_cd(), how can mmc_rescan()
know whether a card is inserted or not?




-- 
Best Regards
Masahiro Yamada
