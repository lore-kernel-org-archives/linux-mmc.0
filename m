From: Eddie Cai <eddie.cai.kernel@gmail.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron boards
Date: Thu, 30 Mar 2017 10:18:59 +0800
Message-ID: <CANCyOWYsG9rpCvEsBMDJAyOTjKJCe=O-35-Zbhjh4is+op_h=w@mail.gmail.com>
References: <20170330011709.GA110687@google.com> <6d87cb71-1339-0dc9-e071-1c117f541881@rock-chips.com>
 <20170330014230.GA21467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33098 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdC3CTB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2017 22:19:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18so7941865wrc.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2017 19:19:00 -0700 (PDT)
In-Reply-To: <20170330014230.GA21467@google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, amstan@chromium.org

HI Brian
I test on rk3288 firefly reload with 4.11-rc4. It work fine.

2017-03-30 9:42 GMT+08:00 Brian Norris <briannorris@chromium.org>:
> On Thu, Mar 30, 2017 at 09:32:22AM +0800, Shawn Lin wrote:
>> Hi Brian,
>>
>> On 2017/3/30 9:17, Brian Norris wrote:
>> >Hi all,
>> >
>> >I haven't managed to get as far as a bugfix for this, but I've bisected
>> >some issues seen on v4.10+ with a Chromebook of the Veyron family (Jaq,
>> >in particular). v4.9 works fine.
>>
>> Does your v4.10+ kernel  have these commits?
>
> By "4.10+", I meant that pure 4.10 is broken, as are all subsequent
> versions (e.g., 4.11-rc1).
>
>> commit e9748e0364fe82dc037d22900ff13a62d04518bf
>> Author: Ziyuan Xu <xzy.xu@rock-chips.com>
>> Date:   Tue Jan 17 09:22:56 2017 +0800
>>
>>     mmc: dw_mmc: force setup bus if active slots exist
>>
>>
>> commit df9bcc2bc0a1f8d2963bd916698268fb2470713b
>> Author: Joonyoung Shim <jy0922.shim@samsung.com>
>> Date:   Fri Nov 25 12:47:15 2016 +0900
>>
>>     mmc: dw_mmc: add missing codes for runtime resume
>
> 'git describe' tells me these are in 4.10-rc1 and -rc6. So yes.
>
>> commit ce69e2fea093b7fa3991c87849c4955cd47796c9
>> Author: Shawn Lin <shawn.lin@rock-chips.com>
>> Date:   Tue Jan 17 09:22:55 2017 +0800
>>
>>     mmc: dw_mmc: silent verbose log when calling from PM context
>
> 'git describe' tells me this is in 4.11-rc1, so no.
>
> Brian
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
