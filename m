From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron
 boards
Date: Fri, 7 Apr 2017 14:50:04 +0800
Message-ID: <bdb7c3c8-87c2-0fd3-73f0-d0b1ddf64e7f@rock-chips.com>
References: <20170330011709.GA110687@google.com>
 <6d87cb71-1339-0dc9-e071-1c117f541881@rock-chips.com>
 <20170330014230.GA21467@google.com>
 <CANCyOWYsG9rpCvEsBMDJAyOTjKJCe=O-35-Zbhjh4is+op_h=w@mail.gmail.com>
 <CGME20170330025350epcas4p423e66068f5d962677952830258676fcf@epcas4p4.samsung.com>
 <20170330025345.GA29421@google.com>
 <6b9a3425-fe3c-0c9a-8d1b-d2d2ac1ec9de@samsung.com>
 <20170406220410.GA5708@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:56415 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbdDGGuI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Apr 2017 02:50:08 -0400
In-Reply-To: <20170406220410.GA5708@google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Eddie Cai <eddie.cai.kernel@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, amstan@chromium.org, Kevin Mihelich <kevin@archlinuxarm.org>, Doug Anderson <dianders@chromium.org>

Hi Brian,

On 2017/4/7 6:04, Brian Norris wrote:
> Hi,
>
> On Thu, Mar 30, 2017 at 02:11:19PM +0900, Jaehoon Chung wrote:
>> On 03/30/2017 11:53 AM, Brian Norris wrote:
>>> On Thu, Mar 30, 2017 at 10:18:59AM +0800, Eddie Cai wrote:
>>>> I test on rk3288 firefly reload with 4.11-rc4. It work fine.
>>>
>>> OK, thanks for checking.
>>>
>>>>> On Thu, Mar 30, 2017 at 09:32:22AM +0800, Shawn Lin wrote:
>>>>>> Hi Brian,
>>>>>>
>>>>>> On 2017/3/30 9:17, Brian Norris wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I haven't managed to get as far as a bugfix for this, but I've bisected
>>>>>>> some issues seen on v4.10+ with a Chromebook of the Veyron family (Jaq,
>>>>>>> in particular). v4.9 works fine.
>>>
>>> [...]
>>>
>>> By the way, Kevin (CC'd) says he noticed similiar Wifi issues on an
>>> Exynos 5800 Peach chromebook, but not on an Exynos 5250 Snow chromebook.	
>>> I haven't picked these apart yet to see what the differences and
>>> similarities are, but presumably it's not actually a Rockchip-specific
>>> bug. Maybe related to the way power sequencing is plumbed for these, for
>>> example?
>>
>> I'm not sure but if card-detecting is polling, the timing issue could be occurred.
>
> I don't know much about MMC in general, nor about this driver. Any
> chance you'd accept reverts of the patches in question though? This is a
> huge regression, and there were only a few relevant changes that seem to
> have triggered this. I can try to come up with something targeted, but
> I'm not going to even try if that'd get rejected up front.

Untile now, none of my(and my colleagues') rockchip platforms are able
to reproduce this issue, so I can't tell what exactly the problem is.
However, I noticed you mentioned that the Exynos platforms are also
affected by rpm of dwmmc. I don't see dw_mmc-exynos enable this feature,
so it looks quite odd to me!

Can I or Eddie get a Veyron board to help you debug it?

>
> Brian
>
>
>

