From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/6] mmc: tmio: set tmio_mmc_host to driver data
Date: Tue, 21 Nov 2017 00:14:04 +0900
Message-ID: <CAK7LNARAQwARu8ELhnZ4A4LmhpVjzgcch4ahgpEWYHvvVXGfcw@mail.gmail.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
 <20171119194930.npqfzqvmh4zbcb34@tetsubishi> <CAK7LNAQZQ13O1pSd5Ah7VDWrZF1MSkLT_QoTDS+uT7C-r09b+g@mail.gmail.com>
 <20171120092023.nc3oxnawxqwa3ofs@tetsubishi> <CAK7LNARsiyNegE-jFg1hi66+eW_jeK2h+QKWpoUs6RLweQVTKQ@mail.gmail.com>
 <20171120132255.kybz6nbtaviygsu7@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120132255.kybz6nbtaviygsu7@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

2017-11-20 22:22 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> Last week I was working on the TMIO driver
>> and I have more bug-fix and clean-up patches in hand now.
>> (about 20 patches)
>>
>> The patch order is getting a mess,
>> so I am planning to put all patches in one series.
>>
>> If not in hurry, can you wait for a little?
>
> So, did I get this correct: all your current patches are obsolete
> meanwhile? And I don't need to test or tag them until your new series
> comes out?
>

No, that is not what I meant.

I a bit felt sorry to ask you to test my patches several times.
I thought I could ask you to test for a larger chunk
(since 4.16 is far away anyway),
but if you do not mind it, please go a head for testing
the current patches.

I fixed some typos, but no change in the code diff.
Once you test them and issue Reviewed-by,
you do not need to re-review them.


Please let me postpone only the following one:
https://patchwork.kernel.org/patch/10045861/

I had two ideas in my mind
 [1] move mmc_of_parse() to each driver's probe
 [2] move mmc_of_parse() to tmio_mmc_host_alloc()

After I thought a bit, perhaps [2] might be cleaner...


Thanks!

-- 
Best Regards
Masahiro Yamada
