From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/4] phy: rockchip-emmc: give DLL some extra time to be ready
Date: Mon, 20 Jun 2016 09:25:18 -0700
Message-ID: <CAD=FV=X73R759Rum3AEUfD_yjswoD8iXQqrow_gpCu=6XJs7Sg@mail.gmail.com>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <5767EB7E.3040606@ti.com> <20160620161908.GA30459@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36012 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781AbcFTQZU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 12:25:20 -0400
Received: by mail-vk0-f52.google.com with SMTP id u64so202230205vkf.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2016 09:25:20 -0700 (PDT)
In-Reply-To: <20160620161908.GA30459@google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Norris <computersforpeace@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Mon, Jun 20, 2016 at 9:19 AM, Brian Norris <briannorris@chromium.org> wrote:
> + linux-mmc, Ulf
>
> On Mon, Jun 20, 2016 at 06:41:26PM +0530, Kishon Vijay Abraham I wrote:
>> On Friday 13 May 2016 04:13 AM, Brian Norris wrote:
>> > From: Shawn Lin <shawn.lin@rock-chips.com>
>> >
>> > According to the databook, 10.2us is the max time for dll to be ready to
>> > work. However in testing, some chips need 20us for dll to be ready. This
>> > patch adds some extra margin for dllrdy to be ready, fixing our
>> > -ETIMEDOUT issues.
>> >
>> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> Thanks! I take it that to mean you're agreeing with Doug's suggestion
> here:
>
> https://lkml.org/lkml/2016/6/13/1067
>
> "Since [the $subject series patches] aren't in 4.7-rc1 presumably they
> would also make sense to take through the MMC tree if others agree."
>
> Ulf,
>
> I see I didn't CC you or linux-mmc on this patch series. Please let me
> know if I should resend, or if you can pick these up off of LKML -- Doug
> gave nice patchwork links in his linked series. NB: patch 2 has a
> version 2, while the others were left unmodified.

I actually need to spin my series to address a small bit of feedback
from Heiko.  Since Brian's original patches weren't on linux-mmc, I'll
include them in my series (along with collected tags) to make it easy.
Hope this is OK.

-Doug
