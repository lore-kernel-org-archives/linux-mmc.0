From: Brian Norris <briannorris@chromium.org>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron
 boards
Date: Wed, 29 Mar 2017 18:42:31 -0700
Message-ID: <20170330014230.GA21467@google.com>
References: <20170330011709.GA110687@google.com>
 <6d87cb71-1339-0dc9-e071-1c117f541881@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34943 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933103AbdC3Bmf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2017 21:42:35 -0400
Received: by mail-pg0-f47.google.com with SMTP id 81so23603930pgh.2
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2017 18:42:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6d87cb71-1339-0dc9-e071-1c117f541881@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, amstan@chromium.org, Ziyuan Xu <xzy.xu@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>

On Thu, Mar 30, 2017 at 09:32:22AM +0800, Shawn Lin wrote:
> Hi Brian,
> 
> On 2017/3/30 9:17, Brian Norris wrote:
> >Hi all,
> >
> >I haven't managed to get as far as a bugfix for this, but I've bisected
> >some issues seen on v4.10+ with a Chromebook of the Veyron family (Jaq,
> >in particular). v4.9 works fine.
> 
> Does your v4.10+ kernel  have these commits?

By "4.10+", I meant that pure 4.10 is broken, as are all subsequent
versions (e.g., 4.11-rc1).

> commit e9748e0364fe82dc037d22900ff13a62d04518bf
> Author: Ziyuan Xu <xzy.xu@rock-chips.com>
> Date:   Tue Jan 17 09:22:56 2017 +0800
> 
>     mmc: dw_mmc: force setup bus if active slots exist
> 
> 
> commit df9bcc2bc0a1f8d2963bd916698268fb2470713b
> Author: Joonyoung Shim <jy0922.shim@samsung.com>
> Date:   Fri Nov 25 12:47:15 2016 +0900
> 
>     mmc: dw_mmc: add missing codes for runtime resume

'git describe' tells me these are in 4.10-rc1 and -rc6. So yes.

> commit ce69e2fea093b7fa3991c87849c4955cd47796c9
> Author: Shawn Lin <shawn.lin@rock-chips.com>
> Date:   Tue Jan 17 09:22:55 2017 +0800
> 
>     mmc: dw_mmc: silent verbose log when calling from PM context

'git describe' tells me this is in 4.11-rc1, so no.

Brian
