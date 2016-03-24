From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Thu, 24 Mar 2016 12:26:43 +0100
Message-ID: <CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
	<CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

I fixed Javier Martinez email and removed tgih.jun@samsung.com (delivery fail)
Also cc'ing Russell King as I think might help (see my comment below)


2016-03-21 23:38 GMT+01:00 Doug Anderson <dianders@chromium.org>:
> Enric,
>
> On Thu, Mar 17, 2016 at 5:12 AM, Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
>> Dear all,
>>
>> Seems the following thread[1] didn't go anywhere. I'd like to continue
>> the discussion and share some tests that I did regarding the issue
>> that the patch is trying to fix.
>>
>> First I reproduced the issue on my rockchip board and I tested the
>> patch intensively, I can confirm that the patch made by Doug fixes the
>> issue.But, as reported by Alim, seems that this patch has the side
>> effect that breaks mmc on peach-pi board [2], specially on
>> suspend/resume, I ran lots of tests on peach-pi and, although is a bit
>> random, I can also confirm the breakage.
>>
>> Looks like that on peach-pi, when the patch is applied the controller
>> moves into a data transfer and the interrupt does not come, then the
>> task blocks. The reason why I think the dw_mmc-rockchip driver works
>> is because it has the DW_MCI_QUIRK_BROKEN_DTO quirk [3].
>>
>> So I did lots of tests on peach-pi with dto quirk, suspend/resume
>> started to work again. But I guess this is not the proper solution or
>> it is? Thoughts?
>>
>> [1] https://lkml.org/lkml/2015/5/18/495
>> [2] https://lava.collabora.co.uk/scheduler/job/169384/log_file#L_195_5
>> [3] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc-rockchip.c?id=57e104864bc4874a36796fd222d8d084dbf90b9b
>
> Ah, that would make some sense why things work OK on Rockchip.  Adding
> DW_MCI_QUIRK_BROKEN_DTO to peach probably doesn't make sense, then.
> Hrm...
>
> Since my original debugging of the issue was over a year ago, I think
> I've almost totally lost context of any debugging I did on the issue,
> so I'm not sure I'm going to be too much help in giving any details
> other than what I put in the original commit message.  From the
> original message it appears that I thought we could solve this other
> ways but just that my patch was easier than the alternative of
> handling every error case.  Maybe we just need to go back to the
> drawing board and handle the error directly?
>

I just saw that Russell introduced a patch [1] that will land on 4.6.
I think that patch solves the same issue that we're trying to fix, but
for sdhci controller.

The problem that we have on peach-pi, with our patch applied, is that
when we get a response CRC error on a command and we move to start
sending data, the transfer doesn't receives a timeout interrupt (I
don't know why). As I told, on rockchip works due the DTO quirk.
exynos is not using this quirk. Also, please correct me if I'm wrong,
looks like the sdhci controller has a timer to signal the command
timed out.

ooi, anyone knows what was the test case that caused the necessity of
the DTO quirk?

> Also: my original commit message says "response error or response CRC
> error".  Do you happen to know which of these two we're hitting on
> rk3288?  If we limit the workaround to just one of these two cases
> does peach pi still break?
>

Yes, the peach pi still break. The one that is hitting is the response
CRC error, so limit the workaround doesn't help.


> Also: I'd be curious, with the same SD card can you reproduce any
> failures on peach pi?  ...or does peach-pi work fine in this case?
>

I can't test this now because I don't have physical access to the
peach-pi. But yeah, this is something to test.

> Hmm, also I think my last suggestion was to see how things looked with
> <https://chromium-review.googlesource.com/#/c/244347/> picked to get
> extra debug info...
>
>
> -Doug

[1] https://git.linaro.org/people/ulf.hansson/mmc.git/commit/71fcbda0fcddd0896c4982a484f6c8aa802d28b1

Enric
