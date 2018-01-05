From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 16/22] mmc: tmio: fix never-detected card insertion bug
Date: Sat, 6 Jan 2018 00:58:41 +0900
Message-ID: <CAK7LNAThnAY43OMPDMaw4DSdtJCVTUTm4-NrTgWD-6SE-yCp=g@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-17-git-send-email-yamada.masahiro@socionext.com>
 <20180102131555.z6amjfqtadkh2w77@ninjato> <20180102171321.mxhcenirdx6ohbyo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180102171321.mxhcenirdx6ohbyo@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,


2018-01-03 2:13 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> > The TMIO mmc cannot detect the card insertion in native_hotplug mode
>> > if the driver is probed without a card inserted.
>>
>> Hmm, it works for me without your patch just fine. Iam currently
>> researching it...
>
> It really doesn't work for you?


Does not work.


> mmc_add_host -> mmc_start_host -> _mmc_detect_change ->
> mmc_schedule_delayed_work -> mmc_rescan -> mmc_start_request
>

Correct except "-> mmc_start_request".

If a card is not inserted, the power will go down. [1]
So, mmc_start_request will not happen.


BTW, did you understand my git-log?

I am talking about the card detection
by the IP-builtin circuit.

I am trying to support it by the following patch:
https://patchwork.kernel.org/patch/10074255/

TMIO MMC calls mmc_detect_change() [2],
but please note this _never_ detects the card event.
It just re-schedules mmc_rescan. [3]

To detect the card insertion/removal, .get_cd hook must be implemented,
but, it is fixed to mmc_gpio_get_cd. [4]

Unless you had already migrated your boards to built-in CD
based on my patch, GPIO is the only way to detect card events.

If so, you are testing unrelated things.

It is really hard to understand what is going on Renesas side,
but I imagined some possibilities:
 - Poll the GPIO for card events          -> out of interest of this patch
 - Use interrupt from GPIO irqchip        -> ditto
 - The media is non-removable like eMMC   -> ditto
 - GPIO is not set up                     -> mmc_gpio_get_cd() returns -ENOSYS


The last case is treated as "inserted", but the card removal will not
be detected.


[1] http://elixir.free-electrons.com/linux/v4.15-rc6/source/drivers/mmc/core/core.c#L2818
[2] http://elixir.free-electrons.com/linux/v4.15-rc6/source/drivers/mmc/host/tmio_mmc_core.c#L656
[3] http://elixir.free-electrons.com/linux/v4.15-rc6/source/drivers/mmc/core/core.c#L1995
[4] http://elixir.free-electrons.com/linux/v4.15-rc6/source/drivers/mmc/host/tmio_mmc_core.c#L1105

-- 
Best Regards
Masahiro Yamada
