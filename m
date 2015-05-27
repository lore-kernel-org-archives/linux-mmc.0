From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Wed, 27 May 2015 10:53:07 +0900
Message-ID: <55652383.2020204@samsung.com>
References: <1431964402-27457-1-git-send-email-dianders@chromium.org>
 <CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com>
 <CAD=FV=WPKV78=Wx5qE43+LsVpx_X9KAfKvcXKWy2hZfDoRLi0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42943 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbE0BxJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2015 21:53:09 -0400
In-reply-to: <CAD=FV=WPKV78=Wx5qE43+LsVpx_X9KAfKvcXKWy2hZfDoRLi0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Alim Akhtar <alim.akhtar@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, All.

Thanks for your effort and sorry for late!

On 05/27/2015 05:44 AM, Doug Anderson wrote:
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

I don't test with this..but if needs, i will test.
It needs to fix the Alim's problem.

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

Which version do you have? I also need to check the TRM version.

Best Regards,
Jaehoon Chung

> 
> 
> -Doug
> 

