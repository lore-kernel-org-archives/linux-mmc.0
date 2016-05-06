From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Fri, 6 May 2016 08:01:54 -0500
Message-ID: <CAL_JsqJ_J=xFH8DfBwXv8Xd2HYYWX-FvCr4zO9sFhY=3keCdtw@mail.gmail.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <20160505224240.GA31429@rob-hp-laptop> <572C355E.7090008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <572C355E.7090008@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, tjakobi@math.uni-bielefeld.de, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, May 6, 2016 at 1:10 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 05/06/2016 12:42 AM, Rob Herring wrote:
>> On Thu, May 05, 2016 at 02:34:13PM +0200, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> This is a different, second try to fix usb3503+lan on Odroid U3 board
>>> if it was initialized by bootloader (e.g. for TFTP boot).
>>>
>>> First version:
>>> http://www.spinics.net/lists/linux-usb/msg140042.html
>>>
>>>
>>> Problem
>>> =======
>>> When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
>>> the usb3503 and LAN smsc95xx do not show up in "lsusb". Hard-reset
>>> is required, e.g. by suspend to RAM. The actual TFTP boot does
>>> not have to happen. Just "usb start" from U-Boot is sufficient.
>>>
>>> From the schematics, the regulator is a supply only to LAN, however
>>> without toggling it off/on, the usb3503 hub won appear neither.
>>>
>>>
>>> Solution
>>> ========
>>> This is very similar to the MMC pwrseq behavior so the idea is to:
>>> 1. Move MMC pwrseq drivers to generic place,
>>
>> You can do that, but I'm going to NAK any use of pwrseq bindings outside
>> of MMC. I think it is the wrong way to do things. The DT should describe
>> the devices. If they happen to be "simple" then the core can walk the
>> tree and do any setup. For example, look for "reset-gpios" and toggle
>> that GPIO. There is no need for a special node.
>
> Okay, I got it, no node for pwrseq but parse device properties. In case
> of reset-gpios it seems quite obvious but also actively used:
> $ git grep reset-gpios arch/arm/boot/dts | wc -l
> 142
>
> Definitely pwrseq shouldn't add itself to all of these devices.
>
> My questions would be then:
> 1. An additional pwrseq compatible for device is acceptable?

Perhaps. The issue is whether common or driver specific code handles
this may change over time. In other words, it is purely a kernel
decision. It could move in either direction. It may be better to just
have a whitelist of devices (though it would need to be board specific
somehow).

> 2. How would you name the regulator? We shouldn't toggle off/on every
> regulator but probably only some specific ones.

I'd argue the generic case is just enable all the ones defined. If you
only need to deal with some of them or need a specific sequence, then
it is not generic.

Rob
