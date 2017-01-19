From: Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [PATCH v3 2/9] mmc: mmci: add support for not-amba, but still
 compatible, variants
Date: Thu, 19 Jan 2017 18:40:22 +0100
Message-ID: <CAN8YU5MMjt0fsM+ZjGAKKhHZoD_2t+6kzEAugN-iYZAN5Y0R5g@mail.gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
 <1484552238-23171-3-git-send-email-andrea.merello@gmail.com>
 <CAPDyKFqX+_ZPWm__FQqNqBDxWnmVCHTBaMN=Tbbeh+E=kuGMMg@mail.gmail.com> <20170119171132.GI27312@n2100.armlinux.org.uk>
Reply-To: andrea.merello@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36813 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdASRko (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 12:40:44 -0500
Received: by mail-yw0-f194.google.com with SMTP id q71so367370ywg.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 09:40:43 -0800 (PST)
In-Reply-To: <20170119171132.GI27312@n2100.armlinux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bruno Herrera <bruherrera@gmail.com>

On Thu, Jan 19, 2017 at 6:11 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jan 19, 2017 at 05:58:10PM +0100, Ulf Hansson wrote:
>> + Russell
>>
>> On 16 January 2017 at 08:37, Andrea Merello <andrea.merello@gmail.com> wrote:
>> > The STM32F4xx family contain a SDIO IP that looks like a variant of
>> > the PL180, however, inspite it's actually attached to a APB bus, it
>> > cannot be handled by the AMBA bus code, because it lacks of the ID
>> > registers that AMBA primecell IPs have.
>> >
>> > This patch prepares for supporting the STM32 variant by letting the
>> > driver register also as a platform driver, that can be matched from
>> > the OF with specific "compatible" strings
>>
>> NAK!
>
> Also NAK.
>
>> Too much code are depending on the amba bus in the driver. I sincerely
>> hope you haven't tried this approach for other amba drivers, because
>> it will screw them up and they will become a nightmare to maintain!

It's almost only probe/remove code.. Nothing in the core of the driver
gets involved here.. What about splitting the driver in three files
(mmci.c, mmci_amba.c and mmci_plat.c) and compile them conditionally?

BTW This approach is not my invention; there is at least another
driver in mainline kernel that does that: amba-pl011.c

>> Moreover, there is a way to override the use of the AMBA IDs
>> registers. I think you can use that instead! No?
>

I'm aware of it; I used it as a quick hack to get the driver probed,
but that looked just like as an hack to me..

> Exactly right.  Nothing wrong with creating an amba device in response
> to probing a platform device - which becomes a shim which keeps the
> main driver clean and maintanable.  The shim could also be used to
> create amba device for other AMBA drivers too, it doesn't have to be
> MMCI specific.

If we ovverride the amba regs from DT (is this what you meant?) then
we just take a random number, prentend it to be an amba ID (hoping for
it to be spare), and use it to force the amba bus layer to probe our
driver. How can we make this common for other drivers/devices ? We
need it to be unique, since it's used by the amba layer to probe the
correct driver (given the generic "arm,primecell" compatible DT
property), or am I missing something ?

> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
