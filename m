From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 6/9] mmc: cavium: Add MMC PCI driver for ThunderX SOCs
Date: Thu, 23 Mar 2017 10:28:44 +0100
Message-ID: <CAPDyKFqzpu1GiRCO5cVQ8yOPg-6CVRUFJSWWW5bLmh99vn+38g@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-7-jglauber@cavium.com>
 <CAPDyKFp2-KOSYy41QCFcqdU_Rzfncea8Q4QvjHSmho+tAMYMKg@mail.gmail.com> <20170323085812.GA2250@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33251 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbdCWJ2q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2017 05:28:46 -0400
Received: by mail-vk0-f50.google.com with SMTP id d188so143100457vka.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2017 02:28:46 -0700 (PDT)
In-Reply-To: <20170323085812.GA2250@hardcore>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>

On 23 March 2017 at 09:58, Jan Glauber <jan.glauber@caviumnetworks.com> wrote:
> On Fri, Mar 17, 2017 at 03:58:26PM +0100, Ulf Hansson wrote:
>> On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
>> > Add a platform driver for ThunderX ARM SOCs.
>> >
>> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
>> > ---
>> >  drivers/mmc/host/Kconfig               |  10 ++
>> >  drivers/mmc/host/Makefile              |   2 +
>> >  drivers/mmc/host/cavium-mmc.h          |  10 +-
>> >  drivers/mmc/host/cavium-pci-thunderx.c | 198 +++++++++++++++++++++++++++++++++
>> >  4 files changed, 218 insertions(+), 2 deletions(-)
>> >  create mode 100644 drivers/mmc/host/cavium-pci-thunderx.c
>> >
>> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> > index 68cc811..3983dee 100644
>> > --- a/drivers/mmc/host/Kconfig
>> > +++ b/drivers/mmc/host/Kconfig
>> > @@ -632,6 +632,16 @@ config MMC_CAVIUM_OCTEON
>> >
>> >           If unsure, say N.
>> >
>> > +config MMC_CAVIUM_THUNDERX
>> > +       tristate "Cavium ThunderX SD/MMC Card Interface support"
>> > +       depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
>> > +       select GPIO_THUNDERX
>>
>> Do you really need to select GPIO_THUNDERX? What is the relationship?
>
> I don't know much about gpio, but in the end despite all these layers
> there must be a gpio set function called doing the writeq on our SOC
> to enable/disable the power gpio, right?
>
> GPIO_THUNDERX implements this gpio set function for Cavium's SOC.

Got it. However using "select" should be avoided.

Please use "depends on GPIOLIB" instead. The select of "GPIO_THUNDERX"
should be done part of the defconfig or via an SoC specifc Kconfig
file.

[...]

>
>> > +                * Create a dummy device per slot and set the node pointer to
>> > +                * the slot. The easiest way to get this is using
>> > +                * of_platform_device_create.
>> > +                */
>> > +               if (!slot_pdev[i])
>> > +                       slot_pdev[i] = of_platform_device_create(child_node, NULL,
>> > +                                                     &pdev->dev);
>>
>> Seems like we should verify that this is a slot node, by checking the
>> compatible, before creating a platform device for it. No?
>
> Not sure I understand you correctly. Before creating the platform device
> I don't have a device for the slot. Looking at functions I could use to
> check the compatible all of these need a device, which I'm just going to
> create. Can you point me to a function I can use here?

if (of_device_is_compatible(child_node, "mmc-slot"))
   ->create device

[...]

Kind regards
Uffe
