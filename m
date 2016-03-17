From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Thu, 17 Mar 2016 13:12:26 +0100
Message-ID: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Doug Anderson <dianders@chromium.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Dear all,

Seems the following thread[1] didn't go anywhere. I'd like to continue
the discussion and share some tests that I did regarding the issue
that the patch is trying to fix.

First I reproduced the issue on my rockchip board and I tested the
patch intensively, I can confirm that the patch made by Doug fixes the
issue.But, as reported by Alim, seems that this patch has the side
effect that breaks mmc on peach-pi board [2], specially on
suspend/resume, I ran lots of tests on peach-pi and, although is a bit
random, I can also confirm the breakage.

Looks like that on peach-pi, when the patch is applied the controller
moves into a data transfer and the interrupt does not come, then the
task blocks. The reason why I think the dw_mmc-rockchip driver works
is because it has the DW_MCI_QUIRK_BROKEN_DTO quirk [3].

So I did lots of tests on peach-pi with dto quirk, suspend/resume
started to work again. But I guess this is not the proper solution or
it is? Thoughts?

[1] https://lkml.org/lkml/2015/5/18/495
[2] https://lava.collabora.co.uk/scheduler/job/169384/log_file#L_195_5
[3] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc-rockchip.c?id=57e104864bc4874a36796fd222d8d084dbf90b9b

Cheers,
Enric

>
> Alim,
>
> On Tue, May 26, 2015 at 11:02 AM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>> Hi Doug,
>> On peach-pi, I got a hung task once in 4 cold boot as [1].
>
> OK, I'll have to get my peach-pi or peach-pit up and running again.  I
> ran out of desk space and I haven't gotten it set back up.  :(
>
> I've been testing on an rk3288-based device.  Past experience has
> taught me that the rk3288 dw_mmc works differently than the exynos
> one, so perhaps this is a difference.
>
> Could you possibly patch in something like
> <https://chromium-review.googlesource.com/#/c/244347/> and provide the
> console for the failure?  I'll put it on my list to try this myself,
> too
>
>
>> I was checking on v4.1-rc5, git hash as below:
>>
>> 862e58a mmc: dw_mmc: Wait for data transfer after response errors
>> ba155e2 Linux 4.1-rc5
>> 5b13966
>>
>> Not sure if I missed any dependent patch??
>
> I'm currently testing out of tree, but my dw_mmc is very close to mainline.
>
>
>> Have not checked the dw TRM for this change, will do that as soon as I
>> get access to it.
>
> OK, sounds good.  I have some old version of the DesignWare TRM, so
> possibly something is different in the newer one...
>
>
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
