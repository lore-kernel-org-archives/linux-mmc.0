From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: MMC performance degradation due to too many requests
Date: Wed, 16 May 2018 16:29:06 +0200
Message-ID: <CACRpkda+jrHgG=5qs-s7dcy4ZV4b9gQFGuf8SkwbAoGKxhBpqw@mail.gmail.com>
References: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com> <CACRpkdaZ5G=gBHNwf7YMLEBOqC2UrO+YLrz09H4h8HWYN=av4w@mail.gmail.com>
 <3e2c96fa-273e-192f-1caf-788de7659592@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e2c96fa-273e-192f-1caf-788de7659592@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, Will Newton <will.newton@gmail.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 15, 2018 at 5:11 PM, Faiz Abbas <faiz_abbas@ti.com> wrote:
> On Tuesday 15 May 2018 06:09 PM, Linus Walleij wrote:
>> On Mon, May 14, 2018 at 1:30 PM, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>>> Also, I see many times the number of interrupts for mmc1 in 4.14.
>> (...)
>>> I also printed out the size of the DMA transfers in the omap_hsmmc
>>> driver during the dd command. I see that the maximum size of the dma
>>> transfer has decreased from 1 MB to 256kB between 4.13 and 4.14.
>>
>> This seems like my fault for removing the bounce buffer.
>> (The name bounce buffer is misleading, I suspect the right
>> term for what is was doing was "merge buffer" or something,
>> coalescing physically consecutive requests.)
>>
>> commit de3ee99b097dd51938276e3af388cd4ad0f2750a
>> "mmc: Delete bounce buffer handling"
>> should be the culprit.
>
> I don't think so. I checked out to the commit before that and see that
> the interrupts are still too high.

OK phew then I'm safe :)

>> The bounce buffer only makes any performance impact if the
>> host DMA controller is unable to handle scatter-gather lists
>> so the number of segments is set down to 1.
>>
>> Can you verifty that:
>> - mmc->max_segs == 1
>
> No. It is 64 in v4.14. It was 1024 in v4.13.

This smells like:
commit 9442400486a1ec28915e9ab31517a5665ed35705
"mmc: omap_hsmmc: Reduce max_segs for reliability"

Can you test reverting that and notify Will Newton if this
commit is causing performance regressions.

Yours,
Linus Walleij
