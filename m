From: Bruno Herrera <bruherrera@gmail.com>
Subject: Re: [PATCH v3 2/9] mmc: mmci: add support for not-amba, but still
 compatible, variants
Date: Thu, 19 Jan 2017 16:36:35 -0200
Message-ID: <CAF3+TqdvNtJnK5Y3V3M1i0EREg-10HLyDBzTW=+Ucw_en-nH_A@mail.gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
 <1484552238-23171-3-git-send-email-andrea.merello@gmail.com>
 <CAPDyKFqX+_ZPWm__FQqNqBDxWnmVCHTBaMN=Tbbeh+E=kuGMMg@mail.gmail.com>
 <20170119171132.GI27312@n2100.armlinux.org.uk> <CAN8YU5MMjt0fsM+ZjGAKKhHZoD_2t+6kzEAugN-iYZAN5Y0R5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35195 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbdASSpx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 13:45:53 -0500
Received: by mail-io0-f194.google.com with SMTP id m98so5899567iod.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 10:45:07 -0800 (PST)
In-Reply-To: <CAN8YU5MMjt0fsM+ZjGAKKhHZoD_2t+6kzEAugN-iYZAN5Y0R5g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Jan 19, 2017 at 3:40 PM, Andrea Merello
<andrea.merello@gmail.com> wrote:
> On Thu, Jan 19, 2017 at 6:11 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Thu, Jan 19, 2017 at 05:58:10PM +0100, Ulf Hansson wrote:
>>> + Russell
>>>
>>> On 16 January 2017 at 08:37, Andrea Merello <andrea.merello@gmail.com> wrote:
>>> > The STM32F4xx family contain a SDIO IP that looks like a variant of
>>> > the PL180, however, inspite it's actually attached to a APB bus, it
>>> > cannot be handled by the AMBA bus code, because it lacks of the ID
>>> > registers that AMBA primecell IPs have.
>>> >
>>> > This patch prepares for supporting the STM32 variant by letting the
>>> > driver register also as a platform driver, that can be matched from
>>> > the OF with specific "compatible" strings
>>>
>>> NAK!
>>
>> Also NAK.
>>
>>> Too much code are depending on the amba bus in the driver. I sincerely
>>> hope you haven't tried this approach for other amba drivers, because
>>> it will screw them up and they will become a nightmare to maintain!
>
> It's almost only probe/remove code.. Nothing in the core of the driver
> gets involved here.. What about splitting the driver in three files
> (mmci.c, mmci_amba.c and mmci_plat.c) and compile them conditionally?
>
> BTW This approach is not my invention; there is at least another
> driver in mainline kernel that does that: amba-pl011.c
>
>>> Moreover, there is a way to override the use of the AMBA IDs
>>> registers. I think you can use that instead! No?
>>
>
> I'm aware of it; I used it as a quick hack to get the driver probed,
> but that looked just like as an hack to me..

I did the same hackish approach and it works, but a first moment
rather than changing the code I would suggest to get this ID from ST.
Does not mean that as we cannot query from the IP core, it does not
exist (my guess).

>
>> Exactly right.  Nothing wrong with creating an amba device in response
>> to probing a platform device - which becomes a shim which keeps the
>> main driver clean and maintanable.  The shim could also be used to
>> create amba device for other AMBA drivers too, it doesn't have to be
>> MMCI specific.
>
> If we ovverride the amba regs from DT (is this what you meant?) then
> we just take a random number, prentend it to be an amba ID (hoping for
> it to be spare), and use it to force the amba bus layer to probe our
> driver. How can we make this common for other drivers/devices ? We
> need it to be unique, since it's used by the amba layer to probe the
> correct driver (given the generic "arm,primecell" compatible DT
> property), or am I missing something ?
>
>> --
>> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
>> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
>> according to speedtest.net.
