From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Mon, 9 May 2016 09:46:40 +0200
Message-ID: <CAPDyKFqpoi03Egfuvd8qJXnn_+FBgPXAb7S4UvkxVs8BA+zwnA@mail.gmail.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
	<20160505224240.GA31429@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160505224240.GA31429@rob-hp-laptop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 6 May 2016 at 00:42, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, May 05, 2016 at 02:34:13PM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> This is a different, second try to fix usb3503+lan on Odroid U3 board
>> if it was initialized by bootloader (e.g. for TFTP boot).
>>
>> First version:
>> http://www.spinics.net/lists/linux-usb/msg140042.html
>>
>>
>> Problem
>> =======
>> When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
>> the usb3503 and LAN smsc95xx do not show up in "lsusb". Hard-reset
>> is required, e.g. by suspend to RAM. The actual TFTP boot does
>> not have to happen. Just "usb start" from U-Boot is sufficient.
>>
>> From the schematics, the regulator is a supply only to LAN, however
>> without toggling it off/on, the usb3503 hub won appear neither.
>>
>>
>> Solution
>> ========
>> This is very similar to the MMC pwrseq behavior so the idea is to:
>> 1. Move MMC pwrseq drivers to generic place,
>
> You can do that, but I'm going to NAK any use of pwrseq bindings outside
> of MMC. I think it is the wrong way to do things. The DT should describe

Huh, I didn't know that was your view of the mmc pwrseq bindings. Why
didn't you NAK them before?

> the devices. If they happen to be "simple" then the core can walk the
> tree and do any setup. For example, look for "reset-gpios" and toggle
> that GPIO. There is no need for a special node.
>
>> 2. Extend the pwrseq-simple with regulator toggling,
>> 3. Add support to USB hub and port core for pwrseq,
>
> We discussed this for USB already[1] and is why we defined how to add
> USB child devices. The idea is not to add pwrseq to that.

I am not familiar with the USB discussion.

Still, let me give you some more background to the mmc pwrseq. The
idea from the mmc pwrseq bindings comes from the power-domain DT
bindings, as I thought these things were a bit related.
In both cases they are not directly a property of the device, but more
describing a HW dependency to allow the device to work.

One could probably use a child node instead of a phandle, but that
wasn't chosen back then. Of course you are the DT expert, but could
you perhaps tell me why a child node is better for cases like this?

>
> Rob
>
> [1] http://www.spinics.net/lists/linux-usb/msg134082.html

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
