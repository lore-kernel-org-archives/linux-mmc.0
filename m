From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: wl1271: sdio: is fine-grained runtime_pm possible?
Date: Fri, 24 Jan 2014 09:15:02 +0100
Message-ID: <CAPDyKFoCRh27TB7x_vzKMrgeUO-QKHcfsfLtkVpTsvKfr1P6uw@mail.gmail.com>
References: <CAKZq+rdaCivZTFSTGt9_Q+3KFE9Ft0XfmWZ=1Vr7QcDDs9=Muw@mail.gmail.com>
	<867ga39raz.fsf@void.printf.net>
	<CAKZq+rf8HAhtjNw3CHPp2C0a2mv0d-zgN6VgdqC5rt4ysOkcpQ@mail.gmail.com>
	<CAPDyKFoyn=PChen-1daxjrH=k+Wuju0T9r5a3HQz5ytch0-LZg@mail.gmail.com>
	<CAKZq+rc5Tg+L02-x8hEWUEYoyXmtPg=Mg7scp8bj79u=fqqYcg@mail.gmail.com>
	<CAPDyKFqDG-s6AVYQ4bP4CE_w1a6EyjQCD_ha_p0PV=2Hun6vFw@mail.gmail.com>
	<CAKZq+redY5_Qu=D9yuJXjSaDLTXj_K6yOoQ9rMD739LZQPaahw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:47208 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaAXIPD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2014 03:15:03 -0500
Received: by mail-qc0-f172.google.com with SMTP id c9so3955023qcz.3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2014 00:15:02 -0800 (PST)
In-Reply-To: <CAKZq+redY5_Qu=D9yuJXjSaDLTXj_K6yOoQ9rMD739LZQPaahw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chao Xu <caesarxuchao@gmail.com>
Cc: Chris Ball <chris@printf.net>, Luciano Coelho <luciano.coelho@intel.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 18 January 2014 23:44, Chao Xu <caesarxuchao@gmail.com> wrote:
> Hi Ulf,
> My apology for the late reply.
>
> On Wed, Jan 15, 2014 at 4:46 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> No, I don't think so. Or, well it depends on what you mean with sdio. :-)
>>
>> In this case, I think the WLAN_EN pin should be converted to a gpio
>> regulator. The regulator should then be handled from omap_hsmmc's
>> ->set_ios callback.
> I checked the codes and confirmed this. pm_runtime_get/put(&func->dev)
> will end up at the ->set_ios callback. But I failed to find the codes
> that convert the WLAN_EN pin to a gpio regulator. Could you provide
> any hint?

I am not sure this has been done yet, so if it hasn't, there is a good
reason to convert it.

>> This will then mean, once the SDIO func driver drops is runtime PM
>> reference the power will be cut to the WLAN chip. I guess this is
>> handled internally by the SDIO func driver as of today, right?
>>
> Agree. I realized my words had been ambiguous. Hope I got it right this time:-)
> As you mentioned, there are two devices. The sdio/mmc/sd sdio
> controller device, which is abstracted as a "host" in codes. And the
> WLAN card, which is abstracted as a "sdio func". Calling
> pm_runtime_put(&func->dev) will power off the WLAN chip. But calling
> pm_runtime_put(host->dev) will NOT power off the WLAN chip, am I
> right?

Actually in the SDIO case there are three struct devices.

1) The sdio card device, attached to the mmc bus.
2) The sdio func device, which has the sdio card device as parent, and
is attached to the sdio bus.
3) The host device.

1) and 2) are connected, since there are a parent/child relation chip.
If the sdio func device's runtime PM reference gets increased
(pm_runtime_get_sync), the runtime PM core will make sure it's parent
device will be runtime resumed as well. Typically the sdio func driver
will operate on 2), which means it can control whether the SDIO card
(WLAN chip) needs power or not.

3) is handled separate from the other, and should handle it's own
runtime PM resources.

>
>>> OMAP4's spec also mentions that one should use GPIO to monitor the
>>> state of DAT1 pin if the power domain is off. So my takeaway is that
>>> through various tricks, SDIO irqs can be fetched when it's in runtime
>>> suspend state. And thus we can enable fine-grain runtime PM in mmc
>>> host driver, at least for omap_hsmmc.
>>
>> Agree. Just to be clear, we have two separate devices being controlled
>> with runtime PM.
>>
>> The sdio/mmc/sd controller device owned by omap_hsmmc, which resides
>> in a power domain.
>>
> So provided the SDIO irqs are handled properly, it's possible to
> enable fine-grain runtime PM on sdio/mmc/sd controller device, e.g.,
> pm_runtime_put(host->dev) when there is no communication between
> WLAN-chip and SDIO controller device.
>> The card device which represents the WLAN-chip/SDIO card, controlled
>> by the mmc core and the SDIO func driver.
>>
> We shall NOT call pm_runtime_put(&func->dev) even if the WLAN-chip is
> not tx/rx packets. Because otherwise the WLAN-chip will be powered off
> and incoming packets will be lost.

Correct.

As stated earlier, you may also want the WLAN driver to put the WLAN
chip in some specific low power mode. Obviously it still need to keep
listen for irq for incoming packets as long as the wlan interface is
up.

>
>>>> 3. If the WLAN chip supports some kind of low power mode, those shall
>>>> be handled from the SDIO func driver. Depending on what mode it
>>>> supports it might be feasible to use runtime PM.
>>>>
>>> Per Figure13 in Pandaboard datasheet, wl1271 uses GPIO53 as the
>>> WLAN_IRQ. So it doesn't use sdio to interrupt cpu. So I think when
>>> running on Pandaboard, the func driver can safely disable the sdio
>>> when it's not reading/writing through sdio.
>>
>> Does it mean that DAT1 can be re-routed to GPIO53 or does it mean that
>> the WLAN chip has a separate line for SDIO irqs?
> I'm not sure. The Figure shows the SDIO_D1 pin of the WLAN-chip is
> connected to the SDMMC5_DAT1 of OMAP. And there is a separate WLAN_IRQ
> pin on WLAN-chip which connects to GPIO53. I guess this means it's a
> separate line?
>> I am not sure what you mean by disable sdio here? Could you elaborate?
>> Maybe use the word "device" instead?
> I mean the SDIO controller device:-)
>>
>> KInd regards
>> Ulf Hansson
>
> Regards,
> Chao Xu
