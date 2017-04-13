From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron
 boards
Date: Thu, 13 Apr 2017 16:28:10 +0800
Message-ID: <170a5878-55e9-bec9-4705-b00a0ff342a7@rock-chips.com>
References: <20170330011709.GA110687@google.com>
 <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
 <23842930-ece6-8879-daa5-c2220cfbf09f@rock-chips.com>
 <CAD=FV=U+SQ8RwPz+8tVzoLgTLNM=jca1FtLBgsZ+GTY24rhTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:59575 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdDMI2P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Apr 2017 04:28:15 -0400
In-Reply-To: <CAD=FV=U+SQ8RwPz+8tVzoLgTLNM=jca1FtLBgsZ+GTY24rhTKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Brian Norris <briannorris@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, kevin@archlinuxarm.org

Hi,

在 2017/4/13 0:12, Doug Anderson 写道:
> Shawn
>
> On Tue, Apr 11, 2017 at 5:54 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>> This doesn't surprise me at all.  What surprises me, though, is that
>>> nobody else seems to be able to reproduce this.
>>>
>>> On veyron, WiFi is connected via SDIO.  For good speed, it uses SDIO
>>> Interrupts.  See this bit in the device tree:
>>>
>>>   cap-sdio-irq;
>>>
>>
>> all of *my* boards are using side-band interrupt, so there are no
>> "cap-sdio-irq".
>
> They are all using side-band interrupt?  What WiFi device do you have connected?

I'm using brcm wifi that using out-of-tree drivers.

>
> If you're truly using a side-band interrupt using the dedicated SDIO
> interrupt pin on your SoC, I'm pretty sure you still need to define

Not really. The intention of using side-band int is that we could put
the host into low power mode(maybe with pd off), so that the wifi could
still works with Socs. And mostly, we don't need to keep the controller
on when in S3. The side-band io could be registered as a gpio interrupt
(wakeup source), and once the wifi chip need to communicate with Socs,
it could wakeup the system(of course sdio controller will be alive
then). Also, once using side-band interrupt, the interrupt service and
management should be done with the wifi function drivers. I'm pretty
sure that my at-hand drivers, for instance, brcm and realtek actually
do that.

> cap-sdio-irq in order for things to work properly.  If you don't do
> that, you'll get "polling mode" for SDIO Interrupts.  See
> sdio_irq_thread() where you can see that the kernel will poll your
> device every 10 ms if MMC_CAP_SDIO_IRQ isn't set.
>
> Maybe you should try defining cap-sdio-irq and see if you get a big
> performance boost?

Sorry, I didn't test the upstreamed wifi drivers but from the test of my
out-of-tree wifi drivers, there is no much difference.

>
>
>

