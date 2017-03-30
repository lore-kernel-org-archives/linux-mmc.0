From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron
 boards
Date: Thu, 30 Mar 2017 14:11:19 +0900
Message-ID: <6b9a3425-fe3c-0c9a-8d1b-d2d2ac1ec9de@samsung.com>
References: <20170330011709.GA110687@google.com>
        <6d87cb71-1339-0dc9-e071-1c117f541881@rock-chips.com>
        <20170330014230.GA21467@google.com>
        <CANCyOWYsG9rpCvEsBMDJAyOTjKJCe=O-35-Zbhjh4is+op_h=w@mail.gmail.com>
        <CGME20170330025350epcas4p423e66068f5d962677952830258676fcf@epcas4p4.samsung.com>
        <20170330025345.GA29421@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31871 "EHLO
        epoutp01.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754735AbdC3FLX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 01:11:23 -0400
In-reply-to: <20170330025345.GA29421@google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Eddie Cai <eddie.cai.kernel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, amstan@chromium.org, Kevin Mihelich <kevin@archlinuxarm.org>

Hi,

On 03/30/2017 11:53 AM, Brian Norris wrote:
> Hi Eddie,
> 
> On Thu, Mar 30, 2017 at 10:18:59AM +0800, Eddie Cai wrote:
>> I test on rk3288 firefly reload with 4.11-rc4. It work fine.
> 
> OK, thanks for checking.
> 
>>> On Thu, Mar 30, 2017 at 09:32:22AM +0800, Shawn Lin wrote:
>>>> Hi Brian,
>>>>
>>>> On 2017/3/30 9:17, Brian Norris wrote:
>>>>> Hi all,
>>>>>
>>>>> I haven't managed to get as far as a bugfix for this, but I've bisected
>>>>> some issues seen on v4.10+ with a Chromebook of the Veyron family (Jaq,
>>>>> in particular). v4.9 works fine.
> 
> [...]
> 
> By the way, Kevin (CC'd) says he noticed similiar Wifi issues on an
> Exynos 5800 Peach chromebook, but not on an Exynos 5250 Snow chromebook.	
> I haven't picked these apart yet to see what the differences and
> similarities are, but presumably it's not actually a Rockchip-specific
> bug. Maybe related to the way power sequencing is plumbed for these, for
> example?

I'm not sure but if card-detecting is polling, the timing issue could be occurred.

Best Regards,
Jaehoon Chung

> 
> Brian
> 
> 
> 

