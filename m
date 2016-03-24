From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Thu, 24 Mar 2016 08:16:49 -0700
Message-ID: <CAD=FV=X2rO+zKoq3BOLcShwA555GMXdKhA92M_SijNDkfcjA1g@mail.gmail.com>
References: <CAFqH_53X-cAP4O7PeSOyDybAG9CHQGoPkUE76CacGjVV4cX6Pg@mail.gmail.com>
	<CAD=FV=XBZr9q9CoodewrUhChuoKSmwR4viGx+-htq+ZHCA066w@mail.gmail.com>
	<CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33920 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbcCXPQu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 11:16:50 -0400
Received: by mail-vk0-f54.google.com with SMTP id e185so62866706vkb.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2016 08:16:50 -0700 (PDT)
In-Reply-To: <CAFqH_51=a7qsLFv_v3uDTsQzz8YD=GiAo3SUcR6rW_MObm=M7Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Russell King <linux@arm.linux.org.uk>

Hi,

On Thu, Mar 24, 2016 at 4:26 AM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>> Ah, that would make some sense why things work OK on Rockchip.  Adding
>> DW_MCI_QUIRK_BROKEN_DTO to peach probably doesn't make sense, then.
>> Hrm...
>>
>> Since my original debugging of the issue was over a year ago, I think
>> I've almost totally lost context of any debugging I did on the issue,
>> so I'm not sure I'm going to be too much help in giving any details
>> other than what I put in the original commit message.  From the
>> original message it appears that I thought we could solve this other
>> ways but just that my patch was easier than the alternative of
>> handling every error case.  Maybe we just need to go back to the
>> drawing board and handle the error directly?
>>
>
> I just saw that Russell introduced a patch [1] that will land on 4.6.
> I think that patch solves the same issue that we're trying to fix, but
> for sdhci controller.

Yes, the description sounds very similar for sure.


> The problem that we have on peach-pi, with our patch applied, is that
> when we get a response CRC error on a command and we move to start
> sending data, the transfer doesn't receives a timeout interrupt (I
> don't know why). As I told, on rockchip works due the DTO quirk.
> exynos is not using this quirk. Also, please correct me if I'm wrong,
> looks like the sdhci controller has a timer to signal the command
> timed out.

I haven't spent any amount of time looking at SDHCI driver.

If we have no other better solution, enabling the DTO timer for this
specific case on all dw_mmc might be a good idea?


> ooi, anyone knows what was the test case that caused the necessity of
> the DTO quirk?

If I remember correctly, the DTO quirk is necessary to get basic
tuning working on almost every UHS card out there on rk3288.  Take it
out and you'll see lots of problems.  If you have it in there and add
a printout when the DTO quirk fires, you'll see your printout a decent
amount during tuning.  Should be easy to test that...

Those same cards work fine on exynos devices without the DTO quirk.


-Doug
