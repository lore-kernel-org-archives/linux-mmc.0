From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Mon, 21 Mar 2016 15:38:00 -0700
Message-ID: <CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36536 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbcCUWiC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2016 18:38:02 -0400
Received: by mail-vk0-f42.google.com with SMTP id q138so140344376vkb.3
        for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2016 15:38:01 -0700 (PDT)
In-Reply-To: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>

Enric,

On Thu, Mar 17, 2016 at 5:12 AM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Dear all,
>
> Seems the following thread[1] didn't go anywhere. I'd like to continue
> the discussion and share some tests that I did regarding the issue
> that the patch is trying to fix.
>
> First I reproduced the issue on my rockchip board and I tested the
> patch intensively, I can confirm that the patch made by Doug fixes the
> issue.But, as reported by Alim, seems that this patch has the side
> effect that breaks mmc on peach-pi board [2], specially on
> suspend/resume, I ran lots of tests on peach-pi and, although is a bit
> random, I can also confirm the breakage.
>
> Looks like that on peach-pi, when the patch is applied the controller
> moves into a data transfer and the interrupt does not come, then the
> task blocks. The reason why I think the dw_mmc-rockchip driver works
> is because it has the DW_MCI_QUIRK_BROKEN_DTO quirk [3].
>
> So I did lots of tests on peach-pi with dto quirk, suspend/resume
> started to work again. But I guess this is not the proper solution or
> it is? Thoughts?
>
> [1] https://lkml.org/lkml/2015/5/18/495
> [2] https://lava.collabora.co.uk/scheduler/job/169384/log_file#L_195_5
> [3] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/dw_mmc-rockchip.c?id=57e104864bc4874a36796fd222d8d084dbf90b9b

Ah, that would make some sense why things work OK on Rockchip.  Adding
DW_MCI_QUIRK_BROKEN_DTO to peach probably doesn't make sense, then.
Hrm...

Since my original debugging of the issue was over a year ago, I think
I've almost totally lost context of any debugging I did on the issue,
so I'm not sure I'm going to be too much help in giving any details
other than what I put in the original commit message.  From the
original message it appears that I thought we could solve this other
ways but just that my patch was easier than the alternative of
handling every error case.  Maybe we just need to go back to the
drawing board and handle the error directly?

Also: my original commit message says "response error or response CRC
error".  Do you happen to know which of these two we're hitting on
rk3288?  If we limit the workaround to just one of these two cases
does peach pi still break?

Also: I'd be curious, with the same SD card can you reproduce any
failures on peach pi?  ...or does peach-pi work fine in this case?

Hmm, also I think my last suggestion was to see how things looked with
<https://chromium-review.googlesource.com/#/c/244347/> picked to get
extra debug info...


-Doug
