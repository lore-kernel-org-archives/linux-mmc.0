From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3 v2] ARM: dts: rk3288-tinker.dtsi: Fix SD card detection
Date: Mon, 25 Feb 2019 09:13:01 -0800
Message-ID: <CAD=FV=UkQ7pEan4aGezvQZZjBc0gDJ1R7YRbN1Lbv9HBVQRgHQ@mail.gmail.com>
References: <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
 <20190222184708.32004-1-beagleboard@davidjohnsummers.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190222184708.32004-1-beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Summers <beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Feb 22, 2019 at 10:48 AM David Summers
<beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org> wrote:
>
> The Problem:
>
> On ASUS Tinker Board S, when booting from the eMMC, and there is no
> card sd slot, then there are constant errors.
>
> Cause:
>
> Thanks must go to Robin Murphy @ ARM for idenifying the problem. The
> rk808 on the Tinker Board and Tinker Board S has many regulators, one
> vccio_sd powers the IO for the sd card. Unfortunatly this is also used
> in the card detect. Now when no card is install, the regulator is
> powered down. This means that the card detect floats, and this means
> random card detection.

Yeah, this is broken on a lot of SoCs that use dw_mmc.  :(  Really the
card detect line needs to be on a different rail and this is why all
boards I've worked on recently have a the card detect going to a GPIO
instead of the dw_mmc CD.

IIRC Rockchip moved the Card Detect to a different rail on newer SoCs
(like rk3399) but we still used a GPIO even there since we didn't like
the default/automatic muxing of JTAG and SD signals.

The one board I was involved in that did it wrong (where we discovered
this issue) was exynos5250-snow.  You can see some discussion about
the issue at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282474.html

In that discussion I'm pretty sure that Ulf suggested that a better
way to go was to use something like "broken-cd" which I think was
supposed to switch us to use polling.  AKA periodically the SD card
would be powered on and we'd check for a card, then we'd power
everything off.  ...but that was never implemented for snow at least
so there may be something more than just adding the property.  You can
read through the whole thread for more details.


IIRC leaving the IO rail always on like you're proposing can also work
OK but there may be some corner cases, especially if you are trying to
reach UHS speeds and/or if the bootloader ever tries to use UHS
speeds.  It's almost certainly busted if the bootloader did UHS since
it will leave the line at ~1.8 V and the kernel will expect it to be
at ~3.3 V.  ...but maybe you rely on the bootloader not doing UHS and
maybe things are generally OK if not?  There may also be cases where
you can't properly power down / reset a card because the card may be
drawing power through the IO lines when you power off its main lines.
That's not good for the card and can also put it in a bad state.  I
haven't done all the research here so this may be a bit of FUD--it's
just a vague recollection from many years ago.


...so to make a long story short, a better solution is to allow the IO
lines to be powered off but then poll for the card periodically.


> The Solution:
>
> Make sure that the sd IO is always powered, this means card detection
> is always active, which is what should be done on a board with an sd
> slot, which both the Tinker Board and Tinker Board S are. Hence change
> is made to the .dtsi which takes effect on all Tinker Boards as
> required.
>
> The change also adds "regulator-boot-on" the Tinker Board boot from
> uboot, and the sd card is always one option. Hence the IO must be
> powered in uboot, and so setting this flag.
>
> Also removed is "disable-wp" the micro sd card which are used have no
> write  protection, so the concept doesn't mean anything, and the
> Tinker Boards work without this. Hence it is removed to simply.

As others have said, please leave disable-wp.  There's no way for the
kernel to know if you have a SD or uSD slot and the only difference
between the two (electrically) is that there's no write protect for
micro SD.


Also: please CC dw_mmc people on future patches in this area.

$ ./scripts/get_maintainer.pl -f drivers/mmc/host/dw_mmc.c
Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> (maintainer:SYNOPSYS DESIGNWARE
MMC/SD/SDIO DRIVER)
Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (maintainer:MULTIMEDIA CARD
(MMC), SECURE DIGITAL (SD) AND...)
linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER)

-Doug
