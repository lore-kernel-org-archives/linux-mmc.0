From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 09:14:47 -0600
Message-ID: <CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
	<3215037.8HVCjAeS8g@wuerfel>
	<CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
	<alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.10.1401162204560.28907-fMhRO7WWcppj+hNMo8g0rg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 16, 2014 at 9:08 PM, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org> wrote:
> On Thu, 16 Jan 2014, Olof Johansson wrote:
>
>> "for SDIO slots" is somewhat misleading; nearly all controllers only
>> do one slot/device per controller. The designware controller can do
>> multiple slots, and that adds a bit of driver and binding complexity
>> for something that seemingly not a single vendor has actually
>> implemented.
>
> The Marvell 8688, just to name one, does both WIFI and BlueTooth over
> the same SDIO controller using separate functions/slots.

But that is logical functions within a chip, not multiple discrete
chips (i.e. slots) with their own reset, regulators, etc. There would
still be a single set of external controls per host controller I
think.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
