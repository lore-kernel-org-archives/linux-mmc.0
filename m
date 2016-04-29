From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 16:01:58 -0700
Message-ID: <CAD=FV=U5jnJJ3v=nFGFecoKB5KGv1ufC+aKbHx2iCqBTWpDTww@mail.gmail.com>
References: <20160429195741.GY19428@n2100.arm.linux.org.uk>
	<CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
	<20160429211328.GZ19428@n2100.arm.linux.org.uk>
	<CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
	<20160429212920.GA19428@n2100.arm.linux.org.uk>
	<CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
	<20160429215017.GC19428@n2100.arm.linux.org.uk>
	<CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
	<20160429221606.GE19428@n2100.arm.linux.org.uk>
	<CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
	<20160429224407.GF19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35602 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbcD2XB7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 19:01:59 -0400
Received: by mail-yw0-f170.google.com with SMTP id g133so186017393ywb.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2016 16:01:59 -0700 (PDT)
In-Reply-To: <20160429224407.GF19428@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Jon Hunter <jonathanh@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>Pawel Moll <p>

Hi,

On Fri, Apr 29, 2016 at 3:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> My reply would be... why should MMC have special handling that no
> other subsystem has?

No other subsystem?

* i2c allows numbering devices by alias
* rtc allows numbering devices by alias.
* serial allows numbering devices by alias.
* spi allows numbering devices by alias.
* watchdog allows numbering devices by alias.

...at least that's my impression doing a grep for of_alias_get_id(),
which I suggested earlier in this thread but apparently wasn't done.


> Here's another example.  Plug in several USB serial adapters.  Which
> USB serial /dev/ttyUSB* device corresponds to which adapter?  The
> answer is... it depends on the order you plug them in, which could
> well be different from the order in which they are found if the
> machine reboots.  That's a very real problem.

USB is, by definition, hotplug and probable and there is no ordering.
For peripherals built-in to a SoC there is a sane ordering.  Thus
hotplug peripherals and builtin peripherals shouldn't have the same
requirements.

Quite honestly, it _would_ be quite convenient that if you are on a
SoC and you know it has builtin USB controllers to have the root hubs
numbered in a sane and consistent manner.  An area for a future patch,
maybe.


> However, the answer to this problem is not to find some way to bind
> a particular /dev/ttyUSB* node to a particular USB device, but to
> use the solution(s) already provided - iow, /dev/serial/by-id or
> /dev/serial/by-path trees which give a stable view of these devices.
>
> Now, while that allows the appropriate /dev/ttyUSB* device to be
> found, it doesn't solve the "which ttyUSB* entry in the kernel
> message log corresponds with which adapter" (which is the basis
> of your point #1.)  That's not solved, and isn't purposely isn't
> solved for any kernel subsystem.
>
> Another example - I have boards here with multiple RTCs... guess
> what happens with those?  Yep, same problem.  They get dynamic
> /dev/rtc* assignment.

Are you quite certain about that?  See above.


> Another example - I have a board with three ethernet devices...
> yep, same problem again, the order depends on the driver probe
> order, and they get dynamically assigned eth* names.

Ethernet is often provided by USB and thus hotplug and probable.
Quite honestly if there was a builtin Ethernet adapter provided on a
SoC (not connected over USB), it would be super handy if it was forced
to be "eth0" (and if there were more than one if they could be ordered
in a way that made sense for that SoC).  Dynamic ordering could come
after.


> The list of subsystems that have this property is large, because
> it's all dependent on the device/driver probing order.

Sure.  For hotplug, there is no sane device ordering.

For things built in to an SoC, there is sane device ordering.  Dynamic
ordering should come after static.


> So, please answer this question: why should _only_ MMC be treated
> as a special case?  Please give a _technical_ reason rather than a
> _personal_ reason.

Because technically it makes it easier for people to understand their
system to have a sane ordering for builtin peripherals.


-Doug
