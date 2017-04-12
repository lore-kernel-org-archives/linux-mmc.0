From: Doug Anderson <dianders@google.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron boards
Date: Wed, 12 Apr 2017 09:12:24 -0700
Message-ID: <CAD=FV=U+SQ8RwPz+8tVzoLgTLNM=jca1FtLBgsZ+GTY24rhTKQ@mail.gmail.com>
References: <20170330011709.GA110687@google.com> <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
 <23842930-ece6-8879-daa5-c2220cfbf09f@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38727 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdDLQM1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 12:12:27 -0400
Received: by mail-wm0-f53.google.com with SMTP id t189so28047695wmt.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2017 09:12:26 -0700 (PDT)
In-Reply-To: <23842930-ece6-8879-daa5-c2220cfbf09f@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Brian Norris <briannorris@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, kevin@archlinuxarm.org

Shawn

On Tue, Apr 11, 2017 at 5:54 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> This doesn't surprise me at all.  What surprises me, though, is that
>> nobody else seems to be able to reproduce this.
>>
>> On veyron, WiFi is connected via SDIO.  For good speed, it uses SDIO
>> Interrupts.  See this bit in the device tree:
>>
>>   cap-sdio-irq;
>>
>
> all of *my* boards are using side-band interrupt, so there are no
> "cap-sdio-irq".

They are all using side-band interrupt?  What WiFi device do you have connected?

If you're truly using a side-band interrupt using the dedicated SDIO
interrupt pin on your SoC, I'm pretty sure you still need to define
cap-sdio-irq in order for things to work properly.  If you don't do
that, you'll get "polling mode" for SDIO Interrupts.  See
sdio_irq_thread() where you can see that the kernel will poll your
device every 10 ms if MMC_CAP_SDIO_IRQ isn't set.

Maybe you should try defining cap-sdio-irq and see if you get a big
performance boost?
